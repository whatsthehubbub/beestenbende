//
//  CaptureSessionManager.m
//  Beestenbende
//
//  Created by Alper Çuğun on 16/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "CaptureSessionManager.h"

@implementation CaptureSessionManager

@synthesize continuous;
@synthesize previewLayer;
@synthesize captureSession;
@synthesize stillImageOutput;

// Code from : http://www.musicalgeometry.com/?p=1273
// and: http://www.musicalgeometry.com/?p=1297
- (id)initWithImageView:(UIImageView *)iView {
    if ((self = [super init])) {
        self.continuous = NO;
        
		self.captureSession = [[AVCaptureSession alloc] init];
        imageView = iView;
        
        // Set captureSession.sessionPreset to something with a sane output value
        // Default is 1280x720 px images
        self.captureSession.sessionPreset = AVCaptureSessionPresetMedium;
        
        AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if (videoDevice) {
            NSError *error;
            AVCaptureDeviceInput *videoIn = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
            
            if (!error) {
                if ([self.captureSession canAddInput:videoIn]) {
                    [self.captureSession addInput:videoIn];
                } else {
                    NSLog(@"Couldn't add video input");
                }
            } else {
                NSLog(@"Couldn't create video input");
            }
        } else {
            NSLog(@"Couldn't create video capture device");
        }
        
        self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
        [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
        
        self.previewLayer.bounds = imageView.bounds;
        self.previewLayer.position = CGPointMake(CGRectGetMidX(imageView.bounds), CGRectGetMidY(imageView.bounds));
        
        [imageView.layer addSublayer:self.previewLayer];
        
        self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
        self.stillImageOutput.outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
        
        AVCaptureConnection *videoConnection = nil;
        for (AVCaptureConnection *connection in self.stillImageOutput.connections) {
            for (AVCaptureInputPort *port in connection.inputPorts) {
                if ([port.mediaType isEqual:AVMediaTypeVideo] ) {
                    videoConnection = connection;
                    break;
                }
            }
            if (videoConnection) {
                break;
            }
        }
        [self.captureSession addOutput:self.stillImageOutput];
        
        [self.captureSession startRunning];
	}
	return self;
}

- (void)captureStillImage {
    AVCaptureConnection *videoConnection = nil;
	for (AVCaptureConnection *connection in self.stillImageOutput.connections) {
		for (AVCaptureInputPort *port in connection.inputPorts) {
			if ([port.mediaType isEqual:AVMediaTypeVideo]) {
				videoConnection = connection;
				break;
			}
		}
		if (videoConnection) {
            break;
        }
	}
    
	NSLog(@"about to request a capture from: %@", self.stillImageOutput);
    
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
        
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
        UIImage *image = [[UIImage alloc] initWithData:imageData];
        
        if (!continuous) {
            // Pass the data using the UIImageView
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            [imageView setImage:image];
            
            // Slow
            // UIImageWriteToSavedPhotosAlbum(image, self, @selector(saved), nil);
            
            [self.previewLayer removeFromSuperlayer];
        } else {
            // TODO flash the image view to show that a picture has been taken
            
            // Pass the data in some other way            
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:image forKey:@"image"];

            [[NSNotificationCenter defaultCenter] postNotificationName:kImageCapturedSuccessfully object:self userInfo:userInfo];
        }
        
        // TODO restart capture session if we want to take another picture
        // [self.captureSession stopRunning];
        
        // [[NSNotificationCenter defaultCenter] postNotificationName:kImageCapturedSuccessfully object:nil];
    }];
}

- (void)restartPreview {
    if (!continuous) {
        // Blank image
        imageView.image = nil;
        
        // Start capture session again
        [imageView.layer addSublayer:previewLayer];
        [captureSession startRunning];
    }
}

- (void)saved {
    
}

@end
