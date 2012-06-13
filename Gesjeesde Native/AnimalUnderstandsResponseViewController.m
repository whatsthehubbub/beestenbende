//
//  AnimalUnderstandsViewController.m
//  Beestenbende
//
//  Created by Alper Çuğun on 13/6/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "AnimalUnderstandsResponseViewController.h"

@interface AnimalUnderstandsResponseViewController ()

@end

@implementation AnimalUnderstandsResponseViewController

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
    Game *game = appDelegate.game;
    
    if (game.issue == 1) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"d05_vogels_opgelucht.wav"];
    } else {
        [[SimpleAudioEngine sharedEngine] playEffect:@"d09_vissen_opgelucht.wav"];
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
