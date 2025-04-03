//
//  ImageRouter.swift
//  GalleryApp
//
//  Created by Bekarys on 04.04.2025.
//

import SwiftUI
import UIKit

final class ImageRouter {
    var rootViewController: UINavigationController?
    
    func showDetails(for id: Int) {
        let service = ImageServiceImpl()
        let detailVC = UIHostingController(rootView: ImageDetailView(id: id, service: service))
        rootViewController?.pushViewController(detailVC, animated: true)
    }
}
