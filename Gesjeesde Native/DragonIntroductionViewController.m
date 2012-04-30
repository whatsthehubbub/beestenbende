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

@synthesize team1Proofs;
@synthesize team2Proofs;

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
    
    self.team1Proofs.image = [UIImage imageNamed:[NSString stringWithFormat:@"dragon-evidence-%d.png", game.team1.dragonProofs]];
    self.team2Proofs.image = [UIImage imageNamed:[NSString stringWithFormat:@"dragon-evidence-%d.png", game.team2.dragonProofs]];
    
    
    Team *currentTeam = [game firstTeamForTurn];
    if (currentTeam.tookFeaturePictures) {
        currentTeam = [game otherTeamForTeam:currentTeam];
    }
    
    explanation.text = [NSString stringWithFormat:@"Team %@: fotografeer een kenmerk. Team %@: jullie mogen straks weer. ", [currentTeam getTeamName], [[game otherTeamForTeam:currentTeam] getTeamName]];
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

- (IBAction)done:(id)sender {
    if (game.team1.dragonProofs == 3 || game.team2.dragonProofs == 3) {
        [self performSegueWithIdentifier:@"DragonDone" sender:sender];
    } else {
        [self performSegueWithIdentifier:@"DragonAgain" sender:sender];
    }
}

@end
