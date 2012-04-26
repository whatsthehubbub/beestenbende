//
//  PresentResultViewController.h
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 5/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "Game.h"
#import "FeaturePicture.h"
#import "ExplainFeatureViewController.h"

@interface PresentResultViewController : UIViewController <ExplainFeatureViewControllerDelegate> {
    Game *game;
}

@property (strong) Game *game;

@property (nonatomic, retain) IBOutlet UILabel *yesNoLabel;

@property (nonatomic, retain) IBOutlet UILabel *team1featureLabel;
@property (nonatomic, retain) IBOutlet UILabel *team2featureLabel;

@property (nonatomic, retain) IBOutlet UIImageView *team1featureImage;
@property (nonatomic, retain) IBOutlet UIImageView *team2featureImage;

@property (nonatomic, retain) IBOutlet UIImageView *team1pointsImage;
@property (nonatomic, retain) IBOutlet UIImageView *team2pointsImage;

@property (nonatomic, retain) IBOutlet UILabel *proofsRequiredLabel;

@property (nonatomic, retain) FeaturePicture *team1fp;
@property (nonatomic, retain) FeaturePicture *team2fp;

@property (assign) bool explanation1Shown;
@property (assign) bool explanation2Shown;

- (IBAction)next:(id)sender;

@end
