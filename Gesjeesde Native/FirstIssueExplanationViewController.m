//
//  FeaturePictureExplanationViewController.m
//  Beestenbende
//
//  Created by Alper Çuğun on 29/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "FirstIssueExplanationViewController.h"

@interface FirstIssueExplanationViewController ()

@end

@implementation FirstIssueExplanationViewController

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
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"d03_vogels_irritatie.wav"];
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
    if ([segue.identifier isEqualToString:@"FeatureExample"]) {
        FeatureExampleViewController *fev = segue.destinationViewController;
        fev.delegate = self;
    }
}

- (IBAction)example:(id)sender {
    [[SimpleAudioEngine sharedEngine] playEffect:@"i02_schermverder.wav"];

    [self performSegueWithIdentifier:@"FeatureExample" sender:self];
}

- (IBAction)next:(id)sender {
    [[SimpleAudioEngine sharedEngine] playEffect:@"i02_schermverder.wav"];
    
    [self performSegueWithIdentifier:@"Next" sender:self];
}

- (IBAction)back:(id)sender {
    [[SimpleAudioEngine sharedEngine] playEffect:@"i03_schermterug.wav"];
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - FeatureExampleViewControllerDelegate

- (void)featureExampleDidBack:(FeatureExampleViewController *)controller {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
