//
//  SignInViewModel.swift
//  Barrel
//
//  Created by Theo Sementa on 18/10/2024.
//

import Foundation

final class SignInViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var password: String = ""
    
}
