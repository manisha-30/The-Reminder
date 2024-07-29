//
//  HistoryViewController.swift
//  The_Reminder
//
//  Created by Ashok on 11/03/24.
//

import UIKit
import SwiftUI
import Charts

class HistoryViewController: UIViewController {

    let contentView = UIHostingController(rootView: GraphView())
                                          
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(contentView)
        self.view.addSubview(contentView.view)
        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            contentView.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            contentView.view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10),
            contentView.view.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            contentView.view.heightAnchor.constraint(equalTo: self.view.heightAnchor)
        ])
        // Do any additional setup after loading the view.
    }
}
