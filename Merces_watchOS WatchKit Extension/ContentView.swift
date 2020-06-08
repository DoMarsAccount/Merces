//
//  ContentView.swift
//  Merces_watchOS WatchKit Extension
//
//  Created by Donovan McCray on 6/7/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var value: Double = 5.0
    @State var value2: Double = 1.0
    
    var body: some View {
        ValuesView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
