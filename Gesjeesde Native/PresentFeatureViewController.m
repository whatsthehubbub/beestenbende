//
//  PresentFeatureViewController.m
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 5/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "PresentFeatureViewController.h"

@interface PresentFeatureViewController ()

@end

@implementation PresentFeatureViewController

@synthesize teamLabel;
@synthesize yesNoButton;
@synthesize featureButton;
@synthesize featureImageView;

@synthesize game;
@synthesize currentTeam;

@synthesize hasFeature;
@synthesize turn;

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
    
    self.currentTeam = game.team1;
    
    self.hasFeature = YES;
    self.turn = game.turn;
    
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
    if ([segue.identifier isEqualToString:@"PickFeature"]) {
        TeamFeaturePickerViewController *tfpvc = segue.destinationViewController;
        tfpvc.delegate = self;
        tfpvc.team = self.currentTeam;
    }
}

- (IBAction)yesNo:(id)sender {
    NSString *title;
    if (self.hasFeature) {
        title = @"Geen";
    } else {
        title = @"Wel";
    }
    
    self.hasFeature = !self.hasFeature;
    
    [self.yesNoButton setTitle:title forState:UIControlStateNormal];
}

- (IBAction)next:(id)sender {
    if (self.currentTeam.number == 1) {
        [UIView beginAnimations:@"View Flip" context:nil];
        [UIView setAnimationDuration:0.80];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:NO];
        
        // Changes to this ViewController
        self.currentTeam = game.team2;
        [self.teamLabel setText:[NSString stringWithFormat:@"Team %@", [self.currentTeam getTeamName]]];
        
        [featureButton setTitle:@"" forState:UIControlStateNormal];
        featureImageView.image = nil;
        
        [yesNoButton setTitle:@"Wel" forState:UIControlStateNormal];
        self.hasFeature = YES;
        
        
        [UIView commitAnimations];
    } else {
        [self performSegueWithIdentifier:@"Result" sender:self];
    }
}

#pragma mark - TeamFeaturePickerViewControllerDelegate

- (void)teamFeaturePickerViewController:(TeamFeaturePickerViewController *)controller didSelectFeature:(int)index {
    FeaturePicture *fp = [self.currentTeam.featurePictures objectAtIndex:index];
    
    fp.presentedTurn = self.turn;
    fp.presentAssertion = self.hasFeature;
    // TODO if you pick a feature and then do No, it is not taken into account
    
    self.featureImageView.image = fp.image;
    
    [self.featureButton setTitle:fp.feature forState:UIControlStateNormal];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
