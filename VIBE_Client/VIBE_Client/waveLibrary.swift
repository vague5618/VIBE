//
//  waveLibrary.swift
//  wave
//
//  Created by ndvor on 3/17/16.
//  Copyright © 2016 ndvor. All rights reserved.
//

import Foundation

struct waveLibrary {
    
    // title : String
    // description : some history - String
    // coverImageName : String
    // songs : [String]
    
    // Each album must be a dictionary
    let album: [String: AnyObject] = ["title":"A hard Day's Night",
        "description": "Released on 10th July, 1964",
        "coverImageName" : "wallpaper5",
        "songs":["A hard day's night","some girls"]
    ]
    
    // an array of dictionaries. Each dictionary is an album.
    let albums:[[String: AnyObject]] = [
        ["title":"A hard Day's Night0",
            "description": "Released on 10th July, 1964",
            "coverImageName" : "wallpaper1",
            "songs":["A hard day's night","some girls"]
        ],
        ["title":"A hard Day's Night1",
            "description": "Released on 10th July, 1964",
            "coverImageName" : "wallpaper2",
            "songs":["A hard day's night","some girls"]
        ],
        ["title":"A hard Day's Night2",
            "description": "Released on 10th July, 1964",
            "coverImageName" : "wallpaper3",
            "songs":["A hard day's night","some girls"]
        ],
        ["title":"A hard Day's Night3",
            "description": "Released on 10th July, 1964",
            "coverImageName" : "wallpaper4",
            "songs":["A hard day's night","some girls"]
        ],
        ["title":"A hard Day's Night4",
            "description": "Released on 10th July, 1964",
            "coverImageName" : "wallpaper5",
            "songs":["A hard day's night","some girls"]
        ],
        ["title":"A hard Day's Night5",
            "description": "Released on 10th July, 1964",
            "coverImageName" : "wallpaper6",
            "songs":["A hard day's night","some girls"]
        ],
        ["title":"A hard Day's Night6",
            "description": "Released on 10th July, 1964",
            "coverImageName" : "wallpaper7",
            "songs":["A hard day's night","some girls"]
        ],
        ["title":"A hard Day's Night7",
            "description": "Released on 10th July, 1964",
            "coverImageName" : "wallpaper8",
            "songs":["A hard day's night","some girls"]
        ],
        ["title":"A hard Day's Night8",
            "description": "Released on 10th July, 1964",
            "coverImageName" : "wallpaper9",
            "songs":["A hard day's night","some girls"]
        ]
    
    
    ]
    
}