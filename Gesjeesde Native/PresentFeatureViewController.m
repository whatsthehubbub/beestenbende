//
//  PresentFeatureViewController.m
//  Beestenbende
//
//  Created by Alper Çuğun on 5/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "PresentFeatureViewController.h"

@interface PresentFeatureViewController ()

@end

@implementation PresentFeatureViewController

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
    self.game = appDelegate.game;
    
    self.currentTeam = [self.game getCurrentTeam];

    self.feature = @"";
    
    self.headerLabel.text = [NSString stringWithFormat:@"Team %@: maak de zin af", [self.currentTeam getTeamName]];
    
    int screenNumber = 17;
    if (self.game.issue == 2) {
        screenNumber = 30;
    }
    
    [self.backgroundImage setUncachedImage:[NSString stringWithFormat:@"%d-background-%@", screenNumber, [self.currentTeam getTeamColor]]];
    self.featureImageFrame.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d-photo-frame-%@", screenNumber, [self.currentTeam getTeamColor]]];
    
    self.hasFeature = YES;
    
    // This is the last picture the team took and which should be assigned a feature and a present assertion
    self.currentFeaturePicture = [self.currentTeam.featurePictures lastObject];
    self.featureImageView.image = self.currentFeaturePicture.image;
    
    self.doneButton.enabled = NO;
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
        [[SimpleAudioEngine sharedEngine] playEffect:@"i10_openmenu.wav"];
        
        FeaturePickerViewController *fpvc = segue.destinationViewController;
        
        fpvc.delegate = self;
    }
}

- (IBAction)yesNo:(id)sender {
    [[SimpleAudioEngine sharedEngine] playEffect:@"i09_knop-toggle.wav"];
    
    self.hasFeature = !self.hasFeature;
    
    NSString *imageName;
    NSString *featureButtonText;
    
    if (self.hasFeature) {
        imageName = @"00-wel-on-geen-off";
        
        featureButtonText = self.feature;
    } else {
        imageName = @"00-wel-off-geen-on";
        
        featureButtonText = [FeaturePicture featureForNegation:self.feature];
    }
    
    // If no feature has been chosen the label will have been blanked by either of the previous two branches and we will have to set it again
    if ([self.feature length] == 0) {
        featureButtonText = @"kies een kenmerk…";
    }

    [self.yesNoButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self.featureButton setTitle:featureButtonText forState:UIControlStateNormal];
}

- (IBAction)next:(id)sender {
    // Commit the feature picture to the current turn and present assertion
    // because it could still change after picking
    
    if (self.currentFeaturePicture) {
        self.currentFeaturePicture.presentAssertion = self.hasFeature;
        
        self.currentFeaturePicture.feature = self.feature;
    }
    
    [self performSegueWithIdentifier:@"Next" sender:self];   
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"i02_schermverder.wav"];
}

- (IBAction)back:(id)sender {
    [[SimpleAudioEngine sharedEngine] playEffect:@"i03_schermterug.wav"];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - FeaturePickerViewControllerDelegate

-(void)featurePickerViewController:(FeaturePickerViewController *)controller didSelectFeature:(NSString *)f {
    self.feature = f;
    
    if (self.hasFeature) {
        [self.featureButton setTitle:self.feature forState:UIControlStateNormal];
    } else {
        [self.featureButton setTitle:[FeaturePicture featureForNegation:self.feature] forState:UIControlStateNormal];
    }
    
    self.doneButton.enabled = YES;
    
    [self.navigationController popViewControllerAnimated:YES];

    self.doneButton.hidden = NO;
}

@end
