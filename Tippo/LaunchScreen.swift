//
//  LaunchScreen.swift
//  Tippo
//
//  Created by Donovan McCray on 6/29/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct LaunchScreen: View {
    @State var progress = 0.0
    
    var body: some View {
        VStack {
            Image(Int(progress) % 2 == 0 ? "Hippo_launch-screen_1" : "Hippo_launch-screen_2")
            Text("Tippo").font(.largeTitle)
        }
        .onAppear() {
            while self.progress < 4 {
                self.handleAnimations()
            }
        }
    }
}

extension LaunchScreen {
    var uAnimationDuration: Double { return 5.0 }
    
    func handleAnimations() {
        runAnimationsPart1()
    }
    
    func runAnimationsPart1() {
        withAnimation(.easeIn(duration: uAnimationDuration)) {
            progress += 1.0
        }
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
