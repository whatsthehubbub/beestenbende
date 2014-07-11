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
#import "UIImageView+UncachedImageView.h"

@interface FeaturePictureViewController : UIViewController <CaptureSessionDelegate> {
}

@property (nonatomic, weak) IBOutlet UILabel *headerLabel;

@property (nonatomic, weak) IBOutlet UIImageView *backgroundImage;
@property (nonatomic, weak) IBOutlet UIImageView *pictureView;
@property (nonatomic, weak) IBOutlet UIImageView *pictureFrame;

@property (nonatomic, weak) IBOutlet UILabel *explanationLabel;
@property (nonatomic, weak) IBOutlet UILabel *hintLabel;

@property (nonatomic, weak) IBOutlet UIButton *takePictureButton;
@property (nonatomic, weak) IBOutlet UIButton *takePictureAgainButton;
@property (nonatomic, weak) IBOutlet UIButton *doneButton;

// Place to store the processed image before we set it on the team upon exit of this view controller
@property (strong) UIImage *featureImage;

@property (nonatomic, weak) Game *game;
@property (strong) Team *team;

@property (strong) CaptureSessionManager *csManager;

- (IBAction)takeFeaturePicture:(id)sender;
- (IBAction)takeFeaturePictureAgain:(id)sender;

- (IBAction)next:(id)sender;

@end
