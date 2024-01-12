//
//  ViewController.swift
//  The_Reminder
//
//  Created by Ashok on 04/01/24.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var innercircle: UIView!
    @IBOutlet weak var tableView : UITableView!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
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
//
//        let totalCellHeight = calculateTotalCellHeight()
//        print("manisha",totalCellHeight)
//        //tableView.frame.size.height = CGFloat(50*90)
//        heightConstraint.constant = ceil(totalCellHeight)
        
        self.tableView.register(UINib(nibName: "DailyRecordCell", bundle: nil), forCellReuseIdentifier: "DailyRecordCell")

        
        self.tableView.invalidateIntrinsicContentSize()
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
    
    func calculateTotalCellHeight() -> CGFloat {
        var totalHeight: CGFloat = 0

               for row in 0..<50 {
                   let indexPath = IndexPath(row: row, section: 0)
                   totalHeight += tableView.delegate?.tableView?(tableView, heightForRowAt: indexPath) ?? 0
               }

               return totalHeight
       }

}


