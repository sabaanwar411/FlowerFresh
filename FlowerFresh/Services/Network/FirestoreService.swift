//
//  FirestoreService.swift
//  FlowerFresh
//
//  Created by Saba Anwar on 19/07/2025.
//
import FirebaseCore
import FirebaseFirestore
import Combine

class FirestoreService: FlowerService {
    
    private let db = Firestore.firestore()
    
    func fetchFlowers() -> AnyPublisher<[Flower], Error> {
        Future { promise in
            self.db.collection("flowers").addSnapshotListener { (querySnapshot, error) in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                
                guard let documents = querySnapshot?.documents else {
                    promise(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No flowers found"])))
                    return
                }
                
                let flowers = documents.compactMap { document in
                    try? document.data(as: Flower.self)
                }
                promise(.success(flowers))
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
