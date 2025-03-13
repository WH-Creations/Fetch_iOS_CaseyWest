//
//  MealDetailView.swift
//  Fetch_iOS_CaseyWest
//
//  Created by Casey West on 3/12/25.
//

import SwiftUI

struct MealDetailView<VM: MealDetailViewModelProtocol>: View {
    
    // MARK: Properties
    let mealId: String
    
    @StateObject var viewModel: VM
    
    // MARK: Initialization
    init(mealId: String, viewModel: VM) {
        self.mealId = mealId
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: Body
    var body: some View {
        ScrollView {
            Group {
                if viewModel.isLoading {
                    loadingView
                } else if let errorMessage = viewModel.errorMessage {
                    errorView(message: errorMessage)
                } else if let meal = viewModel.mealDetail {
                    contentView(for: meal)
                } else {
                    notFoundView
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.fetchMealDetail(id: mealId)
        }
    }
}

// MARK: Private Subviews
private extension MealDetailView {
    
    // MARK: Loading View
    @ViewBuilder
    var loadingView: some View {
        ProgressView("Loading meal details...")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: Error View
    func errorView(message: String) -> some View {
        Text(message)
            .foregroundColor(.red)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: Not Found View
    @ViewBuilder
    var notFoundView: some View {
        Text("Meal not found.")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: Content View
    func contentView(for meal: MealDetail) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            mealTitle(meal.strMeal ?? "Unknown Meal")
            instructionsSection(meal.strInstructions ?? "")
            ingredientsSection(meal.ingredients)
        }
        .padding()
    }
    
    // MARK: Meal Title
    func mealTitle(_ title: String) -> some View {
        Text(title)
            .font(.largeTitle)
            .bold()
    }
    
    // MARK: Instructions Section
    func instructionsSection(_ instructions: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Instructions")
                .font(.headline)
            Text(instructions)
                .font(.body)
                .multilineTextAlignment(.leading)
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(UIColor.secondarySystemBackground))
                )
        }
    }
    
    // MARK: Ingredients Section
    func ingredientsSection(_ ingredients: [(ingredient: String, measure: String)]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Ingredients")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 8) {
                ForEach(Array(ingredients.enumerated()), id: \.offset) { _, item in
                    HStack(spacing: 4) {
                        Text("•")
                            .fontWeight(.bold)
                        Text(item.ingredient)
                            .fontWeight(.semibold)
                        Text("-")
                        Text(item.measure)
                        Spacer()
                    }
                }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(UIColor.secondarySystemBackground))
            )
        }
    }
}
