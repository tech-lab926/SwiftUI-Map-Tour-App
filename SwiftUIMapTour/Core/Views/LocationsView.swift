//
//  LocationsView.swift
//  SwiftUIMapTour
//
//  Created by saul on 6/19/24.
//

import MapKit
import SwiftUI

struct LocationsView: View {
    @EnvironmentObject private var locationsVM: LocationsViewModel
    var body: some View {
        ZStack {
            mapLayer
            VStack {
                header
                    .padding()
                    .frame(maxWidth: Constants.maxWidthForIpad)
                Spacer()
                locationsPreviewCards
            }
        }
        .sheet(item: $locationsVM.sheetLocation) { location in
            LocationDetailView(location: location)
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}

extension LocationsView {
    private var header: some View {
        let currentLocation = locationsVM.currentLocation
        let showLocationsList = locationsVM.showLocationsList
        return VStack {
            Button(action: locationsVM.toggleShowLocationsList) {
                Text("\(currentLocation.name), \(currentLocation.cityName)")
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundStyle(.primary)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundStyle(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: showLocationsList ? 180 : 0))
                    }
            }

            if showLocationsList {
                LocationsListView()
            }
        }
        .background(.thickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: .black.opacity(0.5), radius: 10, y: 10)
        .foregroundStyle(.primary)
    }

    private var locationsPreviewCards: some View {
        ZStack {
            ForEach(locationsVM.locations) { location in
                if locationsVM.currentLocation == location {
                    LocationPreviewCardView(location: location)
                        .padding()
                        .frame(maxWidth: Constants.maxWidthForIpad)
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading))
                        )
                }
            }
        }
    }

    private var mapLayer: some View {
        Map(position: $locationsVM.mapRegion) {
            ForEach(locationsVM.locations) { location in
                Annotation("", coordinate: location.coordinates) {
                    LocationMapAnnotation()
                        .scaleEffect(locationsVM.currentLocation == location ? 1 : 0.7)
                        .onTapGesture {
                            locationsVM.showNewLocation(location: location)
                        }
                }
            }
        }
    }
}
