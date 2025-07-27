//
//  FlowerFreshApp.swift
//  FlowerFresh
//
//  Created by Saba Anwar on 15/07/2025.
//

import SwiftUI
import Combine
@main
struct FlowerFreshApp: App {
    // Link AppDelegate to SwiftUI
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            FlowerGridView(viewModel: FlowerViewModel(service: FirestoreService())) // Switch to NetworkService() if needed
        }
    }
}
