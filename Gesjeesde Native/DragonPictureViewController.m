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
    
    // Register the dragonPictureView for KVO so we know when a picture has actually been taken
    [dragonPictureView addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    
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
    
    // For some reason this camera does not resume gracefully after Active/Inactive
    // I suspect this has something to do with looping back through this ViewController
    // http://developer.apple.com/library/ios/#DOCUMENTATION/iPhone/Conceptual/iPhoneOSProgrammingGuide/ManagingYourApplicationsFlow/ManagingYourApplicationsFlow.html#//apple_ref/doc/uid/TP40007072-CH4-SW1
    // http://stackoverflow.com/questions/10125261/avcapturevideopreviewlayer-displays-nothing-on-resume

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resignedActive) name:UIApplicationWillResignActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(becameActive) name:UIApplicationDidBecomeActiveNotification object:nil];
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
    [[SimpleAudioEngine sharedEngine] playEffect:@"i04_neemfoto_v4.wav"];
    
#if TARGET_IPHONE_SIMULATOR
#else
    [self.csManager captureStillImage];
#endif
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == dragonPictureView && [keyPath isEqualToString:@"image"]) {
        dragonPicture = [dragonPictureView.image imageByScalingAndCroppingForSize:CGSizeMake(612, 612)];
    }
}

- (IBAction)takeDragonPictureAgain:(id)sender {
    [self setupCaptureManager];
    
    self.takeDragonPictureButton.hidden = NO;
    self.takePictureAgainButton.hidden = YES;
    self.doneButton.hidden = YES;
}

- (IBAction)doneWithPicture:(id)sender {
    [currentTeam.featurePictures addObject:[[FeaturePicture alloc] initWithImage:
                                     dragonPicture]];
    
    [self.csManager disposeOfSession];
    
    
    // Remove notification observers
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"i02_schermverder.wav"];
    
    [self performSegueWithIdentifier:@"Next" sender:sender];
}

#pragma mark CaptureSessionDelegate methods

- (void)stillImageSucceeded {
    // Hide take picture button, show other two
    self.takeDragonPictureButton.hidden = YES;
    self.takePictureAgainButton.hidden = NO;
    self.doneButton.hidden = NO;
}

- (void)stillImageFailed {
    [self takeDragonPictureAgain:self];
}

@end
