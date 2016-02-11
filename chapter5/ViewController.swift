//
//  ViewController.swift
//  chapter5
//
//  Created by 森崎 雅之 on 2016/02/08.
//  Copyright © 2016年 森崎 雅之. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var zipField: UITextField!
    
    @IBAction func tapEnd() {
    }
    
    @IBAction func tapSearch() {

        guard let zipText = zipField.text else {
            return;
        }
        
        let urlStr = "http://api.zipaddress.net/?zipcode=\(zipText)"

        if let url = NSURL(string: urlStr) {
            let urlSession = NSURLSession.sharedSession()
            let task = urlSession.dataTaskWithURL(url, completionHandler: self.onGetAddress)
            task.resume()
        }
    }
    
    func onGetAddress(data: NSData?, res: NSURLResponse?, error: NSError?) {
        //print (data)
        
        do {
            // jsonを解析
            let jsonDic = try NSJSONSerialization.JSONObjectWithData(
                data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            if let code = jsonDic["code"] as? Int {
                
                // 200以外はエラー
                if code != 200 {
                    if let errmsg = jsonDic["message"] as? String {
                        print (errmsg)
                    }
                }
            }
            
            if let resData = jsonDic["data"] as? NSDictionary {
                
                // 県名
                if let pref = resData["pref"] as? String {
                    print ("県名は \(pref) です")
                }
                // 住所
                if let address = resData["address"] as? String {
                    print ("住所は \(address) です")
                }
            }
            
        } catch {
            print ("It's error.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

