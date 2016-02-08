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
        print (data)
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

