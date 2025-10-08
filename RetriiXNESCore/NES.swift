//
//  NES.swift
//  NESGameCore
//
//  Created by Vũ Thị Thanh on 9/2/25.
//

import Foundation
import AVFoundation
import RetriiXEmulatorCore

public extension GameType {
    static let nes = GameType("game.emulator.nes")
}

public extension CheatType {
    static let gameGenie6 = CheatType("GameGenie6")
    static let gameGenie8 = CheatType("GameGenie8")
}

@objc public enum NESGameInput: Int, Input {
    case up = 0x10
    case down = 0x20
    case left = 0x40
    case right = 0x80
    case a = 0x01
    case b = 0x02
    case start = 0x08
    case select = 0x04
    
    public var type: InputType {
        return .game(.nes)
    }
}

public struct NES: GameCoreProtocol {
    private init() { }
    public var inputs: [String : Int] {
        return [
            "up": 0x10,
            "down": 0x20,
            "left": 0x40,
            "right": 0x80,
            "a": 0x01,
            "b": 0x02,
            "start": 0x08,
            "select": 0x04
        ]
    }
    
    public static let core = NES()
    
    public var name: String { "NES" }
    public var identifier: String { "game.core.nes" }
    
    public var gameType: GameType { GameType.nes }
    public var gameInputType: Input.Type { NESGameInput.self }
    public var gameSaveFileExtension: String { "sav" }
        
    public let audioFormat = AVAudioFormat(commonFormat: .pcmFormatInt16, sampleRate: 44100, channels: 1, interleaved: true)!
    public let videoFormat = VideoFormat(format: .bitmap(.rgb565), dimensions: CGSize(width: 256, height: 240))
    
    public var supportedCheatFormats: Set<CheatFormat> {
        let gameGenie6Format = CheatFormat(name: NSLocalizedString("Game Genie (6)", comment: ""), format: "XXXXXX", type: .gameGenie6, allowedCodeCharacters: .letters)
        let gameGenie8Format = CheatFormat(name: NSLocalizedString("Game Genie (8)", comment: ""), format: "XXXXXXXX", type: .gameGenie8, allowedCodeCharacters: .letters)
        return [gameGenie6Format, gameGenie8Format]
    }
    
    public var emulatorBridge: EmulatorBridging { NESEmulatorBridge.shared }
}
