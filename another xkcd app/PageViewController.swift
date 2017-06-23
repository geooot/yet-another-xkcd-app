//
//  PageViewController.swift
//  another xkcd app
//
//  Created by George Thayamkery on 6/21/17.
//  Copyright © 2017 George Thayamkery. All rights reserved.
//

import Foundation
import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var detailedViewController: UIViewController?
    var xkcdScraper: XkcdScraper?
    var detailedViewArr = [UIViewController]()
    var canPingForMorePosts = true;
    var startingIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        populateDetailedViewArr()
        
        if startingIndex == nil{
            setViewControllers([detailedViewArr[0],], direction: .forward, animated: true, completion: nil)
        }else{
            setViewControllers([detailedViewArr[startingIndex!],], direction: .forward, animated: true, completion: nil)
        }
    }

    func populateDetailedViewArr(){
        detailedViewArr = [UIViewController]()
        
        for values in xkcdScraper!.entries{
            let currentDetailedVC = storyboard!.instantiateViewController(withIdentifier: "DetailedView") as! DetailedViewController
            currentDetailedVC.titleOfPost = values["title"]
            currentDetailedVC.descriptionOfPost = values["description"]
            currentDetailedVC.imageURL = values["imageURL"]
            currentDetailedVC.urlToPost = values["link"]
            currentDetailedVC.postNumber = values["num"]
            
            currentDetailedVC.xkcdScraper = self.xkcdScraper
            detailedViewArr.append(currentDetailedVC as UIViewController)
        }
        let endVC = storyboard!.instantiateViewController(withIdentifier: "EndingView") as! EndViewController
        endVC.xkcdScraper = xkcdScraper
        detailedViewArr.append(endVC)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("pageView did disappear")
        xkcdScraper = nil
        detailedViewArr.removeAll()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?{
        if let prevCount = detailedViewArr.index(of: viewController) {
            let count = prevCount - 1
            print("back: \(count)")
            if(count >= 0){
                return detailedViewArr[count]
            }else{
                return nil
            }
        }else{
            return nil
        }
        

    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
        if let prevCount = detailedViewArr.index(of: viewController) {
            let count = prevCount + 1
            
            
            if(count < detailedViewArr.count){
                print("forward: \(count)")
                return detailedViewArr[count]
            }else{
                return nil
            }
        }else{
            return nil
        }
        
    }
    
    
//    func presentationCount(for pageViewController: UIPageViewController) -> Int{
//        
//    }
//    
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        
//    }

}
