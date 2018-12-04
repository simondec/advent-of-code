//
//  2018-02.swift
//  advent-of-code
//
//  Created by Simon de Carufel on 18-12-03.
//  Copyright © 2018 Simon de Carufel. All rights reserved.
//

import Foundation

extension Year2018 {
    
    public class Day2: Day {
        
        public init() { super.init(inputSource: .file(#file)) }

        override public func part1() -> String {
            let lines = input.trimmed.lines.characters
            var setOfTwo = Set<String>()
            var setOfThree = Set<String>()
            
            lines.forEach { (lineCharacters) in
                let characters = Set(lineCharacters)
                characters.forEach({ character in
                    switch lineCharacters.filter({c in c == character}).count {
                    case 2: setOfTwo.insert(String(lineCharacters))
                    case 3: setOfThree.insert(String(lineCharacters))
                    default: break
                    }
                })
            }
            
            return "\(setOfTwo.count * setOfThree.count)"
        }
        
        override public func part2() -> String {
            let lines = input.trimmed.lines.characters
            for i in 0..<lines.count {
                for j in i+1..<lines.count {
                    var identicalCharacters = Array<Character>()
                    for (idx, char) in lines[i].enumerated() {
                        if lines[j][idx] == char {
                            identicalCharacters.append(char)
                        }
                    }
                    if identicalCharacters.count == lines[i].count - 1 {
                        return String(identicalCharacters)
                    }
                }
            }
            return ""
        }
    }
}
