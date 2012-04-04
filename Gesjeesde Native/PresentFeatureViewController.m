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

@synthesize yesNoButton;
@synthesize featureButton;
@synthesize featureImageView;

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
    
    self.currentTeam = game.team1;
    
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
    }
}

- (IBAction)yesNo:(id)sender {
    [self.yesNoButton setTitle:@"Niet" forState:UIControlStateNormal];
}

- (IBAction)next:(id)sender {
    [self performSegueWithIdentifier:@"Result" sender:self];
}

#pragma mark - TeamFeaturePickerViewControllerDelegate

- (void)teamFeaturePickerViewController:(TeamFeaturePickerViewController *)controller didSelectFeature:(int)index {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
