//
//  HomeView.swift
//  Barrel
//
//  Created by Theo Sementa on 18/10/2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var router: NavigationManager
    @EnvironmentObject private var userRepository: UserRepository
    @EnvironmentObject private var carRepository: CarRepository
    
    // MARK: -
    var body: some View {
        List(carRepository.cars) { car in
            NavigationButton(push: router.pushCarDetail(car: car)) {
                CarRow(car: car)
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
            .listRowBackground(Color.clear)
        }
        .padding()
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(Color.Apple.background)
        .overlay(alignment: .bottomTrailing) {
            AddButton { router.presentCreateCar() }
                .padding()
        }
        .navigationTitle("Voitures")
    } // body
} // struct

// MARK: - Preview
#Preview {
    HomeView()
        .environmentObject(UserRepository())
        .environmentObject(CarRepository())
}
