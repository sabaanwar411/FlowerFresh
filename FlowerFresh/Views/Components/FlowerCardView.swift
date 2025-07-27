//
//  FlowerCardView.swift
//  FlowerFresh
//
//  Created by Saba Anwar on 19/07/2025.
//
import SwiftUI

struct FlowerCardView: View {
    let flower: Flower
    let isFavorited: Bool
    @State private var isTapped = false
    
    var body: some View {
        VStack {
            Image(flower.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
            
            Text(flower.name)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(String(format: "$%.2f", flower.price))
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text("Available: \(flower.availability)")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Image(systemName: isFavorited ? "heart.fill" : "heart")
                .foregroundColor(isFavorited ? .red : .gray)
                .font(.caption)
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 5)
    }
}
