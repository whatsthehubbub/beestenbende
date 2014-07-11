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
#import "UIImageView+UncachedImageView.h"

@interface PresentFeatureViewController : UIViewController <FeaturePickerViewControllerDelegate> {
}

@property (nonatomic, weak) IBOutlet UILabel *headerLabel;

@property (nonatomic, weak) IBOutlet UIImageView *backgroundImage;

@property (nonatomic, weak) IBOutlet UIButton *yesNoButton;
@property (nonatomic, weak) IBOutlet UIButton *featureButton;
@property (nonatomic, weak) IBOutlet UIImageView *featureImageFrame;
@property (nonatomic, weak) IBOutlet UIImageView *featureImageView;

@property (nonatomic, weak) IBOutlet UIButton *doneButton;

@property (nonatomic, weak) Game *game;
@property (strong) Team *currentTeam;

@property (strong) NSString *feature;
@property (strong) FeaturePicture *currentFeaturePicture;

@property (assign) BOOL hasFeature;

- (IBAction)yesNo:(id)sender;
- (IBAction)next:(id)sender;
- (IBAction)back:(id)sender;

@end
