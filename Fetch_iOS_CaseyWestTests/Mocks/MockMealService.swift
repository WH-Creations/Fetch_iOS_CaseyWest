//
//  MockMealService.swift
//  Fetch_iOS_CaseyWest
//
//  Created by Casey West on 3/11/25.
//

import Foundation
@testable import Fetch_iOS_CaseyWest

// Simple mock service for verifying our view models
struct MockMealService: MealServiceProtocol {
    
    var shouldFail: Bool = false
    
    func fetchDessertList() async throws -> [MealListItem] {
        if shouldFail {
            throw URLError(.badServerResponse)
        }
        return [
            MealListItem(strMeal: "Banana Split",
                         strMealThumb: "https://example.com/bananasplit.jpg",
                         idMeal: "001"),
            MealListItem(strMeal: "Apple Pie",
                         strMealThumb: "https://example.com/applepie.jpg",
                         idMeal: "002")
        ]
    }
    
    func fetchMealDetail(id: String) async throws -> MealDetail? {
        if shouldFail {
            throw URLError(.badServerResponse)
        }
        return MealDetail(
            idMeal: "001",
            strMeal: "Banana Split",
            strInstructions: "Slice bananas. Scoop ice cream. Add toppings.",
            strIngredient1: "Banana",
            strIngredient2: "Ice Cream",
            strIngredient3: "Chocolate Syrup",
            strIngredient4: nil,
            strIngredient5: nil,
            strIngredient6: nil,
            strIngredient7: nil,
            strIngredient8: nil,
            strIngredient9: nil,
            strIngredient10: nil,
            strIngredient11: nil,
            strIngredient12: nil,
            strIngredient13: nil,
            strIngredient14: nil,
            strIngredient15: nil,
            strIngredient16: nil,
            strIngredient17: nil,
            strIngredient18: nil,
            strIngredient19: nil,
            strIngredient20: nil,
            strMeasure1: "1",
            strMeasure2: "2 scoops",
            strMeasure3: "As needed",
            strMeasure4: nil,
            strMeasure5: nil,
            strMeasure6: nil,
            strMeasure7: nil,
            strMeasure8: nil,
            strMeasure9: nil,
            strMeasure10: nil,
            strMeasure11: nil,
            strMeasure12: nil,
            strMeasure13: nil,
            strMeasure14: nil,
            strMeasure15: nil,
            strMeasure16: nil,
            strMeasure17: nil,
            strMeasure18: nil,
            strMeasure19: nil,
            strMeasure20: nil
        )
    }
}
