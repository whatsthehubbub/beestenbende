//
//  DragonPictureViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 30/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "CaptureSessionManager.h"
#import "UIImage+Extras.h"
#import "SimpleAudioEngine.h"

@interface DragonPictureViewController : UIViewController

@property (nonatomic, retain) IBOutlet UILabel *classLabel;

@property (strong) IBOutlet UIImageView *dragonPictureView;
@property (strong) IBOutlet UIImageView *teamOverlay;

@property (strong) IBOutlet UIButton *takeDragonPictureButton;
@property (strong) IBOutlet UIButton *takePictureAgainButton;
@property (strong) IBOutlet UIButton *doneButton;

@property (strong) Game *game;
@property (strong) Team *currentTeam;

@property (strong) CaptureSessionManager *csManager;

- (IBAction)takeDragonPicture:(id)sender;
- (IBAction)takeDragonPictureAgain:(id)sender;
- (IBAction)doneWithPicture:(id)sender;

@end
