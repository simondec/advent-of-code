//
//  Input.swift
//  advent-of-code
//
//  Created by Simon de Carufel on 18-12-03.
//  Copyright © 2018 Simon de Carufel. All rights reserved.
//

import Foundation

public protocol StringInput {
    init(_ raw: String)
    var raw: String { get }
    var integer: Int? { get }
    var characters: Array<Character> { get }
    
    var trimmed: Self { get }
    var lines: Array<Line> { get }
    var words: Array<Word> { get }
}

public final class Input: StringInput {
    public convenience init(file: String) { self.init(try! String(contentsOfFile: file)) }
    public init(_ raw: String) { self.raw = raw }
    
    public let raw: String
    public lazy var integer: Int? = { Int(raw) }()
    public lazy var characters: Array<Character> = { Array(raw) }()
    
    public lazy var trimmed: Input = { Input(raw.trimmingCharacters(in: .whitespacesAndNewlines)) }()
    public lazy var lines: Array<Line> = { return raw.components(separatedBy: .newlines).map { Line($0) } }()
    public lazy var words: Array<Word> = { return raw.components(separatedBy: .whitespaces).filter { $0.isEmpty == false }.map { Word($0) } }()
    
    public lazy var rawLines: Array<String> = { lines.raw }()
    public lazy var rawWords: Array<String> = { words.raw }()
    public lazy var rawLineWords: Array<Array<String>> = { lines.words.raw }()
}

public final class Line: StringInput {
    public init(_ raw: String) { self.raw = raw }
    
    public let raw: String
    public lazy var integer: Int? = { Int(raw) }()
    public lazy var characters: Array<Character> = { Array(raw) }()
    
    public lazy var trimmed: Line = { Line(raw.trimmingCharacters(in: .whitespacesAndNewlines)) }()
    public var lines: Array<Line> { return [self] }
    public lazy var words: Array<Word> = { return raw.components(separatedBy: .whitespaces).filter { $0.isEmpty == false }.map { Word($0) } }()
}

public final class Word: StringInput {
    public init(_ raw: String) { self.raw = raw }
    
    public let raw: String
    public lazy var integer: Int? = { Int(raw) }()
    public lazy var characters: Array<Character> = { Array(raw) }()
    
    public lazy var trimmed: Word = { Word(raw.trimmingCharacters(in: .whitespacesAndNewlines)) }()
    public lazy var lines: Array<Line> = { return [Line(raw)] }()
    public var words: Array<Word> { return [self] }
}

extension Collection where Element: StringInput {
    public var raw: Array<String> { return map { $0.raw } }
    public var integers: Array<Int> { return map { $0.integer! } }
    public var characters: Array<Array<Character>> { return map { $0.characters } }
    
    public var trimmed: Array<Element> { return map { $0.trimmed } }
    public var lines: Array<Array<Line>> { return map { $0.lines } }
    public var words: Array<Array<Word>> { return map { $0.words } }
}

extension Collection where Element: Collection, Element.Element: StringInput {
    public var raw: Array<Array<String>> { return map { $0.raw } }
    public var integers: Array<Array<Int>> { return map { $0.integers } }
}

extension Collection where Element == Character {
    public var integers: Array<Int> { return map { Int("\($0)")! } }
}
