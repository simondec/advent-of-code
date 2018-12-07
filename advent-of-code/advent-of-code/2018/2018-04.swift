//
//  2018-04.swift
//  advent-of-code
//
//  Created by Simon de Carufel on 18-12-04.
//  Copyright © 2018 Simon de Carufel. All rights reserved.
//

import Foundation

extension Year2018 {
    
    public class Day4: Day {
        
        public init() { super.init(inputSource: .file(#file)) }
        
        private func calculateSleepTime(from values:[Array<Word>]) -> [String: (total:Int, perMinute:[Int:Int])] {
            var sleepTime = [String: (total:Int, perMinute:[Int:Int])]()
            
            var currentId: String?
            var asleepTimestamp: Int?
            
            for value in values {
                let timestamp = Int(value[1].raw.trimmingCharacters(in: ["]"]).components(separatedBy: ":").last!)!
                switch value[2].raw {
                case "Guard":
                    currentId = value[3].raw
                    asleepTimestamp = nil
                case "falls":
                    asleepTimestamp = timestamp
                case "wakes":
                    if let currentId = currentId, let asleepTimestamp = asleepTimestamp {
                        let currentSleepTime = timestamp - asleepTimestamp
                        let total = (sleepTime[currentId]?.total ?? 0) + currentSleepTime
                        var perMinute = sleepTime[currentId]?.perMinute ?? [Int:Int]()
                        for x in asleepTimestamp..<timestamp {
                            perMinute[x] = (perMinute[x] ?? 0) + 1
                        }
                        sleepTime[currentId] = (total, perMinute)
                    }
                    asleepTimestamp = nil
                default: break
                }
            }
            return sleepTime
        }
        
        override public func part1() -> String {
            
            let values = input.trimmed.lines.words.sorted(by: {line1, line2 in return "\(line1[0].raw) \(line1[1].raw)" < "\(line2[0].raw) \(line2[1].raw)"})
            let sleepTime = calculateSleepTime(from: values)
            
            let mostSleepy = sleepTime.sorted(by: {value1, value2 in return value1.value.total > value2.value.total }).first!
            let mostMinuteAsleep = mostSleepy.value.perMinute.sorted(by: {min1, min2 in return min1.value > min2.value}).first!
            let value = Int(mostSleepy.key.trimmingCharacters(in: ["#"]))! * mostMinuteAsleep.key
            return "\(mostSleepy.key) x \(mostMinuteAsleep.key) = \(value)"
        }
        
        override public func part2() -> String {
            
            let values = input.trimmed.lines.words.sorted(by: {line1, line2 in return "\(line1[0].raw) \(line1[1].raw)" < "\(line2[0].raw) \(line2[1].raw)"})
            let sleepTime = calculateSleepTime(from: values)
            
            let mostSleepy = sleepTime.sorted(by: {value1, value2 in return value1.value.perMinute.sorted(by: {min1, min2 in return min1.value > min2.value}).first!.value > value2.value.perMinute.sorted(by: {min1, min2 in return min1.value > min2.value}).first!.value }).first!
            let mostMinuteAsleep = mostSleepy.value.perMinute.sorted(by: {min1, min2 in return min1.value > min2.value}).first!
            let value = Int(mostSleepy.key.trimmingCharacters(in: ["#"]))! * mostMinuteAsleep.key
            return "\(mostSleepy.key) x \(mostMinuteAsleep.key) = \(value)"
        }
    }
}
