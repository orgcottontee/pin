//
//  SafariView.swift
//  JingPin
//
//  Created by adobada on 4/16/24.
//

import SwiftUI

struct OpenSafariView: View {
    
    @Binding var showSafari: Bool
    var title: String
    var url: String
    
    var body: some View {
        Button {
            showSafari = true
        } label: {
            ActionButtonView(smallText: title, icon: "globe")
        }
            .popover(isPresented: $showSafari) {
                SafariViewWrapper(url: URL(string: url)!)
        }
    }
}

#Preview {
    OpenSafariView(showSafari: .constant(true),
               title: "Testing Safari",
               url: "https://www.apple.com" )
}
