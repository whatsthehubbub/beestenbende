//
//  EndScreenViewController.m
//  Beestenbende
//
//  Created by Alper Çuğun on 30/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "EndScreenViewController.h"

@interface EndScreenViewController ()

@end

@implementation EndScreenViewController

@synthesize game;

@synthesize winnerPicture;
@synthesize winnerLabel;

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
    
    Team *winner;
    if (game.team1.totalPoints > game.team2.totalPoints) {
        winner = game.team1;
    } else {
        winner = game.team2;
    }
    
    self.winnerPicture.image = winner.picture;
    self.winnerLabel.text = [NSString stringWithFormat:@"Team %@", [winner getTeamName]];
    
    winnerLabel.font = [UIFont fontWithName:@"Vollkorn-Bold" size:winnerLabel.font.pointSize];
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

- (IBAction)mainMenu:(id)sender {
    // Reset game
    [game resetForNextIssue];
    game.issue = 1;
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
