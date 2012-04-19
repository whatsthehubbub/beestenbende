//
//  TeamScoresViewController.h
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 5/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "Game.h"

@interface TeamScoresViewController : UIViewController {
    Game *game;
    
    UILabel *team1ScoreLabel;
    UILabel *team2ScoreLabel;
}

@property (strong) Game *game;

@property (nonatomic, retain) IBOutlet UILabel *team1ScoreLabel;
@property (nonatomic, retain) IBOutlet UILabel *team2ScoreLabel;

- (IBAction)nextIssue:(id)sender;

@end
