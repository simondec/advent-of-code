//
//  2018-05.swift
//  advent-of-code
//
//  Created by Simon de Carufel on 18-12-05.
//  Copyright © 2018 Simon de Carufel. All rights reserved.
//

import Foundation

extension Year2018 {
    
    public class Day5: Day {
        
        // [1518-04-11 00:44] wakes up
        // [1518-11-11 00:12] falls asleep
        // [1518-02-06 23:52] Guard #3109 begins shift
        
        public init() { super.init(inputSource: .file(#file)) }
        
        private func triggerPolymer(polymer: [Character]) -> [Character] {
            var values = polymer
            var idx = 0
            
            while idx < values.count - 1 {
                let currentChar = values[idx]
                let nextChar = values[idx+1]
                
                if currentChar != nextChar && String(currentChar).uppercased() == String(nextChar).uppercased() {
                    values.removeSubrange(idx...idx+1)
                    idx = max(0, idx - 1)
                } else {
                    idx += 1
                }
            }
            return values
        }
        
        override public func part1() -> String {
            let values = input.trimmed.characters
            let trigerredPolymer = triggerPolymer(polymer: values)
            return "\(trigerredPolymer.count)"
        }
        
        override public func part2() -> String {
            let values = input.trimmed.characters
            var minPolymerCount = values.count
            
            for char in "abcdefghijklmnopqrstuvwxyz" {
                var tentativePolymer = values.filter({ c in return String(c).lowercased() != String(char) })
                tentativePolymer = triggerPolymer(polymer: tentativePolymer)
                minPolymerCount = min(minPolymerCount, tentativePolymer.count)
            }
            
            return "\(minPolymerCount)"
        }
    }
}
