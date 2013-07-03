//
//  PresentFeatureViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 5/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
//#import "TeamFeaturePickerViewController.h"
#import "FeaturePickerViewController.h"
#import "FeaturePicture.h"
#import "SimpleAudioEngine.h"

@interface PresentFeatureViewController : UIViewController <FeaturePickerViewControllerDelegate> {
}

@property (nonatomic, retain) IBOutlet UILabel *headerLabel;

@property (nonatomic, retain) IBOutlet UIImageView *overlayImage;

@property (nonatomic, retain) IBOutlet UIButton *yesNoButton;
@property (nonatomic, retain) IBOutlet UIButton *featureButton;
@property (nonatomic, retain) IBOutlet UIImageView *featureImageView;

@property (nonatomic, retain) IBOutlet UIButton *doneButton;

@property (strong) Game *game;
@property (strong) Team *currentTeam;
@property (strong) FeaturePicture *currentFeaturePicture;

@property (assign) BOOL hasFeature;

- (IBAction)yesNo:(id)sender;
- (IBAction)next:(id)sender;
- (IBAction)back:(id)sender;

@end
