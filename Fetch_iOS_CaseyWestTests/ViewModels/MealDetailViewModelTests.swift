//
//  MealDetailViewModelTests.swift
//  Fetch_iOS_CaseyWest
//
//  Created by Casey West on 3/12/25.
//

import XCTest
@testable import Fetch_iOS_CaseyWest

final class MealDetailViewModelTests: XCTestCase {
    
    func testFetchMealDetail_Success() async {
        let mockService = MockMealService(shouldFail: false)
        let viewModel = MealDetailViewModel(service: mockService)
        
        await viewModel.fetchMealDetail(id: "001")
        
        await MainActor.run {
            XCTAssertFalse(viewModel.isLoading)
            XCTAssertNil(viewModel.errorMessage)
            XCTAssertNotNil(viewModel.mealDetail, "Should have meal detail on success.")
            XCTAssertEqual(viewModel.mealDetail?.strMeal, "Banana Split")
        }
    }
    
    func testFetchMealDetail_Failure() async {
        let mockService = MockMealService(shouldFail: true)
        let viewModel = MealDetailViewModel(service: mockService)
        
        await viewModel.fetchMealDetail(id: "xxx")
        
        await MainActor.run {
            XCTAssertFalse(viewModel.isLoading)
            XCTAssertNotNil(viewModel.errorMessage)
            XCTAssertNil(viewModel.mealDetail)
        }
    }
}
