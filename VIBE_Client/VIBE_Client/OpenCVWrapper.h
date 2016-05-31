//
//  OpenCVWrapper.h
//  VIBE_Client
//
//  Created by JAEYONG BAE on 2016. 5. 22..
//  Copyright © 2016년 ndvor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OpenCVWrapper : NSObject
+(UIImage *)centerCropImage:(UIImage *)image;
+(NSMutableArray *)getByte:(UIImage *)image;
+(UIImage *)DetectEdgeWithImage:(UIImage *)image;
@end
