//
//  MenuViewController.m
//  Gesjeesde Native
//
//  Created by Alper Çuğun on 21/3/12.
//  Copyright (c) 2012 Aardverschuiving Media. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

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
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"i01_openingsscherm_v2.wav"];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Credits"]) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"i02_schermverder.wav"];
    }
}

- (IBAction)next:(id)sender {
    [[SimpleAudioEngine sharedEngine] playEffect:@"i02_schermverder.wav"];
    [self performSegueWithIdentifier:@"Next" sender:self];
}

@end
