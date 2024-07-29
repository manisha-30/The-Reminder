//
//  lottieViewController.swift
//  The_Reminder
//
//  Created by Bharath on 30/05/24.
//

import UIKit
import Lottie
class lottieViewController: UIViewController {
    
    var totalInterval = 0
    var avgValue = 0;
    private var animationView: LottieAnimationView?
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
        animationView = .init(name: "loader1")
        
        animationView!.frame = view.bounds
        animationView!.contentMode = .scaleAspectFit
         animationView!.loopMode = .playOnce
         animationView!.animationSpeed = 0.75
         view.addSubview(animationView!)
         animationView!.play()
        
        let wakeup = UserDefaults.standard.string(forKey: "selectedWakeup") ?? "6.00 AM"
        let sleep = UserDefaults.standard.string(forKey: "selectedSleep") ?? "10.00 PM"
        let totalIntake = SettingsViewModel().calculateTotalIntake()
        let intervals = SettingsViewModel().createIntervals(start: wakeup, end: sleep)
        totalInterval = intervals?.count ?? 0
        avgValue = totalIntake / totalInterval
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
            self.animationView!.stop()
            self.animationView?.isHidden = true
            self.setupFinalDisplay()

        }
    }
    func setupFinalDisplay(){
        let imagev = UIImageView()
        imagev.image = UIImage(named: "bannerImage")

        view.addSubview(imagev)
        imagev.translatesAutoresizingMaskIntoConstraints = false
        
        let headingLbl = UILabel()
        headingLbl.text = "How much should you drink"
        headingLbl.font = UIFont.systemFont(ofSize: 24)
        headingLbl.textAlignment = .center
        view.addSubview(headingLbl)
        headingLbl.translatesAutoresizingMaskIntoConstraints = false
        
        let timeLbl = UILabel()
        timeLbl.text = "\(totalInterval) times a day"
        timeLbl.textAlignment = .center
        timeLbl.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(timeLbl)
        timeLbl.translatesAutoresizingMaskIntoConstraints = false
        
        let mlLbl = UILabel()
        mlLbl.text = "\(avgValue)ml each time"
        mlLbl.textAlignment = .center
        mlLbl.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(mlLbl)
        mlLbl.translatesAutoresizingMaskIntoConstraints = false
        
        
        let startBtn = UIButton()
        startBtn.setTitle("START", for: .normal)
        startBtn.backgroundColor = hexStringToUIColor(hex: "0895DC")
        startBtn.setTitleColor(UIColor.white, for: .normal)
        startBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        startBtn.layer.cornerRadius = 10
        startBtn.layer.masksToBounds = false
        startBtn.translatesAutoresizingMaskIntoConstraints = false
        startBtn.addTarget(self, action: #selector(showDashBoard), for: .touchUpInside)
        view.addSubview(startBtn)
        
        NSLayoutConstraint.activate([
            //imagev.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            imagev.widthAnchor.constraint(equalToConstant: 250),
            imagev.heightAnchor.constraint(equalToConstant: 250),
            imagev.centerXAnchor.constraint(equalTo: self.view.centerXAnchor,constant: 0),
            imagev.centerYAnchor.constraint(equalTo: self.view.centerYAnchor,constant: -35),
            
            headingLbl.topAnchor.constraint(equalTo: imagev.bottomAnchor, constant: 20),
            headingLbl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            headingLbl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            
            timeLbl.topAnchor.constraint(equalTo: headingLbl.bottomAnchor, constant: 10),
            timeLbl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            timeLbl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            
            mlLbl.topAnchor.constraint(equalTo: timeLbl.bottomAnchor, constant: 10),
            mlLbl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            mlLbl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            
            startBtn.topAnchor.constraint(equalTo: mlLbl.bottomAnchor, constant: 40),
            startBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            startBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50),
            
        ])
    }
    @objc func showDashBoard(){
        let mainContentVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabVC")
        mainContentVC.modalPresentationStyle = .fullScreen
        self.present(mainContentVC, animated: true, completion: nil)
    }

}
