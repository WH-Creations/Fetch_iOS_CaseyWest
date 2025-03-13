//
//  MealDetailViewModel.swift
//  Fetch_iOS_CaseyWest
//
//  Created by Casey West on 3/12/25.
//

import SwiftUI

class MealDetailViewModel: MealDetailViewModelProtocol {
    
    // MARK: Published Properties
    @Published var mealDetail: MealDetail?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    // MARK: Private Properties
    private let service: MealServiceProtocol
    
    // MARK: Initialization
    init(service: MealServiceProtocol = MealService()) {
        self.service = service
    }
    
    // MARK: Networking
    func fetchMealDetail(id: String) async {
        await setLoading(true)
        
        do {
            let detail = try await service.fetchMealDetail(id: id)
            await setMealDetail(detail)
        } catch {
            await setError("Failed to load meal details: \(error.localizedDescription)")
        }
        
        await setLoading(false)
    }
    
    // MARK: MainActor Helpers
    @MainActor
    private func setLoading(_ loading: Bool) {
        self.isLoading = loading
    }
    
    @MainActor
    private func setError(_ error: String?) {
        self.errorMessage = error
    }
    
    @MainActor
    private func setMealDetail(_ detail: MealDetail?) {
        self.mealDetail = detail
    }
}
