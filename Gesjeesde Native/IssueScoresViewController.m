//
//  TeamScoresViewController.m
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 5/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "IssueScoresViewController.h"

@interface IssueScoresViewController ()

@end

@implementation IssueScoresViewController

@synthesize game;

@synthesize team1Label;
@synthesize team2Label;

@synthesize team1Picture;
@synthesize team2Picture;

@synthesize team1ScoreLabel;
@synthesize team2ScoreLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    game = appDelegate.game;
    
    team1Label.font = [UIFont fontWithName:@"Vollkorn-Bold" size:team1Label.font.pointSize];
    team2Label.font = [UIFont fontWithName:@"Vollkorn-Bold" size:team2Label.font.pointSize];
    
    team1Picture.image = game.team1.picture;
    team2Picture.image = game.team2.picture;
    
    [self.team1ScoreLabel setText:[NSString stringWithFormat:@"%d", game.team1.points]];
    [self.team2ScoreLabel setText:[NSString stringWithFormat:@"%d", game.team2.points]];
    
    // Store the points in the total and reset the points for the second issue
    game.team1.totalPoints += game.team1.points;
    game.team1.points = 0;
    
    game.team2.totalPoints += game.team2.points;
    game.team2.points = 0;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
