//
//  TeamScoresViewController.m
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 5/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "TeamScoresViewController.h"

@interface TeamScoresViewController ()

@end

@implementation TeamScoresViewController
@synthesize game;

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

- (IBAction)nextIssue:(id)sender {
    NSString *controllerIdentifier = @"";
    
    if (game.issue == 1) {
        // Go to the first screen of the second issue
        controllerIdentifier = @"SecondIssueIntroduction";
    } else {
        // Go to the first screen of the dragon
        controllerIdentifier = @"FinalIssueIntroduction";
    }

    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:controllerIdentifier];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
