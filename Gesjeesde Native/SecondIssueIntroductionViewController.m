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

@synthesize game;

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
    
    // Setup game and its teams for the next issue
    game.issue = 2;
    [game resetForNextIssue];
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
