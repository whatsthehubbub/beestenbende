//
//  PresentFeatureViewController.h
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 5/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "TeamFeaturePickerViewController.h"

@interface PresentFeatureViewController : UIViewController <TeamFeaturePickerViewControllerDelegate> {
    UILabel *teamLabel;
    UIButton *yesNoButton;
    UIButton *featureButton;
    
    UIImageView *featureImageView;

    Game *game;
    Team *currentTeam;
    FeaturePicture *currentFeaturePicture;
    
    bool hasFeature;
}

@property (nonatomic, retain) IBOutlet UILabel *headerLabel;

@property (nonatomic, retain) IBOutlet UIImageView *overlayImage;

@property (nonatomic, retain) IBOutlet UIButton *yesNoButton;
@property (nonatomic, retain) IBOutlet UIButton *featureButton;
@property (nonatomic, retain) IBOutlet UIImageView *featureImageView;

@property (strong) Game *game;
@property (strong) Team *currentTeam;
@property (strong) FeaturePicture *currentFeaturePicture;

@property (assign) bool hasFeature;

- (IBAction)yesNo:(id)sender;
- (IBAction)next:(id)sender;

@end
