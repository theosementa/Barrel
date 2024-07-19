//
//  NavigationManager.swift
//  Krabs
//
//  Created by Theo Sementa on 29/11/2023.
//

import SwiftUI

class NavigationManager: Router {

    // push
    func pushHome() {
        navigateTo(.home)
    }

    func pushMyVehicle() {
        navigateTo(.myVehicle)
    }
    
    func pushStatistics() {
        navigateTo(.statistics)
    }
    
    func pushHistory() {
        navigateTo(.history)
    }
    
    // sheet
    func presentCreateNewEntry(dismissAction: (() -> Void)? = nil) {
        presentSheet(.createNewEntry, dismissAction)
    }
    
    func presentCreateVehicleSheet(dismissAction: (() -> Void)? = nil) {
        presentSheet(.createVehicleSheet(vehicleSheet: nil), dismissAction)
    }
    
    func presentEditVehicleSheet(vehicleSheet: VehicleSheetEntity, dismissAction: (() -> Void)? = nil) {
        presentSheet(.createVehicleSheet(vehicleSheet: vehicleSheet), dismissAction)
    }

    // Build view
    override func view(direction: NavigationDirection, route: Route) -> AnyView {
        AnyView(buildView(direction: direction, route: route))
    }
}

private extension NavigationManager {

    @ViewBuilder
    func buildView(direction: NavigationDirection, route: Route) -> some View {
        Group {
            switch direction {
            case .home:
                HomeView(router: router(route: route))
            case .myVehicle:
                MyVehiculeView(router: router(route: route))
            case .statistics:
                StatisticsView()
                
            case .history:
                HistoryView()
                
            case .createNewEntry:
                CreateNewEntryView()
            case .createVehicleSheet(let vehicleSheet):
                CreateNewVehicleSheetView(viewModel: CreateNewVehicleSheetViewModel(vehicleSheet: vehicleSheet))
            }
        }
    }

    func router(route: Route) -> NavigationManager {
        switch route {
        case .navigation:
            return self
        case .sheet:
            return NavigationManager(isPresented: presentingSheet)
        case .fullScreenCover:
            return NavigationManager(isPresented: presentingFullScreen)
        case .modal:
            return NavigationManager(isPresented: presentingModal)
        case .modalCanFullScreen:
            return NavigationManager(isPresented: presentingModalCanFullScreen)
        }
    }
}
