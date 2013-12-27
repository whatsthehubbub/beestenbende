//
//  PresentFeatureViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 5/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "FeaturePickerViewController.h"
#import "FeaturePicture.h"
#import "SimpleAudioEngine.h"

@interface PresentFeatureViewController : UIViewController <FeaturePickerViewControllerDelegate> {
}

@property (strong) IBOutlet UILabel *headerLabel;

@property (strong) IBOutlet UIImageView *backgroundImage;

@property (strong) IBOutlet UIButton *yesNoButton;
@property (strong) IBOutlet UIButton *featureButton;
@property (strong) IBOutlet UIImageView *featureImageFrame;
@property (strong) IBOutlet UIImageView *featureImageView;

@property (nonatomic, retain) IBOutlet UIButton *doneButton;

@property (nonatomic, weak) Game *game;
@property (nonatomic, weak) Team *currentTeam;

@property (strong) NSString *feature;
@property (nonatomic, weak) FeaturePicture *currentFeaturePicture;

@property (assign) BOOL hasFeature;

- (IBAction)yesNo:(id)sender;
- (IBAction)next:(id)sender;
- (IBAction)back:(id)sender;

@end
