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

@interface PresentResultViewController : UIViewController {
    Game *game;
    
    UIImageView *team1featureImage;
    UILabel *team1featureLabel;
    UILabel *team1pointsLabel;
    
    UIImageView *team2featureImage;
    UILabel *team2featureLabel;
    UILabel *team2pointsLabel;
    
    UILabel *proofsRequiredLabel;
    
    FeaturePicture *team1fp;
    FeaturePicture *team2fp;
}

@property (strong) Game *game;

@property (nonatomic, retain) IBOutlet UILabel *team1featureLabel;
@property (nonatomic, retain) IBOutlet UILabel *team2featureLabel;

@property (nonatomic, retain) IBOutlet UIImageView *team1featureImage;
@property (nonatomic, retain) IBOutlet UIImageView *team2featureImage;

@property (nonatomic, retain) IBOutlet UILabel *team1pointsLabel;
@property (nonatomic, retain) IBOutlet UILabel *team2pointsLabel;

@property (nonatomic, retain) IBOutlet UILabel *proofsRequiredLabel;

@property (nonatomic, retain) FeaturePicture *team1fp;
@property (nonatomic, retain) FeaturePicture *team2fp;

- (IBAction)next:(id)sender;

@end
