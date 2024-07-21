//
//  SplashScreenView.swift
//  Barrel
//
//  Created by KaayZenn on 21/07/2024.
//

import SwiftUI

struct SplashScreenView: View {
    
    // MARK: -
    var body: some View {
        VStack {
            Text("Barrel")
                .font(.system(size: 34, weight: .bold, design: .rounded))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .bottom) {
            ProgressView()
                .padding(.bottom)
        }
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    SplashScreenView()
}
