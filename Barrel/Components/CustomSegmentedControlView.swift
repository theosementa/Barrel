//
//  CustomSegmentedControlView.swift
//  Barrel
//
//  Created by KaayZenn on 28/04/2024.
//

import SwiftUI

struct CustomSegmentedControlView: View {
    
    // Builder
    var texts: [String]
    @Binding var selectedIndex: Int
    
    // MARK: -
    var body: some View {
        HStack(spacing: 0) {
            ForEach(texts.indices, id: \.self) { index in
                let text = texts[index]
                
                Button {
                    withAnimation { self.selectedIndex = index }
                } label: {
                    Text(text)
                        .foregroundStyle(Color.customYellow)
                        .fontWeight(selectedIndex == index ? .semibold : .regular)
                        .frame(maxWidth: .infinity)
                        .padding(8)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 2)
        .background {
            GeometryReader { proxy in
                let caseCount = texts.count
                Color.customYellow.opacity(0.1)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(width: proxy.size.width / CGFloat(caseCount))
                    .offset(x: proxy.size.width / CGFloat(caseCount) * CGFloat(selectedIndex))
                    .transition(
                        .asymmetric(insertion: .opacity.animation(
                            .linear(duration: 0.1).delay(0.15)),
                                    removal: .opacity.animation(
                                        .linear(duration: 0.1)
                                    )
                        )
                    )
            }
        }
        .padding(8)
        .backgroundComponent(isPaddingEnabled: false)
    } // End body
} // End struct

// MARK: - Preview
#Preview {
    @State var indexPreview: Int = 0
    
    return CustomSegmentedControlView(
        texts: ["Test 1", "Test 2", "Test 3"],
        selectedIndex: $indexPreview)
            .preferredColorScheme(.dark)
            .padding()
}
