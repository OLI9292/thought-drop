//
//  DropViewController.swift
//  Thought Drop
//
//  Created by Oliver  on 2/16/17.
//  Copyright © 2017 Oliver . All rights reserved.
//

import UIKit

class DropViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func pressedDropButton(_ sender: AnyObject) {
        if let content = textView.text {
            ExploreController.thoughtText = content
            tabBarController?.selectedIndex = 0
        }
    }
}
