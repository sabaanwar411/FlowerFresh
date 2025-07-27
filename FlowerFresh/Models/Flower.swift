//
//  Flower.swift
//  FlowerFresh
//
//  Created by Saba Anwar on 15/07/2025.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

struct Flower: Identifiable, Codable {
    @DocumentID var id: String?
    let name: String
    let imageName: String
    let price: Double
    let availability: Int
}
