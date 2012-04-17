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

@synthesize currentTeamNumber;

@synthesize game;

@synthesize csManager;


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
    
    self.currentTeamNumber = 1;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    game = appDelegate.game;
    
    [self.titleLabel setText:[NSString stringWithFormat:@"Team %@ neem een foto", [game.team1 getTeamName]]];
    
    // Start capture session and bind it to the image view
    self.csManager = [[CaptureSessionManager alloc] initWithImageView:self.teamPictureView];
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
    [self.csManager captureStillImage];
}

- (IBAction)doneWithPicture:(id)sender {
    if ([self currentTeamNumber] == 1) {
        game.team1.picture = [teamPictureView.image imageByScalingAndCroppingForSize:CGSizeMake(612, 612)];
        
        // Start segue back to this view for other team to take picture
        [UIView beginAnimations:@"View Flip" context:nil];
        [UIView setAnimationDuration:0.80];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:NO];
        
        // Changes to this ViewController
        self.currentTeamNumber = 2;
        
        [self.titleLabel setText:[NSString stringWithFormat:@"Team %@ neem een foto", [game.team2 getTeamName]]];
        
        // Blank image
        teamPictureView.image = nil;    
        // Start capture session again for team 2
        [teamPictureView.layer addSublayer:csManager.previewLayer];
        [csManager.captureSession startRunning];
        
        [UIView commitAnimations];
    
    } else {
        game.team2.picture = [teamPictureView.image imageByScalingAndCroppingForSize:CGSizeMake(612, 612)];

        // Start segue to the next view to start the game
        [self performSegueWithIdentifier:@"PastTeamPicture" sender:sender];
    }
}
@end
