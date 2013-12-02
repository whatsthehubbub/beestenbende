//
//  TeamPrepareViewController.m
//  Beestenbende
//
//  Created by Alper Çuğun on 22/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "TeamFlipViewController.h"

@interface TeamFlipViewController ()

@end

@implementation TeamFlipViewController

@synthesize headerLabel;
@synthesize backgroundImage;

@synthesize teamPhoto;
@synthesize photoFrame;

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
    
    NSArray *nautilus = [NSArray arrayWithObjects:@"d01_nautilus_1.wav", @"d01_nautilus_2.wav", @"d01_nautilus_3.wav", @"d01_nautilus_4.wav", @"d01_nautilus_5.wav", @"d01_nautilus_6.wav", @"d01_nautilus_7.wav", @"d01_nautilus_8.wav", @"d01_nautilus_9.wav", @"d01_nautilus_10.wav", @"d01_nautilus_11.wav", nil];
    [[SimpleAudioEngine sharedEngine] playEffect:[nautilus objectAtIndex:arc4random() % [nautilus count]]];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    game = appDelegate.game;
    
    // Find the current team
    Team *team = [game getCurrentTeam];

    headerLabel.text = [NSString stringWithFormat:@"Wie begint?"];
    
//    self.teamImage.image = team.picture;
    
    self.teamPhoto.image = team.picture;
    
    if (team.number == 1) {
        backgroundImage.image = [UIImage imageNamed:@"43-background-blue"];
        photoFrame.image = [UIImage imageNamed:@"43-photo-frame-blue"];
    } else {
        backgroundImage.image = [UIImage imageNamed:@"43-background-yellow"];
        photoFrame.image = [UIImage imageNamed:@"43-photo-frame-yellow"];
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

- (IBAction)next:(id)sender {
    [[SimpleAudioEngine sharedEngine] playEffect:@"i02_schermverder.wav"];
    
    [self performSegueWithIdentifier:@"Next" sender:self];
}

@end
