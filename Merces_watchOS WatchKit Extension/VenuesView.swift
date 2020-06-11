//
//  VenuesView.swift
//  Merces_watchOS WatchKit Extension
//
//  Created by Donovan McCray on 6/10/20.
//  Copyright © 2020 DoMarsToyBox. All rights reserved.
//

import SwiftUI

struct VenuesView: View {
    @EnvironmentObject var wCalcModel: CalculationsModel
    
    var body: some View {
        VStack {
            
            HStack {
                Picker(selection: self.$wCalcModel.selectedVenue, label: Text("Venue").font(.headline)) {
                    ForEach(0..<VenueType.allCases.count) { index in
                        Text(VenueType.allCases[index].name).tag(VenueType.allCases[index])
                    }
                }.frame(height: viewHeight)

                VStack {
                    Text("Tip %").font(.headline)
                    Text(nForm.roundForPercentWithTwoDecimalPlaces(tipRate(for: self.wCalcModel.selectedVenue, service: self.wCalcModel.service)))
                }
            }
            
            Picker(selection: self.$wCalcModel.service, label: Text("Service Level").font(.headline)) {
                ForEach(0..<ServiceQuality.allCases.count) { index in
                    Text(ServiceQuality.allCases[index].name).tag(ServiceQuality.allCases[index])
                }
            }.frame(height: viewHeight)
        }
    }
}

struct VenuesView_Previews: PreviewProvider {
    static var previews: some View {
        VenuesView().environmentObject(varAmts.calcModel)
    }
}
