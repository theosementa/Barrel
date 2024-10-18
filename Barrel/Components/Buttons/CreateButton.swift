//
//  CreateButton.swift
//  TCO
//
//  Created by Theo Sementa on 02/10/2024.
//

import SwiftUI

struct CreateButton: View {
    
    // Builder
    var text: String
    var action: () -> Void
    
    // MARK: -
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Capsule())
        }
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    CreateButton(text: "Hello", action: {})
        .padding()
}
