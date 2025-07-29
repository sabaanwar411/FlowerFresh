//
//  Favourite.swift
//  FlowerFresh
//
//  Created by Saba Anwar on 28/07/2025.
//
import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: FlowerViewModel
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView("Loading favorites...")
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else if viewModel.favoriteFlowers().isEmpty {
                    Text("No favorite flowers yet")
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.favoriteFlowers()) { flower in
                            NavigationLink(
                                destination: FlowerDetailView(flower: flower, viewModel: viewModel)
                            ) {
                                FlowerCardView(flower: flower, isFavorited: true)
                            }
                            .buttonStyle(ScaleButtonStyle())
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Favorites")
            .background(Color(.systemGroupedBackground))
            .onAppear {
                Logger.shared.debug("Favorites tab appeared", category: "UI")
            }
        }
    }
}
