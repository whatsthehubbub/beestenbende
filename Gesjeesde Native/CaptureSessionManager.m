//
//  CaptureSessionManager.m
//  Beestenbende
//
//  Created by Alper Çuğun on 16/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "CaptureSessionManager.h"

@implementation CaptureSessionManager

@synthesize imageView;
@synthesize continuous;

@synthesize previewLayer;
@synthesize captureSession;
@synthesize stillImageOutput;

// Code from: http://www.musicalgeometry.com/?p=1273
// and: http://www.musicalgeometry.com/?p=1297
- (id)initWithImageView:(UIImageView *)iView {
    if ((self = [super init])) {
        self.continuous = NO;
        
        imageView = iView;
        
		self.captureSession = [[AVCaptureSession alloc] init];
        
        [self.captureSession beginConfiguration];
        
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
        
        [self.captureSession commitConfiguration];
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
        
        // Check to see if the buffer is not Null
        if (CMSampleBufferIsValid(imageSampleBuffer)) {
        
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
            UIImage *image = [[UIImage alloc] initWithData:imageData];
            
            if (!continuous) {
                // Pass the data using the UIImageView
                imageView.contentMode = UIViewContentModeScaleAspectFill;
                [imageView setImage:image];
                
                // Slow
                // UIImageWriteToSavedPhotosAlbum(image, self, @selector(saved), nil);
                
                [self stopPreview];
            } else {
                // TODO flash the image view to show that a picture has been taken
                
                // Pass the data in some other way            
                NSDictionary *userInfo = [NSDictionary dictionaryWithObject:image forKey:@"image"];

                [[NSNotificationCenter defaultCenter] postNotificationName:kImageCapturedSuccessfully object:self userInfo:userInfo];
            }
        }
    }];
}

- (void)startPreview {
    if (!continuous) {
        // Blank image, because we're showing a preview
        imageView.image = nil;
    }
    
    [imageView.layer addSublayer:previewLayer];
    [self.captureSession startRunning];
}

- (void)stopPreview {
    [self.previewLayer removeFromSuperlayer];
    
    [captureSession stopRunning];
}

- (void)dealloc {
    [self stopPreview];
    
    self.captureSession = nil;
    
    self.previewLayer = nil;
    self.stillImageOutput = nil;
}

@end
