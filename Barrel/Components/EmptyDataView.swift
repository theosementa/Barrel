//
//  EmptyDataView.swift
//  Barrel
//
//  Created by KaayZenn on 27/04/2024.
//

import SwiftUI

struct EmptyDataView: View {
    
    // Builder
    var image: ImageResource
    var title: String
    var actionTitle: String
    var action: () -> Void
    
    // MARK: -
    var body: some View {
        VStack(spacing: 12) {
            Image(image)
                .resizable()
                .frame(width: 100, height: 100)
            
            VStack(spacing: 2) {
                Text(title)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                Button {
                    action()
                } label: {
                    Text(actionTitle)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.customYellow)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    EmptyDataView(image: .fuelStation, title: "Preveiw title", actionTitle: "Do something", action: {})
}
