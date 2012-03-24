//
//  TeamNamesViewController.m
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 22/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "TeamNamesViewController.h"
#import "TeamPictureViewController.h"

@interface TeamNamesViewController ()

@end

@implementation TeamNamesViewController

@synthesize team1NameField;
@synthesize team2NameField;


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
    
    [self.team1NameField setText:@"Welcome!"];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == team1NameField) {
        [team2NameField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    
    return NO;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Save team names and properly preload Photo view TODO
    NSLog([self.team1NameField text]);
    
    // TODO check for valid names
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[self.team1NameField text] forKey:kTeam1NameKey];
    [defaults setObject:[self.team2NameField text] forKey:kTeam2NameKey];
    
    // Give team 1 as target for next viewcontroller
    
    TeamPictureViewController *tc = [segue destinationViewController];
    [tc setTeamNumber:1];
    
}

@end
