//
//  PensieveObject.swift
//  Pensieve
//
//  Created by brux on 11/16/15.
//  Copyright © 2015 brux. All rights reserved.
//

import Foundation

public typealias PensieveJSON = [String : AnyObject]

public protocol PensieveObject {
    
    func pensieveJSON() -> PensieveJSON
    
    init(json:PensieveJSON)
}
