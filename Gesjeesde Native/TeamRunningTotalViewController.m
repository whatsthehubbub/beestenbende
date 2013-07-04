//
//  PresentResultViewController.m
//  Beestenbende
//
//  Created by Alper Çuğun on 5/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "TeamRunningTotalViewController.h"

@interface TeamRunningTotalViewController ()

@end

@implementation TeamRunningTotalViewController

@synthesize game;

@synthesize titleLabel;

@synthesize team1PointsLabel;
@synthesize team1Image;
@synthesize team2PointsLabel;
@synthesize team2Image;

@synthesize turnLabel;

@synthesize currentFeaturePicture;

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
    
//    Team *currentTeam = [game getCurrentTeam];
    
//    BOOL correctProof = NO;
    
//    currentFeaturePicture = [currentTeam.featurePictures lastObject];
    
//    if (currentTeam.number == 1) {
//        
////        team1fp = [game.team1 featurePictureForTurn:game.turn];
//        
//        int team1points = 0;
//        
//        FEATURE_RESULT team1result = [game resultForFeaturePicture:currentFeaturePicture];
//        if (team1result == FEATURE_YES_UNIQUE) {
//            [self.team1pointsImage setImage:[UIImage imageNamed:@"points-uniek.png"]];
//            team1points = 10;
//        } else if (team1result == FEATURE_YES_CORRECT_AND_DIFFERENTIATING || team1result == FEATURE_NO_INCORRECT) {
//            [self.team1pointsImage setImage:[UIImage imageNamed:@"points-goed.png"]];
//            team1points = 5;
//        } else {
//            [self.team1pointsImage setImage:[UIImage imageNamed:@"points-fout.png"]];
//            team1points = 0; // Superfluous but for clarity
//        }
//        [self.team1featureLabel setText:currentFeaturePicture.feature];
//        self.team1featureImage.image = currentFeaturePicture.image;
//        
//        if (team1points > 0) {
//            correctProof = YES;
//        }
//        
//        game.team1.points += team1points;
//    }
    

//    if (currentTeam.number == 2) {
//        int team2points = 0;
//
//        FEATURE_RESULT team2result = [game resultForFeaturePicture:currentFeaturePicture];
//        if (team2result == FEATURE_YES_UNIQUE) {
//            [self.team2pointsImage setImage:[UIImage imageNamed:@"points-uniek.png"]];
//            team2points = 10;
//        } else if (team2result == FEATURE_YES_CORRECT_AND_DIFFERENTIATING || team2result == FEATURE_NO_INCORRECT) {
//            [self.team2pointsImage setImage:[UIImage imageNamed:@"points-goed.png"]];
//            team2points = 5;
//        } else {
//            [self.team2pointsImage setImage:[UIImage imageNamed:@"points-fout.png"]];
//            team2points = 0; // Superfluous but for clarity
//        }
//        [self.team2featureLabel setText:currentFeaturePicture.feature];
//        self.team2featureImage.image = currentFeaturePicture.image;
//        
//        if (team2points > 0) {
//            correctProof = YES;
//        }
//
//        game.team2.points += team2points;
//    }
//    
    
//    // Update some user interface
//    NSString *present = @"wel";
//    // Presence depends on the first team playing not necessarily team1
//    if (!currentFeaturePicture.presentAssertion) {
//        present = @"geen";
//    }
//    self.titleLabel.text = [NSString stringWithFormat:@"%@ heeft %@…", [game getCurrentAnimalName], present];
//    
//
    
    self.titleLabel.text = [NSString stringWithFormat:@"Overtuig %@…", [game getCurrentAnimalName]];
    
    self.team1Image.image = game.team1.picture;
    self.team2Image.image = game.team2.picture;
    
    self.team1PointsLabel.text = [NSString stringWithFormat:@"%d punten", game.team1.points];
    self.team2PointsLabel.text = [NSString stringWithFormat:@"%d punten", game.team2.points];
    
    self.turnLabel.text = [NSString stringWithFormat:@"Team %@: fotografeer een kenmerk. Team %@: jullie mogen straks weer.", [[game getCurrentTeam] getTeamName], [[game otherTeamForTeam:[game getCurrentTeam]] getTeamName]];
    
    if (game.issue == 1) {
        self.animalImage.image = [UIImage imageNamed:@"animal-squirrel-icon.png"];
    } else if (game.issue == 2) {
        self.animalImage.image = [UIImage imageNamed:@"animal-eel-icon.png"];
    }
    
    self.animalRequiresLabel.text = [NSString stringWithFormat:@"%@ wil nog", [game getCurrentAnimalName]];
    
    
    // Check if we're closer to the required proof
//    if (correctProof) {
//        // This means we have one positive proof
//        game.required -= 1;
//    }
    [self.proofsRequiredLabel setText:[NSString stringWithFormat:@"%d", game.required]];
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
    
//    [game.team1 purgeUsedFeaturePictures];
//    [game.team2 purgeUsedFeaturePictures];
    
    if (game.required > 0) {
        [self performSegueWithIdentifier:@"NextTeam" sender:sender];
    } else {
        game.currentTeam = nil;
        
        if (game.issue == 1) {
            [self performSegueWithIdentifier:@"FirstAnimalConvinced" sender:sender];
        } else if (game.issue == 2) {
            [self performSegueWithIdentifier:@"SecondAnimalConvinced" sender:sender];
        }
    }
    
//    if (game.required > 0 && (game.team1.featurePictures.count > 0 || game.team2.featurePictures.count > 0)) {
//        game.turn += 1;
//        
//        if (game.issue == 1) {
//            [self performSegueWithIdentifier:@"AnotherRoundFirstIssue" sender:sender];
//        } else {
//            [self performSegueWithIdentifier:@"AnotherRoundSecondIssue" sender:sender];
//        }
//    } else {
//        // TODO show something if the proof was completed by a lack of features
//        
//        if (game.issue == 1) {
//            [self performSegueWithIdentifier:@"FirstProofComplete" sender:sender];
//        } else {
//            [self performSegueWithIdentifier:@"SecondProofComplete" sender:sender];
//        }
//    }
}

- (IBAction)back:(id)sender {
    [[SimpleAudioEngine sharedEngine] playEffect:@"i03_schermterug.wav"];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
