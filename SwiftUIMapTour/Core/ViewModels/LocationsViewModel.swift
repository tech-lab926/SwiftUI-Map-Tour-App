//
//  LocationsViewModel.swift
//  SwiftUIMapTour
//
//  Created by saul on 6/19/24.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {
    // All loaded locations
    @Published var locations: [Location]

    // Current location on map
    @Published var currentLocation: Location {
        didSet {
            updateMapRegion(location: currentLocation)
        }
    }

    // Current Map region on map
    @Published var mapRegion = MapCameraPosition.region(MKCoordinateRegion())

    // Coordinate Span
    private let coordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)

    // Show list of locations
    @Published var showLocationsList: Bool = false

    // Location data(detail) to show via sheet
    @Published var sheetLocation: Location? = nil

    init() {
        self.locations = LocationsDataService.locations
        self.currentLocation = LocationsDataService.locations.first!
        updateMapRegion(location: currentLocation)
    }

    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MapCameraPosition.region(
                MKCoordinateRegion(center: location.coordinates, span: coordinateSpan)
            )
        }
    }

    func toggleShowLocationsList() {
        withAnimation {
            showLocationsList.toggle()
        }
    }

    func showNewLocation(location: Location) {
        withAnimation(.easeInOut) {
            currentLocation = location
            showLocationsList = false
        }
    }

    func onNextButtonPressed() {
        // find current location index
        guard let currentLocationIndex = locations.firstIndex(where: { $0 == currentLocation }) else {
            return
        }

        let nexLocationIndex = currentLocationIndex + 1

        // check if nexLocation index is valid
        // if nexLocationIndex == locations.count
        // nexLocation is NOT valid. RESTART from 0
        if nexLocationIndex == locations.count {
            guard let firstLocation = locations.first else { return }
            showNewLocation(location: firstLocation)
            return
        }

        let nexLocation = locations[nexLocationIndex]
        showNewLocation(location: nexLocation)
    }
}
