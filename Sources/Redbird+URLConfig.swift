//
//  Redbird+URLConfig.swift
//  mts01e02
//
//  Created by Simone Civetta on 22/01/17.
//
//

import Foundation
import Redbird
import VaporRedis

enum RedbirdConfigError : Error {
    case invalidScheme
    case noHostProvided
}

private extension URL {
    func redisComponents() throws -> (address: String, port: Int, password: String?) {
        guard let scheme = self.scheme, scheme == "redis" else {
            throw RedbirdConfigError.invalidScheme
        }
        
        guard let host = self.host else {
            throw RedbirdConfigError.noHostProvided
        }
        
        let port = self.port ?? 6379
        let password = self.password
        return (address: host, port: port, password: password)
    }
}

extension RedbirdConfig {
    init(url: URL) throws {
        let (address, port, password) = try url.redisComponents()
        self.init(address: address, port: UInt16(port), password: password)
    }
}

extension VaporRedis.Provider {
    convenience init(url: URL) throws {
        let (address, port, password) = try url.redisComponents()
        try self.init(address: address, port: port, password: password)
    }
}
