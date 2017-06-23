//
//  EndViewController.swift
//  another xkcd app
//
//  Created by George Thayamkery on 6/22/17.
//  Copyright © 2017 George Thayamkery. All rights reserved.
//

import UIKit

class EndViewController: UIViewController {

    var xkcdScraper: XkcdScraper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("GETTING MORE POSTS")
        xkcdScraper?.getMoreEntries {
            print("GOT MORE POSTS")
            let pageVC = self.storyboard!.instantiateViewController(withIdentifier: "PageView") as! PageViewController
            pageVC.xkcdScraper = self.xkcdScraper!
            pageVC.startingIndex = (self.xkcdScraper?.entries.count)!-5
            
            self.present(pageVC, animated: false, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
//    @IBAction func openXkcdWebsite(_ sender: UIButton) {
//        UIApplication.shared.open(URL(string:"https://xkcd.com")!)
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
