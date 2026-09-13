//
//  SwiftUIMapTourApp.swift
//  SwiftUIMapTour
//
//  Created by saul on 6/19/24.
//

import SwiftUI

@main
struct SwiftUIMapTourApp: App {
    @StateObject private var locationsVM = LocationsViewModel()
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(locationsVM)
        }
    }
}
