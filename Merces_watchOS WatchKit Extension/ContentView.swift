//
//  ContentView.swift
//  Merces_watchOS WatchKit Extension
//
//  Created by Donovan McCray on 6/7/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var wCalcModel = varAmts.calcModel
    
    var body: some View {
        ValuesView().environmentObject(wCalcModel)
//        .contextMenu {
//            ScrollView (.vertical) {
//                VStack {
//                    ForEach(VenueType.allCases) { venue in
//                        if venue.name == varAmts.calcModel.selectedVenue.name {
//                            Text("\(venue.name)")
//                                .background(Color.blue)
//                        } else {
//                            Text("\(venue.name)")
//                        }
//                    }
//                }
//            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
