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

@synthesize headerLabel;

@synthesize overlayImage;

@synthesize yesNoButton;
@synthesize featureButton;
@synthesize featureImageView;

@synthesize game;
@synthesize currentTeam;
@synthesize currentFeaturePicture;

@synthesize hasFeature;

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
    
    self.currentTeam = [game firstTeamForTurn];
    
    self.headerLabel.text = [NSString stringWithFormat:@"Team %@: Maak de zin af", [self.currentTeam getTeamName]];
    
    if (self.currentTeam.number == 1) {
        overlayImage.image = [UIImage imageNamed:@"overlay-team-blue.png"];
    } else {
        overlayImage.image = [UIImage imageNamed:@"overlay-team-yellow.png"];
    }
    
    self.hasFeature = YES;
    
    self.featureButton.titleLabel.font = [UIFont fontWithName:@"Vollkorn-Regular" size:self.featureButton.titleLabel.font.pointSize];
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
    self.hasFeature = !self.hasFeature;
    
    NSString *imageName;
    NSString *imageDisabledName;
    if (self.hasFeature) {
        imageName = @"toggle-wel-on-geen-off.png";
        imageDisabledName = @"toggle-wel-on-geen-off-inactive.png";
    } else {
        imageName = @"toggle-wel-off-geen-on.png";
        imageDisabledName = @"toggle-wel-off-geen-on-inactive.png";
    }
    
    [self.yesNoButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self.yesNoButton setImage:[UIImage imageNamed:imageDisabledName] forState:UIControlStateDisabled];
    
    if (self.currentFeaturePicture) {
        self.currentFeaturePicture.presentAssertion = self.hasFeature;
    }
}

- (IBAction)next:(id)sender {
    // Check if they have picked a feature TODO
    
    // Commit the feature picture to the current turn and present assertion
    // because it could still change after picking
    self.currentFeaturePicture.presentedTurn = game.turn;
    self.currentFeaturePicture.presentAssertion = self.hasFeature;
    
    if (self.currentTeam == [game firstTeamForTurn]) {
        [UIView beginAnimations:@"View Flip" context:nil];
        [UIView setAnimationDuration:0.80];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:NO];
        
        // Changes to this ViewController
        self.currentTeam = [game secondTeamForTurn];
        
        self.headerLabel.text = [NSString stringWithFormat:@"Team %@: Maak de zin af", [self.currentTeam getTeamName]];
        
        if (self.currentTeam.number == 1) {
            overlayImage.image = [UIImage imageNamed:@"overlay-team-blue.png"];
        } else {
            overlayImage.image = [UIImage imageNamed:@"overlay-team-yellow.png"];
        }
        
        [featureButton setTitle:@"" forState:UIControlStateNormal];
        featureImageView.image = nil;
        
        // self.hasFeature remains the same for the other team, they have to go along
        self.yesNoButton.enabled = NO; // Disable yes no button for the second team
        
        [UIView commitAnimations];
    } else {
        [self performSegueWithIdentifier:@"Result" sender:self];
    }
}

#pragma mark - TeamFeaturePickerViewControllerDelegate

- (void)teamFeaturePickerViewController:(TeamFeaturePickerViewController *)controller didSelectFeature:(int)index {
    
    self.currentFeaturePicture = [self.currentTeam.featurePictures objectAtIndex:index];
    
    self.featureImageView.image = self.currentFeaturePicture.image;
    
    [self.featureButton setTitle:self.currentFeaturePicture.feature forState:UIControlStateNormal];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
