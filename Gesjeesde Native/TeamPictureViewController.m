//
//  TeamPictureViewController.m
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 22/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "TeamPictureViewController.h"

@interface TeamPictureViewController ()

@end

@implementation TeamPictureViewController

@synthesize teamPictureView;
@synthesize titleLabel;

@synthesize teamNumber;

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
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *key = kTeam1NameKey;
    if (teamNumber == 2) {
        key = kTeam2NameKey;
    }
    
    [self.titleLabel setText:[NSString stringWithFormat:@"Team %@ doe je foto", [defaults objectForKey:key]]];
    
}

- (void)viewDidUnload
{
    [self setTeamPictureView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -

- (IBAction)takeTeamPicture:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
 
    [self presentModalViewController:picker animated:YES];
}

- (IBAction)doneWithPicture:(id)sender {
    if ([self teamNumber] == 1) {
        // TODO save picture for team 1
        
        // Start segue back to this view for other team to take picture
        // Maybe wiser to 
        
        [UIView beginAnimations:@"View Flip" context:nil];
        [UIView setAnimationDuration:0.80];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:NO];
        
        // Changes to this ViewController
        self.teamNumber = 2;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *key = kTeam2NameKey;
        [self.titleLabel setText:[NSString stringWithFormat:@"Team %@ doe je foto", [defaults objectForKey:key]]];
        
        // Blank image
        teamPictureView.image = nil;    
        
        
        [UIView commitAnimations];
    
    } else {
        // Start segue to the next view to start the game
        [self performSegueWithIdentifier:@"PastTeamPicture" sender:sender];
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"TakeTeamPicture"]) {
        TeamPictureViewController *tc = [segue destinationViewController];
        [tc setTeamNumber:2];
    }
}

#pragma mark -

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    teamPictureView.image = image;
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissModalViewControllerAnimated:YES];
}
@end
