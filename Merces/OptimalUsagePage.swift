//
//  OptimalUsagePage.swift
//  Merces
//
//  Created by Donovan McCray on 3/29/15.
//  Copyright (c) 2015 DoMarsToyBox. All rights reserved.
//

import UIKit

class OptimalUsagePage: UIViewController {
    
    
    @IBOutlet var textViewOutlet: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        updateColorValues()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        updateColorValues()
        
    }
    
    func updateColorValues() {
        
        self.view.backgroundColor = coloringThemes.getBackgroundColor()
        
        textViewOutlet.backgroundColor = coloringThemes.getBackgroundColor()
        
        textViewOutlet.textColor = UIColor(contrastingBlackOrWhiteColorOn: coloringThemes.getBackgroundColor(), isFlat: true)
        
    }
    
    

}
