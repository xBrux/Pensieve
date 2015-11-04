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
        test1()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func test1() {
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        guard let path = paths.first else { return }
        guard let db = try? Connection(path + "/test.db") else {
            print("Connection Error : \(path)")
            return }
        
        let users = Table("usersssa")
        let id = Expression<Int64>("id")
        let name = Expression<String?>("name")
        let email = Expression<String>("email")
        
//        do {
//            try db.run(users.create { t in
//                t.column(id, primaryKey: true)
//                t.column(name)
//                t.column(email, unique: true)
//                })
//        } catch PensieveError.TableAlreadyExists {
//            print("TableAlreadyExists")
//        } catch {
//            print("Unknown")
//        }
        
//        print(users.create { t in
//                        t.column(id, primaryKey: true)
//                        t.column(name)
//                        t.column(email, unique: true)
//                        })
//        print(try? db.scalar(users.))
        
        do {
            users
            print(users.exists.asSQL())
            try print(db.scalar(users.exists))
        } catch {
            print(error)
        }
    }


}

