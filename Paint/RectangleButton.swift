//
//  RectangleButton.swift
//  ShowOff
//
//  Created by Ray Fix on 8/26/19.
//  Copyright © 2019 Ray Fix. All rights reserved.
//

import SwiftUI

struct RectangleButton: View {

  let title: String
  let action: (() -> Void)
  
  init(_ title: String, action: @escaping (() -> Void)) {
    self.title = title
    self.action = action
  }
  
  var body: some View {
    Button(title) {
      self.action()
      }.frame(width: 150, height: 50)
      .background(Color.blue)
      .foregroundColor(.white)
      .font(.subheadline)
      .cornerRadius(10)
  }
}

struct RectangleButton_Previews: PreviewProvider {
  static var previews: some View {
    RectangleButton("Push") { }
  }
}
