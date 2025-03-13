//
//  DessertListViewModel.swift
//  Fetch_iOS_CaseyWest
//
//  Created by Casey West on 3/11/25.
//

import SwiftUI

class DessertListViewModel: DessertListViewModelProtocol {
    
    // MARK: Published Properties
    @Published var desserts: [MealListItem] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    @Published var navigationPath = NavigationPath()
    @Published var searchText: String = ""
    
    // MARK: Private Properties
    private let service: MealServiceProtocol
    
    // MARK: Initialization
    init(service: MealServiceProtocol = MealService()) {
        self.service = service
        Task { await fetchDessertList() }
    }
    
    // MARK: Computed Properties
    var filteredDesserts: [MealListItem] {
        if searchText.isEmpty {
            return desserts
        } else {
            return desserts.filter { ($0.strMeal ?? "").localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    // MARK: Networking
    func fetchDessertList() async {
        await setLoading(true)
        
        do {
            let fetchedDesserts = try await service.fetchDessertList()
            let sortedDesserts = fetchedDesserts.sorted { ($0.strMeal ?? "") < ($1.strMeal ?? "") }
            await setDesserts(sortedDesserts)
        } catch {
            await setError("Failed to load desserts: \(error.localizedDescription)")
        }
        
        await setLoading(false)
    }

    // MARK: MainActor Helpers
    @MainActor
    private func setLoading(_ isLoading: Bool) {
        self.isLoading = isLoading
    }

    @MainActor
    private func setDesserts(_ newDesserts: [MealListItem]) {
        self.desserts = newDesserts
    }

    @MainActor
    private func setError(_ error: String?) {
        self.errorMessage = error
    }
    
    // MARK: Navigation
    func navigateToDessert(_ mealId: String) {
        navigationPath.append(DessertListRoute.mealDetail(mealID: mealId))
    }
    
    func popToRoot() {
        navigationPath = NavigationPath()
    }
    
    func popBackOne() {
        navigationPath.removeLast()
    }
}
