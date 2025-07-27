//
//  FlowerDetailView.swift
//  FlowerFresh
//
//  Created by Saba Anwar on 19/07/2025.
//
import SwiftUI

struct FlowerDetailView: View {
    let flower: Flower
    @ObservedObject var viewModel: FlowerViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView{
            VStack(spacing: 20) {
                Image(flower.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 5)
                
                Text(flower.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text(String(format: "$%.2f", flower.price))
                    .font(.title2)
                    .foregroundColor(.secondary)
                
                Text("Available: \(flower.availability)")
                    .font(.title3)
                    .foregroundColor(.secondary)
                
                Button(action: {
                    if let flowerID = flower.id {
                        viewModel.toggleFavorite(flowerID: flowerID)
                    }
                }) {
                    HStack {
                        Image(systemName: viewModel.isFavorite(flowerID: flower.id ?? "") ? "heart.fill" : "heart")
                        Text(viewModel.isFavorite(flowerID: flower.id ?? "") ? "Remove from Favorites" :
                                "Add to Favorites")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.isFavorite(flowerID: flower.id ?? "") ? Color.red.opacity(0.2) : Color.blue.opacity(0.2))
                    .foregroundColor(.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                Button(action: {
                    print("Proceeding to checkout for \(flower.name)")
                }) {
                    Text("Checkout")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green.opacity(0.2))
                        .foregroundColor(.primary)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                Spacer()
            }
            .padding()
            .background(Color(.systemGroupedBackground))
            .navigationBarHidden(true)
        }
    }
}
