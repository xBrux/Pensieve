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
     获得Pensieve的单例，如果没有遇到fatalError，则说明与数据库的链接没有问题
     
     - returns: Pensieve的单例
     */
    public class func sharedPensieve() -> Pensieve {
        return SharedPensieve
    }
    
    public func setObject(object:PensieveObject, forKey key:String) throws {
        guard let jsonString = jsonStringFromPensieveJSON(object.pensieveJSON()) else { throw PensieveError.ObjectCouldNotConvertToJSON(key: key) }
        do {
            try dbAdapter.insert(key: key, value: jsonString)
        } catch PensieveDBError.UniqueConstraintFailed {
            throw PensieveError.ReduplicateKey(key: key)
        } catch let error where error is PensieveDBError {
            throw PensieveError.DatabaseError(error: (error as! PensieveDBError))
        }
    }
    
    public func deleteObjectForKey(key:String) throws {
        do {
            try dbAdapter.delete(key: key)
        } catch let error where error is PensieveDBError {
            throw PensieveError.DatabaseError(error: (error as! PensieveDBError))
        }
    }
    
    public func objectForKey(key: String, objectType:Any.Type) -> PensieveObject? {
        guard let type = objectType as? PensieveObject.Type else {return nil}
        if !(objectType is PensieveObject.Type) {
            return nil
        }
        
        guard let jsonString = try? dbAdapter.selectWhere(key: key) else { return nil }
        guard let data = (jsonString as NSString?)?.dataUsingEncoding(NSUTF8StringEncoding) else {return nil}
        guard let json = try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) else {return nil}
        guard let pensieveJSON = json as? PensieveJSON else {return nil}
        return type.init(json: pensieveJSON)
    }
    
    
    //MARK: - Private Properties
    private let dbAdapter:DBAdapter

    //MARK: - Inits
    private static let SharedPensieve = Pensieve(dbUrl: "")
    
    init(dbUrl: String) {
        let url:String
        
        if dbUrl == "" {
            let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            guard let path = paths.first else { fatalError("Couldn't Find Document Directory") }
            url = path + "/PensieveM.db"
        } else {
           url = dbUrl
        }
        
        guard let adapter = try? DBAdapter(dbUrl: url) else { fatalError("Pensieve failed to connect the db") }
        
        dbAdapter = adapter
        databaseURL = url
    }
    
    private func jsonStringFromPensieveJSON(pensieveJSON: PensieveJSON) -> String? {
        guard NSJSONSerialization.isValidJSONObject(pensieveJSON) else {return nil}
        guard let data = try? NSJSONSerialization.dataWithJSONObject(pensieveJSON, options: .PrettyPrinted) else {return nil}
        return NSString(data: data, encoding: NSUTF8StringEncoding) as String?
    }
}
