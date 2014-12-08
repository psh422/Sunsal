//
//  AlbumManager.swift
//  Sunsal
//
//  Created by Baekjoon Choi on 11/10/14.
//  Copyright (c) 2014 Baekjoon Choi. All rights reserved.
//

import UIKit

class AlbumManager : NSObject, MWPhotoBrowserDelegate {
    
    var imageFiles : [MWPhoto!] = []
    var thumbnailFiles : [MWPhoto!] = []
    
    class var sharedManager : AlbumManager {
        struct Static {
            static let instance : AlbumManager = AlbumManager();
        }
        return Static.instance;
    }
    
    override init() {
        super.init();
        loadFile();
    }
    
    func loadFile() {
        var fileName = NSBundle.mainBundle().pathForResource("codershigh", ofType: "json")!;
        NSLog("%@",fileName);
        var fileData = NSData(contentsOfFile: fileName)!;
        if let a = NSJSONSerialization.JSONObjectWithData(fileData, options: NSJSONReadingOptions.allZeros, error: nil) as? [String] {
//            NSLog("%@",a);
//            imageFileNames = a;
            for f in a {
                var url = "https://www.acmicpc.net" + f;
                var thumbnailUrl = url.stringByReplacingOccurrencesOfString(".jpg", withString: "_thumb.jpg", options: NSStringCompareOptions.allZeros, range: nil)
//                NSLog("%@", url)
//                NSLog("%@", thumbnailUrl)
                var photo = MWPhoto(URL: NSURL(string: url)!)
                var thumbnail = MWPhoto(URL: NSURL(string: thumbnailUrl)!)
                imageFiles += [photo];
                thumbnailFiles += [thumbnail];
            }
        }
    }
    func numberOfPhotosInPhotoBrowser(photoBrowser: MWPhotoBrowser!) -> UInt {
        return UInt(imageFiles.count);
    }
    
    func photoBrowser(photoBrowser: MWPhotoBrowser!, photoAtIndex index: UInt) -> MWPhotoProtocol! {
        return imageFiles[Int(index)];
    }
    func photoBrowser(photoBrowser: MWPhotoBrowser!, thumbPhotoAtIndex index: UInt) -> MWPhotoProtocol! {
        return thumbnailFiles[Int(index)];
    }
}
