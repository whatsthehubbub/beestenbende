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
@synthesize classPicker;

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
    
    [classPicker selectRow:currentTeam.dragonClass inComponent:0 animated:NO];
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
    
    NSLog(@"Dragon animal group picked %d", [classPicker selectedRowInComponent:0]);
    
    [self performSegueWithIdentifier:@"Next" sender:sender];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [game getClasses].count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [[game getClasses] objectAtIndex:row];
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    currentTeam.dragonClass = row;
}

@end
