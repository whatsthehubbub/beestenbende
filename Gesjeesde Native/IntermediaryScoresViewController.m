//
//  IntermediaryScoresViewController.m
//  Beestenbende
//
//  Created by Alper Çuğun on 24/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "IntermediaryScoresViewController.h"

@interface IntermediaryScoresViewController ()

@end

@implementation IntermediaryScoresViewController

@synthesize game;

@synthesize team1Label;
@synthesize team2Label;

@synthesize team1Picture;
@synthesize team2Picture;

@synthesize team1ScoreLabel;
@synthesize team2ScoreLabel;

@synthesize progressImage;

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
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"i15_tussenstand_v2.wav"];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    game = appDelegate.game;
    
    team1Label.font = [UIFont fontWithName:@"HoeflerText-Black" size:team1Label.font.pointSize];
    team2Label.font = [UIFont fontWithName:@"HoeflerText-Black" size:team2Label.font.pointSize];
    
    team1Picture.image = game.team1.picture;
    team2Picture.image = game.team2.picture;
    
    [self.team1ScoreLabel setText:[NSString stringWithFormat:@"%d", game.team1.totalPoints]];
    [self.team2ScoreLabel setText:[NSString stringWithFormat:@"%d", game.team2.totalPoints]];
    
    team1ScoreLabel.font = [UIFont fontWithName:@"HoeflerText-Black" size:team1ScoreLabel.font.pointSize];
    team2ScoreLabel.font = [UIFont fontWithName:@"HoeflerText-Black" size:team2ScoreLabel.font.pointSize];
    
    self.progressImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"progress-%d.png", game.issue]];
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

- (IBAction)nextIssue:(id)sender {
    [[SimpleAudioEngine sharedEngine] playEffect:@"i02_schermverder.wav"];
    
    if (game.issue == 1) {
        game.issue = 2;
        [game resetForNextIssue];
        
        // Go to the first screen of the second issue
        UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondIssueIntroduction"];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (game.issue == 2) {
        game.issue = 3;
        [game resetForNextIssue];
        
        // Go to the first screen of the dragon
        UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FinalIssueIntroduction"];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (game.issue == 3) {
        [self performSegueWithIdentifier:@"EndScreen" sender:sender];
    }
}

- (IBAction)back:(id)sender {
    [[SimpleAudioEngine sharedEngine] playEffect:@"i03_schermterug.wav"];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
