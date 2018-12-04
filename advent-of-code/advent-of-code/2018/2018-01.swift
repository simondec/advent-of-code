//
//  2018-01.swift
//  advent-of-code
//
//  Created by Simon de Carufel on 18-12-03.
//  Copyright © 2018 Simon de Carufel. All rights reserved.
//

import Foundation

extension Year2018 {
    
    public class Day1: Day {
        
        public init() { super.init(inputSource: .file(#file)) }
        
        override public func part1() -> String {
            let sum = input.trimmed.lines.integers.reduce(0, {cur, val in cur + val})
            return "\(sum)"
        }
        
        override public func part2() -> String {
            let integers = input.trimmed.lines.integers
            
            var frequency = 0
            var seen = Set([frequency])
            var index = 0
            while true {
                frequency += integers[index]
                if seen.contains(frequency) { return "\(frequency)" }
                index = (index + 1) % integers.count
                seen.insert(frequency)
            }
        }
    }
}
