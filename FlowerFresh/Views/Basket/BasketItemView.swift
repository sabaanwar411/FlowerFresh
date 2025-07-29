//
//  BasketItemView.swift
//  FlowerFresh
//
//  Created by Saba Anwar
//
import SwiftUI

struct BasketItemView: View {
    let flower: Flower
    let quantity: Int
    @ObservedObject var viewModel: FlowerViewModel
    @State private var isRemoving = false
    
    var body: some View {
        HStack {
            Image(flower.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading) {
                Text(flower.name)
                    .font(.headline)
                Text(String(format: "$%.2f x %d", flower.price, quantity))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: {
                withAnimation(.easeInOut) {
                    isRemoving = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        viewModel.removeFromBasket(flowerID: flower.id!)
                    }
                }
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
                    .padding(8)
                    .background(Color.red.opacity(0.1))
                    .clipShape(Circle())
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 3)
        .padding(.horizontal)
        .opacity(isRemoving ? 0 : 1)
    }
}

