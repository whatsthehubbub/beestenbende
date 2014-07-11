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
    self.game = appDelegate.game;
    
    
    self.currentTeam = [self.game getCurrentTeam];
    
    [self setViewsForCurrentTeam];
    
    [self.backgroundImage setUncachedImage:[NSString stringWithFormat:@"18-background-%@", [self.currentTeam getTeamColor]]];
    self.featureImageFrame.image = [UIImage imageNamed:[NSString stringWithFormat:@"18-photo-frame-%@", [self.currentTeam getTeamColor]]];
}

- (void)setViewsForCurrentTeam {
    // Utility method to not have to type this twice, parametrized on self.currentTeam
    FeaturePicture *fp = [self.currentTeam.featurePictures lastObject];
    
    self.featureImage.image = fp.image;
    
    // We may need to change this text but need to leave the original intact
    NSString *featureText = fp.feature;
    
    // Update some user interface
    NSString *present = @"wel";
    // Presence depends on the first team playing not necessarily team1
    if (!fp.presentAssertion) {
        present = @"geen";
        
        featureText = [FeaturePicture featureForNegation:fp.feature];
    }

    self.featureLabel.text = [NSString stringWithFormat:@"%@ heeft %@ %@.", [self.game getCurrentAnimalName], present, featureText];
    
    // Lots of code to generate the result
    NSString *explanation = [[self.game getFeatureWithName:fp.feature] objectForKey:@"Explanation"];
    
    FEATURE_RESULT result = [self.game resultForFeaturePicture:fp];
    
    if (result == FEATURE_YES_UNIQUE || result == FEATURE_NO_INCORRECT_AND_UNIQUE) {
        self.resultAndExplanationLabel.text = [NSString stringWithFormat:@"Uniek want: %@", explanation];
        
        self.currentTeam.points += 10;
        
        self.pointsImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"18-points-10-%@", [self.currentTeam getTeamColor]]];
    } else if (result == FEATURE_YES_CORRECT_AND_DIFFERENTIATING || result == FEATURE_NO_INCORRECT) {
        self.resultAndExplanationLabel.text = [NSString stringWithFormat:@"Goed want: %@", explanation];
        
        self.currentTeam.points += 5;
        
        self.pointsImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"18-points-05-%@", [self.currentTeam getTeamColor]]];
    } else if (result == FEATURE_YES_CORRECT_NOT_DIFFERENTIATING) {
        self.resultAndExplanationLabel.text = [NSString stringWithFormat:@"Denk beter na: een %@ en een %@ hebben allebei dit kenmerk. Hier schiet %@ niks mee op.", [[self.game getCorrectAnimalClass] lowercaseString], [[self.game getWrongAnimalClass] lowercaseString], [self.game getCurrentAnimalName]];
        
        self.pointsImage.image = [UIImage imageNamed:@"18-points-00"];
    } else {
        self.resultAndExplanationLabel.text = [NSString stringWithFormat:@"Fout want: %@", explanation];
        
        self.pointsImage.image = [UIImage imageNamed:@"18-points-00"];
    }
    
    if (result == FEATURE_YES_UNIQUE || result == FEATURE_YES_CORRECT_AND_DIFFERENTIATING || result == FEATURE_NO_INCORRECT || result == FEATURE_NO_INCORRECT_AND_UNIQUE) {
        // This means we have one positive proof
        self.game.required -= 1;
        fp.usedSuccesfully = YES;
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
    
    self.game.currentTeam = [self.game otherTeamForTeam:self.game.currentTeam];
    
    [self performSegueWithIdentifier:@"NextTeam" sender:self];
}

@end
