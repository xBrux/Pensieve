//
//  DBAdapter.swift
//  Pensieve
//
//  Created by brux on 11/4/15.
//  Copyright © 2015 brux. All rights reserved.
//

import Foundation

class DBAdapter {
    
    //MARK: - Private Properties
    private let db:Connection
    private let primaryTable = Table("primary")
    private let keyColumn = Expression<String>("key")
    private let valueColumn = Expression<String>("value")
    
    //MARK: - Inits
    init(dbUrl: String = "") throws {
        guard let dbConnection = try? Connection(dbUrl) else {
            fatalError("Couldn't Connect to \(dbUrl)")
        }
        db = dbConnection
        
        do {
            try db.run(primaryTable.create { t in
                t.column(keyColumn, primaryKey: true)
                t.column(valueColumn)
                })
        } catch PensieveDBError.TableAlreadyExists {
            return
        }
    }
    
    //SQL Works
    func insert(key key:String, value:String) throws {
        let insert = primaryTable.insert(keyColumn <- key, valueColumn <- value)
        try db.run(insert)
    }
    
    func selectWhere(key key:String) throws -> String? {
        let select = primaryTable.select(valueColumn).filter(keyColumn == key)
        let values = try Array(db.prepare(select))
        if values.count > 1 { throw PensieveError.PrimaryStorageError }
        if values.count == 0 {
            return nil
        }
        return values[0][valueColumn]
    }
    
    func delete(key key:String) throws {
        let delete = primaryTable.filter(keyColumn == key)
        try db.run(delete.delete())
    }
    
    func updateWhere(key key:String, newValue : String) throws {
        let update = primaryTable.filter(keyColumn == key).update(valueColumn <- newValue)
        try db.run(update)
    }
    
    
}
