//
//  BytesSequence.swift
//  CryptoSwift
//
//  Created by Marcin Krzyzanowski on 26/09/15.
//  Copyright © 2015 Marcin Krzyzanowski. All rights reserved.
//

struct BytesSequence: Sequence {
    let chunkSize: Int
    let data: Array<UInt8>
    
    func makeIterator() -> AnyIterator<ArraySlice<UInt8>> {
        
        var offset:Int = 0
        
        return AnyIterator {
            let end = self.data.count - offset
            if self.chunkSize > end {
                let result = self.data[offset..<offset + end]
                offset += result.count
                return !result.isEmpty ? result : nil
            } else {
                let result = self.data[offset..<offset + self.chunkSize]
                offset += result.count
                return !result.isEmpty ? result : nil
            }
        }
    }
}
