//
//  Logger.swift
//  mts01e02
//
//  Created by Simone Civetta on 21/01/17.
//
//

#if os(Linux)
    import Glibc
#else
    import Darwin
#endif

enum Logger {
    static func info(_ string: String) {
        fputs(string, stdout)
        fflush(stdout)
    }
}
