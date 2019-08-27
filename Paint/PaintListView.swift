//
//  PaintListView.swift
//  ShowOff
//
//  Created by Ray Fix on 8/26/19.
//  Copyright © 2019 Ray Fix. All rights reserved.
//

import SwiftUI

class PaintListViewModel: ObservableObject {
  @Published var paints: [PaintViewModel]
  
  init() {
    self.paints = (1...1000).map { _ in PaintViewModel(red: 0, green: 0, blue: 0) }
    self.paints.forEach { $0.randomize() }
  }
  
}

struct PaintListItem: View {
  
  @ObservedObject var viewModel: PaintViewModel
  
  var body: some View {
    HStack {
      viewModel.color.aspectRatio(1, contentMode: .fit).frame(width: 150, height: 150)
      VStack {
        Text(viewModel.redHex)
        Text(viewModel.greenHex)
        Text(viewModel.blueHex)
      }

      Image(systemName: "star.fill")
        .imageScale(.small)
        .foregroundColor(.yellow)
    }
  }
}

struct PaintListView: View {

  @ObservedObject var viewModel: PaintListViewModel
  
  var body: some View {
    NavigationView {
      List {
        ForEach(viewModel.paints) { paint in
          NavigationLink(destination: PaintView(viewModel: paint)) {
            PaintListItem(viewModel: paint)
          }
        }
      }.listStyle(GroupedListStyle())
      .navigationBarTitle("Color List", displayMode: .inline)
    }
  }
}
  
struct PaintListView_Previews: PreviewProvider {
    static var previews: some View {
      PaintListView(viewModel: PaintListViewModel())
    }
}
