//
//  LocationDetailView.swift
//  SwiftUIMapTour
//
//  Created by saul on 6/20/24.
//

import MapKit
import SwiftUI

struct LocationDetailView: View {
    @EnvironmentObject private var locationsVM: LocationsViewModel
    @Environment(\.dismiss) var dismiss
    let location: Location
    var body: some View {
        ScrollView {
            VStack {
                imagesSection
                titleSection
                Divider()
                descriptionSection
                Divider()
                mapSection
            }
        }
        .overlay(alignment: .topLeading, content: {
            backButton
        })
        .scrollIndicators(ScrollIndicatorVisibility.hidden)
        .background(.ultraThinMaterial)
        .ignoresSafeArea()
    }
}

#Preview {
    LocationDetailView(location: LocationsDataService.locations.first!)
        .environmentObject(LocationsViewModel())
}

extension LocationDetailView {
    private var imagesSection: some View {
        var widthForIpad: CGFloat? {
            if UIDevice.current.userInterfaceIdiom == .phone {
                return UIScreen.main.bounds.width
            }
            return nil
        }
        return TabView {
            ForEach(location.imageNames, id: \.self) {
                Image($0)
                    .resizable()
                    .scaledToFill()
                    .frame(width: widthForIpad)
                    .clipped()
            }
        }
        .frame(height: 500)
        .shadow(color: .black.opacity(0.4), radius: 10, y: 10)
        .tabViewStyle(PageTabViewStyle())
    }

    private var titleSection: some View {
        VStack(alignment: .leading) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.headline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }

    private var descriptionSection: some View {
        VStack(alignment: .leading) {
            Text(location.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            if let url = URL(string: location.link) {
                Link("Read more on Wikipedia", destination: url)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .tint(.blue)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }

    private var mapSection: some View {
        let delta = 0.01
        let mapRegion = MapCameraPosition.region(MKCoordinateRegion(
            center: location.coordinates,
            span: MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta))
        )
        return Map(position: .constant(mapRegion)) {
            Annotation("", coordinate: location.coordinates) {
                LocationMapAnnotation()
            }
        }
        .allowsHitTesting(false)
        .aspectRatio(1.5, contentMode: .fill)
    }

    private var backButton: some View {
        XMarkButton {
            dismiss()
        }
        .padding(.horizontal)
        .padding(.vertical, 50)
    }
}
