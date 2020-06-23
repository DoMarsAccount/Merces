//
//  ListStyleMainPage.swift
//  TipTok
//
//  Created by Donovan McCray on 6/22/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct ListStyleMainPage: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var userPrefs: UserPreferences
    @State private var activeField: EditableTextFields = .none
    @ObservedObject var calcModel: CalculationsModel = varAmts.calcModel
    var body: some View {
        GeometryReader { geo in
            VStack {
                VStack {
                    Text("Venue")
                        .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                    
                    ZStack {
                        Color.black
                            .opacity(0.0)
                        Text(self.calcModel.selectedVenue.name)
                            .font(Font(UserPreferences.sharedInstance.checkForDynamicType(preferredFontSize: 18)))
                    }
                    .frame(maxHeight: geo.size.height / 3)
                    .modifier(MercesStyleTextField())
                }.onTapGesture {
                    self.activeField = EditableTextFields.venue
                }
                .accessibility(label: Text("Venue: \(self.calcModel.selectedVenue.name)"))
            }
        }
    }
}

struct ListStyleMainPage_Previews: PreviewProvider {
    static var previews: some View {
        ListStyleMainPage()
    }
}
