//
//  Tree.swift
//  finalProject_AndaAchimescu
//
//  Created by Student2018 on 2018-06-20.
//  Copyright © 2018 Student2018. All rights reserved.
//

import UIKit

/*extension CGFloat {
    func degrees_to_radians() -> CGFloat {
        return CGFloat(Double.pi) * self / 180.0
    }
}

extension Double {
    func degrees_to_radians() -> Double {
        return Double(Double.pi) * self / 180.0
    }
    
}

class Tree: UIView {

    func drawTree(x1: CGFloat, y1: CGFloat, angle: CGFloat, depth:Int){
        if depth == 0 {
            return
        }
        let ang = angle.degrees_to_radians()
        let x2:CGFloat = x1 + ( cos(ang) as CGFloat) * CGFloat(depth) * (self.frame.width / 60)
        let y2:CGFloat = y1 + ( sin(ang) as CGFloat) * CGFloat(depth) * (self.frame.width / 60)
        
        let line = drawLine(x1: x1, y1: y1, x2: x2, y2: y2)
        
        line.stroke()
        drawTree(x1: x2, y1: y2, angle: angle - 20, depth: depth - 1)
        drawTree(x1: x2, y1: y2, angle: angle + 20, depth: depth - 1)
    }
    
    func drawLine(x1:CGFloat, y1:CGFloat, x2:CGFloat, y2:CGFloat) -> UIBezierPath
    {
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: x1,y: y1))
        path.addLine(to: CGPoint(x: x2,y: y2))
        path.lineWidth = 1
        return path
    }
    
    override func draw(_ rect: CGRect) {
        
        let color = UIColor(red: 3.0, green: 0.3, blue: 5.0, alpha: 5.0)
        color.set()
        drawTree(x1: self.frame.width / 2 , y1: self.frame.height * 0.8, angle: -90 , depth: 9 )
    }
}

let tree = Tree(frame: CGRect(x: 0, y: 0, width: 300, height: 300))*/
