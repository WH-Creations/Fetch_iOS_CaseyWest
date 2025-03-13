//
//  MealListItem.swift
//  Fetch_iOS_CaseyWest
//
//  Created by Casey West on 3/12/25.
//

import Foundation

struct DessertListResponse: Decodable {
    let meals: [MealListItem]
}

struct MealListItem: Decodable, Identifiable {
    var id: String { idMeal ?? "" }

    let strMeal: String?
    let strMealThumb: String?
    let idMeal: String?
}
