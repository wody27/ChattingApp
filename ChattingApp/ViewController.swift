//
//  ViewController.swift
//  ChattingApp
//
//  Created by 이재용 on 2020/10/10.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = ""
        var charIndex = 0
        let titleText = "💬 ChattingApp"
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * Double(charIndex), repeats: false) { (timer) in
                self.titleLabel.text?.append(letter)
                
            }
            charIndex += 1
        }
        
    }


}

