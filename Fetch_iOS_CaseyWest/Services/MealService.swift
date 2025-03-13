//
//  MealService.swift
//  Fetch_iOS_CaseyWest
//
//  Created by Casey West on 3/11/25.
//

import Foundation

struct MealService: MealServiceProtocol {
    
    // MARK: Properties
    private let baseURL = "https://themealdb.com/api/json/v1/1"
    
    // MARK: Endpoints
    private enum Endpoints {
        static let dessertList = "/filter.php?c=Dessert"
        
        static func mealDetail(_ mealID: String) -> String {
            "/lookup.php?i=\(mealID)"
        }
    }
    
    // MARK: Dessert List
    func fetchDessertList() async throws -> [MealListItem] {
        guard let url = URL(string: baseURL + Endpoints.dessertList) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(DessertListResponse.self, from: data)
        
        // Filter out any items where `idMeal` or `strMeal` is nil/empty per the spec.
        let validMeals = decoded.meals.compactMap { item -> MealListItem? in
            guard
                let mealId = item.idMeal, !mealId.isEmpty,
                let mealName = item.strMeal, !mealName.isEmpty
            else {
                return nil
            }
            
            return MealListItem(
                strMeal: mealName,
                strMealThumb: item.strMealThumb,
                idMeal: mealId
            )
        }
        
        return validMeals
    }
    
    // MARK: Meal Detail
    func fetchMealDetail(id: String) async throws -> MealDetail? {
        guard let url = URL(string: baseURL + Endpoints.mealDetail(id)) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(MealDetailResponse.self, from: data)
        
        //Just return the first item in the list
        return decoded.meals.first
    }
}
