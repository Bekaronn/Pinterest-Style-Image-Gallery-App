//
//  ImageService.swift
//  GalleryApp
//
//  Created by Bekarys on 04.04.2025.
//

import Foundation
import SwiftUI

protocol ImageService {
    func fetchImageDetailById(id: Int) async throws -> ImageEntity
}

struct ImageServiceImpl: ImageService {
    func fetchImageDetailById(id: Int) async throws -> ImageEntity {
        let urlString = "https://picsum.photos/id/\(id)/info"
        
        guard let url = URL(string: urlString) else {
            throw ImageError.wrongUrl
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse?.statusCode ?? 0)
            
            let image = try JSONDecoder().decode(ImageEntity.self, from: data)
            return image
        } catch {
            print(error)
            throw ImageError.somethingWentWrong
        }
    }
}

enum ImageError: Error {
    case wrongUrl
    case somethingWentWrong
}
