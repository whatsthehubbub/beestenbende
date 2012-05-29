//
//  DragonPictureViewController.m
//  Beestenbende
//
//  Created by Alper Çuğun on 30/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "DragonPictureViewController.h"

@interface DragonPictureViewController ()

@end

@implementation DragonPictureViewController

@synthesize classLabel;

@synthesize dragonPictureView;
@synthesize teamOverlay;

@synthesize takeDragonPictureButton;
@synthesize takePictureAgainButton;
@synthesize doneButton;

@synthesize game;
@synthesize currentTeam;

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
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    game = appDelegate.game;
    
    // Get the team that has to take the picture
    currentTeam = [game firstTeamForTurn];
    if (currentTeam.tookFeaturePictures) {
        currentTeam = [game otherTeamForTeam:currentTeam];
    }
    
    if (currentTeam.number != 1) {
        teamOverlay.image = [UIImage imageNamed:@"overlay-team-yellow.png"];
    }
    
    NSString *class = [[game getClasses] objectAtIndex:currentTeam.dragonClass];
    self.classLabel.text = [NSString stringWithFormat:@"Fotografeer een kenmerk van een %@.", class.lowercaseString];
    
    // Start capture session and bind it to the image view
    self.csManager = [[CaptureSessionManager alloc] initWithImageView:self.dragonPictureView];
    
    // For some reason this camera does not resume gracefully after Active/Inactive
    // I suspect this has something to do with looping back through this ViewController
    // http://developer.apple.com/library/ios/#DOCUMENTATION/iPhone/Conceptual/iPhoneOSProgrammingGuide/ManagingYourApplicationsFlow/ManagingYourApplicationsFlow.html#//apple_ref/doc/uid/TP40007072-CH4-SW1
    // http://stackoverflow.com/questions/10125261/avcapturevideopreviewlayer-displays-nothing-on-resume
//    [[NSNotificationCenter defaultCenter] addObserver:self.csManager
//                                             selector:@selector(restartPreview)
//                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self.csManager
//                                             selector:@selector(stopPreview)
//                                                 name:UIApplicationWillResignActiveNotification object:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self.csManager];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -

- (IBAction)takeDragonPicture:(id)sender {
    [self.csManager captureStillImage];
    
    // Hide take picture button, show other two
    // TODO actually switch the buttons when the picture has been really taken (slight delay)
    self.takeDragonPictureButton.hidden = YES;
    self.takePictureAgainButton.hidden = NO;
    self.doneButton.hidden = NO;
}

- (IBAction)takeDragonPictureAgain:(id)sender {
    [csManager restartPreview];
    
    self.takeDragonPictureButton.hidden = NO;
    self.takePictureAgainButton.hidden = YES;
    self.doneButton.hidden = YES;
}

- (IBAction)doneWithPicture:(id)sender {
    [currentTeam.featurePictures addObject:[[FeaturePicture alloc] initWithImage:
                                     [dragonPictureView.image imageByScalingAndCroppingForSize:CGSizeMake(612, 612)]]];
    
    [self.csManager stopPreview];
    
    [self performSegueWithIdentifier:@"Next" sender:sender];
}


@end
