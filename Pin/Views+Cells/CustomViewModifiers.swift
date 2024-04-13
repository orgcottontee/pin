//
//  CustomViewModifiers.swift
//  JingPin
//
//  Created by adobada on 4/12/24.
//

import SwiftUI

struct TextFieldSubmissionStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.custom(UniversFont.light, size: 14))
            .kerning(1.2)
            .autocorrectionDisabled(true)
            .padding(.horizontal)
            .padding(.top, 20)
        Rectangle()
            .frame(height: 1)
            .padding(.horizontal)
            .foregroundColor(.gray)
    }
}
