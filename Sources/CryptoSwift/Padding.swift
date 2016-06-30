//
//  Padding.swift
//  CryptoSwift
//
//  Created by Marcin Krzyzanowski on 27/02/15.
//  Copyright (c) 2015 Marcin Krzyzanowski. All rights reserved.
//

public protocol Padding {
    func add(_ data: Array<UInt8>, blockSize:Int) -> Array<UInt8>
    func remove(_ data: Array<UInt8>, blockSize:Int?) -> Array<UInt8>
}
