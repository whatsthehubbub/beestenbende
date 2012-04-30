//
//  DragonResultViewController.m
//  Beestenbende
//
//  Created by Alper Çuğun on 30/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "DragonResultViewController.h"

@interface DragonResultViewController ()

@end

@implementation DragonResultViewController

@synthesize game;
@synthesize currentTeam;

@synthesize teamOverlay;

@synthesize featureImage;
@synthesize featureLabel;
@synthesize explanationLabel;

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
    
    // Get the team that has to take the picture
    currentTeam = [game firstTeamForTurn];
    if (currentTeam.tookFeaturePictures) {
        currentTeam = [game otherTeamForTeam:currentTeam];
    }
    
    if (!currentTeam.number == 1) {
        teamOverlay.image = [UIImage imageNamed:@"overlay-team-yellow.png"];
    }
    
    // Check the result
    FeaturePicture *featurePicture = currentTeam.featurePictures.lastObject;
    
    self.featureImage.image = featurePicture.image;
    self.featureLabel.text = featurePicture.feature;
    
    int points = [game pointsForFeaturePicture:featurePicture];
    
    NSString *correctOrWrong = @"Fout";
    if (points > 0) {
        correctOrWrong = @"Goed";
        currentTeam.dragonProofs += 1;
    } else {
        
    }
    
    self.explanationLabel.text = [NSString stringWithFormat:@"%@ want [uitleg].", correctOrWrong];
    
    // Only now we can move over to the next team
    currentTeam.tookFeaturePictures = YES;
    
    // If both teams now have taken feature pictures, reset
    if (currentTeam.tookFeaturePictures && [game otherTeamForTeam:currentTeam].tookFeaturePictures) {
        // Increment turn so the other team can start
        game.turn += 1;
        
        currentTeam.tookFeaturePictures = NO;
        [game otherTeamForTeam:currentTeam].tookFeaturePictures = NO;
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
    [self performSegueWithIdentifier:@"DragonAgain" sender:sender];
}

@end
