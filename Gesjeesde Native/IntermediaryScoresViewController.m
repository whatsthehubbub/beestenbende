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

@synthesize headerLabel;

@synthesize team1Picture;
@synthesize team2Picture;

@synthesize team1ScoreLabel;
@synthesize team2ScoreLabel;

@synthesize tieLabel;

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
    
    team1Picture.image = game.team1.picture;
    team2Picture.image = game.team2.picture;
    
    [self.team1ScoreLabel setText:[NSString stringWithFormat:@"%d", game.team1.totalPoints]];
    [self.team2ScoreLabel setText:[NSString stringWithFormat:@"%d", game.team2.totalPoints]];
    
    self.progressImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"34-progress-%d", game.issue]];
    
    if (game.issue == 3) {
        self.headerLabel.text = @"Eindstand";
        
        if (game.team1.totalPoints == game.team2.totalPoints) {
            // Tie, so show the label with how we break it
            
            Team *winner = game.team1.dragonFeaturesGuessed.count == 3 ? game.team1 : game.team2;
            
            self.tieLabel.text = [NSString stringWithFormat:@"Gelijkspel! %@ heeft \r het draakje opgelost en wint dus.", [winner getTeamName]];
            self.tieLabel.hidden = NO;
            
            
        }
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

- (IBAction)nextIssue:(id)sender {
    [[SimpleAudioEngine sharedEngine] playEffect:@"i02_schermverder.wav"];
    
    if (game.issue == 1) {
        game.issue = 2;
        [game resetForNextIssue];
        
        // Go to the first screen of the second issue
        UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondIssueSplash"];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (game.issue == 2) {
        game.issue = 3;
        [game resetForNextIssue];
        
        // Go to the first screen of the dragon
        UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FinalIssueSplash"];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (game.issue == 3) {
        [self performSegueWithIdentifier:@"EndScreen" sender:sender];
    }
}

@end
