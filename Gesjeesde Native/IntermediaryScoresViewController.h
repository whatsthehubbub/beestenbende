//
//  IntermediaryScoresViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 24/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

@interface IntermediaryScoresViewController : UIViewController

@property (strong) Game *game;

@property (nonatomic, retain) IBOutlet UILabel *team1Label;
@property (nonatomic, retain) IBOutlet UILabel *team2Label;

@property (nonatomic, retain) IBOutlet UIImageView *team1Picture;
@property (nonatomic, retain) IBOutlet UIImageView *team2Picture;

@property (nonatomic, retain) IBOutlet UILabel *team1ScoreLabel;
@property (nonatomic, retain) IBOutlet UILabel *team2ScoreLabel;

@property (nonatomic, retain) IBOutlet UIImageView *progressImage;

- (IBAction)nextIssue:(id)sender;

@end
