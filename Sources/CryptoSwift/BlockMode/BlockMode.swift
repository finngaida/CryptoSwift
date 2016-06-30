//
//  BlockMode.swift
//  CryptoSwift
//
//  Created by Marcin Krzyzanowski on 08/03/16.
//  Copyright © 2016 Marcin Krzyzanowski. All rights reserved.
//

typealias CipherOperationOnBlock = (block: Array<UInt8>) -> Array<UInt8>?

public enum BlockMode {
    case ecb, cbc, pcbc, cfb, ofb, ctr

    func worker(_ iv: Array<UInt8>?, cipherOperation: CipherOperationOnBlock) -> BlockModeWorker {
        switch (self) {
        case ecb:
            return ECBModeWorker(iv: iv ?? [], cipherOperation: cipherOperation)
        case cbc:
            return CBCModeWorker(iv: iv ?? [], cipherOperation: cipherOperation)
        case pcbc:
            return PCBCModeWorker(iv: iv ?? [], cipherOperation: cipherOperation)
        case cfb:
            return CFBModeWorker(iv: iv ?? [], cipherOperation: cipherOperation)
        case ofb:
            return OFBModeWorker(iv: iv ?? [], cipherOperation: cipherOperation)
        case ctr:
            return CTRModeWorker(iv: iv ?? [], cipherOperation: cipherOperation)
        }
    }

    var options: BlockModeOptions {
        switch (self) {
        case .ecb:
            return .PaddingRequired
        case .cbc:
            return [.InitializationVectorRequired, .PaddingRequired]
        case .cfb:
            return .InitializationVectorRequired
        case .ctr:
            return .InitializationVectorRequired
        case .ofb:
            return .InitializationVectorRequired
        case .pcbc:
            return [.InitializationVectorRequired, .PaddingRequired]
        }
    }
}
