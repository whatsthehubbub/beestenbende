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
#import "UIImageView+UncachedImageView.h"

@interface TeamPictureViewController : UIViewController <CaptureSessionDelegate> {
}

@property (assign) int currentTeamNumber;

@property (nonatomic, weak) IBOutlet UIImageView *backgroundImage;
@property (nonatomic, weak) IBOutlet UIImageView *teamPictureView;
@property (nonatomic, weak) IBOutlet UIImageView *teamPictureFrame;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@property (nonatomic, weak) IBOutlet UIButton *takeTeamPictureButton;
@property (nonatomic, weak) IBOutlet UIButton *takePictureAgainButton;
@property (nonatomic, weak) IBOutlet UIButton *nextButton;

@property (nonatomic, weak) Game *game;

@property (strong) CaptureSessionManager *csManager;

// For debug only
@property (nonatomic, weak) IBOutlet UISegmentedControl *selector;

- (IBAction)takeTeamPicture:(id)sender;
- (IBAction)takeTeamPictureAgain:(id)sender;
- (IBAction)doneWithPicture:(id)sender;

@end
