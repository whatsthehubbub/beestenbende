//
//  DragonLabelViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 30/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "FeaturePickerViewController.h"
#import "FeaturePicture.h"

@interface DragonLabelViewController : UIViewController <FeaturePickerViewControllerDelegate>

@property (nonatomic, retain) IBOutlet UILabel *classLabel;

@property (strong) IBOutlet UIImageView *backgroundImage;
@property (strong) IBOutlet UILabel *headerLabel;

@property (strong) IBOutlet UIImageView *dragonPictureView;


@property (strong) IBOutlet UIButton *featureButton;
@property (strong) IBOutlet UIButton *doneButton;

@property (strong) Game *game;
@property (strong) Team *currentTeam;

- (IBAction)next:(id)sender;

@end
