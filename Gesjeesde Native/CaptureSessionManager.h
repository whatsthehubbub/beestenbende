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

@interface CaptureSessionManager : NSObject {
    UIImageView *imageView;
}

@property (retain) AVCaptureVideoPreviewLayer *previewLayer;
@property (retain) AVCaptureSession *captureSession;
@property (retain) AVCaptureStillImageOutput *stillImageOutput;

//@property (readonly) UIImageView *imageView;

- (id)initWithImageView:(UIImageView *)iView;

- (void)captureStillImage;

@end
