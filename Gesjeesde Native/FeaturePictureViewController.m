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

@synthesize headerLabel;

@synthesize timeLabel;
@synthesize imagesLabel;

@synthesize timeUpImage;
@synthesize timeUpLabel;

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
    
    self.pictureFrame.hidden = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pictureTaken:) name:kImageCapturedSuccessfully object:nil];
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resignedActive) name:UIApplicationWillResignActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(becameActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    

#ifdef DEBUG
    secondsLeft = 3;
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
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)decrementTimer:(NSTimer *)theTimer {
    // Could get userinfo object from theTimer if necessary
    
    self.timeLabel.text = [NSString stringWithFormat:@"%d", self.secondsLeft];
    
    self.secondsLeft -= 1;
    
    if (self.secondsLeft > 10) {
        // The normal second sounds
        [[SimpleAudioEngine sharedEngine] playEffect:@"i06_tijdtiktaf.wav"];
    } else if (self.secondsLeft < 0) {
        [self timeUp];
    } else {
        // The last couple of seconds have a different sound
        [[SimpleAudioEngine sharedEngine] playEffect:@"i07_tijdtiktlaatstesec_v3.wav"];
    }
}

- (void)timeUp {
    [[SimpleAudioEngine sharedEngine] playEffect:@"i08_tijdvoorbij_v2.wav"];
    
    [self stopTimer];
    
    pictureView.hidden = YES;
    pictureFrame.hidden = YES;
    takePictureButton.hidden = YES;
    
    headerLabel.text = @"De tijd is op!";
    timeUpImage.hidden = NO;
    timeUpLabel.hidden = NO;
    
    doneButton.hidden = NO;
}

- (void)resignedActive {    
    [self stopTimer];
    [self.csManager stopPreview];
    
    self.pictureFrame.hidden = YES;
}

- (void)becameActive {
    [self startTimer];
    [self.csManager startPreview];

    self.pictureFrame.hidden = NO;
}

- (void)startTimer {
    // Timer code from: http://www.herbert-siojo.com/2011/04/19/drawing-a-countdown-timer-ios/
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(decrementTimer:) userInfo:nil repeats:YES];
}

- (void)stopTimer {
    [self.timer invalidate];
}

- (IBAction)next:(id)sender {
    [self stopTimer];
    
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
        [[NSNotificationCenter defaultCenter] removeObserver:self name:kImageCapturedSuccessfully object:nil];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
        
        // Go back again to have team 2 take their pictures
        [self performSegueWithIdentifier:@"NextTeamPrepare" sender:self];
    }
}

- (void)pictureTaken:(NSNotification *)notification {
    UIImage *image = [notification.userInfo valueForKey:@"image"];

    [[SimpleAudioEngine sharedEngine] playEffect:@"i04_neemfoto_v4.wav"];
    
    // Save UIImage to team object
    [team.featurePictures addObject:[[FeaturePicture alloc] initWithImage:
                                     [image imageByScalingAndCroppingForSize:CGSizeMake(612, 612)]]];
    
    // Update the count of images
    imagesLabel.text = [NSString stringWithFormat:@"%d", team.featurePictures.count];
}

#pragma mark -

- (IBAction)takeFeaturePicture:(id)sender {
    if (self.timer.isValid) {
        [csManager captureStillImage];
    } else {
        [self timeUp];
    }
}

@end
