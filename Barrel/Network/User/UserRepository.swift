//
//  UserRepository.swift
//  Split
//
//  Created by Theo Sementa on 28/05/2024.
//

import Foundation

final class UserRepository: ObservableObject {
    static let shared = UserRepository()
        
    @Published var currentUser: UserModel? = nil
    
    var isUserLogged: Bool {
        return currentUser != nil
    }
}

extension UserRepository {
    
    @MainActor
    func register(body: UserModel) async {
        do {
            let user = try await NetworkService.shared.sendRequest(
                apiBuilder: UserAPIRequester.register(body: body),
                responseModel: UserModel.self
            )
                        
            if let token = user.token, let refreshToken = user.refreshToken {
                TokenManager.shared.setTokenAndRefreshToken(token: token, refreshToken: refreshToken)
            }
            
            self.currentUser = user
        } catch {
            self.currentUser = nil
        }
    }
    
    @MainActor
    func loginWithToken() async throws {
        try await TokenManager.shared.refreshToken()
    }
}
