//
//  ExplanationViewController.m
//  Beestenbende
//
//  Created by Alper Çuğun on 22/6/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "ExplanationViewController.h"

@interface ExplanationViewController ()

@end

@implementation ExplanationViewController

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
    
    [self performSegueWithIdentifier:@"Next" sender:self];
}

- (IBAction)back:(id)sender {
    [[SimpleAudioEngine sharedEngine] playEffect:@"i03_schermterug.wav"];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
