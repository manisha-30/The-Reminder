//
//  sleepPage.swift
//  The_Reminder
//
//  Created by Bharath on 30/05/24.
//

import UIKit

class sleepPage: UIViewController {

    @IBOutlet weak var frwdImg: UIImageView!
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var backwardView: UIView!
    @IBOutlet weak var frwdView: UIView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var sleepLbl: UILabel!
    @IBOutlet weak var wakeupLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    
    let datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        if UserDefaults.standard.string(forKey: "selectedSleep") == nil{
            UserDefaults.standard.setValue("10.00 PM", forKey: "selectedSleep")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let initialPickerValue = UserDefaults.standard.string(forKey: "selectedSleep") ?? "10.00 PM"
        datePicker.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "h:mm a"
      //  dateFormatter.timeZone = TimeZone(identifier: "UTC")

        
        if let defaultDate = dateFormatter.date(from: initialPickerValue) {
            //datePicker.timeZone = TimeZone(identifier: "UTC")
            datePicker.setDate(defaultDate, animated: false)
        }
        updateTopView()
    }
    
    func setupUI(){
        frwdView.layer.cornerRadius = frwdView.frame.height / 2
        frwdView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(frwdTapped)))
        frwdView.layer.masksToBounds = true
        
        backwardView.layer.cornerRadius = frwdView.frame.height / 2
        backwardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backTapped)))
        backwardView.layer.masksToBounds = true
        backImg.tintColor = UIColor.white
        frwdImg.tintColor = UIColor.white
        
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(dueDateChanged), for: UIControl.Event.valueChanged)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        dateView.addSubview(datePicker)
        NSLayoutConstraint.activate([
            datePicker.leadingAnchor.constraint(equalTo: dateView.leadingAnchor),
            datePicker.topAnchor.constraint(equalTo: dateView.topAnchor),
            datePicker.bottomAnchor.constraint(equalTo: dateView.bottomAnchor),
            datePicker.trailingAnchor.constraint(equalTo: dateView.trailingAnchor)
        ])
    }
    @objc func dueDateChanged(){
        
        let time = datePicker.date
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeStyle = .short
        let timeStamp = dateFormatter.string(from: time)
        UserDefaults.standard.setValue(timeStamp, forKey: "selectedSleep")
        updateTopView()
        print("manih",timeStamp)
    }
    @objc func backTapped(){
        self.dismiss(animated: true)
    }
    
    @objc func frwdTapped(){
//        lottieViewController
   //     let storyboard = UIStoryboard(name: "OnboardingViewController", bundle: nil)
        let vc = lottieViewController()//storyboard.instantiateViewController(identifier: "sleepPage") as! sleepPage
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    func updateTopView(){
        let userdefault = UserDefaults.standard
        
        let gender = userdefault.string(forKey: "selectedGender")
        let weight = userdefault.string(forKey: "selectedWeight")
        let wakeup = userdefault.string(forKey: "selectedWakeup")
        let sleep = userdefault.string(forKey: "selectedSleep")
        
        if gender != nil{
            genderLbl.text = gender
            genderLbl.textColor = hexStringToUIColor(hex: "50c8ef").withAlphaComponent(1.5)
        }else{
            genderLbl.text = "---"
            genderLbl.textColor = .black
        }
        
        if weight != nil{
            weightLbl.text = weight
            weightLbl.textColor = hexStringToUIColor(hex: "0ACBFF").withAlphaComponent(1.5)
        }else{
            weightLbl.text = "---"
            weightLbl.textColor = .black
        }
        
        if wakeup != nil{
            wakeupLbl.text = wakeup
            wakeupLbl.textColor = hexStringToUIColor(hex: "0ACBFF").withAlphaComponent(1.5)
        }else{
            wakeupLbl.text = "---"
            wakeupLbl.textColor = .black
        }
        
        if sleep != nil{
            sleepLbl.text = sleep
            sleepLbl.textColor = hexStringToUIColor(hex: "0ACBFF").withAlphaComponent(1.5)
        }else{
            sleepLbl.text = "---"
            sleepLbl.textColor = .black
        }
    }
}
