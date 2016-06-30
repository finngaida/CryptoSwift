//
//  StringExtension.swift
//  CryptoSwift
//
//  Created by Marcin Krzyzanowski on 15/08/14.
//  Copyright (c) 2014 Marcin Krzyzanowski. All rights reserved.
//

/** String extension */
extension String {
    
    public func md5() -> String {
        return self.bytes().md5().toHexString()
    }
    
    public func sha1() -> String {
        return self.bytes().sha1().toHexString()
    }

    public func sha224() -> String {
        return self.bytes().sha224().toHexString()
    }

    public func sha256() -> String {
        return self.bytes().sha256().toHexString()
    }

    public func sha384() -> String {
        return self.bytes().sha384().toHexString()
    }

    public func sha512() -> String {
        return self.bytes().sha512().toHexString()
    }

    public func crc32(_ seed: UInt32? = nil, reflect : Bool = true) -> String {
        return self.bytes().crc32(seed, reflect: reflect).toHexString()
    }

    public func crc16(_ seed: UInt16? = nil) -> String {
        return self.bytes().crc16(seed).toHexString()
    }

    public func encrypt(_ cipher: Cipher) throws -> Array<UInt8> {
        return try self.bytes().encrypt(cipher)
    }

    public func decrypt(_ cipher: Cipher) throws -> Array<UInt8> {
        return try self.bytes().decrypt(cipher)
    }
    
    /// Returns hex string of bytes.
    public func authenticate(_ authenticator: Authenticator) throws -> String {
        return  try self.bytes().authenticate(authenticator).toHexString()
    }
    
    public func bytes() -> Array<UInt8> {
        return self.utf8.lazy.map({ $0 as UInt8 })
    }
}
