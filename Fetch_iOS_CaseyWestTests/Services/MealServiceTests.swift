//
//  MealServiceTests.swift
//  Fetch_iOS_CaseyWest
//
//  Created by Casey West on 3/12/25.
//

import XCTest
@testable import Fetch_iOS_CaseyWest

final class MealServiceIntegrationTests: XCTestCase {
    
    private var service: MealService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        service = MealService()
    }
    
    override func tearDownWithError() throws {
        service = nil
        try super.tearDownWithError()
    }
    
    func testFetchDessertList_Integration() async throws {
        let desserts = try await service.fetchDessertList()
        
        XCTAssertFalse(desserts.isEmpty, "Dessert list should not be empty from the real API.")
        
        // Because we do a .compactMap filter, every dessert should have valid IDs & names
        for dessert in desserts {
            XCTAssertFalse(dessert.id.isEmpty, "id (idMeal) should not be empty after filtering.")
            XCTAssertNotNil(dessert.strMeal, "strMeal should not be nil after filtering.")
            XCTAssertFalse(dessert.strMeal!.isEmpty, "strMeal should not be empty after filtering.")
        }
    }
    
    func testFetchMealDetail_Integration() async throws {
        let desserts = try await service.fetchDessertList()
        XCTAssertFalse(desserts.isEmpty, "Should have at least one dessert to test detail fetching.")
        
        guard let firstDessert = desserts.first else {
            XCTFail("No desserts returned, cannot test details.")
            return
        }
        
        let detail = try await service.fetchMealDetail(id: firstDessert.idMeal ?? "")
        
        XCTAssertNotNil(detail, "Expected to find meal detail for a known dessert.")
        
        if let detail = detail {
            // Checking id equals, name and instructions for presence.
            // This is just an example, depends on what we'd want to test.

            XCTAssertEqual(detail.idMeal, firstDessert.idMeal,
                           "Detail's idMeal should match the dessert's idMeal.")
            XCTAssertNotNil(detail.strMeal, "Meal name (strMeal) should not be nil for a real dessert.")
            XCTAssertNotNil(detail.strInstructions, "Instructions should not be nil for a real dessert.")
        }
    }
}
