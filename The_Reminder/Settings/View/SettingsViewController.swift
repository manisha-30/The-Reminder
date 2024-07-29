//
//  SettingsViewController.swift
//  The_Reminder
//
//  Created by Ashok on 11/03/24.
//

import UIKit
import RealmSwift
class settingsCell : UITableViewCell{
    
    @IBOutlet weak var hLbl: UILabel!
    @IBOutlet weak var vLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var settingTB: UITableView!
    var Personal_information : [String] = ["Gender","Weight","Wake-up time","Bedtime"]
    var otherHeading = ["Reset Data","Feedback","Share","Privacy policy"] //[String]() 
    var info_personal = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let gender = UserDefaults.standard.string(forKey: "selectedGender") ?? ""
        let weight = UserDefaults.standard.string(forKey: "selectedWeight") ?? ""
        let wakeup = UserDefaults.standard.string(forKey: "selectedWakeup") ?? ""
        let sleep = UserDefaults.standard.string(forKey: "selectedSleep") ?? ""
        
        
      //   Personal_information = ["Gender","Weight","Wake-up time","Bedtime"]
         info_personal = [gender,weight,wakeup,sleep]

         //otherHeading = ["Reset Data","Feedback","Share","Privacy policy"]
        settingTB.delegate = self
        settingTB.dataSource = self
        settingTB.separatorStyle = .none
        settingTB.reloadData()
    }

}
extension SettingsViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return Personal_information.count
        }else{
            return otherHeading.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as! settingsCell
        if indexPath.section == 0{
            cell.hLbl.text = Personal_information[indexPath.row]
            cell.vLbl.text = info_personal[indexPath.row]
            cell.vLbl.isHidden = false
        }else{
            cell.hLbl.text = otherHeading[indexPath.row]
            cell.vLbl.isHidden = true
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Personal Information"
        }else{
            return "Other"
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != 0{
            if otherHeading[indexPath.row] == "Reset Data"{
                reset()
            }
        }
    }
    
    func reset(){
        if UserDefaults.standard.object(forKey: "totalInTakeValue") == nil{
            UserDefaults.standard.set(0, forKey: "totalInTakeValue")
        }
        if UserDefaults.standard.object(forKey: "totalQuans") == nil{
            UserDefaults.standard.set(0, forKey: "totalQuans")
        }
        if UserDefaults.standard.object(forKey: "selectedCup") == nil{
            UserDefaults.standard.setValue("100", forKey: "selectedCup")
        }
        
        let userdefault = UserDefaults.standard

        userdefault.removeObject(forKey: "selectedGender")
        userdefault.removeObject(forKey: "selectedWeight")
        userdefault.removeObject(forKey: "selectedWakeup")
        userdefault.removeObject(forKey: "selectedSleep")
        
        UserDefaults.standard.synchronize()
        
        
        let realm = try! Realm()
        try! realm.write{
            realm.deleteAll()
        }
        
        let mainContentVC = UIStoryboard(name: "OnboardingViewController", bundle: nil).instantiateViewController(withIdentifier: "introPage")
        mainContentVC.modalPresentationStyle = .fullScreen
        self.present(mainContentVC, animated: true)
    }
}
