//
//  MainTabView.swift
//  FlowerFresh
//
//  Created by Saba Anwar on 28/07/2025.
//
import SwiftUI

struct MainTabView: View {
    @StateObject private var viewModel = FlowerViewModel(service: FirestoreService()) // Switch to NetworkService() for Mockoon
    @State private var selectedTab: Int = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                FlowerGridView(viewModel: viewModel)
                    .tag(0)
                
                FavoritesView(viewModel: viewModel)
                    .tag(1)
                
                BasketView(viewModel: viewModel)
                    .tag(2)
            }
            
            BottomTabBar(selectedTab: $selectedTab)
                
        }
        .background(Color.red)
        
    }
}
#Preview {
    MainTabView()
}
