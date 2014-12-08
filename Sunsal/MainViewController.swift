//
//  MainViewController.swift
//  Sunsal
//
//  Created by Baekjoon Choi on 11/6/14.
//  Copyright (c) 2014 Baekjoon Choi. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    @IBOutlet weak var hudCell: UITableViewCell!
    @IBOutlet weak var alertCell: UITableViewCell!
    @IBOutlet weak var actionSheetCell: UITableViewCell!
    @IBOutlet weak var photoViewCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AlbumManager.sharedManager;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            if cell == hudCell {
                showHUD();
            } else if cell == alertCell {
                showAlert(UIAlertControllerStyle.Alert)
            } else if cell == actionSheetCell {
                showAlert(UIAlertControllerStyle.ActionSheet)
            } else if cell == photoViewCell {
                photoView();
            }
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
    }
    
    func photoView() {
        var browser = MWPhotoBrowser(delegate: AlbumManager.sharedManager);
        
        browser.displayActionButton = true;
        browser.displayNavArrows = false;
        browser.displaySelectionButtons = false;
        browser.zoomPhotosToFill = true;
        browser.alwaysShowControls = false;
        browser.enableGrid = true;
        browser.startOnGrid = true;
        browser.enableSwipeToDismiss = true;
        
        self.navigationController!.pushViewController(browser, animated: true);
    }
    
    func showHUD() {
        MBProgressHUD.showHUDAddedTo(navigationController?.view, animated: true);
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "hideHUD", userInfo: nil, repeats: false);
    }
    
    func hideHUD() {
        MBProgressHUD.hideHUDForView(navigationController?.view, animated: true);
    }
    
    func showAlert(alertType: UIAlertControllerStyle) {
        var alertController = UIAlertController(title: "안녕하세요", message: "나는 이준규입니다", preferredStyle: alertType);
        
        alertController.addAction(UIAlertAction(title: "꺼주세요", style: .Cancel, handler: { (alertAction) -> Void in
            
        }))
        
        alertController.addAction(UIAlertAction(title: "끄지마요", style: .Default, handler: { (alertAction) -> Void in
            self.presentViewController(alertController, animated: true, completion: nil);
        }))
        
        presentViewController(alertController, animated: true, completion: nil);
        
    }
    
}