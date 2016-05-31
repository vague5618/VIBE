//
//  PatternView.h
//  VIBE_Client
//
//  Created by JAEYONG BAE on 2016. 5. 22..
//  Copyright © 2016년 ndvor. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <opencv2/opencv.hpp>
//#import <opencv2/imgproc/imgproc_c.h>
//#import <opencv2/highgui/highgui_c.h>
//#import <opencv2/videoio/cap_ios.h>
//#import <opencv2/core/core_c.h>

using namespace cv;

@interface rcgController : UIViewController
{
    __weak IBOutlet UIImageView *imageView;
//    CvVideoCamera * videoCamera;
}

//@property (nonatomic, retain) CvVideoCamera * videoCamera;

@property (weak, nonatomic) IBOutlet UIButton *cameraStart;
@property (weak, nonatomic) IBOutlet UIButton *cameraStop;

@end