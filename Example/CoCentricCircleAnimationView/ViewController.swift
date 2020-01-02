//
//  ViewController.swift
//  CoCentricCircleAnimationView
//
//  Created by e-sung on 01/02/2020.
//  Copyright (c) 2020 e-sung. All rights reserved.
//

import UIKit
import CoCentricCircleAnimationView

class ViewController: UIViewController {

    @IBOutlet private var circleAnimationView: CoCentricAnimationView!
    

    @IBAction func start() {
        circleAnimationView.start()
    }
    
    @IBAction func stop() {
        circleAnimationView.stop()
    }

}

