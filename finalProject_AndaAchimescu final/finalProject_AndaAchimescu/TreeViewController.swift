//
//  TreeViewController.swift
//  finalProject_AndaAchimescu
//
//  Created by Student2018 on 2018-05-02.
//  Copyright © 2018 Student2018. All rights reserved.
//

import UIKit

class TreeViewController: UIViewController {

    // the tree will be viewed through the uiview
    @IBOutlet var aTree: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // display tree
        aTree = Tree(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        self.view = aTree
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

// change degrees to radians
extension CGFloat {
    func degrees_to_radians() -> CGFloat {
        return CGFloat(Double.pi) * self / 180.0
    }
}
extension Double {
    func degrees_to_radians() -> Double {
        return Double(Double.pi) * self / 180.0
    }
    
}

// create the fractal tree
class Tree: UIView {
    
    func drawTree(x1: CGFloat, y1: CGFloat, angle: CGFloat, depth:Int) {
        if depth == 0 {
            return
        }
        
        let ang = angle.degrees_to_radians()
        let x2:CGFloat = x1 + ( cos(ang) as CGFloat) * CGFloat(depth) * (self.frame.width / 60)
        let y2:CGFloat = y1 + ( sin(ang) as CGFloat) * CGFloat(depth) * (self.frame.width / 60)
        
        let line = drawLine(x1: x1, y1: y1, x2: x2, y2: y2)
        
        line.stroke()
        // recursively call the function in order to draw more branches
        drawTree(x1: x2, y1: y2, angle: angle - 20, depth: depth - 1)
        drawTree(x1: x2, y1: y2, angle: angle + 20, depth: depth - 1)
    }
    
    // use line segments to draw out the lines in the tree
    func drawLine(x1:CGFloat, y1:CGFloat, x2:CGFloat, y2:CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: x1,y: y1))
        path.addLine(to: CGPoint(x: x2,y: y2))
        path.lineWidth = 1
        return path
    }
    
    // choose the colours (user will most likely) to draw out the tree 
    override func draw(_ rect: CGRect) {
        let color = UIColor(red: redC/255, green: greenC/255, blue: blueC/255, alpha: 6.0)
        color.set()
        drawTree(x1: self.frame.width / 2 , y1: self.frame.height * 0.8, angle: -90 , depth: 9 )
    }
}

