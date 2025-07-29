//
//  BasketView.swift
//  FlowerFresh
//
//  Created by Saba Anwar
//
import SwiftUI

struct BasketView: View {
    @ObservedObject var viewModel: FlowerViewModel
    
    var body: some View {
        NavigationView {
            VStack{
                if viewModel.basket.isEmpty {
                    Text("Your basket is empty")
                        .foregroundColor(.black)
                }else{
                    ScrollView {
                        VStack(spacing: 15) {
                           
                                ForEach(viewModel.flowers.filter { viewModel.basket[$0.id!] != nil }) { flower in
                                    BasketItemView(flower: flower, quantity: viewModel.basket[flower.id!]!, viewModel: viewModel)
                                        .transition(.asymmetric(insertion: .scale.combined(with: .opacity), removal: .opacity))
                                }
                                HStack {
                                    Text("Total: $\(String(format: "%.2f", viewModel.basketTotal()))")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    Spacer()
                                    Button(action: {
                                        withAnimation(.easeInOut) {
                                            viewModel.clearBasket()
                                        }
                                    }) {
                                        Text("Clear Basket")
                                            .padding()
                                            .background(Color.red.opacity(0.2))
                                            .foregroundColor(.primary)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    }
                                }
                                .padding(.horizontal)
                            Button(action: {
                                print("Proceeding to checkout")
                            }) {
                                Text("Checkout")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.green.opacity(0.2))
                                    .foregroundColor(.primary)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                        .padding()
                        
                    }
                    
                }
            }
            .navigationTitle("Basket")
            .background(Color(.systemGroupedBackground))
            .onAppear {
                Logger.shared.debug("Basket tab appeared", category: "UI")
            }
            
        }
    }
}
//#Preview {
//    MainTabView()
//}
