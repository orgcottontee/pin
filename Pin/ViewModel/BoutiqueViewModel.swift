//
//  BoutiqueMapViewModel.swift
//  Pin
//
//  Created by adobada on 4/10/24.
//

import MapKit
import SwiftUI

final class BoutiqueViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var alertItem: AlertItem?
    @Published var isShowingOnboardingView: Bool = true
    @Published var isLoading: Bool = false
    
    // MARK: - Actions
    
    @MainActor
    func getUSBoutiques(for locationManager: BoutiqueManager) {
        
        showLoadingView()
        
        Task {
            do {
                locationManager.locations = try await CloudKitManager.shared.fetchUSBoutiques()
                hideLoadingView()
            } catch {
                hideLoadingView()
                alertItem = AlertContext.unableToGetLocations
                print(error.localizedDescription)
            }
        }
    }
    
    private func showLoadingView() { return isLoading = true }
    private func hideLoadingView() { return isLoading = false }
}
