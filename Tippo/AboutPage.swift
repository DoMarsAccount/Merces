//
//  AboutPage.swift
//  Tippo
//
//  Created by Donovan McCray on 7/5/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

fileprivate var aboutMessage = "👋🏾 Hi, I’m Donovan McCray.\n\nI’m a software engineer from Texas.\n\nI started work on this app (originally titled ”Merces”) back in 2014 in order to familiarize myself with iOS app development.\n\nAs you’ve probably noticed, this app is a bit gratuitous (pun intended). To put it plainly, there is no shortage of tip calculator apps on the App Store. But, for a number of reasons, I was driven to create something I thought was better.\n\nI’d love to hear your thoughts on Tippo. If you tweet, feel free to contact me on Twitter @iDonosaur.\n\nIf you enjoy Tippo, please share it with a friend, or leave it a review on the App Store!"

struct AboutPage: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Image("Hippo_launch-screen_2")
                
                Text(aboutMessage)
                    .font(Font(UserPreferences.sharedInstance.headlineFont(size: 18)))
                    .padding()
            }
            .padding(.top)
            .navigationBarTitle(Text("About Tippo"))
        }
    }
}

struct AboutPage_Previews: PreviewProvider {
    static var previews: some View {
        AboutPage()
    }
}
