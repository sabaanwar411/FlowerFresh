//
//  NetworkService.swift
//  FlowerFresh
//
//  Created by Saba Anwar on 19/07/2025.
//
import SwiftUI
import Combine

protocol FlowerService {
    func fetchFlowers() -> AnyPublisher<[Flower], Error>
}
class NetworkService: FlowerService {
    
    func fetchFlowers() -> AnyPublisher<[Flower], Error> {
        guard let url = URL(string: "\(Constants.BASE_API_URL)/flowers") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Flower].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
