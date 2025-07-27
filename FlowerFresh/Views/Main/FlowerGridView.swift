//
//  FlowerGridView.swift
//  FlowerFresh
//
//  Created by Saba Anwar on 19/07/2025.
//

import SwiftUI
import Combine

struct FlowerGridView: View {
    @ObservedObject var viewModel: FlowerViewModel
    
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.flowers) { flower in
                            NavigationLink(
                                destination: FlowerDetailView(flower: flower, viewModel: viewModel)
                            ) {
                                FlowerCardView(flower: flower, isFavorited: viewModel.isFavorite(flowerID: flower.id ?? ""))
                            }
                            .buttonStyle(ScaleButtonStyle())
                        }
                    }
                    .padding()
                }
                .navigationTitle("Flower Shop")
                .background(Color(.systemGroupedBackground))
                .onAppear {
                    viewModel.fetchFlowers()
                }
            }
        }
    }
struct FlowerGridView_Previews: View {
    var body: some View {
        FlowerGridView(viewModel: FlowerViewModel(service: FirestoreService()))
    }
}

#Preview {
    FlowerGridView(viewModel: FlowerViewModel(service: FirestoreService()))
        .environment(\.colorScheme, .light)
}
