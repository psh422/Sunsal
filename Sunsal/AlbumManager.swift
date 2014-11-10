//
//  AlbumManager.swift
//  Sunsal
//
//  Created by Baekjoon Choi on 11/10/14.
//  Copyright (c) 2014 Baekjoon Choi. All rights reserved.
//

import UIKit

class AlbumManager {
    class var sharedManager : AlbumManager {
        struct Static {
            static let instance : AlbumManager = AlbumManager();
        }
        return Static.instance;
    }
}
