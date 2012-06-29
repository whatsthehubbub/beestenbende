//
//  FeaturePictureViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 30/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "FeaturePicture.h"
#import "CaptureSessionManager.h"
#import "UIImage+Extras.h"
#import "SimpleAudioEngine.h"

@interface FeaturePictureViewController : UIViewController {
    UILabel *timeLabel;
    UILabel *imagesLabel;
    
    UIImageView *pictureView;
    
    NSTimer *timer;
    int secondsLeft;
    
    Game *game;
    Team *team;
    
    CaptureSessionManager *csManager;
}

@property (strong) IBOutlet UILabel *headerLabel;

@property (nonatomic, retain) IBOutlet UILabel *timeLabel;
@property (nonatomic, retain) IBOutlet UILabel *imagesLabel;

@property (strong) IBOutlet UIImageView *timeUpImage;
@property (nonatomic, retain) IBOutlet UILabel *timeUpLabel;

@property (nonatomic, retain) IBOutlet UIImageView *pictureView;
@property (nonatomic, retain) IBOutlet UIImageView *pictureFrame;

@property (nonatomic, retain) IBOutlet UIImageView *teamOverlay;

@property (strong) IBOutlet UIButton *takePictureButton;
@property (strong) IBOutlet UIButton *doneButton;

@property (nonatomic, retain) NSTimer *timer;
@property (readwrite) int secondsLeft;

@property (strong) Game *game;

@property (strong) CaptureSessionManager *csManager;

- (void)startTimer;
- (void)stopTimer;
- (void)decrementTimer:(NSTimer *)theTimer;
- (void)timeUp;

- (IBAction)takeFeaturePicture:(id)sender;
- (IBAction)next:(id)sender;
- (void)pictureTaken:(NSNotification *)notification;



@end
