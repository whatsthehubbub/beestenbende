//
//  DragonLabelViewController.m
//  Beestenbende
//
//  Created by Alper Çuğun on 30/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "DragonLabelViewController.h"

@interface DragonLabelViewController ()

@end

@implementation DragonLabelViewController

@synthesize classLabel;

@synthesize backgroundImage;
@synthesize headerLabel;

@synthesize dragonPictureFrame;
@synthesize dragonPictureView;

@synthesize featureButton;
@synthesize doneButton;

@synthesize game;
@synthesize currentTeam;

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
    
    // Get the team that has to take the picture
    currentTeam = [game firstTeamForTurn];
    if (currentTeam.tookFeaturePictures) {
        currentTeam = [game otherTeamForTeam:currentTeam];
    }
    
    backgroundImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"42-background-%@", [currentTeam getTeamColor]]];
    dragonPictureFrame.image = [UIImage imageNamed:[NSString stringWithFormat:@"42-photo-frame-%@", [currentTeam getTeamColor]]];
    headerLabel.text = [NSString stringWithFormat:@"Team %@: maak de zin af", [currentTeam getTeamName]];
    
    NSString *class = [[game getClasses] objectAtIndex:currentTeam.dragonClass];
    self.classLabel.text = [NSString stringWithFormat:@"Draakje is een %@ \r want hij heeft…", class.lowercaseString];
    
    self.dragonPictureView.image = ((FeaturePicture *)self.currentTeam.featurePictures.lastObject).image;
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

- (IBAction)next:(id)sender {
    [[SimpleAudioEngine sharedEngine] playEffect:@"i02_schermverder.wav"];
    
    [self performSegueWithIdentifier:@"Next" sender:self];
}

#pragma mark - FeaturePickerViewControllerDelegate

-(void)featurePickerViewController:(FeaturePickerViewController *)controller didSelectFeature:(NSString *)feature {
    [self.featureButton setTitle:feature forState:UIControlStateNormal];
    
    FeaturePicture *fp = [self.currentTeam.featurePictures lastObject];

    // Set that object's feature
    fp.feature = feature;
    
    [self.navigationController popViewControllerAnimated:YES];
    
    doneButton.hidden = NO;
}

@end
