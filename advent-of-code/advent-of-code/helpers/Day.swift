//
//  Day.swift
//  advent-of-code
//
//  Created by Simon de Carufel on 18-12-03.
//  Copyright © 2018 Simon de Carufel. All rights reserved.
//

import Foundation

public protocol Year {
}

public class Day {
    public enum InputSource {
        case none
        case raw(String)
        case file(StaticString)
    }
    
    private let source: InputSource
    
    public lazy var input: Input = {
        switch source {
        case .none:
            return Input("")
        case .raw(let s):
            return Input(s)
        case .file(let f):
            var fileWithExtensionChanged = ("\(f)" as NSString).deletingPathExtension + ".txt"
            var components = (fileWithExtensionChanged as NSString).pathComponents
            _ = components.insert("input", at: components.endIndex - 1)
            let path = NSString.path(withComponents: components)
            return Input(file: path)
        }
    }()
    
    public init(inputSource: InputSource = .none) {
        self.source = inputSource
    }
    
    public func run() -> (String, String) {
        return (part1(), part2())
    }
    
    public func part1() -> String { fatalError("Implement \(#function)") }
    public func part2() -> String { fatalError("Implement \(#function)") }
}
