//
//  RectangleButton.swift
//
//  Created by Ray Fix on 8/26/19.
//  Copyright © 2019 Ray Fix. All rights reserved.
//

import SwiftUI

struct RectangularButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label.frame(width: 150, height: 50)
            .background(Color.blue)
            .foregroundColor(.white)
            .font(.subheadline)
            .cornerRadius(10)
    }
}

