//
//  OnboardingViewController.swift
//  The_Reminder
//
//  Created by Ashok on 23/01/24.
//

import UIKit

class OnboardingViewController: UIPageViewController, UIPageViewControllerDelegate {

    
    
    var pages = [UIViewController]()
    let pageControl = UIPageControl()
    let initialPage = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpPageControl()
       
    }
    
    func setUpPageControl(){
        delegate = self
        dataSource = self
        
       // pageControl.addTarget(self, action: #selector(pageControlTapped), for: .valueChanged)
        
        let storyboard = UIStoryboard(name: "OnboardingViewController", bundle: nil)
        let vc1 = storyboard.instantiateViewController(withIdentifier: "introPage")
        let vc2 = storyboard.instantiateViewController(withIdentifier: "genderPage")
        let vc3 = storyboard.instantiateViewController(withIdentifier: "weightPage")
        let vc4 = storyboard.instantiateViewController(withIdentifier: "wakeupPage")
        let vc5 = storyboard.instantiateViewController(withIdentifier: "sleepPage")
        
        pages.append(vc1)
        pages.append(vc2)
        pages.append(vc3)
        pages.append(vc4)
        pages.append(vc5)
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true)
    }
    
    @objc func pageControlTapped(){
        
    }

}
extension OnboardingViewController:UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentPage = pages.firstIndex(of: viewController) else{
            return nil
        }
        if currentPage != 0{
            return pages[currentPage - 1]
        }else{
            return pages[initialPage]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentPage = pages.firstIndex(of: viewController) else{
            return nil
        }
        if currentPage < pages.count - 1{
            return pages[currentPage + 1]
        }else{
            return pages[pages.count - 1]
        }
        
    }
}
