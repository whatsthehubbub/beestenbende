//
//  EndScreenViewController.m
//  Beestenbende
//
//  Created by Alper Çuğun on 30/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "EndScreenViewController.h"

@interface EndScreenViewController ()

@end

@implementation EndScreenViewController

@synthesize game;

@synthesize backgroundImage;
@synthesize winnerPicture;

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
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"d14_alledierenblij_einde_v2.wav"];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    game = appDelegate.game;
    
    Team *winner;
    if (game.team1.totalPoints > game.team2.totalPoints) {
        winner = game.team1;
    } else if (game.team2.totalPoints > game.team1.totalPoints) {
        winner = game.team2;
    } else {
        // The team that had 3 dragon proofs wins on ties
        winner = game.team1.dragonFeaturesGuessed.count == 3 ? game.team1 : game.team2;
    }
        
    backgroundImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"45-background-%@", [winner getTeamColor]]];
    
    self.winnerPicture.image = winner.picture;
    
    [Flurry logEvent:@"GameOver"];
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

- (IBAction)mainMenu:(id)sender {
    // Create new game because we are in fact creating a a new game
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.game = [[Game alloc] init];
    
    // Go to the main menu again
//    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
//    [self.navigationController pushViewController:viewController animated:YES];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
//    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
