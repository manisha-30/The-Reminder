//
//  weightPage.swift
//  The_Reminder
//
//  Created by Bharath on 30/05/24.
//

import UIKit

class weightPage: UIViewController {

    
    @IBOutlet weak var frwdImg: UIImageView!
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var backwardView: UIView!
    @IBOutlet weak var frwdView: UIView!
    
    @IBOutlet weak var sleepLbl: UILabel!
    @IBOutlet weak var wakeupLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    
    @IBOutlet weak var weightPicker: UIPickerView!
    let weights = Array(1...100)
  //  var initialPickerValue = 40
    override func viewDidLoad() {
        super.viewDidLoad()

        if UserDefaults.standard.string(forKey: "selectedWeight") == nil{
            UserDefaults.standard.setValue("40", forKey: "selectedWeight")
        }
        
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let initialPickerValue = UserDefaults.standard.integer(forKey: "selectedWeight")
        if let initialIndex = weights.firstIndex(of: initialPickerValue) {
            // Select the row corresponding to the initial picker value
            weightPicker.selectRow(initialIndex, inComponent: 0, animated: false)
        }
        
        //UserDefaults.standard.setValue("\(initialPickerValue)", forKey: "selectedWeight")
        
        updateTopView()
    }

    func setupUI(){
        frwdView.layer.cornerRadius = frwdView.frame.height / 2
        frwdView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(frwdTapped)))
        frwdView.layer.masksToBounds = true
        
        backwardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backTapped)))
        backwardView.layer.cornerRadius = frwdView.frame.height / 2
        backwardView.layer.masksToBounds = true
        backImg.tintColor = UIColor.white
        frwdImg.tintColor = UIColor.white
        
        weightPicker.delegate = self
        weightPicker.dataSource = self 
    }
    @objc func backTapped(){
        self.dismiss(animated: true)
    }
    
    @objc func frwdTapped(){
        let storyboard = UIStoryboard(name: "OnboardingViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "wakeupPage") as! wakeupPage
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
extension weightPage:UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return weights.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(weights[row])" // Display each weight in the picker view
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedValue = weights[row]
        print("Selected weight: \(selectedValue)") // Handle the selected weight
        UserDefaults.standard.setValue("\(selectedValue)", forKey: "selectedWeight")
        updateTopView()
    }
    
}
