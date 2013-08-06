//
//  FeaturePictureViewController.m
//  Beestenbende
//
//  Created by Alper Çuğun on 30/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "FeaturePictureViewController.h"

@interface FeaturePictureViewController ()

@end

@implementation FeaturePictureViewController

@synthesize headerLabel;

@synthesize pictureView;
@synthesize pictureFrame;
@synthesize teamOverlay;

@synthesize takePictureButton;
@synthesize takePictureAgainButton;
@synthesize doneButton;

@synthesize game;
@synthesize team;

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
    team = [game getCurrentTeam];
    
    // Set the correct overlay for this team
    teamOverlay.image = [UIImage imageNamed:@"overlay-team-blue.png"];
    if (team.number != 1) {
        teamOverlay.image = [UIImage imageNamed:@"overlay-team-yellow.png"];
    }
    
    self.headerLabel.text = [NSString stringWithFormat:@"Onderzoek de %@", [[game getCurrentAnimalName] lowercaseString]];
    
    self.explanationLabel.text = [NSString stringWithFormat:@"Fotografeer een kenmerk van een %@ of een %@.", [[game getCorrectAnimalClass] lowercaseString], [[game getWrongAnimalClass] lowercaseString]];
    
    if (game.issue == 1) {
        self.hintLabel.text = @"Bijvoorbeeld: veren.";
    } else if (game.issue == 2) {
        self.hintLabel.text = @"Bijvoorbeeld: vinnen.";
    }

    
    // Start capture session and bind it to the image view
    csManager = [[CaptureSessionManager alloc] initWithImageView:self.pictureView];
//    csManager.continuous = YES;
    [csManager startPreview];
    
    self.pictureFrame.hidden = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pictureTaken:) name:kImageCapturedSuccessfully object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resignedActive) name:UIApplicationWillResignActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(becameActive) name:UIApplicationDidBecomeActiveNotification object:nil];
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

- (void)resignedActive {    
//    [self stopTimer];
    [self.csManager stopPreview];
    
    self.pictureFrame.hidden = YES;
}

- (void)becameActive {
    self.pictureFrame.hidden = NO;
    [self.csManager startPreview];
}

- (IBAction)next:(id)sender {
//    [self stopTimer];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kImageCapturedSuccessfully object:nil];
    
    // TODO does it still make sense to have featurePictures be an array?
    [team.featurePictures addObject:[[FeaturePicture alloc] initWithImage:[pictureView.image imageByScalingAndCroppingForSize:CGSizeMake(612, 612)]]];
    
    team.tookFeaturePictures = YES;
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"i02_schermverder.wav"];
    
    if (game.issue == 1) {
        [self performSegueWithIdentifier:@"UsePictureFirst" sender:sender];
    } else if (game.issue == 2) {
        [self performSegueWithIdentifier:@"UsePictureSecond" sender:sender];
    }
}

- (IBAction)back:(id)sender {
    [[SimpleAudioEngine sharedEngine] playEffect:@"i03_schermterug.wav"];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)takeFeaturePictureAgain:(id)sender {
    [csManager startPreview];
    
    self.takePictureButton.hidden = NO;
    self.takePictureAgainButton.hidden = YES;
    self.doneButton.hidden = YES;
}

#pragma mark -

- (IBAction)takeFeaturePicture:(id)sender {
    [[SimpleAudioEngine sharedEngine] playEffect:@"i04_neemfoto_v4.wav"];

#if TARGET_IPHONE_SIMULATOR
#else
    [self.csManager captureStillImage];
#endif
    
    self.takePictureButton.hidden = YES;
    self.takePictureAgainButton.hidden = NO;
    self.doneButton.hidden = NO;
}

@end
