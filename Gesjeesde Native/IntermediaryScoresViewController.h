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

@property (nonatomic, retain) IBOutlet UILabel *team1ScoreLabel;
@property (nonatomic, retain) IBOutlet UILabel *team2ScoreLabel;

- (IBAction)nextIssue:(id)sender;

@end
