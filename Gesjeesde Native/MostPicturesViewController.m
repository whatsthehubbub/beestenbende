//
//  MostPicturesViewController.m
//  Beestenbende
//
//  Created by Alper Çuğun on 26/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "MostPicturesViewController.h"

@interface MostPicturesViewController ()

@end

@implementation MostPicturesViewController

@synthesize game;

@synthesize team1Image;
@synthesize team1Label;
@synthesize team1PictureCount;

@synthesize team2Image;
@synthesize team2Label;
@synthesize team2PictureCount;

@synthesize systemText;

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
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"i08_tijdvoorbij_v2.wav"];

    team1Image.image = game.team1.picture;
    team2Image.image = game.team2.picture;
    
    team1PictureCount.text = [NSString stringWithFormat:@"%d", game.team1.featurePictures.count];
    
    team2PictureCount.text = [NSString stringWithFormat:@"%d", game.team2.featurePictures.count];
    
    NSString *winnerText;
    if (game.team1.featurePictures.count == game.team2.featurePictures.count) {
        winnerText = @"Goed werk, teams! Maar hebben jullie ook de juiste kenmerken?";
    } else {
        Team *winner = game.team1.featurePictures.count > game.team2.featurePictures.count ? game.team1 : game.team2;
        winnerText = [NSString stringWithFormat:@"Goed werk, team %@! Maar hebben jullie ook de juiste kenmerken?", winner.getTeamName];
    }
    systemText.text = winnerText;
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

- (IBAction)done:(id)sender {
    [[SimpleAudioEngine sharedEngine] playEffect:@"i02_schermverder.wav"];
    
    if (game.issue == 1) {
        [self performSegueWithIdentifier:@"LabellingDone" sender:sender];
    } else if (game.issue == 2) {
        [self performSegueWithIdentifier:@"LabellingDoneSecond" sender:sender];
    }
}

@end
