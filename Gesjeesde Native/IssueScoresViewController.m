//
//  TeamScoresViewController.m
//  Beestenbende
//
//  Created by Alper Çuğun on 5/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "IssueScoresViewController.h"

@interface IssueScoresViewController ()

@end

@implementation IssueScoresViewController

@synthesize game;

@synthesize headerLabel;

@synthesize team1Label;
@synthesize team2Label;

@synthesize team1Picture;
@synthesize team2Picture;

@synthesize team1ScoreLabel;
@synthesize team2ScoreLabel;

@synthesize thanksLabel;

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
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"i14_uitslagkwestie_v2.wav"];
    
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    game = appDelegate.game;
    
    if (game.issue == 1 || game.issue == 2) {
        self.headerLabel.text = [NSString stringWithFormat:@"%@ snapt het", [game getCurrentAnimalName]];
    } else {
        self.headerLabel.text = @"De draak is ontmaskerd";
    }
    
    team1Label.font = [UIFont fontWithName:@"HoeflerText-Black" size:team1Label.font.pointSize];
    
    
    
    team1Picture.image = game.team1.picture;
    team2Picture.image = game.team2.picture;
    
    [self.team1ScoreLabel setText:[NSString stringWithFormat:@"%d", game.team1.points]];
    [self.team2ScoreLabel setText:[NSString stringWithFormat:@"%d", game.team2.points]];
    
    team1ScoreLabel.font = [UIFont fontWithName:@"HoeflerText-Black" size:team1ScoreLabel.font.pointSize];
    team2ScoreLabel.font = [UIFont fontWithName:@"HoeflerText-Black" size:team2ScoreLabel.font.pointSize];
    
    // Store the points in the total and reset the points for the second issue
    game.team1.totalPoints += game.team1.points;
    game.team1.points = 0;
    
    game.team2.totalPoints += game.team2.points;
    game.team2.points = 0;
    
    if (game.issue == 1 || game.issue == 2) {
        self.thanksLabel.text = [NSString stringWithFormat:@"Bedankt voor jullie hulp met het overtuigen van %@.", [game getCurrentAnimalName]];
    } else {
        self.thanksLabel.text = @"Bedankt voor jullie hulp met het ontmaskeren van het draakje.";
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

- (IBAction)back:(id)sender {
    [[SimpleAudioEngine sharedEngine] playEffect:@"i03_schermterug.wav"];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
