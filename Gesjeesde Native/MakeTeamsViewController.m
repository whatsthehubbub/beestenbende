//
//  MakeTeamsViewController.m
//  Beestenbende
//
//  Created by Alper Çuğun on 22/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "MakeTeamsViewController.h"

@interface MakeTeamsViewController ()

@end

@implementation MakeTeamsViewController

@synthesize teamYellowLabel;
@synthesize teamBlueLabel;

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
    
    teamYellowLabel.font = [UIFont fontWithName:@"Vollkorn-Bold" size:teamYellowLabel.font.pointSize];
    teamBlueLabel.font = [UIFont fontWithName:@"Vollkorn-Bold" size:teamBlueLabel.font.pointSize];
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

@end
