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

@class CaptureSessionManager;

@protocol CaptureSessionDelegate
    -(void)stillImageFailed;
    -(void)stillImageSucceeded;
@end

@interface CaptureSessionManager : NSObject {
}

@property (retain) AVCaptureVideoPreviewLayer *previewLayer;
@property (retain) AVCaptureSession *captureSession;
@property (retain) AVCaptureStillImageOutput *stillImageOutput;

@property (nonatomic, weak) UIImageView *imageView;

@property (nonatomic, weak) id <CaptureSessionDelegate> delegate;

- (id)initWithImageView:(UIImageView *)iView;

- (void)captureStillImage;
- (void)startPreview;
- (void)stopPreview;
- (void)disposeOfSession;

@end
