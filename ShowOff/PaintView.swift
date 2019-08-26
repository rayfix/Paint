//
//  ContentView.swift
//
//  Created by Ray Fix on 8/25/19.
//  Copyright © 2019 Ray Fix. All rights reserved.
//

import SwiftUI

class PaintViewModel: ObservableObject, Identifiable {
  let id = UUID()
  @Published var red: Double
  @Published var green: Double
  @Published var blue: Double
  
  init(red: Double, green: Double, blue: Double) {
    self.red = Self.clamp(red)
    self.green = Self.clamp(green)
    self.blue = Self.clamp(blue)
  }
  
  private static func clamp(_ input: Double) -> Double { min(max(input, 0), 1) }
  
  func brighten() {
    red = Self.clamp(red+0.1)
    blue = Self.clamp(blue+0.1)
    green = Self.clamp(green+0.1)
  }
  
  func darken() {
    red = Self.clamp(red-0.1)
    blue = Self.clamp(blue-0.1)
    green = Self.clamp(green-0.1)
  }
  
  func randomize() {
    red = Double.random(in: 0...1)
    green = Double.random(in: 0...1)
    blue = Double.random(in: 0...1)
  }
  
  private func toHex(_ input: Double) -> String {
    String(format: "0x%02X", Int((input * 255).rounded(.down)))
  }
  
  var redHex: String { toHex(red) }
  var greenHex: String { toHex(green) }
  var blueHex: String { toHex(blue) }
    
  var color: Color { Color(red: red, green: green, blue: blue) }
}

struct PaintView: View {
    
  @ObservedObject var viewModel: PaintViewModel
  
  var body: some View {
    VStack {
      Rectangle()
        .foregroundColor(viewModel.color)
        .aspectRatio(1, contentMode: .fit)
      Slider(value: $viewModel.red, in: 0...1)
      Slider(value: $viewModel.green, in: 0...1)
      Slider(value: $viewModel.blue, in: 0...1)
      HStack {
        Spacer()
        RectangleButton("Darken") {
          withAnimation {
            self.viewModel.darken()
          }
        }
        RectangleButton("Brighten") {
          withAnimation {
            self.viewModel.brighten()
          }
        }
        Spacer()
      }.padding()
      RectangleButton("Randomize") {
        withAnimation {
          self.viewModel.randomize()
        }
      }
    }.padding()
  }
}

struct PaintView_Previews: PreviewProvider {
  static var previews: some View {
    PaintView(viewModel: PaintViewModel(red: 1, green: 1, blue: 0))
  }
}