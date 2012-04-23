//
//  FeaturePictureExplanationViewController.m
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 29/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "FeaturePictureExplanationViewController.h"

@interface FeaturePictureExplanationViewController ()

@end

@implementation FeaturePictureExplanationViewController

@synthesize scrollView;
@synthesize pageControl;

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
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 4, self.scrollView.frame.size.height);
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

- (IBAction)scrollPage:(id)sender {
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    
    [self.scrollView scrollRectToVisible:frame animated:YES];
}

- (IBAction)previous:(id)sender {
    if (self.pageControl.currentPage > 0) {
        self.pageControl.currentPage -= 1;
        
        [self scrollPage:self];
    }
}

- (IBAction)next:(id)sender {
    if (self.pageControl.currentPage < 4) {
        self.pageControl.currentPage += 1;
        [self scrollPage:self];
    }
}

- (IBAction)done:(id)sender {
    NSLog(@"Page %d", self.pageControl.currentPage);
    
    if (NO && /* Short circuit for quicker testing. TODO */ self.pageControl.currentPage != 3) {
        [self next:self];
    } else {
        [self performSegueWithIdentifier:@"Next" sender:self];
    }
}

#pragma mark - FeatureExampleViewControllerDelegate

- (void)featureExampleDidBack:(FeatureExampleViewController *)controller {
    // [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
