//
//  ViewController.swift
//  LocationTest
//
//  Created by bendnaiba on 8/8/17.
//  Copyright © 2017 bendnaiba. All rights reserved.
//

import UIKit
 
class ViewController: UIViewController, UITabBarDelegate, UITableViewDataSource {
     
    @IBOutlet weak var tableView:UITableView!
    //var
    var locationArray:NSMutableArray = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if (UserDefaults.standard.array(forKey: "location") != nil) {
            self.locationArray = NSMutableArray(array: UserDefaults.standard.array(forKey: "location")!)
            self.tableView.reloadData()
        }
        //observe userDefault
        UserDefaults.standard.addObserver(self, forKeyPath: "location", options: NSKeyValueObservingOptions.new, context: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UITableView Delegate -
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
        let dicoLocation:NSDictionary = self.locationArray.object(at: indexPath.row) as! NSDictionary

        let lat:NSNumber = dicoLocation.object(forKey: "lat") as! NSNumber
        let long:NSNumber = dicoLocation.object(forKey: "long") as! NSNumber
        cell.textLabel?.text = "Lat \(lat.doubleValue) -- Long \(long.doubleValue)"
        cell.detailTextLabel?.text = "Date \(dicoLocation.object(forKey: "Date"))"
        
        return cell
    }
    
    //MARK: - userDefault Updated -
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "location" {
            self.locationArray = NSMutableArray(array: UserDefaults.standard.array(forKey: "location")!)
            self.tableView.reloadData()
        }

    }
    

}

