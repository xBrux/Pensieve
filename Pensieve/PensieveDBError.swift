//
//  PensieveDBError.swift
//  SQLite
//
//  Created by brux on 11/3/15.
//  Copyright © 2015 brux. All rights reserved.
//

import UIKit

public enum PensieveDBError : ErrorType {
    case TableAlreadyExists
    case TableNotFounded
    case UniqueConstraintFailed
    case Unknown(message:String)
    
    init(sqliteError:Result) {
        switch sqliteError {
        case let .Error(message: message, code: _, statement: _) :
            self = PensieveDBError.pensieveErrorByErrorMessage(message)
        }
    }
    
    static func pensieveErrorByErrorMessage(message:String) -> PensieveDBError {
        print("message : \(message)")
        switch message {
        case let msg where msg.hasPrefix("table") && msg.hasSuffix("already exists"):
            return .TableAlreadyExists
        case let msg where msg.hasPrefix("no such table"):
            return .TableNotFounded
        case let msg where msg.hasPrefix("UNIQUE constraint failed"):
            return .UniqueConstraintFailed
        default:
            return .Unknown(message: message)
        }
    }
}
