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

@synthesize backgroundImage;
@synthesize headerLabel;

@synthesize classLabel;

@synthesize dragonPictureView;
@synthesize dragonPictureFrame;

@synthesize takeDragonPictureButton;
@synthesize takePictureAgainButton;
@synthesize doneButton;

@synthesize dragonPicture;

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
    
    backgroundImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"41-background-%@", [currentTeam getTeamColor]]];
    dragonPictureFrame.image = [UIImage imageNamed:[NSString stringWithFormat:@"41-photo-frame-%@", [currentTeam getTeamColor]]];
    headerLabel.text = [NSString stringWithFormat:@"Team %@: onderzoek de draak", [currentTeam getTeamName]];
    
    NSString *class = [[game getClasses] objectAtIndex:currentTeam.dragonClass];
    self.classLabel.text = [NSString stringWithFormat:@"Fotografeer een kenmerk \r van een %@.", class.lowercaseString];
    
    [self setupCaptureManager];
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

- (void)resignedActive {
    [self.csManager stopPreview];
    
    self.dragonPictureFrame.hidden = YES;
}

- (void)becameActive {
    [self.csManager startPreview];
    
    self.dragonPictureFrame.hidden = NO;
}

- (void)setupCaptureManager {
    // Start capture session and bind it to the image view
    csManager = [[CaptureSessionManager alloc] initWithImageView:self.dragonPictureView];
    csManager.delegate = self;
    [csManager startPreview];
}

#pragma mark -

- (IBAction)takeDragonPicture:(id)sender {
    self.takeDragonPictureButton.enabled = NO;
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"i04_neemfoto_v4.wav"];
    
#if TARGET_IPHONE_SIMULATOR
#else
    [self.csManager captureStillImage];
#endif
}

- (IBAction)takeDragonPictureAgain:(id)sender {
    [self setupCaptureManager];
    
    self.takeDragonPictureButton.enabled = YES;
    self.takeDragonPictureButton.hidden = NO;
    
    self.takePictureAgainButton.hidden = YES;
    self.doneButton.hidden = YES;
}

- (IBAction)doneWithPicture:(id)sender {
    [currentTeam.featurePictures addObject:[[FeaturePicture alloc] initWithImage:
                                     dragonPicture]];
    
    [self.csManager disposeOfSession];
    
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"i02_schermverder.wav"];
    
    [self performSegueWithIdentifier:@"Next" sender:sender];
}

#pragma mark CaptureSessionDelegate methods

- (void)stillImageSucceeded {
    dragonPicture = [dragonPictureView.image imageByScalingAndCroppingForSize:CGSizeMake(612, 612)];
    
    // Hide take picture button, show other two
    self.takeDragonPictureButton.hidden = YES;
    self.takePictureAgainButton.hidden = NO;
    self.doneButton.hidden = NO;
}

- (void)stillImageFailed {
    [self takeDragonPictureAgain:self];
}

@end
