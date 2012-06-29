//
//  ExplainFeatureViewController.m
//  Beestenbende
//
//  Created by Alper Çuğun on 6/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "ExplainFeatureViewController.h"

@interface ExplainFeatureViewController ()

@end

@implementation ExplainFeatureViewController

@synthesize game;
@synthesize currentTeam;

@synthesize overlayImage;

@synthesize featureImage;
@synthesize featureLabel;
@synthesize resultAndExplanationLabel;

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
    
    NSArray *nautilus = [NSArray arrayWithObjects:@"d01_nautilus_1.wav", @"d01_nautilus_2.wav", @"d01_nautilus_3.wav", @"d01_nautilus_4.wav", @"d01_nautilus_5.wav", @"d01_nautilus_6.wav", @"d01_nautilus_7.wav", @"d01_nautilus_8.wav", @"d01_nautilus_9.wav", @"d01_nautilus_10.wav", @"d01_nautilus_11.wav", nil];
    [[SimpleAudioEngine sharedEngine] playEffect:[nautilus objectAtIndex:arc4random() % [nautilus count]]];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    game = appDelegate.game;
    
    self.currentTeam = [game firstTeamForTurn];
    
    [self setViewsForCurrentTeam];
    
    if (self.currentTeam.number == 1) {
        overlayImage.image = [UIImage imageNamed:@"overlay-team-blue-explanation-bubble.png"];
    } else {
        overlayImage.image = [UIImage imageNamed:@"overlay-team-yellow-explanation-bubble.png"];
    }
}

- (void)setViewsForCurrentTeam {
    // Utility method to not have to type this twice, parametrized on self.currentTeam
    FeaturePicture *fp = [self.currentTeam featurePictureForTurn:game.turn];
    
    featureImage.image = fp.image;
    
    // Update some user interface
    NSString *present = @"wel";
    // Presence depends on the first team playing not necessarily team1
    if (!fp.presentAssertion) {
        present = @"niet";
    }

    featureLabel.text = [NSString stringWithFormat:@"De %@ heeft %@ %@", [[game getCurrentAnimalName] lowercaseString], present, fp.feature]; 
    
    // Lots of code to generate the result
    NSString *explanation = [[game getFeatureWithName:fp.feature] objectForKey:@"Explanation"];
    
    FEATURE_RESULT result = [game resultForFeaturePicture:fp];
    
    if (result == FEATURE_YES_UNIQUE) {
        resultAndExplanationLabel.text = [NSString stringWithFormat:@"Uniek want: %@", explanation];
    } else if (result == FEATURE_YES_CORRECT_AND_DIFFERENTIATING || result == FEATURE_NO_INCORRECT) {
        resultAndExplanationLabel.text = [NSString stringWithFormat:@"Goed want: %@", explanation];
    } else if (result == FEATURE_YES_CORRECT_NOT_DIFFERENTIATING) {
        resultAndExplanationLabel.text = [NSString stringWithFormat:@"Denk beter na: een %@ en een %@ hebben allebei dit kenmerk. Hier schiet %@ niks mee op.", [[game getCorrectAnimalClass] lowercaseString], [[game getWrongAnimalClass] lowercaseString], [[game getCurrentAnimalName] lowercaseString]];
    } else {
        resultAndExplanationLabel.text = [NSString stringWithFormat:@"Fout want: %@", explanation];
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
    
    if (self.currentTeam == [game firstTeamForTurn]) {
        [UIView beginAnimations:@"View Flip" context:nil];
        [UIView setAnimationDuration:0.80];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:NO];
        
        // Changes to this ViewController
        self.currentTeam = [game secondTeamForTurn];
        [self setViewsForCurrentTeam];
        
        if (self.currentTeam.number == 1) {
            overlayImage.image = [UIImage imageNamed:@"overlay-team-blue-explanation-bubble.png"];
        } else {
            overlayImage.image = [UIImage imageNamed:@"overlay-team-yellow-explanation-bubble.png"];
        }
        
        [UIView commitAnimations];
    } else {
        [[SimpleAudioEngine sharedEngine] playEffect:@"i02_schermverder.wav"];
        
        [self performSegueWithIdentifier:@"Done" sender:self];
    }
}

@end
