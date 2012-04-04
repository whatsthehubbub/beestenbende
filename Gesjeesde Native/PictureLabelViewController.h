//
//  PictureLabelViewController.h
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 3/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FeaturePickerViewController.h"
#import "FeaturePicture.h"
#import "SwitchTeamViewController.h"

@interface PictureLabelViewController : UIViewController <FeaturePickerViewControllerDelegate, SwitchTeamViewControllerDelegate> {
    UIButton *featureButton;
    UIButton *deleteButton;
    
    UILabel *teamLabel;
    UILabel *currentLabel;
    
    UIImageView *currentImage;
    
    Game *game;
    Team *currentTeam;
    
    int currentPictureIndex;
}

@property (nonatomic, retain) IBOutlet UIButton *featureButton;
@property (nonatomic, retain) IBOutlet UIButton *deleteButton;
@property (nonatomic, retain) IBOutlet UIImageView *currentImage;

@property (nonatomic, retain) IBOutlet UILabel *teamLabel;
@property (nonatomic, retain) IBOutlet UILabel *currentLabel;

@property (assign) int currentPictureIndex;

@property (strong) Game *game;
@property (strong) Team *currentTeam;

-(IBAction)next:(id)sender;
-(IBAction)previous:(id)sender;
-(IBAction)done:(id)sender;
-(IBAction)deleted:(id)sender;

@end
