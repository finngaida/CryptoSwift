//
//  PGPDataExtension.swift
//  SwiftPGP
//
//  Created by Marcin Krzyzanowski on 05/07/14.
//  Copyright (c) 2014 Marcin Krzyzanowski. All rights reserved.
//

import Foundation

extension NSMutableData {
    
    /** Convenient way to append bytes */
    internal func appendBytes(_ arrayOfBytes: Array<UInt8>) {
        self.append(arrayOfBytes, length: arrayOfBytes.count)
    }
    
}

extension Data {

    /// Two octet checksum as defined in RFC-4880. Sum of all octets, mod 65536
    public func checksum() -> UInt16 {
        var s:UInt32 = 0
        var bytesArray = self.arrayOfBytes()
        for i in 0..<bytesArray.count {
            s = s + UInt32(bytesArray[i])
        }
        s = s % 65536
        return UInt16(s)
    }
    
    public func md5() -> Data {
        let result = Hash.md5(self.arrayOfBytes()).calculate()
        return Data.withBytes(result)
    }

    public func sha1() -> Data? {
        let result = Hash.sha1(self.arrayOfBytes()).calculate()
        return Data.withBytes(result)
    }

    public func sha224() -> Data? {
        let result = Hash.sha224(self.arrayOfBytes()).calculate()
        return Data.withBytes(result)
    }

    public func sha256() -> Data? {
        let result = Hash.sha256(self.arrayOfBytes()).calculate()
        return Data.withBytes(result)
    }

    public func sha384() -> Data? {
        let result = Hash.sha384(self.arrayOfBytes()).calculate()
        return Data.withBytes(result)
    }

    public func sha512() -> Data? {
        let result = Hash.sha512(self.arrayOfBytes()).calculate()
        return Data.withBytes(result)
    }

    public func crc32(_ seed: UInt32? = nil, reflect : Bool = true) -> Data? {
        let result = Hash.crc32(self.arrayOfBytes(), seed: seed, reflect: reflect).calculate()
        return Data.withBytes(result)
    }

    public func crc16(_ seed: UInt16? = nil) -> Data? {
        let result = Hash.crc16(self.arrayOfBytes(), seed: seed).calculate()
        return Data.withBytes(result)
    }

    public func encrypt(_ cipher: Cipher) throws -> Data {
        let encrypted = try cipher.encrypt(self.arrayOfBytes())
        return Data.withBytes(encrypted)
    }

    public func decrypt(_ cipher: Cipher) throws -> Data {
        let decrypted = try cipher.decrypt(self.arrayOfBytes())
        return Data.withBytes(decrypted)
    }
    
    public func authenticate(_ authenticator: Authenticator) throws -> Data {
        let result = try authenticator.authenticate(self.arrayOfBytes())
        return Data.withBytes(result)
    }
}

extension Data {
    
    public func toHexString() -> String {
        return self.arrayOfBytes().toHexString()
    }
    
    public func arrayOfBytes() -> Array<UInt8> {
        let count = self.count / sizeof(UInt8)
        var bytesArray = Array<UInt8>(repeating: 0, count: count)
        (self as NSData).getBytes(&bytesArray, length:count * sizeof(UInt8))
        return bytesArray
    }

//    public init(bytes: Array<UInt8>) {
//        (self as NSData).dynamicType.init(data: Data.withBytes(bytes))
//    }
    
    static public func withBytes(_ bytes: Array<UInt8>) -> Data {
        return Data(bytes: UnsafePointer<UInt8>(bytes), count: bytes.count)
    }
}

