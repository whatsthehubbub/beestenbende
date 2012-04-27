//
//  ExplainFeatureViewController.m
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 6/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "ExplainFeatureViewController.h"

@interface ExplainFeatureViewController ()

@end

@implementation ExplainFeatureViewController

@synthesize game;

@synthesize feature;

@synthesize team1NameLabel;
@synthesize team1FeatureImage;
@synthesize team1FeatureLabel;
@synthesize team1ResultAndExplanationLabel;

@synthesize team2NameLabel;
@synthesize team2FeatureImage;
@synthesize team2FeatureLabel;
@synthesize team2ResultAndExplanationLabel;

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
    
    // TODO fill in all the explanation code here
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

@end
