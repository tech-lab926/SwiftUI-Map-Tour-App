//
//  LocationMapAnnotation.swift
//  SwiftUIMapTour
//
//  Created by saul on 6/19/24.
//

import SwiftUI

struct LocationMapAnnotation: View {
    var body: some View {
        VStack(spacing: 0.0) {
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundStyle(.white)
                .padding(8)
                .background(.accent)
                .clipShape(Circle())

            Image(systemName: "triangle.fill")
                .rotationEffect(.degrees(180))
                .offset(y: -5)
        }
        .foregroundStyle(.accent)
        .shadow(color: .black.opacity(0.5), radius: 10)
    }
}

#Preview {
    LocationMapAnnotation()
}
