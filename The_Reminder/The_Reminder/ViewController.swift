//
//  ViewController.swift
//  The_Reminder
//
//  Created by Ashok on 04/01/24.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var outerCircleView: UIView!
    @IBOutlet weak var innercircle: UIView!
    @IBOutlet weak var tableView : UITableView!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    let shapeLayer = CAShapeLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        innercircle.layer.cornerRadius = innercircle.frame.width / 2
        innercircle.layer.masksToBounds = true
        // Do any additional setup after loading the view.
        
        tableView.layer.cornerRadius = 5  // Adjust the corner radius as needed
        tableView.layer.shadowColor = UIColor.black.cgColor  // Adjust the shadow color as needed
        tableView.layer.shadowOffset = CGSize(width: 0, height: 2)  // Adjust the shadow offset as needed
        tableView.layer.shadowOpacity = 0.5  // Adjust the shadow opacity as needed
        tableView.layer.shadowRadius = 2  // Adjust the shadow radius as needed
        tableView.layer.masksToBounds = false
        
        
        self.tableView.register(UINib(nibName: "DailyRecordCell", bundle: nil), forCellReuseIdentifier: "DailyRecordCell")

        
        self.tableView.invalidateIntrinsicContentSize()
        
        drawSemiCircle()
        
        innercircle.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSemicircle)))
    }
    override func viewWillLayoutSubviews() {
        self.heightConstraint.constant = CGFloat(10 * 90)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "DailyRecordCell", for: indexPath) as! DailyRecordCell
      //  cell.textLabel?.text = "mani"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func drawSemiCircle(){
        
        let center = CGPoint(x: outerCircleView.frame.width / 2, y: outerCircleView.frame.height / 2)
        let semiCirclePath = UIBezierPath(arcCenter: center, radius: innercircle.frame.width / 2 + 25 , startAngle: CGFloat.pi, endAngle: 2 * CGFloat.pi, clockwise: true)
        //semiCirclePath.close()
        shapeLayer.path = semiCirclePath.cgPath
      shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 7
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = .round
        shapeLayer.fillColor = UIColor.clear.cgColor
        self.outerCircleView.layer.addSublayer(shapeLayer)
        
    }
    
    @objc func handleSemicircle(){
        print("hell world")
        
        let animate = CABasicAnimation(keyPath: "strokeEnd")
        animate.toValue = 1
        animate.duration = 3
        animate.fillMode = .forwards
        animate.isRemovedOnCompletion = false
        shapeLayer.add(animate, forKey: "drawCircle")
    }
}


