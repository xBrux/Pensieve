//
//  ViewController.swift
//  Test
//
//  Created by brux on 11/3/15.
//  Copyright © 2015 stephencelis. All rights reserved.
//

import UIKit
import Pensieve

class OBJ: PensieveObject {
    required init(json: PensieveJSON) {
        print(json)
    }
    
    func pensieveJSON() -> PensieveJSON {
        return ["test" : 1, "你" : "好"]
    }
}

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
        
        do {
            try pensieve.setObject(OBJ(json: PensieveJSON()), forKey: "test")
        } catch {
            print(error)
        }
        
        do {
            try pensieve.setObject(OBJ(json: PensieveJSON()), forKey: "test")
        } catch {
            print(error)
        }
        
        let o = (pensieve.objectForKey("test", objectType:OBJ.self) as? OBJ)!
        print(o)
        try? pensieve.deleteObjectForKey("test")
        let o1 = pensieve.objectForKey("test", objectType:OBJ.self)
        print(o1)
    }


}

