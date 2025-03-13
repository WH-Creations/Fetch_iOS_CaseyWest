//
//  Fetch_iOS_CaseyWestApp.swift
//  Fetch_iOS_CaseyWest
//
//  Created by Casey West on 3/11/25.
//

import SwiftUI

@main
struct Fetch_iOS_CaseyWestApp: App {
    var body: some Scene {
        WindowGroup {
            DessertListView(
                viewModel: DessertListViewModel(service: MealService())
            )
        }
    }
}
