//
//  MealDetailViewModel.swift
//  Fetch_iOS_CaseyWest
//
//  Created by Casey West on 3/12/25.
//

import SwiftUI

// Note: This class has some sample documentation in Doc-C style, which I have done recently for a project and it was very helpful, so wanted to showcase that style here. Can do Product -> Build Documentation to check it out.

/// The `MealDetailViewModel` is responsible for fetching and managing
/// the details of a selected meal. It coordinates with a service
/// conforming to `MealServiceProtocol` to load data asynchronously
/// and exposes published properties for SwiftUI to observe.
class MealDetailViewModel: MealDetailViewModelProtocol {
    
    // MARK: - Published Properties
    
    /// Contains the detailed data for the currently selected meal, if any.
    @Published var mealDetail: MealDetail?
    
    /// A Boolean indicating whether the view model is currently loading data.
    @Published var isLoading: Bool = false
    
    /// An optional string containing an error message if data loading fails.
    @Published var errorMessage: String? = nil
    
    // MARK: - Private Properties
    
    /// A reference to an object that conforms to `MealServiceProtocol`
    /// for fetching meal details from a remote source.
    private let service: MealServiceProtocol
    
    // MARK: - Initialization
    
    /**
     Initializes a new `MealDetailViewModel`.
     
     - Parameter service: An object that conforms to `MealServiceProtocol`, used
       for fetching meal details. Defaults to a `MealService()` instance.
     */
    init(service: MealServiceProtocol = MealService()) {
        self.service = service
    }
    
    // MARK: - Networking
    
    /**
     Fetches the details for a specific meal identified by `id`.
     
     This method updates the `mealDetail`, `isLoading`, and `errorMessage` properties
     accordingly, using asynchronous operations.
     
     - Parameter id: A string representing the unique identifier of the meal to load.
     */
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
    
    // MARK: - MainActor Helpers
    
    /**
     Sets the loading state of the view model.
     
     - Parameter loading: A Boolean value indicating whether loading is in progress.
     */
    @MainActor
    private func setLoading(_ loading: Bool) {
        self.isLoading = loading
    }
    
    /**
     Sets or clears the error message for the view model.
     
     - Parameter error: A string describing the error, or `nil` to clear any existing error message.
     */
    @MainActor
    private func setError(_ error: String?) {
        self.errorMessage = error
    }
    
    /**
     Updates the `mealDetail` property with fetched meal data.
     
     - Parameter detail: An optional `MealDetail` instance containing the fetched meal's data.
     */
    @MainActor
    private func setMealDetail(_ detail: MealDetail?) {
        self.mealDetail = detail
    }
}
