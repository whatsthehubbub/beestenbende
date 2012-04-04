//
//  FeaturePictureViewController.h
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 30/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "FeaturePicture.h"
#import "SwitchTeamViewController.h"

@interface FeaturePictureViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, SwitchTeamViewControllerDelegate> {
    UILabel *titleLabel;
    UILabel *timeLabel;
    
    UIView *imagesView;
    
    NSTimer *timer;
    int secondsLeft;
    
    Game *game;
    
    int currentTeamNumber;
}

@property (assign) int currentTeamNumber;

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *timeLabel;
@property (nonatomic, retain) IBOutlet UIView *imagesView;

@property (nonatomic, retain) NSTimer *timer;
@property (readwrite) int secondsLeft;

@property (strong) Game *game;

- (void)startTimer;
- (void)decrementTimer:(NSTimer *)theTimer;

- (IBAction)takeFeaturePicture:(id)sender;
- (IBAction)next:(id)sender;



@end
