//
//  SecondIssueIntroductionViewController.m
//  Beestenbende
//
//  Created by Alper Çuğun on 19/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "SecondIssueIntroductionViewController.h"

@interface SecondIssueIntroductionViewController ()

@end

@implementation SecondIssueIntroductionViewController

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

- (IBAction)next:(id)sender {
    [self performSegueWithIdentifier:@"Next" sender:self];
}

@end
