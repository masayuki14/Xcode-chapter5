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
    @IBOutlet weak var prefLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func tapEnd() {
        clearLabels()
    }
    
    @IBAction func tapSearch() {
        clearLabels()

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
    
    func clearLabels() {
        prefLabel.text = ""
        addressLabel.text = ""
        errorLabel.text = ""
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
//                        print (errmsg)
                        dispatch_async(dispatch_get_main_queue(), {
                            self.errorLabel.text = errmsg
                        })
                    }
                }
            }
            
            if let resData = jsonDic["data"] as? NSDictionary {
                
                // 県名
                if let pref = resData["pref"] as? String {
//                    print ("県名は \(pref) です")
                    dispatch_async(dispatch_get_main_queue()) {
                        self.prefLabel.text = pref
                    }
                }
                // 住所
                if let address = resData["address"] as? String {
//                    print ("住所は \(address) です")
                    dispatch_async(dispatch_get_main_queue(), {
                        self.addressLabel.text = address
                    })
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

