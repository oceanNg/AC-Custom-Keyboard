//
//  KeyboardViewController.swift
//  Appcoda Keyboard
//
//  Created by Joyce Echessa on 10/27/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    var capsLockOn = true
    
    @IBOutlet weak var row1: UIView!
    @IBOutlet weak var row2: UIView!
    @IBOutlet weak var row3: UIView!
    @IBOutlet weak var row4: UIView!
    
    @IBOutlet weak var charSet1: UIView!
    @IBOutlet weak var charSet2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "KeyboardView", bundle: nil)
        let objects = nib.instantiateWithOwner(self, options: nil)
        view = objects[0] as! UIView;
        
        charSet2.hidden = true
    }
    
    @IBAction func nextKeyboardPressed(button: UIButton) {
        advanceToNextInputMode()
    }
    
    @IBAction func capsLockPressed(button: UIButton) {
        capsLockOn = !capsLockOn
        
        changeCaps(row1)
        changeCaps(row2)
        changeCaps(row3)
        changeCaps(row4)
    }
    
    @IBAction func keyPressed(button: UIButton) {
        var string = button.titleLabel!.text
        (textDocumentProxy as UIKeyInput).insertText("\(string!)")
        
        UIView.animateWithDuration(0.2, animations: {
            button.transform = CGAffineTransformScale(CGAffineTransformIdentity, 2.0, 2.0)
            }, completion: {(_) -> Void in
                button.transform =
                    CGAffineTransformScale(CGAffineTransformIdentity, 1, 1)
        })
    }
    
    @IBAction func backSpacePressed(button: UIButton) {
        (textDocumentProxy as UIKeyInput).deleteBackward()
    }
    
    @IBAction func spacePressed(button: UIButton) {
        (textDocumentProxy as UIKeyInput).insertText(" ")
    }
    
    @IBAction func returnPressed(button: UIButton) {
        (textDocumentProxy as UIKeyInput).insertText("\n")
    }
    
    @IBAction func charSetPressed(button: UIButton) {
        if button.titleLabel!.text == "1/2" {
            charSet1.hidden = true
            charSet2.hidden = false
            button.setTitle("2/2", forState: .Normal)
        } else if button.titleLabel!.text == "2/2" {
            charSet1.hidden = false
            charSet2.hidden = true
            button.setTitle("1/2", forState: .Normal)
        }
    }
    
    func changeCaps(containerView: UIView) {
        for view in containerView.subviews {
            if let button = view as? UIButton {
                let buttonTitle = button.titleLabel!.text
                if capsLockOn {
                    let text = buttonTitle!.uppercaseString
                    button.setTitle("\(text)", forState: .Normal)
                } else {
                    let text = buttonTitle!.lowercaseString
                    button.setTitle("\(text)", forState: .Normal)
                }
            }
        }
    }
    
}
