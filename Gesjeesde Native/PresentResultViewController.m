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

@synthesize yesNoLabel;

@synthesize team1featureLabel;
@synthesize team1featureImage;
@synthesize team2featureLabel;
@synthesize team2featureImage;

@synthesize team1pointsImage;
@synthesize team2pointsImage;

@synthesize team1fp;
@synthesize team2fp;

@synthesize animalImage;
@synthesize animalRequiresLabel;
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
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"i13_uitslagronde_v2.wav"];
    
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    game = appDelegate.game;
    
    team1featureLabel.font = [UIFont fontWithName:@"HoeflerText-Black" size:team1featureLabel.font.pointSize];
    team2featureLabel.font = [UIFont fontWithName:@"HoeflerText-Black" size:team2featureLabel.font.pointSize];
    
    team1fp = [game.team1 featurePictureForTurn:game.turn];
    
    FEATURE_RESULT team1result = [game resultForFeaturePicture:team1fp];
    int team1points = 0;
    if (team1result == FEATURE_YES_UNIQUE) {
        [self.team1pointsImage setImage:[UIImage imageNamed:@"points-uniek.png"]];
        team1points = 10;
    } else if (team1result == FEATURE_YES_CORRECT_AND_DIFFERENTIATING || team1result == FEATURE_NO_INCORRECT) {
        [self.team1pointsImage setImage:[UIImage imageNamed:@"points-goed.png"]];
        team1points = 5;
    } else {
        [self.team1pointsImage setImage:[UIImage imageNamed:@"points-fout.png"]];
        team1points = 0;
    }
    
    game.team1.points += team1points;
    
    [self.team1featureLabel setText:team1fp.feature];
    self.team1featureImage.image = team1fp.image;
    

    // Do exactly the same thing for team 2
    team2fp = [game.team2 featurePictureForTurn:game.turn];

    FEATURE_RESULT team2result = [game resultForFeaturePicture:team2fp];
    int team2points = 0;
    if (team2result == FEATURE_YES_UNIQUE) {
        [self.team2pointsImage setImage:[UIImage imageNamed:@"points-uniek.png"]];
        team2points = 10;
    } else if (team2result == FEATURE_YES_CORRECT_AND_DIFFERENTIATING || team2result == FEATURE_NO_INCORRECT) {
        [self.team2pointsImage setImage:[UIImage imageNamed:@"points-goed.png"]];
        team2points = 5;
    } else {
        [self.team2pointsImage setImage:[UIImage imageNamed:@"points-fout.png"]];
        team2points = 0;
    }
    
    game.team2.points += team2points;
    
    [self.team2featureLabel setText:team2fp.feature];
    self.team2featureImage.image = team2fp.image;
    
    // Update some user interface
    NSString *present = @"wel";
    // Presence depends on the first team playing not necessarily team1
    if (![[game firstTeamForTurn] featurePictureForTurn:game.turn].presentAssertion) {
        present = @"geen"; 
    }
    self.yesNoLabel.text = [NSString stringWithFormat:@"%@ heeft %@…", [game getCurrentAnimal], present];
    
    if (game.issue == 1) {
        self.animalImage.image = [UIImage imageNamed:@"animal-squirrel-icon.png"];
    } else if (game.issue == 2) {
        self.animalImage.image = [UIImage imageNamed:@"animal-eel-icon.png"];
    }
    
    self.animalRequiresLabel.text = [NSString stringWithFormat:@"%@ heeft nog", [game getCurrentAnimal]];
    
    
    // Check if we're closer to the required proof
    if (abs(team1points) + abs(team2points) > 0) {
        // This means we have one positive proof
        game.required -= 1;
        
        [self.proofsRequiredLabel setText:[NSString stringWithFormat:@"%d", game.required]];
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
    [[SimpleAudioEngine sharedEngine] playEffect:@"i02_schermverder.wav"];
    
    [self performSegueWithIdentifier:@"Explanation" sender:sender];
}

@end
