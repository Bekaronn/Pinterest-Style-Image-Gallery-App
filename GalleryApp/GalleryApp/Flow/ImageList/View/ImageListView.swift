//
//  ImageListView.swift
//  GalleryApp
//
//  Created by Bekarys on 04.04.2025.
//

import SwiftUI

struct ImageListView: View {
    @StateObject var viewModel: ImageListViewModel
    @State private var isAtBottom = false
    
    var body: some View {
        listOfImages()
        .task {
            viewModel.getImages()
        }
    }
}

extension ImageListView {
    @ViewBuilder
    private func listOfImages() -> some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 10),
                GridItem(.flexible(), spacing: 10)
            ]) {
                ForEach(viewModel.images) { model in
                    imageCard(model: model)
                }
            }.padding([.leading, .trailing, .bottom], 10)
            .onChange(of: isAtBottom) {
                if isAtBottom {
                    viewModel.getImages {
                        isAtBottom = false
                    }
                }
            }
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
            }
        }
        .refreshable {
            await viewModel.refreshImages()
        }
        .scrollIndicators(.hidden)
    }
    
    @ViewBuilder
    private func imageCard(model: ImageModel) -> some View {
        model.image
            .resizable()
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .onAppear {
                if model.id == viewModel.images.last?.id {
                    print("isAtBottom = true")
                    isAtBottom = true
                }
            }.onTapGesture {
                print("Tapped \(model.id)")
                viewModel.routeToDetail(by: model.imageId)
            }
    }
}
