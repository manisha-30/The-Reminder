//
//  genderPage.swift
//  The_Reminder
//
//  Created by Bharath on 30/05/24.
//

import UIKit

class genderPage: UIViewController {

    @IBOutlet weak var frwdImg: UIImageView!
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var backwardView: UIView!
    @IBOutlet weak var frwdView: UIView!
    @IBOutlet weak var femaleView: UIView!
    @IBOutlet weak var femaleImg: UIImageView!
    @IBOutlet weak var maleImage: UIImageView!
    @IBOutlet weak var maleView: UIView!
    
    @IBOutlet weak var sleepLbl: UILabel!
    @IBOutlet weak var wakeupLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeGenderUI()
        updateTopView()

    }
    func setupUI(){
        femaleView.layer.cornerRadius = 10
        femaleView.layer.shadowColor = UIColor.black.cgColor
        femaleView.layer.shadowRadius = 2
        femaleView.layer.shadowOpacity = 0.50
        femaleView.layer.shadowOffset = CGSize(width: 1, height: 1);
        femaleView.layer.masksToBounds = false
        femaleView.clipsToBounds = false
        femaleImg.image = UIImage(named: "gendergirl")
        femaleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectGirl)))
        
        maleView.layer.cornerRadius = 10
        maleView.layer.shadowColor = UIColor.black.cgColor
        maleView.layer.shadowRadius = 2
        maleView.layer.shadowOpacity = 0.50
        maleView.layer.shadowOffset = CGSize(width: 1, height: 1);
        maleView.layer.masksToBounds = false
        maleView.clipsToBounds = false
        maleImage.image = UIImage(named: "genderboy")
        maleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectBoy)))
        
        frwdView.layer.cornerRadius = frwdView.frame.height / 2
        frwdView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(frwdTapped)))
        frwdView.layer.masksToBounds = true
        
        backwardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backTapped)))
        backwardView.layer.cornerRadius = frwdView.frame.height / 2
        backwardView.layer.masksToBounds = true
        backImg.tintColor = UIColor.white
        frwdImg.tintColor = UIColor.white
        
        
    }
    @objc func backTapped(){
        self.dismiss(animated: true)
    }
    
    @objc func frwdTapped(){
        
        let sGender = UserDefaults.standard.string(forKey: "selectedGender")
        if sGender == nil{
            maleView.backgroundColor = hexStringToUIColor(hex: "#50c8ef")
            maleImage.image = UIImage(named: "boySelected")
            maleImage.tintColor = .white
            
            femaleView.backgroundColor = UIColor.white
            femaleImg.image = UIImage(named: "gendergirl")
            UserDefaults.standard.setValue("Male", forKey: "selectedGender")
        }
        
        let storyboard = UIStoryboard(name: "OnboardingViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "weightPage") as! weightPage
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc func selectGirl(){
        UserDefaults.standard.setValue("Female", forKey: "selectedGender")
        changeGenderUI()
    }
    @objc func selectBoy(){
        UserDefaults.standard.setValue("Male", forKey: "selectedGender")
        changeGenderUI()
    }
    func changeGenderUI(){
        
        let sGender = UserDefaults.standard.string(forKey: "selectedGender")
        if sGender == "Male"{
            maleView.backgroundColor = hexStringToUIColor(hex: "#50c8ef")
            maleImage.image = UIImage(named: "boySelected")
            maleImage.tintColor = .white
            
            femaleView.backgroundColor = UIColor.white
            femaleImg.image = UIImage(named: "gendergirl")
        }else if sGender == "Female"{
            femaleView.backgroundColor = hexStringToUIColor(hex: "#ff5f96")
            femaleImg.image = UIImage(named: "femaleSelected")
            femaleImg.tintColor = .white
            
            maleView.backgroundColor = UIColor.white
            maleImage.image = UIImage(named: "genderboy")
        }else{
            maleView.backgroundColor = UIColor.white
            maleImage.image = UIImage(named: "genderboy")
            
            femaleView.backgroundColor = UIColor.white
            femaleImg.image = UIImage(named: "gendergirl")
        }
        updateTopView()
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
