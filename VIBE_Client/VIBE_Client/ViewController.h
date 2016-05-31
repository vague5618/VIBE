//
//  ViewController.h
//  opencv
//
//  Created by JAEYONG BAE on 2016. 5. 15..
//  Copyright © 2016년 JAEYONG BAE. All rights reserved.
//
//

#import <UIKit/UIKit.h>

#import <opencv2/opencv.hpp>
#import <opencv2/imgproc/imgproc_c.h>
#import <opencv2/highgui/highgui_c.h>
#import <opencv2/videoio/cap_ios.h>
#import <opencv2/core/core_c.h>
using namespace cv;

@interface ViewController : UIViewController<CvVideoCameraDelegate>
{
    __weak IBOutlet UIImageView *imageView;
    CvVideoCamera * videoCamera;
}

@property (nonatomic, retain) CvVideoCamera * videoCamera;

- (IBAction)cameraStart:(id)sender;
- (IBAction)cameraStop:(id)sender;

@end

