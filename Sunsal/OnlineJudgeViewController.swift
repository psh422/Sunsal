//
//  OnlineJudgeViewController.swift
//  Sunsal
//
//  Created by Baekjoon Choi on 11/6/14.
//  Copyright (c) 2014 Baekjoon Choi. All rights reserved.
//

import UIKit

class OnlineJudgeViewController: UITableViewController {

    var listArray : [AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadProblems();
    }
    
    func loadProblems() {
        MBProgressHUD.showHUDAddedTo(navigationController?.view, animated: true);
        var manager = AFHTTPRequestOperationManager();
        manager.GET("http://www.acmicpc.net/data/problems.json", parameters: nil, success: { (operation, list) -> Void in
            
            var a = list as [AnyObject]
            
            self.listArray = a;
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                MBProgressHUD.hideHUDForView(self.navigationController?.view, animated: true);
                self.tableView.reloadData();
            })
            
        }) { (operation, error) -> Void in
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count;
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("OJCell", forIndexPath: indexPath) as UITableViewCell

        if let d = listArray[indexPath.row] as? [NSObject : AnyObject] {
            if let s = d["title"] as? String {
                cell.detailTextLabel?.text = s;
            }
            if let s = d["problem_id"] as? String {
                cell.textLabel.text = s;
            }
        }

        return cell
    }


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let d = listArray[indexPath.row] as? [NSObject : AnyObject] {
            if let s = d["problem_id"] as? String {
                var url = "https://www.acmicpc.net/problem/\(s)";
                NSLog("%@",url);
                UIApplication.sharedApplication().openURL(NSURL(string: url)!)
            }
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
    }
}
