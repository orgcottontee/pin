//
//  CustomPickerView.swift
//  JingPin
//
//  Created by adobada on 4/29/24.
//

import SwiftUI

struct CustomPickerView: View {
    
    @Binding var selectedState: USState
    private let rows = [GridItem(.fixed(30))]
    private let states = USState.allCases
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    var body: some View {
        
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 14) {
                ForEach(states) { stateName in
                    Button {
                        withAnimation {
                            selectedState = stateName
                        }
                    } label: {
                        ZStack {
                            Capsule()
                                .fill(selectedState == stateName ? Color.App.accent : Color.secondary)
                                .frame(height: 40)
                            Text(stateName.state)
                                .applyJPBody(.App.background)
                                .padding(.horizontal)
                        }
                    }
                }
            }
            .frame(height: 44)
        }
        .scrollIndicators(.hidden)
        
    }
}

#Preview {
    CustomPickerView(selectedState: .constant(.california))
}
