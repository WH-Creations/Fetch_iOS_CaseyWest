//
//  DessertListViewModelTests.swift
//  Fetch_iOS_CaseyWest
//
//  Created by Casey West on 3/11/25.
//

import XCTest
@testable import Fetch_iOS_CaseyWest

final class DessertListViewModelTests: XCTestCase {
    
    func testFetchDessertListSuccess() async {
        let mockService = MockMealService(shouldFail: false)
        let viewModel = DessertListViewModel(service: mockService)
        
        await viewModel.fetchDessertList()
        
        await MainActor.run {
            XCTAssertFalse(viewModel.isLoading)
            XCTAssertNil(viewModel.errorMessage)
            XCTAssertEqual(viewModel.desserts.count, 2)
            XCTAssertEqual(viewModel.desserts[0].strMeal, "Apple Pie")
        }
    }
    
    func testFetchDessertListFailure() async {
        let mockService = MockMealService(shouldFail: true)
        let viewModel = DessertListViewModel(service: mockService)
        
        await viewModel.fetchDessertList()
        
        await MainActor.run {
            XCTAssertFalse(viewModel.isLoading)
            XCTAssertNotNil(viewModel.errorMessage)
            XCTAssertTrue(viewModel.desserts.isEmpty)
        }
    }
}
