//
//  ImageDetailViewModel.swift
//  GalleryApp
//
//  Created by Bekarys on 04.04.2025.
//

import SwiftUI

final class ImageDetailViewModel: ObservableObject {
    @Published private(set) var image: ImageDetailModel? = nil
    
    private let service: ImageService
    
    init(service: ImageService) {
        self.service = service
    }
    
    func fetchImageDetail(id: Int) async {
        do {
            let imageResponse = try await service.fetchImageDetailById(id: id)
            
            // Преобразуем строку в URL
            guard let downloadURL = URL(string: imageResponse.download_url) else {
                print("Invalid URL string: \(imageResponse.download_url)")
                return
            }

            let imageModel = ImageDetailModel(
                id: imageResponse.id,
                author: imageResponse.author,
                width: imageResponse.width,
                height: imageResponse.height,
                url: imageResponse.url,
                downloadURL: downloadURL
            )

            await MainActor.run {
                self.image = imageModel
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
