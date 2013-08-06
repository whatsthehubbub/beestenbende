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

@synthesize headerLabel;

@synthesize overlayImage;

@synthesize yesNoButton;
@synthesize featureButton;
@synthesize featureImageView;

@synthesize doneButton;

@synthesize game;
@synthesize currentTeam;
@synthesize feature;
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
    
    self.currentTeam = [game getCurrentTeam];

    self.feature = @"";
    
    self.headerLabel.text = [NSString stringWithFormat:@"Team %@: maak de zin af", [self.currentTeam getTeamName]];
    
    if (self.currentTeam.number == 1) {
        overlayImage.image = [UIImage imageNamed:@"overlay-team-blue-choose-evidence-bubble.png"];
    } else {
        overlayImage.image = [UIImage imageNamed:@"overlay-team-yellow-choose-evidence-bubble.png"];
    }
    
    self.hasFeature = YES;
    
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
    NSString *imageDisabledName;
    
    if (self.hasFeature) {
        imageName = @"toggle-wel-on-geen-off.png";
        imageDisabledName = @"toggle-wel-on-geen-off-inactive.png";
        
        [self.featureButton setTitle:self.feature forState:UIControlStateNormal];
    } else {
        imageName = @"toggle-wel-off-geen-on.png";
        imageDisabledName = @"toggle-wel-off-geen-on-inactive.png";
        
        [self.featureButton setTitle:[FeaturePicture featureForNegation:self.feature] forState:UIControlStateNormal];
    }
    
    [self.yesNoButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [self.yesNoButton setImage:[UIImage imageNamed:imageDisabledName] forState:UIControlStateDisabled];
}

- (IBAction)next:(id)sender {
    // Check if they have picked a feature TODO
    
    // Commit the feature picture to the current turn and present assertion
    // because it could still change after picking
    
    if (self.currentFeaturePicture) {
        self.currentFeaturePicture.presentedTurn = game.turn;
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

-(void)featurePickerViewController:(FeaturePickerViewController *)controller didSelectFeature:(NSString *)feature {
    self.feature = feature;
    
    [self.featureButton setTitle:feature forState:UIControlStateNormal];
    
    self.doneButton.enabled = YES;
    
    [self.navigationController popViewControllerAnimated:YES];

    doneButton.hidden = NO;
}

@end
