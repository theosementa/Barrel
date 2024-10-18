//
//  CustomTextField.swift
//  Barrel
//
//  Created by Theo Sementa on 18/10/2024.
//

import SwiftUI

struct CustomTextField: View {
    
    // Builder
    @Binding var text: String
    var config: Configuration
    
    @FocusState private var isFocused: Bool
    
    // MARK: -
    var body: some View {
        Group {
            if config.isSecured {
                SecureField(config.placeholder, text: $text)
            } else {
                TextField(config.placeholder, text: $text)
            }
        }
        .textInputAutocapitalization(config.isAutoCapitalizationEnabled ? .none : .never)
        .focused($isFocused)
        .font(.system(size: 16, weight: .medium))
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.Apple.backgroundComponentSheet)
        }
        .onTapGesture {
            isFocused.toggle()
        }
    } // End body
} // End struct

extension CustomTextField {
    
    struct Configuration {
        var placeholder: String
        var isSecured: Bool
        var isAutoCapitalizationEnabled: Bool
        
        init(placeholder: String, isSecured: Bool = false, isAutoCapitalizationEnabled: Bool = true) {
            self.placeholder = placeholder
            self.isSecured = isSecured
            self.isAutoCapitalizationEnabled = isAutoCapitalizationEnabled
        }
    }
    
}

// MARK: - Preview
#Preview {
    CustomTextField(text: .constant("COUCOU"), config: .init(placeholder: "Test"))
        .preferredColorScheme(.dark)
}
