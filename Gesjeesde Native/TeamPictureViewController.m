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
@synthesize teamOverlay;
@synthesize titleLabel;

@synthesize takeTeamPictureButton;
@synthesize takePictureAgainButton;
@synthesize nextButton;

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
    
    [self.titleLabel setText:[NSString stringWithFormat:@"Teamfoto %@", [game.team1 getTeamName]]];
    
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
    
    // Hide take picture button, show other two
    // TODO actually switch the buttons when the picture has been really taken (slight delay)
    self.takeTeamPictureButton.hidden = YES;
    self.takePictureAgainButton.hidden = NO;
    self.nextButton.hidden = NO;
}

- (IBAction)takeTeamPictureAgain:(id)sender {
    [csManager restartPreview];
    
    self.takeTeamPictureButton.hidden = NO;
    self.takePictureAgainButton.hidden = YES;
    self.nextButton.hidden = YES;
}

- (IBAction)doneWithPicture:(id)sender {
    if ([self currentTeamNumber] == 1) {
        // TODO team1 picture is sometimes not saved (if everything goes to quickly maybe?)
        game.team1.picture = [teamPictureView.image imageByScalingAndCroppingForSize:CGSizeMake(612, 612)];
        
        // Start segue back to this view for other team to take picture
        [UIView beginAnimations:@"View Flip" context:nil];
        [UIView setAnimationDuration:0.80];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:NO];
        
        // Changes to this ViewController
        self.currentTeamNumber = 2;
        
        [self.titleLabel setText:[NSString stringWithFormat:@"Teamfoto %@", [game.team2 getTeamName]]];
        [self.teamOverlay setImage:[UIImage imageNamed:@"overlay-team-yellow.png"]];
        
        // Setup everything for team picture again
        [self takeTeamPictureAgain:self];
        
        [UIView commitAnimations];
    
    } else {
        game.team2.picture = [teamPictureView.image imageByScalingAndCroppingForSize:CGSizeMake(612, 612)];

        if (game.issue == 1) {
            // Start segue to the next view to start the game
            [self performSegueWithIdentifier:@"FirstIssueIntroduction" sender:sender];
        } else if (game.issue == 2) {
            [self performSegueWithIdentifier:@"SecondIssueIntroduction" sender:sender];
        } else {
            [self performSegueWithIdentifier:@"FinalIssueIntroduction" sender:sender];
        }
    }
}
@end
