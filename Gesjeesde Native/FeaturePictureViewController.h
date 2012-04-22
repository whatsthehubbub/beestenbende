//
//  FeaturePictureViewController.h
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 30/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "FeaturePicture.h"
#import "SwitchTeamViewController.h"
#import "CaptureSessionManager.h"
#import "UIImage+Extras.h"

@interface FeaturePictureViewController : UIViewController <SwitchTeamViewControllerDelegate> {
    UILabel *timeLabel;
    UILabel *imagesLabel;
    
    UIImageView *pictureView;
    
    NSTimer *timer;
    int secondsLeft;
    
    Game *game;
    Team *team;
    
    CaptureSessionManager *csManager;
}

@property (nonatomic, retain) IBOutlet UILabel *timeLabel;
@property (nonatomic, retain) IBOutlet UILabel *imagesLabel;
@property (nonatomic, retain) IBOutlet UIImageView *pictureView;
@property (nonatomic, retain) IBOutlet UIImageView *teamOverlay;

@property (strong) IBOutlet UIButton *takePictureButton;
@property (strong) IBOutlet UIButton *doneButton;

@property (nonatomic, retain) NSTimer *timer;
@property (readwrite) int secondsLeft;

@property (strong) Game *game;

@property (strong) CaptureSessionManager *csManager;

- (void)startTimer;
- (void)decrementTimer:(NSTimer *)theTimer;

- (IBAction)takeFeaturePicture:(id)sender;
- (IBAction)next:(id)sender;
- (void)pictureTaken:(NSNotification *)notification;



@end
