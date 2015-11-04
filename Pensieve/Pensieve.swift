//
//  Pensieve.swift
//  Pensieve
//
//  Created by brux on 11/4/15.
//  Copyright © 2015 brux. All rights reserved.
//

import Foundation

public final class Pensieve {
    
    //MARK: - Public APIs
    /// 获取实际使用的数据库所在路径
    public let databaseURL:String
    
    /**
     永远不要用`Pensieve()`创建实例，而是调用`Pensieve.sharedPensieve()`获取一个单例
     
     - returns: fatalError("Use sharedPensieve instead")
     */
    public init() {
        fatalError("Use sharedPensieve instead")
    }
    
    /**
     获得Pensieve的单例，如果没有遇到fatalError，则说明与数据库的链接没有问题
     
     - returns: Pensieve的单例
     */
    public class func sharedPensieve() -> Pensieve {
        return SharedPensieve
    }
    
    //MARK: - Private Properties
    private let dbConnection:Connection

    //MARK: - Inits
    private static let SharedPensieve = Pensieve(dbURL: "")
    
    init(dbURL: String) {
        let url:String
        
        if dbURL == "" {
            let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            guard let path = paths.first else { fatalError("Couldn't Find Document Directory") }
            url = path + "/PensieveM.db"
        } else {
           url = dbURL
        }
        
        guard let db = try? Connection(url) else {
            fatalError("Couldn't Connect to \(url)")
        }
        dbConnection = db
        databaseURL = url
    }
    
    
    

}
