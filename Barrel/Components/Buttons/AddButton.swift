//
//  AddButton.swift
//  Barrel
//
//  Created by Theo Sementa on 18/10/2024.
//

import SwiftUI

struct AddButton: View {
    
    // builder
    var action: () -> Void
    
    // MARK: -
    var body: some View {
        Button(action: action) {
            Circle()
                .frame(width: 58, height: 58)
                .overlay {
                    Image(systemName: "plus")
                        .foregroundStyle(Color.white)
                        .font(.system(size: 18, weight: .bold))
                }
        }
    } // body
} // struct

// MARK: -
#Preview {
    AddButton(action: {})
}
