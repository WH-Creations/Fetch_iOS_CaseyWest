//
//  DessertListViewModelProtocol.swift
//  Fetch_iOS_CaseyWest
//
//  Created by Casey West on 3/12/25.
//

import SwiftUI

protocol DessertListViewModelProtocol: ObservableObject {
    
    // MARK: Published properties
    var desserts: [MealListItem] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get set }
    var navigationPath: NavigationPath { get set }
    var searchText: String { get set }
    
    // MARK: Computed properties
    // Used for filtered results. This is not the most performant thing ever having
    // this be computed but time is a factor and I want to include a search sample.
    var filteredDesserts: [MealListItem] { get }
    
    // MARK: Functions
    func fetchDessertList() async
    func navigateToDessert(_ mealId: String)
    func popToRoot()
    func popBackOne()
}
