//
//  IntermediaryScoresViewController.m
//  Beestenbende
//
//  Created by Alper Çuğun on 24/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "IntermediaryScoresViewController.h"

@interface IntermediaryScoresViewController ()

@end

@implementation IntermediaryScoresViewController

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
    
    [self.team1ScoreLabel setText:[NSString stringWithFormat:@"%d", game.team1.totalPoints]];
    [self.team2ScoreLabel setText:[NSString stringWithFormat:@"%d", game.team2.totalPoints]];
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
