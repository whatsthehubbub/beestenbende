//
//  TeamPrepareViewController.m
//  Beestenbende
//
//  Created by Alper Çuğun on 22/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "TeamPrepareViewController.h"

@interface TeamPrepareViewController ()

@end

@implementation TeamPrepareViewController

@synthesize headerLabel;
@synthesize teamOverlay;

@synthesize game;

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
    
    // Find the current team
    Team *team = game.team1;
    if (team.tookFeaturePictures) {
        team = game.team2;
    }

    headerLabel.text = [NSString stringWithFormat:@"Team %@ bereid je voor", [team getTeamName]];
    
    if (team.number == 1) {
        teamOverlay.image = [UIImage imageNamed:@"overlay-team-blue.png"];
    } else {
        teamOverlay.image = [UIImage imageNamed:@"overlay-team-yellow.png"];
    }
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
