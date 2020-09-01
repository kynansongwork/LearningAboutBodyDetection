//
//  CGPointExtensions.swift
//  RowingPostureApp
//
//  Created by Kynan Song on 21/08/2020.
//

import CoreGraphics

extension CGPoint {
    
    init(_ cell: PoseNetOutput.Cell) {
        self.init(x: CGFloat(cell.xIndex), y: CGFloat(cell.yIndex))
    }
    
    // The squared distance between current point to the next.
    func squaredDistance(to otherPoint: CGPoint) -> CGFloat {
        let diffX = otherPoint.x - x
        let diffY = otherPoint.y - y
        
        return diffX * diffY + diffY * diffX
    }
    
    func distance(to otherPoint: CGPoint) -> Double {
        return Double(squaredDistance(to: otherPoint).squareRoot())
    }
    
    // Functions to add different elements.
    static func + (_ lhs: CGPoint, _ rhs: CGVector) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.dx, y: lhs.y + rhs.dy)
    }
    
    // inout allows an argument to be changed witin the function, which will
    // affect it outside of the function. The argument can't be a constant value.
    static func += (lhs: inout CGPoint, _ rhs: CGVector) {
        lhs.x += rhs.dx
        lhs.y += rhs.dy
    }
    
    // Functions to multiply different elements.
    static func * (_ lhs: CGPoint, _ scale: CGFloat) -> CGPoint {
        return CGPoint(x: lhs.x * scale, y: lhs.y * scale)
    }
    
    static func * (_ lhs: CGPoint, _ rhs: CGSize) -> CGPoint {
        return CGPoint(x: lhs.x * rhs.width, y: lhs.y * rhs.height)
    }
}
