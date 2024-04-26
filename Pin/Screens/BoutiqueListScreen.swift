//
//  BoutiqueListScreen.swift
//  Pin
//
//  Created by adobada on 4/3/24.
//

import SwiftUI
import SwiftData
import CloudKit

struct BoutiqueListScreen: View {
    
    @Environment(BoutiqueManager.self) private var boutiqueManager
    @State private var viewModel = BoutiqueViewModel()
    
    private var filterResults: [UnitedStatesBoutique] {
        viewModel.selectedState == .allStates ? searchResults : boutiqueManager.locations.filter { $0.state == viewModel.selectedState.rawValue }
    }
    
    private var searchResults: [UnitedStatesBoutique] {
        viewModel.searchText.isEmpty ? boutiqueManager.locations : boutiqueManager.locations.filter { $0.name.localizedCaseInsensitiveContains(viewModel.searchText) }
    }
    
    var body: some View {
        if !viewModel.isLoading {
            NavigationStack {
                ZStack {
                    Color(.MainScreen.background).ignoresSafeArea()
                    VStack {
                        SearchFilterView(isSearchTextfieldVisible: $viewModel.isSearchTextfieldVisible,
                                         selectedState: $viewModel.selectedState,
                                         searchText: $viewModel.searchText)
                        ListView(filterResults: filterResults)
                            .navigationDestination(for: UnitedStatesBoutique.self) { boutique in
                                BoutiqueDetailScreen(viewModel: BoutiqueDetailViewModel(boutiqueLocation: boutique))
                            }
                    }
                }
                .onAppear {
                    if boutiqueManager.locations.isEmpty { viewModel.getUSBoutiques(for: boutiqueManager) }
                }
            }
            .tint(.App.accent)
        } else {
            ProgressView()
                .alert(isPresented: $viewModel.hasError,
                       error: viewModel.jingPinError) {
                    Button("Retry") {
                        if boutiqueManager.locations.isEmpty { viewModel.getUSBoutiques(for: boutiqueManager) }
                    }
                }
        }
    }
}

#Preview {
    BoutiqueListScreen()
        .environment(BoutiqueManager())
}

fileprivate struct SearchFilterView: View {
    
    @Binding var isSearchTextfieldVisible: Bool
    @Binding var selectedState: USState
    @Binding var searchText: String
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    withAnimation(.smooth) {
                        isSearchTextfieldVisible.toggle()
                    }
                } label: {
                    Label("Search", systemImage: isSearchTextfieldVisible ? ListScreenConstant.activeSearchIcon : ListScreenConstant.searchIcon)
                        .labelStyle(.iconOnly)
                        .applyJPBody(.App.accent)
                }
                Picker("Filter by State", selection: $selectedState) {
                    ForEach(USState.allCases) { state in
                        Text(state.state)
                            .tag(state)
                    }
                }
            }
            if isSearchTextfieldVisible {
                TextField("Search boutique", text: $searchText)
                    .applyJPTextfield()
            }
        }
    }
}

fileprivate struct ListView: View {
    
    var filterResults: [UnitedStatesBoutique]
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(filterResults) { boutique in
                    NavigationLink(value: boutique) {
                        BoutiqueCellView(boutiqueLocation: boutique)
                    }
                }
            }
        }
        .padding()
    }
}
