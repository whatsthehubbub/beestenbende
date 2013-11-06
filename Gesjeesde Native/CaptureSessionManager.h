//
//  CaptureSessionManager.h
//  Beestenbende
//
//  Created by Alper Çuğun on 16/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <ImageIO/ImageIO.h>

#define kImageCapturedSuccessfully @"imageCapturedSuccessfully"

@interface CaptureSessionManager : NSObject {
}

// TODO we probably don't use this anymore
// Continuous means the imageView is not used to display previews of the images
@property (readwrite) bool continuous;

@property (retain) AVCaptureVideoPreviewLayer *previewLayer;
@property (retain) AVCaptureSession *captureSession;
@property (retain) AVCaptureStillImageOutput *stillImageOutput;

@property (weak) UIImageView *imageView;

- (id)initWithImageView:(UIImageView *)iView;

- (void)captureStillImage;
- (void)startPreview;
- (void)stopPreview;

@end
