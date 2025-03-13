//
//  MealServiceProtocol.swift
//  Fetch_iOS_CaseyWest
//
//  Created by Casey West on 3/11/25.
//

import Foundation

protocol MealServiceProtocol {
    
    //MARK: Functions
    func fetchDessertList() async throws -> [MealListItem]
    func fetchMealDetail(id: String) async throws -> MealDetail?
}
