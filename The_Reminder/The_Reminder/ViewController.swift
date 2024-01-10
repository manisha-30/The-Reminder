//
//  ViewController.swift
//  The_Reminder
//
//  Created by Ashok on 04/01/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        innercircle.layer.cornerRadius = innercircle.frame.width / 2
        innercircle.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }


    @IBOutlet weak var innercircle: UIView!
}

