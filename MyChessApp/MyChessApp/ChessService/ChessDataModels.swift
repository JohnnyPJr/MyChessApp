//
//  ChessDataModels.swift
//  MyChessApp
//
//  Created by John Platsis on 14/9/20.
//  Copyright © 2020 IPV. All rights reserved.
//

import Foundation

public class ChessModel {
    var size: Int?
    var sourcePosition: Node?
    var destinationPosition: Node?
    var results: [ChessPathsResultModel]?

    convenience init(size: Int?,
                     sourcePosition: Node?,
                     destinationPosition: Node?,
                     results: [ChessPathsResultModel]?) {
        self.init()
        self.size = size
        self.sourcePosition = sourcePosition
        self.destinationPosition = destinationPosition
        self.results = results
    }
}

public struct ChessPathsResultModel {

    var pathNumber: Int
    var availablePaths: Node?
    var theDescription: String = ""
    var allIndexpaths: [IndexPath] = []

    /// Method to get the Description shown in the tableview results (using recursive method)
    ///
    /// - Parameter availablePaths: the available paths of a node
    /// - Returns: the description to show in label
    mutating func getInfo(availablePaths: Node?) -> String {

        let x = availablePaths?.x ?? 0
        let y = availablePaths?.y ?? 0
        if theDescription.isEmpty {
            theDescription = String(y) + ":" + String(x)
        } else {
            theDescription = theDescription  + " <- " + String(y) + ":" + String(x)
        }
        if let allPaths = availablePaths?.previousNodes {
            for node in allPaths {
                return getInfo(availablePaths: node)
            }
        }
        return theDescription
    }

    /// Method to get the indexPaths of the past nodes
    ///
    /// - Parameter availablePaths: the available paths of a node
    /// - Returns: the description to show in label
    mutating func getIndexpathsOfNode(availablePaths: Node?) -> [IndexPath] {

        let x = availablePaths?.x ?? 0
        let y = availablePaths?.y ?? 0
        let indexpath = IndexPath(row: x, section: y)
        allIndexpaths.append(indexpath)
        if let allPaths = availablePaths?.previousNodes {
            for node in allPaths {
                return getIndexpathsOfNode(availablePaths: node)
            }
        }
        return allIndexpaths
    }
}

public struct Node {

    let y: Int, x: Int // (x, y) represents chessboard coordinates
    let distance: Int // dist represent its minimum distance from the source\
    var previousNodes:[Node] = [] // previousNodes represent all the previous paths of nodes

    init(x: Int, y: Int, distance: Int = 0) {
        self.x = x
        self.y = y
        self.distance = distance
    }

    mutating func addToPreviousVisitedNodes(node: Node) {
        self.previousNodes.append(node)
    }
}

extension Node: Hashable {

    // Using Node struct as a key we need conform to Hashable
    public var hashValue: Int {
        return "\(self.x)\(self.y)".hashValue
    }

    public static func ==(lhs: Node, rhs: Node) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

// all 8 possible movements for a knight
let knightMoves = [
    [ 2, -1],
    [ 2,  1],
    [-2,  1],
    [-2, -1],
    [ 1,  2],
    [ 1, -2],
    [-1,  2],
    [-1, -2]
]

struct Queue<T> {
    var array = [T]()

    public var isEmpty: Bool {
        return self.array.isEmpty
    }

    public var count: Int {
        return self.array.count
    }

    public mutating func enqueue(_ element: T) {
        self.array.append(element)
    }

    public mutating func dequeue() -> T? {
        if self.isEmpty {
            return nil
        } else {
            return self.array.removeFirst()
        }
    }

    public var front: T? {
        return self.array.first
    }
}

extension Int {
    var associatedCharacter: String? {
        guard 1...16 ~= self, let unicodeScalar = UnicodeScalar(64 + self) else { return nil }
        return String(Character(unicodeScalar))
    }
}
