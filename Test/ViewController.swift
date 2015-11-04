//
//  ViewController.swift
//  Test
//
//  Created by brux on 11/3/15.
//  Copyright © 2015 stephencelis. All rights reserved.
//

import UIKit
import Pensieve

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        test2()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func test2() {
        let pensieve = Pensieve.sharedPensieve()
    }


}

