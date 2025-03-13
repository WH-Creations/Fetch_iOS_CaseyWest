//
//  MealDetailViewModelProtocol.swift
//  Fetch_iOS_CaseyWest
//
//  Created by Casey West on 3/12/25.
//

import SwiftUI

protocol MealDetailViewModelProtocol: ObservableObject {
    
    // MARK: Published properties
    var mealDetail: MealDetail? { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
    
    // MARK: Functions
    func fetchMealDetail(id: String) async
}
