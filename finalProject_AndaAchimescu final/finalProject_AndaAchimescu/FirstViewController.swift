//
//  ViewController.swift
//  finalProject_AndaAchimescu
//
//  Created by Student2018 on 2018-05-02.
//  Copyright © 2018 Student2018. All rights reserved.
//

import UIKit

// declare the variables used to colour in the tree fractal
// given random values that can be later changed by the user
var redC:CGFloat = 230
var greenC:CGFloat = 60
var blueC:CGFloat = 60

var text:String? = ""        // initialize text string
var check:Bool = true

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // change the colour of the tree fractal
    // however the number inputted cannot be greater than 255, so it just change the number to 0 if the user tries to input anything larger
    // red
    @IBAction func newRedColour(_ sender: UITextField) {
        text = sender.text
        
        check = checkIfInt(text!)       // call func to check if all int (check with nil)
        
        if check == true {
            if Int(text!)! < 255 {
                redC = CGFloat(Double(text!)!)
            }
            else {
                text = "0"
                sender.text = text
            }
        } else {
            text = "0"
            sender.text = text
        }
    }
    
    // green
    @IBAction func newGreenColour(_ sender: UITextField) {
        text = sender.text
        
        check = checkIfInt(text!)
        
        if check == true {
            if Int(text!)! < 255 {
                greenC = CGFloat(Double(text!)!)
            }
            else {
                text = "0"
                sender.text = text
            }
        } else {
            text = "0"
            sender.text = text
        }
    }
    
    // blue
    @IBAction func newBlueColour(_ sender: UITextField) {
        text = sender.text
        
        check = checkIfInt(text!)
        
        if check == true {
            if Int(text!)! < 255 {
                blueC = CGFloat(Double(text!)!)
            }
            else {
                text = "0"
                sender.text = text
            }
        } else {
            text = "0"
            sender.text = text
        }
    }
    
    // Check if characters from the string are integers
    func checkIfInt(_ input:String) -> Bool {
       
        return Int(input) != nil
    }
    
}

