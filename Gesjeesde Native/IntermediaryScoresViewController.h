//
//  IntermediaryScoresViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 24/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "SimpleAudioEngine.h"

@interface IntermediaryScoresViewController : UIViewController

@property (nonatomic, weak) Game *game;

@property (strong) IBOutlet UILabel *headerLabel;

@property (strong) IBOutlet UIImageView *team1Picture;
@property (strong) IBOutlet UIImageView *team2Picture;

@property (strong) IBOutlet UILabel *team1ScoreLabel;
@property (strong) IBOutlet UILabel *team2ScoreLabel;

@property (strong) IBOutlet UILabel *tieLabel;
@property (strong) IBOutlet UIImageView *tieImage;

@property (strong) IBOutlet UIImageView *progressImage;

- (IBAction)nextIssue:(id)sender;

@end
