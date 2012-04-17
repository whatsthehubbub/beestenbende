//
//  TeamPictureViewController.h
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 22/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "AppDelegate.h"
#import "CaptureSessionManager.h"
#import "UIImage+Extras.h"

@interface TeamPictureViewController : UIViewController {
    UIImageView *teamPictureView;
    UIButton *takeTeamPictureButton;
    UILabel *titleLabel;
    
    int currentTeamNumber;
    
    Game *game;
    
    CaptureSessionManager *csManager;
}

@property (assign) int currentTeamNumber;

@property (strong) IBOutlet UIImageView *teamPictureView;
@property (strong) IBOutlet UILabel *titleLabel;

@property (strong) Game *game;

@property (strong) CaptureSessionManager *csManager;

- (IBAction)takeTeamPicture:(id)sender;
- (IBAction)doneWithPicture:(id)sender;

@end
