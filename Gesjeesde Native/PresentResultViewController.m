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
    
    [self.team1featureLabel setText:team1fp.feature];
    self.team1featureImage.image = team1fp.image;
    
    FeaturePicture *team2fp;
    for (FeaturePicture *fp in game.team2.featurePictures) {
        if (fp.presentedTurn == game.turn) {
            team2fp = fp;
            break;
        }
    }
    
    [self.team2featureLabel setText:team2fp.feature];
    self.team2featureImage.image = team2fp.image;
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
    game.turn += 1;
    
    // TODO Purge used FeaturePictures from teams
    
    [self performSegueWithIdentifier:@"AnotherRound" sender:self];
}

@end
