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
