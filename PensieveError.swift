//
//  PensieveError.swift
//  Pensieve
//
//  Created by brux on 11/16/15.
//  Copyright © 2015 brux. All rights reserved.
//

import Foundation

public enum PensieveError : ErrorType {
    case AddObjectError(key:String)
    case GetObjectError(key:String)
    case KeyExisted(key:String)
    case DatabaseError(error:PensieveDBError)
    case PrimaryStorageError
    case ObjectCouldNotConvertToJSON(key:String)
    case ReduplicateKey(key: String)
}
