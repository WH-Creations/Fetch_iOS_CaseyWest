//
//  DessertListView.swift
//  Fetch_iOS_CaseyWest
//
//  Created by Casey West on 3/11/25.
//

import SwiftUI

// MARK: Dessert List Navigation Routes
enum DessertListRoute: Hashable {
    case mealDetail(mealID: String)
}

// MARK: - DessertListView
struct DessertListView<VM: DessertListViewModelProtocol>: View {
    
    // MARK: Properties
    @StateObject var viewModel: VM
    
    // MARK: Initialization
    init(viewModel: VM) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: Body
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            Group {
                if viewModel.isLoading {
                    loadingView
                } else if let errorMessage = viewModel.errorMessage {
                    errorView(message: errorMessage)
                } else {
                    dessertListView
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "Search desserts")
            .navigationTitle("Desserts")
            .navigationDestination(for: DessertListRoute.self) { route in
                switch route {
                case .mealDetail(let mealID):
                    MealDetailView(
                        mealId: mealID,
                        viewModel: MealDetailViewModel(service: MealService())
                    )
                }
            }
        }
    }
}

// MARK: Private Subviews
private extension DessertListView {
    
    // MARK: Loading View
    @ViewBuilder
    var loadingView: some View {
        ProgressView("Loading desserts...")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: Error View
    func errorView(message: String) -> some View {
        Text(message)
            .foregroundColor(.red)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: Desserts List
    @ViewBuilder
    var dessertListView: some View {
        List(viewModel.filteredDesserts) { dessert in
            dessertRow(for: dessert)
        }
    }
    
    // MARK: Dessert Row
    func dessertRow(for dessert: MealListItem) -> some View {
        Button {
            if let validMealId = dessert.idMeal {
                viewModel.navigateToDessert(validMealId)
            } else {
                // This we'd likely want to put into an alert or something. Right now it wipes the list.
                // Easy enough to change but time is limitation.
                viewModel.errorMessage = "Unable to locate selected meal details."
            }
        } label: {
            HStack {
                // Basic image loading with some free caching from the underlying URLSession. In a proper
                // release we'd likely want a more robust cacheing mechanism.
                AsyncImage(url: URL(string: dessert.strMealThumb ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.trailing, 8)
                
                Text(dessert.strMeal ?? "")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
        }
    }
}
