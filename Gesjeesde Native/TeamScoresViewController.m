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
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondIssueIntroduction"];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
