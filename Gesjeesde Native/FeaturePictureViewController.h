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

@interface FeaturePictureViewController : UIViewController <CaptureSessionDelegate> {
}

@property (strong) IBOutlet UILabel *headerLabel;

@property (nonatomic, retain) IBOutlet UIImageView *backgroundImage;
@property (nonatomic, retain) IBOutlet UIImageView *pictureView;
@property (nonatomic, retain) IBOutlet UIImageView *pictureFrame;

@property (strong) IBOutlet UILabel *explanationLabel;
@property (strong) IBOutlet UILabel *hintLabel;

@property (strong) IBOutlet UIButton *takePictureButton;
@property (strong) IBOutlet UIButton *takePictureAgainButton;
@property (strong) IBOutlet UIButton *doneButton;

// Place to store the processed image before we set it on the team upon exit of this view controller
@property (strong) UIImage *featureImage;

@property (strong) Game *game;
@property (strong) Team *team;

@property (strong) CaptureSessionManager *csManager;

- (IBAction)takeFeaturePicture:(id)sender;
- (IBAction)takeFeaturePictureAgain:(id)sender;

- (IBAction)next:(id)sender;

@end
