//
//  LocationsListView.swift
//  SwiftUIMapTour
//
//  Created by saul on 6/19/24.
//

import SwiftUI

struct LocationsListView: View {
    @EnvironmentObject private var locationsVM: LocationsViewModel
    var body: some View {
        List(locationsVM.locations) { location in

            Button(action: {
                locationsVM.showNewLocation(location: location)
            }, label: {
                locationListRowView(location: location)
            })
            .padding(.vertical, 2)
            .listRowBackground(Color.clear)
        }
        .listStyle(PlainListStyle())
    }
}

#Preview {
    LocationsListView()
        .environmentObject(LocationsViewModel())
}

extension LocationsListView {
    private func locationListRowView(location: Location) -> some View {
        HStack {
            if let image = location.imageNames.first {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
