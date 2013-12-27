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
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"i13_uitslagronde_v2.wav"];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    game = appDelegate.game;
    
    // We don't need the images taken up until now
    [game scrubAllImages];
    
    team1Picture.image = game.team1.picture;
    team2Picture.image = game.team2.picture;
    
    self.team1Proofs.image = [UIImage imageNamed:[NSString stringWithFormat:@"39-progress-%d", game.team1.dragonFeaturesGuessed.count]];
    self.team2Proofs.image = [UIImage imageNamed:[NSString stringWithFormat:@"39-progress-%d", game.team2.dragonFeaturesGuessed.count]];
    
    
    Team *currentTeam = [game firstTeamForTurn];
    if (currentTeam.tookFeaturePictures) {
        currentTeam = [game otherTeamForTeam:currentTeam];
    }
    
    if (game.team1.dragonFeaturesGuessed.count < 3 && game.team2.dragonFeaturesGuessed.count < 3) {
        explanation.text = [NSString stringWithFormat:@"Team %@: fotografeer een kenmerk. \r Team %@: jullie mogen straks weer. ", [currentTeam getTeamName], [[game otherTeamForTeam:currentTeam] getTeamName]];
    } else {
        Team *winner = game.team1.dragonFeaturesGuessed.count == 3 ? game.team1 : game.team2;
        explanation.text = [NSString stringWithFormat:@"Team %@ heeft drie goede kenmerken gevonden!", [winner getTeamName]];
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

- (IBAction)done:(id)sender {
    [[SimpleAudioEngine sharedEngine] playEffect:@"i02_schermverder.wav"];
    
    if (game.team1.dragonFeaturesGuessed.count == 3 || game.team2.dragonFeaturesGuessed.count == 3) {
        [self performSegueWithIdentifier:@"DragonDone" sender:sender];
    } else {
        [self performSegueWithIdentifier:@"DragonAgain" sender:sender];
    }
}

- (IBAction)back:(id)sender {
    [[SimpleAudioEngine sharedEngine] playEffect:@"i03_schermterug.wav"];
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
