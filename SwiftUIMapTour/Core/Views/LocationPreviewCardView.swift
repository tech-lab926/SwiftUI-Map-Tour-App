//
//  LocationPreviewView.swift
//  SwiftUIMapTour
//
//  Created by saul on 6/19/24.
//

import SwiftUI

struct LocationPreviewCardView: View {
    @EnvironmentObject private var locationsVM: LocationsViewModel
    let location: Location
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading) {
                imageSection
                titleSection
            }
            Spacer()
            buttonsSection
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(.ultraThinMaterial)
                .offset(y: 50)
        )
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: .black.opacity(0.5), radius: 10)
    }
}

#Preview {
    let location = LocationsDataService.locations.first!
    return ZStack {
        Color.green
            .ignoresSafeArea()
        LocationPreviewCardView(location: location)
    }
    .environmentObject(LocationsViewModel())
}

extension LocationPreviewCardView {
    private var imageSection: some View {
        ZStack {
            if let image = location.imageNames.first {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
        }
        .padding(8)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }

    private var titleSection: some View {
        VStack(alignment: .leading) {
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            Text(location.cityName)
                .font(.subheadline)
        }
    }

    private var buttonsSection: some View {
        VStack {
            Button(action: {
                locationsVM.sheetLocation = location
            }, label: {
                Text("Learn More")
                    .padding(5)
                    .frame(width: 125)
            })
            .buttonStyle(.borderedProminent)

            Button(action: locationsVM.onNextButtonPressed, label: {
                Text("Next")
                    .padding(5)
                    .frame(width: 125)
            })
            .buttonStyle(.bordered)
        }
    }
}
