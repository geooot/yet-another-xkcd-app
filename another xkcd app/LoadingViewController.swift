//
//  LodaingViewController.swift
//  another xkcd app
//
//  Created by George Thayamkery on 6/21/17.
//  Copyright © 2017 George Thayamkery. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    var xkcdScraper = XkcdScraper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        xkcdScraper.getEntries {
            let PageView = self.storyboard?.instantiateViewController(withIdentifier: "PageView") as! PageViewController
            PageView.xkcdScraper = self.xkcdScraper
            self.present(PageView, animated: true, completion: nil)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
