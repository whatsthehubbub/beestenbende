//
//  PresentResultViewController.m
//  Beestenbende
//
//  Created by Alper Çuğun on 5/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "TeamRunningTotalViewController.h"

@interface TeamRunningTotalViewController ()

@end

@implementation TeamRunningTotalViewController

@synthesize game;

@synthesize titleLabel;

@synthesize team1PointsLabel;
@synthesize team1Image;
@synthesize team2PointsLabel;
@synthesize team2Image;

@synthesize turnLabel;

@synthesize currentFeaturePicture;

@synthesize animalImage;
@synthesize animalRequiresLabel;
@synthesize proofsRequiredLabel;

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
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"i13_uitslagronde_v2.wav"];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    game = appDelegate.game;
    
    self.titleLabel.text = [NSString stringWithFormat:@"Overtuig de %@…", [[game getCurrentAnimalName] lowercaseString]];
    
    self.team1Image.image = game.team1.picture;
    self.team2Image.image = game.team2.picture;
    
    self.team1PointsLabel.text = [NSString stringWithFormat:@"%d", game.team1.points];
    self.team2PointsLabel.text = [NSString stringWithFormat:@"%d", game.team2.points];
    
    self.turnLabel.text = [NSString stringWithFormat:@"Team %@: fotografeer een kenmerk. Team %@: jullie mogen straks weer.", [[game getCurrentTeam] getTeamName], [[game otherTeamForTeam:[game getCurrentTeam]] getTeamName]];
    
    if (game.issue == 1) {
        self.animalImage.image = [UIImage imageNamed:@"animal-squirrel-icon.png"];
    } else if (game.issue == 2) {
        self.animalImage.image = [UIImage imageNamed:@"animal-eel-icon.png"];
    }
    
    self.animalRequiresLabel.text = [NSString stringWithFormat:@"%@ wil nog", [game getCurrentAnimalName]];
    
    [self.proofsRequiredLabel setText:[NSString stringWithFormat:@"%d", game.required]];
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
    
    if (game.required > 0) {
        [self performSegueWithIdentifier:@"NextTeam" sender:sender];
    } else {
        game.currentTeam = nil;
        
        if (game.issue == 1) {
            [self performSegueWithIdentifier:@"FirstAnimalConvinced" sender:sender];
        } else if (game.issue == 2) {
            [self performSegueWithIdentifier:@"SecondAnimalConvinced" sender:sender];
        }
    }
}

- (IBAction)back:(id)sender {
    [[SimpleAudioEngine sharedEngine] playEffect:@"i03_schermterug.wav"];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
