//
//  BoutiqueCellView.swift
//  Pin
//
//  Created by adobada on 4/3/24.
//

import SwiftUI

struct BoutiqueCellView: View {
    
    var boutiqueLocation: UnitedStatesBoutique
    
    var body: some View {
        
        VStack {
            ZStack(alignment: .topTrailing) {
                LogoView(image: boutiqueLocation.createSquareLogo(),
                         frameWidth: 250)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                // TODO: Add logic to only show a filled heart icon if they've liked that boutique. Don't show an outline-only heart since they can't click it - they'll be sent to detail screen when they click anywhere on the Logo image 
                Image(systemName: "heart")
                    .foregroundStyle(.favorited)
                    .padding()
            }
            CityStateView(city: boutiqueLocation.city, state: boutiqueLocation.state)
        }
        .padding(.bottom, 30)
    }
}

#Preview {
    BoutiqueCellView(boutiqueLocation: UnitedStatesBoutique(record: MockData.boutiqueLocation))
}

fileprivate struct CityStateView: View {
    
    var city: String
    var state: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray).opacity(0.1)
                .frame(width: 250, height: 50)
            Text("\(city), \(state)")
                .applyJPBody(.listScreenAccent)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
                .truncationMode(.tail)
        }
    }
}
