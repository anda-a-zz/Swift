//
//  MandelViewController.swift
//  finalProject_AndaAchimescu
//
//  Created by Student2018 on 2018-05-22.
//  Copyright © 2018 Student2018. All rights reserved.
//

import UIKit
import SpriteKit

// linking up a SKScene with a UIViewController
extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        if let path = Bundle.main.path(forResource: file as String, ofType: "sks") {
            let sceneData = try! Data(contentsOf: URL(fileURLWithPath: path), options: Data.ReadingOptions.dataReadingMapped)
            let archiver = NSKeyedUnarchiver(forReadingWith: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! MandelScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class MandelViewController: UIViewController, UIScrollViewDelegate {

    // declare variables
    var node:SKSpriteNode!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    var location:CGPoint = CGPoint(x:Double(0.0),y:Double(0.0))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = MandelScene.unarchiveFromFile(file: "MandelScene") as? MandelScene {
            
            // Configure the view
            // not orginally a SKView so this line is necessary to convert from UIView
            self.view = SKView(frame: CGRect(x: 0, y: 0, width: 375, height: 603))
            let skView = self.view as! SKView
            skView.ignoresSiblingOrder = true
            
            // Fill the window with the animation
            scene.scaleMode = .fill
            node = scene.childNode(withName: "MandelScene") as! SKSpriteNode
   
            // use a SKCamera in order to zoom in and see the mandelbrot set better
            let camera = SKCameraNode()
            camera.position = CGPoint(x:location.x, y:location.y)
            camera.xScale = 1
            camera.yScale = 1
            camera.zRotation = 3.14
            scene.addChild(camera)
            scene.camera = camera
            
            // view the scene/animation
            skView.presentScene(scene)
        }
        // updateShader(scrollView: scrollView)
    }
    
    @IBAction func tapForLocation(_ sender: UITapGestureRecognizer) {
        location = sender.location(in: view)
        print(location)
    }

    // used for zoom
    // zoom is the float and offset are the vec2 number(s)
    
    func updateShader(scrollView: UIScrollView) {
        let zoomUniform = node.shader!.uniformNamed("zoom")!
        let offsetUniform = node.shader!.uniformNamed("offset")!
        var offset = scrollView.contentOffset
        
        offset.x /= scrollView.contentSize.width
        offset.y /= scrollView.contentSize.height
        
        zoomUniform.floatValue = Float(scrollView.zoomScale)
        offsetUniform.floatVector2Value = GLKVector2Make(Float(offset.x), Float(offset.y))
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateShader(scrollView: scrollView)
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateShader(scrollView: scrollView)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return contentView
    }
    
    func prefersStatusBarHidden() -> Bool {
        return true
    }

}
