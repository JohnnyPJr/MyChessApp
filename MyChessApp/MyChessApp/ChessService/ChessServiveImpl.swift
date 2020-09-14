//
//  ChessServiveImpl.swift
//  MyChessApp
//
//  Created by John Platsis on 14/9/20.
//  Copyright © 2020 IPV. All rights reserved.
//

import Foundation
import UIKit

/// The share account service protocol
public protocol ChessService {
    /// Called to determine Whether to show the knight image on a specific cell
    ///
    /// - Parameters:
    ///   - IndexPath: The indexpath of the cell
    func shouldShowKnightImage(at indexPath: IndexPath) -> Bool

    /// Called to determine the background color of a specific cell
    ///
    /// - Parameters:
    ///   - IndexPath: The indexpath of the cell
    func getBackgroundColor(at indexPath: IndexPath) -> UIColor

    /// Called to determine the text color of a specific cell
    ///
    /// - Parameter indexPath: the indexPath
    /// - Returns: the colour
    func getTextColorForCell(at indexPath: IndexPath) -> UIColor

    /// Shares an account
    func validateData()

    /// Called to return All Paths for selected Nodes
    ///
    /// - Parameters:
    ///   - startingNode: The indexpath of the cell
    ///   - destinationNode: The indexpath of the cell
    ///   - sizeOfChess: The indexpath of the cell
    /// - Returns: the colour
    func getAvailablePaths(startingNode src: Node,
                           destinationNode dest: Node,
                           sizeOfChess size: Int) -> [ChessPathsResultData]
}

public class ChessServiceImpl: NSObject, ChessService {

    var data: ChessModel

    init(data: ChessModel) {
        self.data = data
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func shouldShowKnightImage(at indexPath: IndexPath) -> Bool {
        var isHidden = true
        if data.sourcePosition?.x == indexPath.row &&
            data.sourcePosition?.y == indexPath.section {
            isHidden = false
        }
        return isHidden
    }

    public func getBackgroundColor(at indexPath: IndexPath) -> UIColor {

        var color: UIColor = UIColor.clear
        let number = indexPath.row + indexPath.section
        if number % 2 == 0 {
            color = .black
        } else {
            color = .white
        }

        for index in getAllIndexPaths() {
            if index.row == indexPath.row && index.section == indexPath.section {
                color = .yellow
            }
        }

        if data.sourcePosition?.x == indexPath.row &&
            data.sourcePosition?.y == indexPath.section {
            color = .green
        } else if data.destinationPosition?.x == indexPath.row &&
            data.destinationPosition?.y == indexPath.section {
            color = .green
        }
        return color
    }

    public func getTextColorForCell(at indexPath: IndexPath) -> UIColor {

        var color: UIColor = UIColor.clear
        let number = indexPath.row + indexPath.section
        if number % 2 == 0 {
            color = .white
        } else {
            color = .black
        }

        for index in getAllIndexPaths() {
            if index.row == indexPath.row && index.section == indexPath.section {
                color = .black
            }
        }

        if data.sourcePosition?.x == indexPath.row &&
            data.sourcePosition?.y == indexPath.section {
            color = .black
        } else if data.destinationPosition?.x == indexPath.row &&
            data.destinationPosition?.y == indexPath.section {
            color = .black
        }
        return color
    }

    public func validateData() {

    }

    public func getAvailablePaths(startingNode src: Node, destinationNode dest: Node, sizeOfChess size: Int) -> [ChessPathsResultData] {


        var minimumPath: Int = 10
        let results = bfs(src: src,
                          dest: dest,
                          sizeOfChess: size)
        var tempArray:[ChessPathsResultData] = []
        for aPath in results {
            let distance = aPath.availablePaths?.distance ?? 10
            if distance <= minimumPath {
                minimumPath = distance
                tempArray.append(aPath)
            }
        }
        return tempArray
    }

    // Called to determine the minimum steps taken
    /// by the knight from the source to the destination
    /// - Parameters:
    /// - src: the initial Cell exrpresesed as a node
    ///   - dest: the destination Cell exrpresesed as a node
    ///   - sizeOfChess: the size of the chess
      fileprivate func bfs(src: Node, dest: Node, sizeOfChess: Int) -> [ChessPathsResultData] {

          var arrayOfResults: [ChessPathsResultData] = []

          // map to check if matrix cell is visited before or not
          var visited = [Node: Bool]()

          // Create a queue and enqueue first node
          // Queue node used in BFS
          var q = Queue(array: [Node]())
          q.enqueue(src)

          // Run until queue is empty
          while (!q.isEmpty) {

              // Pop front node and process it
              guard let node = q.dequeue() else { break }

              let x = node.x
              let y = node.y
              let dist = node.distance

              // If destination is reached, return distance
              if (x == dest.x && y == dest.y) {

                  let resultData = ChessPathsResultData.init(pathNumber: dist,
                                                             availablePaths: node,
                                                             theDescription: "",
                                                             allIndexpaths: [])
                  arrayOfResults.append(resultData)
              }
              let currentNode = node

              // Skip if location is visited
              if visited[node] == nil && dist < 3{
                  visited[node] = true

                  // Check for all 8 possible movements for a knight
                  // and enqueue each valid movement
                  for i in 0..<knightMoves.count {

                      // Get the new valid position of Knight from current
                      // position on chessboard and enqueue it in the
                      // queue with +1 distance
                      let position = knightMoves[i]
                      let x1 = x + position[0]
                      let y1 = y + position[1]

                    if (isValid(x: x1, y: y1, sizeOfChess: sizeOfChess)) {
                          var node = Node(x: x1, y: y1, distance: dist + 1)
                          node.addToPreviousVisitedNodes(node: currentNode)
                          q.enqueue(node)
                      }
                  }
              }
          }
          return arrayOfResults;
      }

    // Called to determine whether the coordinates are in bounds
    /// - Parameters:
    /// - x
    /// - y
    /// - sizeOfChess: the size of the chess

      fileprivate func isValid(x: Int, y: Int, sizeOfChess: Int) -> Bool {
          guard (x >= 0 && y >= 0 && x < sizeOfChess && y < sizeOfChess) else { return false }
          return true
      }

    // convert nodes to IndexPaths
    /// - Parameters:
    /// - x
    /// - y
    /// - sizeOfChess: the size of the chess
       fileprivate func getAllIndexPaths() -> [IndexPath] {
           var tempresult:[IndexPath] = []
           if let allResults = data.results {
               for var result in allResults {
                   tempresult += result.getIndexpathsOfNode(availablePaths: result.availablePaths)
               }
           }
           return tempresult
       }
}
