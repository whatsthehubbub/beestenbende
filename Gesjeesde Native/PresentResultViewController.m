//
//  PresentResultViewController.m
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 5/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "PresentResultViewController.h"

@interface PresentResultViewController ()

@end

@implementation PresentResultViewController

@synthesize game;

@synthesize team1featureLabel;
@synthesize team1featureImage;
@synthesize team2featureLabel;
@synthesize team2featureImage;

@synthesize team1pointsLabel;
@synthesize team2pointsLabel;

@synthesize proofsRequiredLabel;

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
    
    // TODO figure out which features each team has played
    FeaturePicture *team1fp;
    for (FeaturePicture *fp in game.team1.featurePictures) {
        if (fp.presentedTurn == game.turn) {
            team1fp = fp;
            break;
        }
    }
    
    NSDictionary *team1FeatureDict = [game getFeatureWithName:team1fp.feature];
    int team1featureNumber = [[team1FeatureDict objectForKey:@"Mammal"] intValue];
    int team1points = 0;
    
    if (team1fp.presentAssertion && team1featureNumber == 0) {
        team1points = 10;
    } else if (team1fp.presentAssertion && team1featureNumber == 1) {
        team1points = 5;
    } else if (!team1fp.presentAssertion && team1featureNumber == 2) {
        team1points = 5;
    }
    [self.team1pointsLabel setText:[NSString stringWithFormat:@"%d punten", team1points]];
    
    [self.team1featureLabel setText:team1fp.feature];
    self.team1featureImage.image = team1fp.image;
    
    // Do some magic
    
    FeaturePicture *team2fp;
    for (FeaturePicture *fp in game.team2.featurePictures) {
        if (fp.presentedTurn == game.turn) {
            team2fp = fp;
            break;
        }
    }
    
    NSDictionary *team2FeatureDict = [game getFeatureWithName:team2fp.feature];
    int team2featureNumber = [[team2FeatureDict objectForKey:@"Mammal"] intValue];
    int team2points = 0;
    
    NSLog(@"Team 2 featurenumber %d", team2featureNumber);
    
    if (team2fp.presentAssertion && team2featureNumber == 0) {
        team2points = 10;
    } else if (team2fp.presentAssertion && team2featureNumber == 1) {
        team2points = 5;
    } else if (!team2fp.presentAssertion && team2featureNumber == 2) {
        team2points = 5;
    }
    [self.team2pointsLabel setText:[NSString stringWithFormat:@"%d punten", team2points]];
    
    [self.team2featureLabel setText:team2fp.feature];
    self.team2featureImage.image = team2fp.image;
    
    
    if (team1points + team2points > 0) {
        // This means we have one positive proof
        game.required -= 1;
        
        [self.proofsRequiredLabel setText:[NSString stringWithFormat:@"De eekhoorn heeft nog %d bewijzen nodig.", game.required]];
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

- (IBAction)next:(id)sender {
    if (game.required > 0) {
        game.turn += 1;
            
        [game.team1 purgeUsedFeaturePictures];
        [game.team2 purgeUsedFeaturePictures];
        
        // TODO only perform another round if there are still feature pictures left for both teams
        
        [self performSegueWithIdentifier:@"AnotherRound" sender:self];
    } else {
        [self performSegueWithIdentifier:@"ProofComplete" sender:self];
    }
}

@end
