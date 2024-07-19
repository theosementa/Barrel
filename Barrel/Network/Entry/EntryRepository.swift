//
//  EntryRepository.swift
//  Barrel
//
//  Created by KaayZenn on 19/07/2024.
//

import Foundation

final class EntryRepository: ObservableObject {
    static let shared = EntryRepository()
    
    @Published var entries: [EntryResponse] = []
}

extension EntryRepository {
    
    @MainActor
    func fetchEntries() async {
        do {
            let entries = try await NetworkService.shared.sendRequest(
                apiBuilder: EntryAPIRequester.getEntries,
                responseModel: [EntryResponse].self
            )
            
            self.entries = entries
        } catch let error {
            if let networkError = error as? NetworkError {
                BannerManager.shared.banner = networkError.banner
            }
        }
    }
    
    @MainActor
    func createEntry(body: EntryBody) async {
        do {
            let entry = try await NetworkService.shared.sendRequest(
                apiBuilder: EntryAPIRequester.createEntry(body: body),
                responseModel: EntryResponse.self
            )
            
            self.entries.append(entry)
        } catch let error {
            if let networkError = error as? NetworkError {
                BannerManager.shared.banner = networkError.banner
            }
        }
    }
    
}
