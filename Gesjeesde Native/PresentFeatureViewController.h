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
    UIButton *yesNoButton;
    UIButton *featureButton;
    
    UIImageView *featureImageView;

    Game *game;
    Team *currentTeam;
}

@property (nonatomic, retain) IBOutlet UIButton *yesNoButton;
@property (nonatomic, retain) IBOutlet UIButton *featureButton;
@property (nonatomic, retain) IBOutlet UIImageView *featureImageView;

@property (strong) Game *game;
@property (strong) Team *currentTeam;

- (IBAction)yesNo:(id)sender;
- (IBAction)next:(id)sender;

@end
