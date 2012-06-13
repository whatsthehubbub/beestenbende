//
//  FeaturePictureViewController.m
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 30/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "FeaturePictureViewController.h"

@interface FeaturePictureViewController ()

@end

@implementation FeaturePictureViewController

@synthesize timeLabel;
@synthesize imagesLabel;
@synthesize pictureView;
@synthesize pictureFrame;
@synthesize teamOverlay;

@synthesize takePictureButton;
@synthesize doneButton;

@synthesize timer;
@synthesize secondsLeft;


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
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    game = appDelegate.game;
    
    // Find the current team
    team = [game firstTeamForTurn];
    if (team.tookFeaturePictures) {
        team = [game otherTeamForTeam:team];
    }
    
    // Set the correct overlay for this team
    teamOverlay.image = [UIImage imageNamed:@"overlay-team-blue.png"];
    if (team.number != 1) {
        teamOverlay.image = [UIImage imageNamed:@"overlay-team-yellow.png"];
    }
    
    // Start capture session and bind it to the image view
    csManager = [[CaptureSessionManager alloc] initWithImageView:self.pictureView];
    csManager.continuous = YES;
    [csManager startPreview];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pictureTaken:) name:kImageCapturedSuccessfully object:nil];
    
#ifdef DEBUG
    secondsLeft = 2;
#else
    secondsLeft = 89;
#endif
    
    timeLabel.text = [NSString stringWithFormat:@"%d", secondsLeft+1];
    
    imagesLabel.text = @"0";
    
    [self startTimer];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kImageCapturedSuccessfully object:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)decrementTimer:(NSTimer *)theTimer {
    // Could get userinfo object from theTimer if necessary
    
    self.timeLabel.text = [NSString stringWithFormat:@"%d", self.secondsLeft];
    [[SimpleAudioEngine sharedEngine] playEffect:@"i06_tijdtiktaf.wav"];
    
    self.secondsLeft -= 1;
    
    if (self.secondsLeft < 0) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"i08_tijdvoorbij_v2.wav"];
        
        [self.timer invalidate];
        // If the time is up, call the next method
        
        pictureView.hidden = YES;
        pictureFrame.hidden = YES;
        takePictureButton.hidden = YES;
        doneButton.hidden = NO;
    }
}

- (void)startTimer {
    // Timer code from: http://www.herbert-siojo.com/2011/04/19/drawing-a-countdown-timer-ios/
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(decrementTimer:) userInfo:nil repeats:YES];
}

- (IBAction)next:(id)sender {
    [self.timer invalidate];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kImageCapturedSuccessfully object:nil];
    
    team.tookFeaturePictures = YES;
    
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"i02_schermverder.wav"];
    
    
    if (team.tookFeaturePictures && [[game otherTeamForTeam:team] tookFeaturePictures]) {
        // Go on to labelling
        if (game.issue == 1) {
            [self performSegueWithIdentifier:@"LabelFirst" sender:sender];
        } else {
            [self performSegueWithIdentifier:@"LabelSecond" sender:sender];
        }
    } else {
        // Go back again to have team 2 take their pictures
        [self performSegueWithIdentifier:@"NextTeamPrepare" sender:self];

    }
}

- (void)pictureTaken:(NSNotification *)notification {
    UIImage *image = [notification.userInfo valueForKey:@"image"];

    [[SimpleAudioEngine sharedEngine] playEffect:@"i04_neemfoto_v2.wav"];
    
    // Save UIImage to team object
    [team.featurePictures addObject:[[FeaturePicture alloc] initWithImage:
                                     [image imageByScalingAndCroppingForSize:CGSizeMake(612, 612)]]];
    
    // Update the count of images
    imagesLabel.text = [NSString stringWithFormat:@"%d", team.featurePictures.count];
}

#pragma mark -

- (IBAction)takeFeaturePicture:(id)sender {
    [csManager captureStillImage];
}

@end
