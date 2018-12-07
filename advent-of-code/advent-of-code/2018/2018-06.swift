//
//  2018-06.swift
//  advent-of-code
//
//  Created by Simon de Carufel on 18-12-06.
//  Copyright © 2018 Simon de Carufel. All rights reserved.
//

import Foundation

extension Year2018 {
    
    public class Day6: Day {
        
        public init() { super.init(inputSource: .file(#file)) }
        
        struct Data: Hashable {
            var hashValue: Int { return "\(coord.x), \(coord.y)".hashValue}
            
            static func == (lhs: Year2018.Day6.Data, rhs: Year2018.Day6.Data) -> Bool {
                return lhs.coord.x == rhs.coord.x && lhs.coord.y == rhs.coord.y
            }
            
            var isTie: Bool = false
            var coord: (x:Int, y:Int)
            var distance: Int
        }
        
        private func manhattanDistance(from:(x:Int, y:Int), to:(x:Int, y:Int)) -> Int {
            return abs(from.x - to.x) + abs(from.y - to.y)
        }
        
        override public func part1() -> String {
            let values = input.trimmed.lines.map({line in (x:Int(line.raw.components(separatedBy: ", ").first!)!, y:Int(line.raw.components(separatedBy: ", ").last!)!)})
            
            var maxX = 0
            var maxY = 0
            
            for value in values {
                maxX = max(maxX, value.x)
                maxY = max(maxY, value.y)
            }
            
            var coords = Array<Array>(repeating: Array<Data?>(repeating: nil, count: maxY+1), count: maxX+1)
            
            // Fill matrix with closest coordinates
            for value in values {
                for i in 0...maxX {
                    for j in 0...maxY {
                        let distance = manhattanDistance(from: (i,j), to: value)
                        if let currentData = coords[i][j] {
                            if distance < currentData.distance {
                                coords[i][j] = Data(isTie:false, coord: value, distance: distance)
                            } else if distance == currentData.distance {
                                coords[i][j] = Data(isTie:true, coord: value, distance: distance)
                            }
                        } else {
                            coords[i][j] = Data(isTie:false, coord: value, distance: distance)
                        }
                    }
                }
            }
            
            // Remove all infinite areas
            var infiniteCoords = Set<Data>()
            
            for i in 0...maxX {
                if let data = coords[i][0], !data.isTie {
                    infiniteCoords.insert(data)
                }
                if let data = coords[i][maxY], !data.isTie {
                    infiniteCoords.insert(data)
                }
            }
            
            for j in 0...maxY {
                if let data = coords[0][j], !data.isTie {
                    infiniteCoords.insert(data)
                }
                if let data = coords[maxX][j], !data.isTie {
                    infiniteCoords.insert(data)
                }
            }
            
            // Compute each areas
            var areas = [String:Int]()
            
            for i in 0...maxX {
                for j in 0...maxY {
                    if let data = coords[i][j], !data.isTie {
                        if infiniteCoords.contains(data) {
                            coords[i][j] = nil
                        } else {
                            let areaName = "\(data.coord.x),\(data.coord.y)"
                            let areaSize = (areas[areaName] ?? 0) + 1
                            areas[areaName] = areaSize
                        }
                    }
                }
            }
            
            let finalValue = areas.sorted(by: {val1, val2 in val1.value > val2.value}).first!
            return "\(finalValue.value)"
        }
        
        override public func part2() -> String {
            let values = input.trimmed.lines.map({line in (x:Int(line.raw.components(separatedBy: ", ").first!)!, y:Int(line.raw.components(separatedBy: ", ").last!)!)})
            
            var maxX = 0
            var maxY = 0
            
            for value in values {
                maxX = max(maxX, value.x)
                maxY = max(maxY, value.y)
            }
            
            var count = 0
            
            // Count every coordinate's total values that are below threshold
            for i in 0...maxX {
                for j in 0...maxY {
                    let value = values.reduce(into: 0, {result, val in result = result + manhattanDistance(from: val, to: (i, j))})
                    count = count + (value < 10000 ? 1 : 0)
                }
            }

            return "\(count)"
        }
    }
}
