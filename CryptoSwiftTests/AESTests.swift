//
//  CipherAESTests.swift
//  CryptoSwift
//
//  Created by Marcin Krzyzanowski on 27/12/14.
//  Copyright (c) 2014 Marcin Krzyzanowski. All rights reserved.
//
import XCTest
@testable import CryptoSwift

final class AESTests: XCTestCase {
    // 128 bit key
    let aesKey:Array<UInt8> = [0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f]

    func testAES_encrypt2() {
        let key:Array<UInt8>   = [0x36, 0x37, 0x39, 0x66, 0x62, 0x31, 0x64, 0x64, 0x66, 0x37, 0x64, 0x38, 0x31, 0x62, 0x65, 0x65];
        let iv:Array<UInt8>    = [0x6b, 0x64, 0x66, 0x36, 0x37, 0x33, 0x39, 0x38, 0x44, 0x46, 0x37, 0x33, 0x38, 0x33, 0x66, 0x64]
        let input:Array<UInt8> = [0x62, 0x72, 0x61, 0x64, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
        
        let expected:Array<UInt8> = [0xae,0x8c,0x59,0x95,0xb2,0x6f,0x8e,0x3d,0xb0,0x6f,0x0a,0xa5,0xfe,0xc4,0xf0,0xc2];
        
        let aes = try! AES(key: key, iv: iv, blockMode: .cbc, padding: NoPadding())
        let encrypted = try! aes.encrypt(input)
        XCTAssertEqual(encrypted, expected, "encryption failed")
        let decrypted = try! aes.decrypt(encrypted)
        XCTAssertEqual(decrypted, input, "decryption failed")
    }

    func testAES_encrypt3() {
        let key = "679fb1ddf7d81bee"
        let iv = "kdf67398DF7383fd"
        let input:Array<UInt8> = [0x62, 0x72, 0x61, 0x64, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
        let expected:Array<UInt8> = [0xae,0x8c,0x59,0x95,0xb2,0x6f,0x8e,0x3d,0xb0,0x6f,0x0a,0xa5,0xfe,0xc4,0xf0,0xc2];
        
        let aes = try! AES(key: key, iv: iv, blockMode: .cbc, padding: NoPadding())
        let encrypted = try! aes.encrypt(input)
        XCTAssertEqual(encrypted, expected, "encryption failed")
        let decrypted = try! aes.decrypt(encrypted)
        XCTAssertEqual(decrypted, input, "decryption failed")
    }
    
    func testAES_encrypt() {
        let input:Array<UInt8> = [0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff];
        let expected:Array<UInt8> = [0x69, 0xc4, 0xe0, 0xd8, 0x6a, 0x7b, 0x4, 0x30, 0xd8, 0xcd, 0xb7, 0x80, 0x70, 0xb4, 0xc5, 0x5a];
        
        let aes = try! AES(key: aesKey, blockMode: .ecb, padding: NoPadding())
        let encrypted = try! aes.encrypt(input)
        XCTAssertEqual(encrypted, expected, "encryption failed")
        let decrypted = try! aes.decrypt(encrypted)
        XCTAssertEqual(decrypted, input, "decryption failed")
    }

    func testAES_encrypt_cbc_no_padding() {
        let key:Array<UInt8> = [0x2b,0x7e,0x15,0x16,0x28,0xae,0xd2,0xa6,0xab,0xf7,0x15,0x88,0x09,0xcf,0x4f,0x3c];
        let iv:Array<UInt8> = [0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F]
        let plaintext:Array<UInt8> = [0x6b,0xc1,0xbe,0xe2,0x2e,0x40,0x9f,0x96,0xe9,0x3d,0x7e,0x11,0x73,0x93,0x17,0x2a]
        let expected:Array<UInt8> = [0x76,0x49,0xab,0xac,0x81,0x19,0xb2,0x46,0xce,0xe9,0x8e,0x9b,0x12,0xe9,0x19,0x7d];

        let aes = try! AES(key: key, iv:iv, blockMode: .cbc, padding: NoPadding())
        let encrypted = try! aes.encrypt(plaintext)
        XCTAssertEqual(encrypted, expected, "encryption failed")
        let decrypted = try! aes.decrypt(encrypted)
        XCTAssertEqual(decrypted, plaintext, "decryption failed")
    }

    func testAES_encrypt_cbc_with_padding() {
        let key:Array<UInt8> = [0x2b,0x7e,0x15,0x16,0x28,0xae,0xd2,0xa6,0xab,0xf7,0x15,0x88,0x09,0xcf,0x4f,0x3c];
        let iv:Array<UInt8> = [0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F]
        let plaintext:Array<UInt8> = [0x6b,0xc1,0xbe,0xe2,0x2e,0x40,0x9f,0x96,0xe9,0x3d,0x7e,0x11,0x73,0x93,0x17,0x2a]
        let expected:Array<UInt8> = [0x76,0x49,0xab,0xac,0x81,0x19,0xb2,0x46,0xce,0xe9,0x8e,0x9b,0x12,0xe9,0x19,0x7d,0x89,0x64,0xe0,0xb1,0x49,0xc1,0x0b,0x7b,0x68,0x2e,0x6e,0x39,0xaa,0xeb,0x73,0x1c]
        
        let aes = try! AES(key: key, iv:iv, blockMode: .cbc, padding: PKCS7())
        let encrypted = try! aes.encrypt(plaintext)
        XCTAssertEqual(encrypted, expected, "encryption failed")
        let decrypted = try! aes.decrypt(encrypted)
        XCTAssertEqual(decrypted, plaintext, "decryption failed")
    }

    func testAES_encrypt_cbc_with_padding_partial() {
        let key:Array<UInt8> = [0x2b,0x7e,0x15,0x16,0x28,0xae,0xd2,0xa6,0xab,0xf7,0x15,0x88,0x09,0xcf,0x4f,0x3c];
        let iv:Array<UInt8> = [0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F]
        let plaintext:Array<UInt8> = [0x6b,0xc1,0xbe,0xe2,0x2e,0x40,0x9f,0x96,0xe9,0x3d,0x7e,0x11,0x73,0x93,0x17,0x2a,0x6b,0xc1,0xbe,0xe2,0x2e,0x40,0x9f,0x96,0xe9,0x3d,0x7e,0x11,0x73,0x93,0x17,0x2a]

        let aes = try! AES(key: key, iv:iv, blockMode: .cbc, padding: PKCS7())

        var ciphertext = Array<UInt8>()
        var encryptor = aes.makeEncryptor()
        ciphertext += try! encryptor.update(withBytes: Array(plaintext[0..<8]))
        ciphertext += try! encryptor.update(withBytes: Array(plaintext[8..<16]))
        ciphertext += try! encryptor.update(withBytes: Array(plaintext[16..<32]))
        ciphertext += try! encryptor.finish()
        XCTAssertEqual(try! aes.encrypt(plaintext), ciphertext, "encryption failed")
    }

    func testAES_encrypt_incremental() {
        do {
            var ciphertext = Array<UInt8>()
            let plaintext = "Today Apple launched the open source Swift community, as well as amazing new tools and resources."
            let aes = try AES(key: "passwordpassword".bytes(), iv: "drowssapdrowssap".utf8.map({$0}))
            var encryptor = aes.makeEncryptor()

            ciphertext += try encryptor.update(withBytes: plaintext.utf8.map({$0}))
            ciphertext += try encryptor.finish()
        } catch {
            XCTAssert(false, "\(error)")
        }
    }

    func testAES_decrypt_cbc_with_padding_partial() {
        let key:Array<UInt8> = [0x2b,0x7e,0x15,0x16,0x28,0xae,0xd2,0xa6,0xab,0xf7,0x15,0x88,0x09,0xcf,0x4f,0x3c];
        let iv:Array<UInt8> = [0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F]
        let ciphertext:Array<UInt8> = [118, 73, 171, 172, 129, 25, 178, 70, 206, 233, 142, 155, 18, 233, 25, 125, 76, 187, 200, 88, 117, 107, 53, 129, 37, 82, 158, 150, 152, 163, 143, 68, 169, 105, 137, 234, 93, 98, 239, 215, 41, 45, 51, 254, 138, 92, 251, 17]

        let aes = try! AES(key: key, iv:iv, blockMode: .cbc, padding: PKCS7())
        var plaintext = Array<UInt8>()
        var decryptor = aes.makeDecryptor()
        plaintext += try! decryptor.update(withBytes: Array(ciphertext[0..<8]))
        plaintext += try! decryptor.update(withBytes: Array(ciphertext[8..<16]))
        plaintext += try! decryptor.update(withBytes: Array(ciphertext[16..<32]))
        plaintext += try! decryptor.finish()
        XCTAssertEqual(try! aes.decrypt(ciphertext), plaintext, "encryption failed")
    }

    func testAES_encrypt_cfb() {
        let key:Array<UInt8> = [0x2b,0x7e,0x15,0x16,0x28,0xae,0xd2,0xa6,0xab,0xf7,0x15,0x88,0x09,0xcf,0x4f,0x3c];
        let iv:Array<UInt8> = [0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F]
        let plaintext:Array<UInt8> = [0x6b,0xc1,0xbe,0xe2,0x2e,0x40,0x9f,0x96,0xe9,0x3d,0x7e,0x11,0x73,0x93,0x17,0x2a]
        let expected:Array<UInt8> = [0x3b,0x3f,0xd9,0x2e,0xb7,0x2d,0xad,0x20,0x33,0x34,0x49,0xf8,0xe8,0x3c,0xfb,0x4a];
        
        let aes = try! AES(key: key, iv:iv, blockMode: .cfb, padding: NoPadding())
        let encrypted = try! aes.encrypt(plaintext)
        XCTAssertEqual(encrypted, expected, "encryption failed")
        let decrypted = try! aes.decrypt(encrypted)
        XCTAssertEqual(decrypted, plaintext, "decryption failed")
    }

    // https://github.com/krzyzanowskim/CryptoSwift/issues/142
    func testAES_encrypt_cfb_long() {
        let key: Array<UInt8> = [56, 118, 37, 51, 125, 78, 103, 107, 119, 40, 74, 88, 117, 112, 123, 75, 122, 89, 72, 36, 46, 91, 106, 60, 54, 110, 34, 126, 69, 126, 61, 87]
        let iv: Array<UInt8> = [69, 122, 99, 87, 83, 112, 110, 65, 54, 109, 107, 89, 73, 122, 74, 49]
        let plaintext: Array<UInt8> = [123, 10, 32, 32, 34, 67, 111, 110, 102, 105, 114, 109, 34, 32, 58, 32, 34, 116, 101, 115, 116, 105, 110, 103, 34, 44, 10, 32, 32, 34, 70, 105, 114, 115, 116, 78, 97, 109, 101, 34, 32, 58, 32, 34, 84, 101, 115, 116, 34, 44, 10, 32, 32, 34, 69, 109, 97, 105, 108, 34, 32, 58, 32, 34, 116, 101, 115, 116, 64, 116, 101, 115, 116, 46, 99, 111, 109, 34, 44, 10, 32, 32, 34, 76, 97, 115, 116, 78, 97, 109, 101, 34, 32, 58, 32, 34, 84, 101, 115, 116, 101, 114, 34, 44, 10, 32, 32, 34, 80, 97, 115, 115, 119, 111, 114, 100, 34, 32, 58, 32, 34, 116, 101, 115, 116, 105, 110, 103, 34, 44, 10, 32, 32, 34, 85, 115, 101, 114, 110, 97, 109, 101, 34, 32, 58, 32, 34, 84, 101, 115, 116, 34, 10, 125]
        let encrypted: Array<UInt8> = try! AES(key: key, iv: iv, blockMode: .cfb).encrypt(plaintext)
        let decrypted: Array<UInt8> = try! AES(key: key, iv: iv, blockMode: .cfb).decrypt(encrypted)
        XCTAssert(decrypted == plaintext, "decryption failed")
    }

    func testAES_encrypt_ofb128() {
        let key:Array<UInt8> = [0x2b,0x7e,0x15,0x16,0x28,0xae,0xd2,0xa6,0xab,0xf7,0x15,0x88,0x09,0xcf,0x4f,0x3c];
        let iv:Array<UInt8> = [0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F]
        let plaintext:Array<UInt8> = [0x6b,0xc1,0xbe,0xe2,0x2e,0x40,0x9f,0x96,0xe9,0x3d,0x7e,0x11,0x73,0x93,0x17,0x2a]
        let expected:Array<UInt8> = [0x3b,0x3f,0xd9,0x2e,0xb7,0x2d,0xad,0x20,0x33,0x34,0x49,0xf8,0xe8,0x3c,0xfb,0x4a];

        let aes = try! AES(key: key, iv:iv, blockMode: .ofb, padding: NoPadding())
        let encrypted = try! aes.encrypt(plaintext)
        XCTAssertEqual(encrypted, expected, "encryption failed")
        let decrypted = try! aes.decrypt(encrypted)
        XCTAssertEqual(decrypted, plaintext, "decryption failed")
    }

    func testAES_encrypt_ofb256() {
        let key: Array<UInt8> = [0x60,0x3d,0xeb,0x10,0x15,0xca,0x71,0xbe,0x2b,0x73,0xae,0xf0,0x85,0x7d,0x77,0x81,0x1f,0x35,0x2c,0x07,0x3b,0x61,0x08,0xd7,0x2d,0x98,0x10,0xa3,0x09,0x14,0xdf,0xf4]
        let iv: Array<UInt8> = [0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F]
        let plaintext: Array<UInt8> = [0x6b,0xc1,0xbe,0xe2,0x2e,0x40,0x9f,0x96,0xe9,0x3d,0x7e,0x11,0x73,0x93,0x17,0x2a]
        let expected:Array<UInt8> = [0xdc,0x7e,0x84,0xbf,0xda,0x79,0x16,0x4b,0x7e,0xcd,0x84,0x86,0x98,0x5d,0x38,0x60];

        let aes = try! AES(key: key, iv:iv, blockMode: .ofb, padding: NoPadding())
        let encrypted = try! aes.encrypt(plaintext)
        XCTAssertEqual(encrypted, expected, "encryption failed")
        let decrypted = try! aes.decrypt(encrypted)
        XCTAssertEqual(decrypted, plaintext, "decryption failed")
    }

    func testAES_encrypt_pcbc256() {
        let key: Array<UInt8> = [0x60,0x3d,0xeb,0x10,0x15,0xca,0x71,0xbe,0x2b,0x73,0xae,0xf0,0x85,0x7d,0x77,0x81,0x1f,0x35,0x2c,0x07,0x3b,0x61,0x08,0xd7,0x2d,0x98,0x10,0xa3,0x09,0x14,0xdf,0xf4]
        let iv: Array<UInt8> = [0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F]
        let plaintext: Array<UInt8> = [0x6b,0xc1,0xbe,0xe2,0x2e,0x40,0x9f,0x96,0xe9,0x3d,0x7e,0x11,0x73,0x93,0x17,0x2a]
        let expected:Array<UInt8> = [0xf5,0x8c,0x4c,0x04,0xd6,0xe5,0xf1,0xba,0x77,0x9e,0xab,0xfb,0x5f,0x7b,0xfb,0xd6];

        let aes = try! AES(key: key, iv:iv, blockMode: .pcbc, padding: NoPadding())
        let encrypted = try! aes.encrypt(plaintext)
        print(encrypted.toHexString())
        XCTAssertEqual(encrypted, expected, "encryption failed")
        let decrypted = try! aes.decrypt(encrypted)
        XCTAssertEqual(decrypted, plaintext, "decryption failed")
    }

    func testAES_encrypt_ctr() {
        let key:Array<UInt8> = [0x2b,0x7e,0x15,0x16,0x28,0xae,0xd2,0xa6,0xab,0xf7,0x15,0x88,0x09,0xcf,0x4f,0x3c];
        let iv:Array<UInt8> = [0xf0,0xf1,0xf2,0xf3,0xf4,0xf5,0xf6,0xf7,0xf8,0xf9,0xfa,0xfb,0xfc,0xfd,0xfe,0xff]
        let plaintext:Array<UInt8> = [0x6b,0xc1,0xbe,0xe2,0x2e,0x40,0x9f,0x96,0xe9,0x3d,0x7e,0x11,0x73,0x93,0x17,0x2a]
        let expected:Array<UInt8> = [0x87,0x4d,0x61,0x91,0xb6,0x20,0xe3,0x26,0x1b,0xef,0x68,0x64,0x99,0x0d,0xb6,0xce]
        
        let aes = try! AES(key: key, iv:iv, blockMode: .ctr, padding: NoPadding())
        let encrypted = try! aes.encrypt(plaintext)
        XCTAssertEqual(encrypted, expected, "encryption failed")
        let decrypted = try! aes.decrypt(encrypted)
        XCTAssertEqual(decrypted, plaintext, "decryption failed")
    }

    func testAES_encrypt_ctr_irregular_length() {
        let key:Array<UInt8> = [0x2b,0x7e,0x15,0x16,0x28,0xae,0xd2,0xa6,0xab,0xf7,0x15,0x88,0x09,0xcf,0x4f,0x3c];
        let iv:Array<UInt8> = [0xf0,0xf1,0xf2,0xf3,0xf4,0xf5,0xf6,0xf7,0xf8,0xf9,0xfa,0xfb,0xfc,0xfd,0xfe,0xff]
        let plaintext:Array<UInt8> = [0x6b,0xc1,0xbe,0xe2,0x2e,0x40,0x9f,0x96,0xe9,0x3d,0x7e,0x11,0x73,0x93,0x17,0x2a,0x01]
        let expected:Array<UInt8> = [0x87,0x4d,0x61,0x91,0xb6,0x20,0xe3,0x26,0x1b,0xef,0x68,0x64,0x99,0x0d,0xb6,0xce,0x37]

        let aes = try! AES(key: key, iv:iv, blockMode: .ctr, padding: NoPadding())
        let encrypted = try! aes.encrypt(plaintext)
        XCTAssertEqual(encrypted, expected, "encryption failed")
        let decrypted = try! aes.decrypt(encrypted)
        XCTAssertEqual(decrypted, plaintext, "decryption failed")
    }

    func testAES_encrypt_performance() {
        let key:Array<UInt8> = [0x2b,0x7e,0x15,0x16,0x28,0xae,0xd2,0xa6,0xab,0xf7,0x15,0x88,0x09,0xcf,0x4f,0x3c];
        let iv:Array<UInt8> = [0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F]
        let message = Array<UInt8>(repeating: 7, count: 1024 * 1024)
        let aes = try! AES(key: key, iv: iv, blockMode: .cbc, padding: PKCS7())
        measureMetrics([XCTPerformanceMetric_WallClockTime], automaticallyStartMeasuring: true, for: { () -> Void in
            try! aes.encrypt(message)
        })
    }

    func testAES_decrypt_performance() {
        let key:Array<UInt8> = [0x2b,0x7e,0x15,0x16,0x28,0xae,0xd2,0xa6,0xab,0xf7,0x15,0x88,0x09,0xcf,0x4f,0x3c];
        let iv:Array<UInt8> = [0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F]
        let message = Array<UInt8>(repeating: 7, count: 1024 * 1024)
        let aes = try! AES(key: key, iv: iv, blockMode: .cbc, padding: PKCS7())
        measureMetrics([XCTPerformanceMetric_WallClockTime], automaticallyStartMeasuring: true, for: { () -> Void in
            try! aes.decrypt(message)
        })
    }

    func testAESPerformanceCommonCrypto() {
        let key:Array<UInt8> = [0x2b,0x7e,0x15,0x16,0x28,0xae,0xd2,0xa6,0xab,0xf7,0x15,0x88,0x09,0xcf,0x4f,0x3c];
        let iv:Array<UInt8> = [0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F]
        let message = Array<UInt8>(repeating: 7, count: 1024 * 1024)
        
        measureMetrics([XCTPerformanceMetric_WallClockTime], automaticallyStartMeasuring: false, for: { () -> Void in
            let keyData     = Data.withBytes(key)
            let keyBytes    = UnsafePointer<Void>((keyData as NSData).bytes)
            let ivData      = Data.withBytes(iv)
            let ivBytes     = UnsafePointer<Void>((ivData as NSData).bytes)
            
            let data = Data.withBytes(message)
            let dataLength    = data.count
            let dataBytes     = UnsafePointer<Void>((data as NSData).bytes)
            
            let cryptData    = NSMutableData(length: Int(dataLength) + kCCBlockSizeAES128)
            let cryptPointer = UnsafeMutablePointer<Void>(cryptData!.mutableBytes)
            let cryptLength  = cryptData!.length
            
            var numBytesEncrypted:Int = 0
            
            self.startMeasuring()
            
            CCCrypt(
                UInt32(kCCEncrypt),
                UInt32(kCCAlgorithmAES128),
                UInt32(kCCOptionPKCS7Padding),
                keyBytes,
                key.count,
                ivBytes,
                dataBytes,
                dataLength,
                cryptPointer, cryptLength,
                &numBytesEncrypted)

            self.stopMeasuring()
        })
    }

    func testAESWithWrongKey() {
        let key:Array<UInt8> = [0x2b,0x7e,0x15,0x16,0x28,0xae,0xd2,0xa6,0xab,0xf7,0x15,0x88,0x09,0xcf,0x4f,0x3c];
        let key2:Array<UInt8> = [0x22,0x7e,0x15,0x16,0x28,0xae,0xd2,0xa6,0xab,0xf7,0x15,0x88,0x09,0xcf,0x4f,0x33];
        let iv:Array<UInt8> = [0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F]
        let plaintext:Array<UInt8> = [49, 46, 50, 50, 50, 51, 51, 51, 51]

        let aes = try! AES(key: key, iv:iv, blockMode: .cbc, padding: PKCS7())
        let aes2 = try! AES(key: key2, iv:iv, blockMode: .cbc, padding: PKCS7())
        let encrypted = try! aes.encrypt(plaintext)
        let decrypted = try? aes2.decrypt(encrypted)
        XCTAssertTrue(decrypted! != plaintext, "failed")
    }

}
