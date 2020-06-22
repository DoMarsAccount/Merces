//
//  ContentView.swift
//  TipTok
//
//  Created by Donovan McCray on 6/22/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI
let themes = Themes()

struct ContentView: View {
    var body: some View {
        MainPageSwiftUI()
            .environmentObject(UserPreferences.sharedInstance)
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
