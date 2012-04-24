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

@synthesize team1pointsLabel;
@synthesize team2pointsLabel;

@synthesize team1fp;
@synthesize team2fp;

@synthesize explanation1Shown;
@synthesize explanation2Shown;

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
    
    self.explanation1Shown = NO;
    self.explanation2Shown = NO;
    
    for (FeaturePicture *fp in game.team1.featurePictures) {
        if (fp.presentedTurn == game.turn) {
            team1fp = fp;
            break;
        }
    }
    
    if (!team1fp.presentAssertion) {
        self.yesNoLabel.text = @"Geen";
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
    game.team1.points += team1points;
    
    [self.team1featureLabel setText:team1fp.feature];
    self.team1featureImage.image = team1fp.image;
    
    // Do some magic
    
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
    NSLog(@"Team 2 team2fp %@", team2fp.feature);
    
    if (team2fp.presentAssertion && team2featureNumber == 0) {
        team2points = 10;
    } else if (team2fp.presentAssertion && team2featureNumber == 1) {
        team2points = 5;
    } else if (!team2fp.presentAssertion && team2featureNumber == 2) {
        team2points = 5;
    }
    [self.team2pointsLabel setText:[NSString stringWithFormat:@"%d punten", team2points]];
    game.team2.points += team2points;
    
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowFirstExplanation"]) {
        ExplainFeatureViewController *efvc = segue.destinationViewController;
        efvc.delegate = self;
        efvc.feature = [game getFeatureWithName:team1fp.feature];
    }
    
    if ([segue.identifier isEqualToString:@"ShowSecondExplanation"]) {
        ExplainFeatureViewController *efvc = segue.destinationViewController;
        efvc.delegate = self;
        efvc.feature = [game getFeatureWithName:team2fp.feature];
    }
}

- (IBAction)next:(id)sender {
    // Horrible state machine nonsense TODO
    if (!(self.explanation1Shown && self.explanation2Shown)) {
        // Show Modal View Controllers with explanation of both features
        if (!self.explanation1Shown) {
            [self performSegueWithIdentifier:@"ShowFirstExplanation" sender:self];
            self.explanation1Shown = YES;
        } else if (!self.explanation2Shown) {
            [self performSegueWithIdentifier:@"ShowSecondExplanation" sender:self];
            self.explanation2Shown = YES;
        }
    } else {
        [game.team1 purgeUsedFeaturePictures];
        [game.team2 purgeUsedFeaturePictures];
        
        if (game.required > 0 && game.team1.featurePictures.count > 0 && game.team2.featurePictures.count > 0) {
            game.turn += 1;
                
            [self performSegueWithIdentifier:@"AnotherRound" sender:self];
        } else {
            // TODO show something if the proof was completed by a lack of features
            
            if (game.issue == 1) {
                [self performSegueWithIdentifier:@"FirstProofComplete" sender:sender];
            } else {
                [self performSegueWithIdentifier:@"SecondProofComplete" sender:sender];
            }
        }
    }
}

#pragma mark - ExplainFeatureViewControllerDelegate

- (void)explainFeatureViewControllerWasDone:(ExplainFeatureViewController *)controller {
    [self.navigationController dismissModalViewControllerAnimated:YES];
    
    // Immediately go into the next action
    // [self next:self];
}

@end
