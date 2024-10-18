//
//  ContentView.swift
//  Barrel
//
//  Created by Theo Sementa on 18/10/2024.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var userRepository: UserRepository
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("\(userRepository.currentUser?.username ?? "Fail to get username")")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
