//
//  FlowerViewModel.swift
//  FlowerFresh
//
//  Created by Saba Anwar on 19/07/2025.
//
import SwiftUI
import Combine

class FlowerViewModel: ObservableObject {
    @Published private(set) var flowers: [Flower] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?
    @Published private(set) var basket: [String: Int] = [:] // Flower ID: Quantity
    
    private let basketKey = "basketItems"
    private let favoritesKey = "favoriteFlowerIDs"
    private let service: FlowerService
    
    private var cancellables = Set<AnyCancellable>()
    
    init(service: FlowerService = NetworkService()) {
        self.service  = service
    }
    
    func fetchFlowers() {
        isLoading = true
        errorMessage = nil
        service.fetchFlowers()
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = "Failed to fetch flowers: \(error.localizedDescription)"
                }
            } receiveValue: { [weak self] flowers in
                self?.flowers = flowers
                Logger.shared.debug("All flowers are fetched")
            }
            .store(in: &cancellables)
    }
    
    func favoriteFlowers() -> [Flower] {
        flowers.filter { isFavorite(flowerID: $0.id!) }
        }
    func isFavorite(flowerID: String) -> Bool {
        let favoriteIDs = UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
        return favoriteIDs.contains(flowerID)
    }
    
    func toggleFavorite(flowerID: String) {
        var favoriteIDs = UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
        if favoriteIDs.contains(flowerID) {
            favoriteIDs.removeAll { $0 == flowerID }
        } else {
            favoriteIDs.append(flowerID)
        }
        UserDefaults.standard.set(favoriteIDs, forKey: favoritesKey)
        objectWillChange.send()
    }
    
    func addToBasket(flowerID: String, quantity: Int) {
        guard quantity > 0, let flower = flowers.first(where: { $0.id == flowerID }), flower.availability >= quantity else {
            Logger.shared.debug("Cannot add flower \(flowerID) to basket: Invalid quantity or unavailable", category: "Basket")
            return
        }
        var basket = self.basket
        basket[flowerID, default: 0] += quantity
        self.basket = basket
        saveBasket()
        Logger.shared.debug("Added \(quantity) of flower \(flowerID) to basket", category: "Basket")
        objectWillChange.send()
    }
    
    func removeFromBasket(flowerID: String) {
        var basket = self.basket
        basket.removeValue(forKey: flowerID)
        self.basket = basket
        saveBasket()
        Logger.shared.debug("Removed flower \(flowerID) from basket", category: "Basket")
        objectWillChange.send()
    }
    
    func clearBasket() {
        basket = [:]
        saveBasket()
        Logger.shared.debug("Cleared basket", category: "Basket")
        objectWillChange.send()
    }
    
    func basketTotal() -> Double {
        let total = flowers.reduce(0.0) { total, flower in
            guard let quantity = basket[flower.id!] else { return total }
            return total + flower.price * Double(quantity)
        }
        Logger.shared.debug("Calculated basket total: $\(String(format: "%.2f", total))", category: "Basket")
        return total
    }
    
    private func loadBasket() {
        if let savedBasket = UserDefaults.standard.dictionary(forKey: basketKey) as? [String: Int] {
            basket = savedBasket
            Logger.shared.debug("Loaded basket with \(savedBasket.count) items", category: "Basket")
        }
    }
    
    private func saveBasket() {
        UserDefaults.standard.set(basket, forKey: basketKey)
        Logger.shared.debug("Saved basket to UserDefaults", category: "Basket")
    }
}
