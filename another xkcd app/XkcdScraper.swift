//
//  XkcdScraper.swift
//  another xkcd app
//
//  Created by George Thayamkery on 6/21/17.
//  Copyright © 2017 George Thayamkery. All rights reserved.
//

import Foundation
import Alamofire

class XkcdScraper{
    var entries = [[String:String]]()
    var imageCache = [String:UIImage]()
    var ongoingOps = 0;
    
    func getEntries(whenDone callback:@escaping () -> Void){
        //https://xkcd.com/info.0.json
        Alamofire.request("https://xkcd.com/info.0.json").responseJSON { response in
            //print("Response: \(String(describing: response.response))") // http url response
            
            let json = response.result.value as! [String: Any]
            //print("JSON: \(json)") // serialized json response
            
            let latestId = json["num"] as! Int
            
            
            for _ in (0...5){
                self.entries.append(["":""])
            }
            
            for i in (latestId-5...latestId).reversed(){
                Alamofire.request("https://xkcd.com/\(i)/info.0.json").responseJSON { response in
                    let json = response.result.value as! [String: Any]
                    //print("JSON: \(json)") // serialized json response
                    
                    let entry = [
                        "title":json["safe_title"] as! String,
                        "link":"https://xkcd.com/\(String(describing: json["num"]!))",
                        "imageURL": json["img"] as! String,
                        "description": json["alt"] as! String,
                        "num": String(describing: json["num"]!)
                    ]
                    
                    //print(entry)
                    
                    Alamofire.request(entry["imageURL"]!).response { response in
                        self.imageCache[entry["imageURL"]!] = UIImage(data: response.data!)
                        print(self.imageCache.count, self.entries.count)

                        if(self.imageCache.count == self.entries.count){
                            callback()
                        }
                    }
                    
                    print(abs(latestId - i))
                    self.entries[abs(latestId - i)] = entry
                }
            }
        
        }

    }
    
    func getMoreEntries(whenDone callback:@escaping () -> Void){
        let lastId = Int(entries.last!["num"]!)!
        let lastEndIndex = entries.endIndex-1
        
        for _ in (lastEndIndex...lastEndIndex+5){
            entries.append(["":""])
        }
        self.ongoingOps = 6
        for i in (lastId-5...lastId).reversed(){
            Alamofire.request("https://xkcd.com/\(i)/info.0.json").responseJSON { response in
                let json = response.result.value as! [String: Any]
                //print("JSON: \(json)") // serialized json response
                
                let entry = [
                    "title":json["safe_title"] as! String,
                    "link":"https://xkcd.com/\(String(describing: json["num"]!))",
                    "imageURL": json["img"] as! String,
                    "description": json["alt"] as! String,
                    "num": String(describing: json["num"]!)
                ]
                
                //print(entry)
                
                self.entries[abs(lastId - i) + (lastEndIndex+1)] = entry
                
                
                
                Alamofire.request(entry["imageURL"]!).response { response in
                    self.ongoingOps -= 1
                    self.imageCache[entry["imageURL"]!] = UIImage(data: response.data!)
                    
                    //print(self.ongoingOps)
                    if(self.ongoingOps == 0){
                        callback()
                    }

                }
                
                
                //print(abs(latestId - i) + (lastEndIndex+1))
                
            }
        }
        
        
    }
    



}
