//
//  ImageDetailView.swift
//  GalleryApp
//
//  Created by Bekarys on 04.04.2025.
//

import SwiftUI

struct ImageDetailView: View {
    let id: Int
    @StateObject var viewModel: ImageDetailViewModel
    
    init(id: Int, service: ImageService) {
        self.id = id
        _viewModel = StateObject(wrappedValue: ImageDetailViewModel(service: service))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let imageModel = viewModel.image {
                    imageView(imageModel.downloadURL)
                    
                    imageAuthor(imageModel.author)
                   
                } else {
                    ProgressView()
                }
            }
            .padding()
        }
        .task {
            await viewModel.fetchImageDetail(id: id)
        }
    }
}

extension ImageDetailView {
    
    @ViewBuilder
    private func imageView(_ url: URL?) -> some View {
        HStack {
            AsyncImage(url: url) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                default:
                    Color.gray
                        .frame(height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    private func imageAuthor(_ author: String) -> some View {
        Text("Author: " + author)
            .font(.largeTitle)
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
    }
}
