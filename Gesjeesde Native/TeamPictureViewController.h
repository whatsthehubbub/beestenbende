//
//  TeamPictureViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 22/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "AppDelegate.h"
#import "CaptureSessionManager.h"
#import "UIImage+Extras.h"
#import "SimpleAudioEngine.h"

@interface TeamPictureViewController : UIViewController {
}

@property (assign) int currentTeamNumber;

@property (strong) IBOutlet UIImageView *teamPictureView;
@property (strong )IBOutlet UIImageView *teamPictureFrame;
@property (strong) IBOutlet UIImageView *teamOverlay;
@property (strong) IBOutlet UILabel *titleLabel;

@property (strong) IBOutlet UIButton *takeTeamPictureButton;
@property (strong) IBOutlet UIButton *takePictureAgainButton;
@property (strong) IBOutlet UIButton *nextButton;

@property (strong) Game *game;

@property (strong) CaptureSessionManager *csManager;

@property (strong) IBOutlet UISegmentedControl *selector;

- (IBAction)takeTeamPicture:(id)sender;
- (IBAction)takeTeamPictureAgain:(id)sender;
- (IBAction)doneWithPicture:(id)sender;

@end
