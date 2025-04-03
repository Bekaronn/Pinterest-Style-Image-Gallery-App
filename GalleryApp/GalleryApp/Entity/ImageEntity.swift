//
//  ImageEntity.swift
//  GalleryApp
//
//  Created by Bekarys on 04.04.2025.
//

import Foundation

struct ImageEntity: Decodable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let download_url: String
}
