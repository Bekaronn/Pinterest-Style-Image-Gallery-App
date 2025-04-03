//
//  ImageListViewModel.swift
//  GalleryApp
//
//  Created by Bekarys on 04.04.2025.
//

import SwiftUI

struct ImageModel: Identifiable {
    let id = UUID()
    let image: Image
    let imageId: Int
}

final class ImageListViewModel: ObservableObject {
    @Published var images: [ImageModel] = []
    @Published var isLoading = false
    
    private var imageCache: [String: UIImage] = [:]
    
    private let service: ImageService
    private let router: ImageRouter

    init(service: ImageService, router: ImageRouter) {
        self.service = service
        self.router = router
    }
    
    func refreshImages() async {
        await MainActor.run {
            self.images.removeAll()
            getImages()
        }
    }

    func getImages(completion: (() -> Void)? = nil) {
        guard !isLoading else { return }
        isLoading = true
        
        var tempImages: [ImageModel] = []
        let group = DispatchGroup()
        
        for _ in 0...4 {
            group.enter()
            let imageId = Int.random(in: 0...1000)
            let url = "https://picsum.photos/id/\(imageId)/400"
            downloadImage(imageId: imageId, urlString: url) { model in
                if let model = model {
                    tempImages.append(model)
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.images += tempImages
            self.isLoading = false
            completion?()
        }
    }
    

    private func downloadImage(imageId: Int, urlString: String, completion: @escaping (ImageModel?) -> Void) {
        if let cachedImage = imageCache[urlString] {
            completion(ImageModel(image: Image(uiImage: cachedImage), imageId: imageId))
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }

            if let safeData = data {
                guard let image = UIImage(data: safeData) else {
                    print("Cannot create image")
                    completion(nil)
                    return
                }
                
                self.imageCache[urlString] = image

                let convertedImage = Image(uiImage: image)
                let model = ImageModel(image: convertedImage, imageId: imageId)
                completion(model)
            }
        }
        .resume()
    }
    
    func routeToDetail(by id: Int) {
        router.showDetails(for: id)
    }
}
