//
//  OpenCVWrapper.m
//  VIBE_Client
//
//  Created by JAEYONG BAE on 2016. 5. 22..
//  Copyright © 2016년 ndvor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "OpenCVWrapper.h"
#import <opencv2/opencv.hpp>
#import <opencv2/imgproc/imgproc_c.h>
#import <opencv2/highgui/highgui_c.h>
#import <opencv2/videoio/cap_ios.h>
#import <opencv2/imgcodecs/ios.h>
#import <opencv2/core/core_c.h>

using namespace cv;
using namespace std;

@implementation OpenCVWrapper
+(UIImage *) centerCropImage:(UIImage *)image
{
    // Use smallest side length as crop square length
    CGFloat squareLength = MIN(image.size.width, image.size.height);
    // Center the crop area
    
    CGRect clippedRect = CGRectMake((image.size.width - squareLength) / 4, (image.size.height - squareLength) / 4, image.size.width, image.size.height);
    
    // Crop logic
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], clippedRect);
    
    UIImage * croppedImage = [UIImage imageWithCGImage:imageRef];
    
    CGImageRelease(imageRef);
    
    return croppedImage;
}


+(NSMutableArray *)getByte:(UIImage *)image{
    
    double thresh = 100;
    double maxValue = 255;
    
    cv::Mat cvMat;
    
    UIImageToMat(image,cvMat);
    
    cv::Mat gray;
    cv::Mat binary;
    cv::Mat edge;
    
    cv::cvtColor(cvMat, gray, CV_BGR2GRAY);
    
    cv::cvtColor(cvMat, edge, CV_BGR2GRAY);
    
    NSLog(@"%d %d",gray.rows,gray.cols);
    
    cv::resize(gray, gray, cv::Size(gray.rows/4, gray.cols/4));
    
    cv::threshold(gray, binary, thresh, maxValue, THRESH_BINARY_INV);
    
    cv::Canny(binary, edge, 200, 200);
    
    NSLog(@"%d %d",edge.rows,edge.cols);
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity: edge.rows + edge.cols];
    
    for(int y=0; y<edge.rows; y++)
    {
        for(int x=0; x<edge.cols; x++)
        {
            int pixel = edge.at<uchar>(y,x);
            
            if(pixel==255)
                [array addObject: [NSNumber numberWithInteger: 1]]; // 하나하나 추가하면서 만듬
            
            else
                [array addObject: [NSNumber numberWithInteger: pixel]]; // 하나하나 추가하면서 만듬
        }
    }
    
    return array;
}
+(UIImage *)DetectEdgeWithImage:(UIImage *)image{
    
    double thresh = 100;
    double maxValue = 255;
    
    cv::Mat cvMat;
    
    UIImageToMat(image,cvMat);  //이미지 Matrix생성
    
    cv::Mat gray;  // 그레이스킬 이미지
    cv::Mat binary; // 이진화 작업 된 이미지
    cv::Mat edge; // 외곽선데이터
    
    cv::cvtColor(cvMat, gray, CV_BGR2GRAY); //그레이스케일
    
    cv::cvtColor(cvMat, edge, CV_BGR2GRAY);
    
    cv::threshold(gray, binary, thresh, maxValue, THRESH_BINARY_INV); //이진화
    
    cv::Canny(binary, edge, 200, 200); //외곽선 데이터
    
    cv::resize(edge, edge, cv::Size(edge.rows/4, edge.cols/4));
    
    UIImage *edgeImg = MatToUIImage(edge);
    
    return edgeImg;
}

@end
