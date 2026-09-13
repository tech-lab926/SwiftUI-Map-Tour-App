//
//  XButton.swift
//  SwiftUIMapTour
//
//  Created by saul on 6/20/24.
//

import SwiftUI

struct XMarkButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: action, label: {
            Image(systemName: "xmark")
                .font(.headline)
                .fontWeight(.bold)
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(10)
        })
        .foregroundStyle(.primary)
    }
}

#Preview {
    XMarkButton(action: {})
}
