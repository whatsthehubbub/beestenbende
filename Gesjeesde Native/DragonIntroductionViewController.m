//
//  DragonIntroductionViewController.m
//  Beestenbende
//
//  Created by Alper Çuğun on 29/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "DragonIntroductionViewController.h"

@interface DragonIntroductionViewController ()

@end

@implementation DragonIntroductionViewController

@synthesize game;

@synthesize team1Picture;
@synthesize team2Picture;

@synthesize explanation;

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

    [game resetForNextIssue];
    game.issue = 3;
    
    team1Picture.image = game.team1.picture;
    team2Picture.image = game.team2.picture;
    
    explanation.text = [NSString stringWithFormat:@"Team %@: fotografeer een kenmerk. Team %@: jullie mogen straks weer. ", [[game firstTeamForTurn] getTeamName], [[game secondTeamForTurn] getTeamName]];
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
