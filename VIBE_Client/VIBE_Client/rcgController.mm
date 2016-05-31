//
//  PatternView.m
//  VIBE_Client
//
//  Created by JAEYONG BAE on 2016. 5. 22..
//  Copyright © 2016년 ndvor. All rights reserved.
//
#include "rcgController.hpp"




//
//
//@interface ViewController ()
//
//@end
//
//@implementation ViewController
//
//@synthesize videoCamera;
//
//
//- (void)viewDidLoad{
//    [super viewDidLoad];
//    
//    
//    self.videoCamera = [[CvVideoCamera alloc] initWithParentView:imageView];
//    self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
//    self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset352x288;
//    self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
//    self.videoCamera.defaultFPS = 30;
//    self.videoCamera.grayscaleMode = NO;
//    
//    self.videoCamera.delegate = self;
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//}
//
//- (void)processImage:(Mat&)image; { //여기서 opencv 작업을 함
//    Mat image_copy;
//    Mat image_copy2;
//    cvtColor(image, image_copy, CV_BGRA2GRAY); //흑백 1채널로 변환
//    cvtColor(image, image_copy2, CV_BGRA2GRAY);
//    Canny(image_copy2,image_copy,200,200); //외곽선 따기
//    bitwise_not(image_copy, image_copy);
//    cvtColor(image_copy, image, CV_GRAY2BGRA);
//}
//
//- (IBAction)cameraStart:(id)sender {
//    
//    [videoCamera start];
//}
//
//- (IBAction)cameraStop:(id)sender {
//}
//@end
//
//
