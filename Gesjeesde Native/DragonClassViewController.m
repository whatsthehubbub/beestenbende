//
//  DragonClassViewController.m
//  Beestenbende
//
//  Created by Alper Çuğun on 1/5/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "DragonClassViewController.h"

@interface DragonClassViewController ()

@end

@implementation DragonClassViewController

@synthesize game;
@synthesize currentTeam;

@synthesize teamOverlay;

@synthesize mammalButton;
@synthesize fishButton;
@synthesize reptileButton;
@synthesize birdButton;

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
    
    currentTeam = [game firstTeamForTurn];
    if (currentTeam.tookFeaturePictures) {
        currentTeam = [game otherTeamForTeam:currentTeam];
    }
    
    if (currentTeam.number != 1) {
        teamOverlay.image = [UIImage imageNamed:@"overlay-team-yellow.png"];
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
    // Store animal group and move on
    [[SimpleAudioEngine sharedEngine] playEffect:@"i02_schermverder.wav"];
    
    [self performSegueWithIdentifier:@"Next" sender:sender];
}

- (IBAction)back:(id)sender {
    [[SimpleAudioEngine sharedEngine] playEffect:@"i03_schermterug.wav"];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)buttonPushed:(UIButton *)sender {
    for (int i = 1; i < 5; i++) {
        UIButton *button = (UIButton *)[self.view viewWithTag:i];
        
        if (button.enabled) {
            button.selected = NO;
        }
        
    }
    
    sender.selected = YES;
    currentTeam.dragonClass = sender.tag-1;
}

@end
