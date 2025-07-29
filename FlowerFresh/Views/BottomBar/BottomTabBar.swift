//
//  BottomTabBar.swift
//  FlowerFresh
//
//  Created by Saba Anwar
//
import SwiftUI
struct BottomTabBar: View {
    @Binding var selectedTab: Int
    
    var body: some View {
        HStack {
            TabBarButton(icon: "house.fill", label: "Home", isSelected: selectedTab == 0) {
                selectedTab = 0
                Logger.shared.debug("Switched to Home tab", category: "UI")
            }
            Spacer()
            TabBarButton(icon: "cart.fill", label: "Basket", isSelected: selectedTab == 2) {
                selectedTab = 2
                Logger.shared.debug("Switched to Basket tab", category: "UI")
            }
            Spacer()
            TabBarButton(icon: "heart.fill", label: "Favorites", isSelected: selectedTab == 1) {
                selectedTab = 1
                Logger.shared.debug("Switched to Favorites tab", category: "UI")
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .background(Color(.systemBackground).opacity(0.95))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}


