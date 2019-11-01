//
//  PaintView.swift
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
}

extension PaintViewModel {
  
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
  
  private static func toHexString(_ input: Double, prefix: Bool = true) -> String {
    let value = UInt8((input * 255).rounded(.down))
    return prefix ? String(format: "0x%02X", value) : String(format: "%02X", value)
  }
  
  var hex: String {
    redHex + Self.toHexString(green, prefix: false) + Self.toHexString(blue, prefix: false)
  }
  
  var redHex: String { Self.toHexString(red) }
  var greenHex: String { Self.toHexString(green) }
  var blueHex: String { Self.toHexString(blue) }
  var color: Color { Color(red: red, green: green, blue: blue) }
}

struct PaintView: View {
    
  @ObservedObject var viewModel: PaintViewModel
  
  var body: some View {
    
    //EmptyView()
    
    VStack {
      ZStack {
        Rectangle()
          .foregroundColor(viewModel.color)
          .aspectRatio(1, contentMode: .fit)
        Text(viewModel.hex).font(.system(.largeTitle, design: .monospaced))
      }
      Slider(value: $viewModel.red, in: 0...1)
      Slider(value: $viewModel.green, in: 0...1)
      Slider(value: $viewModel.blue, in: 0...1)
      HStack {
        Spacer()
        Button("Darken") {
          withAnimation {
            self.viewModel.darken()
          }
        }.buttonStyle(RectangularButtonStyle())
        Button("Brighten") {
          withAnimation {
            self.viewModel.brighten()
          }
        }.buttonStyle(RectangularButtonStyle())
        Spacer()
      }.padding()
      Button("Randomize") {
        withAnimation {
          self.viewModel.randomize()
        }
      }.buttonStyle(RectangularButtonStyle())
    }.padding()
  }
}

struct PaintView_Previews: PreviewProvider {
  static var previews: some View {
    PaintView(viewModel: PaintViewModel(red: 1, green: 1, blue: 0))
  }
}
