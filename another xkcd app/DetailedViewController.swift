//
//  DetailedViewController.swift
//  another xkcd app
//
//  Created by George Thayamkery on 6/21/17.
//  Copyright © 2017 George Thayamkery. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var numberLabel: UILabel!
    
    var titleOfPost: String?
    var descriptionOfPost: String?
    var imageURL: String?
    var urlToPost: String?
    var postNumber: String?
    var xkcdScraper: XkcdScraper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel?.text = titleOfPost == nil ? "":titleOfPost
        descLabel?.text = descriptionOfPost == nil ? "": descriptionOfPost
        numberLabel?.text = postNumber == nil ? "": "#\(postNumber!)"
        
        if xkcdScraper!.imageCache[imageURL!] != nil{
            imageView.frame = CGRect(x: imageView.frame.origin.x, y: imageView.frame.origin.y, width: (xkcdScraper?.imageCache[imageURL!]!.size.width)!, height: imageView.frame.height)
        
            imageView?.image = xkcdScraper?.imageCache[imageURL!]
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        imageView = nil
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func shareThisPost(_ sender: UIBarButtonItem) {
        let textToShare = titleOfPost == nil ? "Check this out from xkcd!" : titleOfPost!
        let urlToUse = urlToPost == nil ? NSURL(string: "https://xkcd.com") : NSURL(string: urlToPost!)
        
        let shareObj: [Any] = [textToShare, urlToUse!]
        
        let shareVC = UIActivityViewController(activityItems: shareObj, applicationActivities: nil)
        
        self.present(shareVC, animated: true, completion: nil)
    }

    @IBAction func onRefresh(_ sender: UIBarButtonItem) {
        xkcdScraper?.entries.removeAll()
        xkcdScraper?.imageCache.removeAll()
        xkcdScraper = nil
        imageView = nil
    }
    
    /*
    // MARK: - Navigations

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
