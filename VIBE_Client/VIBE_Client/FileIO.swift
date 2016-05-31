//
//  FileIO.swift
//  VIBE_Client
//
//  Created by JAEYONG BAE on 2016. 5. 24..
//  Copyright © 2016년 ndvor. All rights reserved.
//

import Foundation

class FileIO {
    
    func writeFile(temp : NSMutableArray) -> String
    {
        
        let path = NSBundle.mainBundle().pathForResource("Mytext", ofType: "txt")
        
        //  let path = NSTemporaryDirectory() + "MyFile.txt"
        var error: NSError?
        var temp_string = temp.componentsJoinedByString("")
        do{
            let written = try temp_string.writeToFile(path!, atomically: true, encoding: NSUTF8StringEncoding)
        }
        catch let error as NSError{
            print("error \(error)")
        }
        
        return path!
        
    }
}
