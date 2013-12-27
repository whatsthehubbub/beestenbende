//
//  TeamScoresViewController.h
//  Beestenbende
//
//  Created by Alper Çuğun on 5/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "Game.h"
#import "SimpleAudioEngine.h"

@interface IssueScoresViewController : UIViewController {
}

@property (nonatomic, weak) Game *game;

@property (strong) IBOutlet UILabel *headerLabel;

@property (strong) IBOutlet UIImageView *team1Picture;
@property (strong) IBOutlet UIImageView *team2Picture;

@property (strong) IBOutlet UILabel *team1ScoreLabel;
@property (strong) IBOutlet UILabel *team2ScoreLabel;

@property (strong) IBOutlet UILabel *thanksLabel;

- (IBAction)next:(id)sender;

@end
