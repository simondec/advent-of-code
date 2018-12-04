//
//  2018-03.swift
//  advent-of-code
//
//  Created by Simon de Carufel on 18-12-04.
//  Copyright © 2018 Simon de Carufel. All rights reserved.
//

import Foundation

extension Year2018 {
    
    public class Day3: Day {
        
        struct Pair<T: Hashable, U: Hashable>: Hashable {
            let first: T
            let second: U
        }
        
        public init() { super.init(inputSource: .file(#file)) }
        
        override public func part1() -> String {
            let values = input.trimmed.lines.words
            var inches = [String: Int]()
            
            for value in values {
                let coordsRawValue = value[2].raw.trimmingCharacters(in: CharacterSet(charactersIn: ":"))
                let coords = (x: Int(coordsRawValue.components(separatedBy: ",").first!)!, y:Int(coordsRawValue.components(separatedBy: ",").last!)!)
                let dims = (w: Int(value[3].raw.components(separatedBy: "x").first!)!, h:Int(value[3].raw.components(separatedBy: "x").last!)!)
                
                for i in coords.x..<(coords.x + dims.w) {
                    for j in coords.y..<(coords.y + dims.h) {
                        let key = "\(i),\(j)"
                        if let inch = inches[key] {
                            inches[key] = inch + 1
                        } else {
                            inches[key] = 1
                        }
                    }
                }
            }
            
            let sum = inches.reduce(0, {res, inch in inch.value > 1 ? res + 1 : res })
            return "\(sum)"
        }
        
        override public func part2() -> String {
            let values = input.trimmed.lines.words
            var inches = [String: Set<String>]()
            var distinctIds = Set<String>()
            
            for value in values {
                let coordsRawValue = value[2].raw.trimmingCharacters(in: CharacterSet(charactersIn: ":"))
                let coords = (x: Int(coordsRawValue.components(separatedBy: ",").first!)!, y:Int(coordsRawValue.components(separatedBy: ",").last!)!)
                let dims = (w: Int(value[3].raw.components(separatedBy: "x").first!)!, h:Int(value[3].raw.components(separatedBy: "x").last!)!)
                
                var isDistinct = true
                for i in coords.x..<(coords.x + dims.w) {
                    for j in coords.y..<(coords.y + dims.h) {
                        let key = "\(i),\(j)"
                        if var inch = inches[key] {
                            inch.insert(value[0].raw)
                            inches[key] = inch
                            isDistinct = false
                            distinctIds.subtract(inch)
                        } else {
                            inches[key] = Set([value[0].raw])
                        }
                    }
                }
                
                if isDistinct {
                    distinctIds.insert(value[0].raw)
                }
            }
            return "\(distinctIds.first!)"
        }
    }
}
