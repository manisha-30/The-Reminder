//
//  AppDelegate.swift
//  The_Reminder
//
//  Created by Ashok on 04/01/24.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Thread.sleep(forTimeInterval: 0.6)
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]){granted,error in
            if granted{
                print("Permission granted")
            }else{
                print("permission denied")
            }
        }
        
        if UserDefaults.standard.object(forKey: "totalInTakeValue") == nil{
            UserDefaults.standard.set(0, forKey: "totalInTakeValue")
        }
        if UserDefaults.standard.object(forKey: "totalQuans") == nil{
            UserDefaults.standard.set(0, forKey: "totalQuans")
        }
        if UserDefaults.standard.object(forKey: "selectedCup") == nil{
            UserDefaults.standard.setValue("100", forKey: "selectedCup")
        }
        UserDefaults.standard.synchronize()
        
        let walkthroughShown = UserDefaults.standard.bool(forKey: "WalkthroughShown")
                
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        
       
                if !walkthroughShown {
                    let mainContentVC = UIStoryboard(name: "OnboardingViewController", bundle: nil).instantiateViewController(withIdentifier: "introPage")
                    window?.rootViewController = mainContentVC
                    UserDefaults.standard.set(true, forKey: "WalkthroughShown")
              } else {
                    let mainContentVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabVC")
                    window?.rootViewController = mainContentVC
                }

        return true
    }

    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }


}

