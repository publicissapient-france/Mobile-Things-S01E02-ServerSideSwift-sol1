//
//  Logger.swift
//  mts01e02
//
//  Created by Simone Civetta on 21/01/17.
//
//

import Foundation

enum Logger {
    static func info(_ string: String) {
        fputs(string, stdout)
        fflush(stdout)
    }
}
