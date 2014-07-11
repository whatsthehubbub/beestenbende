//
//  TeamPictureViewController.m
//  Beestenbende
//
//  Created by Alper Çuğun on 22/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "TeamPictureViewController.h"

@interface TeamPictureViewController ()

@end

@implementation TeamPictureViewController

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
    
#ifndef DEBUG
    self.selector.hidden = YES;
#endif
    
    self.currentTeamNumber = 1;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.game = appDelegate.game;
    
    [self.titleLabel setText:[NSString stringWithFormat:@"Teamfoto %@", [self.game.team1 getTeamName]]];
    
    // Start capture session and bind it to the image view
    self.csManager = [[CaptureSessionManager alloc] initWithImageView:self.teamPictureView];
    self.csManager.delegate = self;
    [self.csManager startPreview];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    [self.csManager stopPreview];
    [self.csManager disposeOfSession];
    self.csManager = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -

- (IBAction)takeTeamPicture:(id)sender {
    self.takeTeamPictureButton.enabled = NO;
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"i04_neemfoto_v4.wav"];
    
#if TARGET_IPHONE_SIMULATOR
    [self stillImageSucceeded];
#else
    [self.csManager captureStillImage];
#endif
}

- (IBAction)takeTeamPictureAgain:(id)sender {
    [self.csManager startPreview];
    
    self.takeTeamPictureButton.enabled = YES;
    self.takeTeamPictureButton.hidden = NO;
    
    self.takePictureAgainButton.hidden = YES;
    self.nextButton.hidden = YES;
}

- (IBAction)doneWithPicture:(id)sender {
    if ([self currentTeamNumber] == 1) {
        // Start segue back to this view for other team to take picture
        [UIView beginAnimations:@"View Flip" context:nil];
        [UIView setAnimationDuration:0.80];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:NO];
        
        // Changes to this ViewController
        self.currentTeamNumber = 2;
        
        [self.titleLabel setText:[NSString stringWithFormat:@"Teamfoto %@", [self.game.team2 getTeamName]]];
        
        [self.backgroundImage setUncachedImage:[NSString stringWithFormat:@"10-background-%@", [self.game.team2 getTeamColor]]];
        [self.teamPictureFrame setImage:[UIImage imageNamed:[NSString stringWithFormat:@"10-camera-frame-%@", [self.game.team2 getTeamColor]]]];
        
        // Setup everything for team picture again
        [self takeTeamPictureAgain:self];
        
        [UIView commitAnimations];
    } else {
        [[SimpleAudioEngine sharedEngine] playEffect:@"i02_schermverder.wav"];
        
        self.game.issue = self.selector.selectedSegmentIndex+1;
        
        [self.csManager disposeOfSession];
        
        if (self.game.issue == 1) {
            // Start segue to the next view to start the game
            [self performSegueWithIdentifier:@"FirstIssueIntroduction" sender:sender];
        } else if (self.game.issue == 2) {
            [self performSegueWithIdentifier:@"SecondIssueIntroduction" sender:sender];
        } else {
            [self performSegueWithIdentifier:@"FinalIssueIntroduction" sender:sender];
        }
    }
}

-(void)didReceiveMemoryWarning {
    self.csManager = nil;
    
    NSLog(@"Did receive memory warning in %@", NSStringFromClass([self class]));
}

- (void)dealloc {
    NSLog(@"Dealloc called for %@", NSStringFromClass([self class]));
}

#pragma mark - CaptureSessionDelegate methods

- (void)stillImageFailed {
    [self takeTeamPictureAgain:self];
}

- (void)stillImageSucceeded {
    Team *team;
    if (self.currentTeamNumber == 1) {
        team = self.game.team1;
    } else {
        team = self.game.team2;
    }
    
    team.picture = [self.teamPictureView.image imageByScalingAndCroppingForSize:CGSizeMake(612, 612)];
    
    self.takeTeamPictureButton.hidden = YES;
    self.takePictureAgainButton.hidden = NO;
    self.nextButton.hidden = NO;
}

@end
