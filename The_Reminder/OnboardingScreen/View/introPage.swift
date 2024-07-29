//
//  introPage.swift
//  The_Reminder
//
//  Created by Bharath on 30/05/24.
//

import UIKit

class introPage: UIViewController {

    @IBOutlet weak var letsgoBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func proceedAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "OnboardingViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "genderPage") as! genderPage
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    

}
