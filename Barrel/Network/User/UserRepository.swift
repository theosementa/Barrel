//
//  UserRepository.swift
//  Split
//
//  Created by KaayZenn on 28/05/2024.
//

import Foundation

final class UserRepository: ObservableObject {
    static let shared = UserRepository()
    
    @Published var isUserLogged: Bool = false
    
    @Published var currentUser: UserResponse? = nil
}

extension UserRepository {
    
    @MainActor
    func register() async {
        do {
            let user = try await NetworkService.shared.sendRequest(
                apiBuilder: UserAPIRequester.register,
                responseModel: UserResponse.self
            )
            
            print("🔥 USER : \(user.token)")
            
            if let token = user.token {
                KeychainManager.shared.setItemToKeychain(newValue: token, service: .token)
            }
            
            self.currentUser = user
        } catch let error {
            if let networkError = error as? NetworkError {
                BannerManager.shared.banner = networkError.banner
            }
        }
    }
    
    @MainActor
    func login() async {
        do {
            let user = try await NetworkService.shared.sendRequest(
                apiBuilder: UserAPIRequester.login,
                responseModel: UserResponse.self
            )
            
            self.currentUser = user
        } catch let error {
            if let networkError = error as? NetworkError {
                BannerManager.shared.banner = networkError.banner
            }
        }
    }
    
}
