//
//  PictureLabelViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 3/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FeaturePickerViewController.h"
#import "FeaturePicture.h"
#import "SimpleAudioEngine.h"

@interface PictureLabelViewController : UIViewController <FeaturePickerViewControllerDelegate> {
    UIButton *featureButton;
    UIButton *deleteButton;
    
    UILabel *currentLabel;
    
    UIImageView *currentImage;
    
    Game *game;
    Team *currentTeam;
    
    int currentPictureIndex;
}

@property (nonatomic, retain) IBOutlet UIButton *featureButton;
@property (nonatomic, retain) IBOutlet UIButton *deleteButton;
@property (nonatomic, retain) IBOutlet UIImageView *currentImage;
@property (nonatomic, retain) IBOutlet UIImageView *overlayImage;
@property (nonatomic, retain) IBOutlet UIButton *doneButton;

@property (nonatomic, retain) IBOutlet UILabel *headerLabel;
@property (nonatomic, retain) IBOutlet UILabel *currentLabel;

@property (readwrite) int currentPictureIndex;

@property (strong) Game *game;
@property (strong) Team *currentTeam;

-(IBAction)next:(id)sender;
-(IBAction)previous:(id)sender;
-(IBAction)done:(id)sender;
-(IBAction)deleted:(id)sender;

@end
