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

@synthesize backgroundImage;
@synthesize pictureView;
@synthesize pictureFrame;


@synthesize takePictureButton;
@synthesize takePictureAgainButton;
@synthesize doneButton;

@synthesize featureImage;

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
    
    // Observe the setting of image on the pictureView so we can catch it directly
    [pictureView addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    
    // Find the current team
    team = [game getCurrentTeam];
    
    // Set the correct overlay for this team
    backgroundImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"22-background-%@", [team getTeamColor]]];
    pictureFrame.image = [UIImage imageNamed:[NSString stringWithFormat:@"22-camera-frame-%@", [team getTeamColor]]];
    
    self.headerLabel.text = [NSString stringWithFormat:@"Onderzoek de %@", [[game getCurrentAnimalName] lowercaseString]];
    
    self.explanationLabel.text = [NSString stringWithFormat:@"Fotografeer een kenmerk van \r een %@ of een %@.", [[game getCorrectAnimalClass] lowercaseString], [[game getWrongAnimalClass] lowercaseString]];
    
    if (game.issue == 1) {
        self.hintLabel.text = @"Bijvoorbeeld: veren.";
    } else if (game.issue == 2) {
        self.hintLabel.text = @"Bijvoorbeeld: vinnen.";
    }
    
    [self setupCaptureManager];
    
    self.pictureFrame.hidden = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resignedActive) name:UIApplicationWillResignActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(becameActive) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    [self.csManager stopPreview];
    self.csManager = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)resignedActive {
    [self.csManager stopPreview];
    
    self.pictureFrame.hidden = YES;
}

- (void)becameActive {
    self.pictureFrame.hidden = NO;
    [self.csManager startPreview];
}

- (IBAction)next:(id)sender {
    [team addFeaturePicture:[[FeaturePicture alloc] initWithImage:featureImage]];

    team.tookFeaturePictures = YES;
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"i02_schermverder.wav"];
    
    [self.csManager disposeOfSession];
    
    if (game.issue == 1) {
        [self performSegueWithIdentifier:@"UsePictureFirst" sender:sender];
    } else if (game.issue == 2) {
        [self performSegueWithIdentifier:@"UsePictureSecond" sender:sender];
    }
}

- (IBAction)takeFeaturePictureAgain:(id)sender {
    [self setupCaptureManager];
    
    self.takePictureButton.hidden = NO;
    self.takePictureAgainButton.hidden = YES;
    self.doneButton.hidden = YES;
}

- (void)setupCaptureManager {
    csManager = [[CaptureSessionManager alloc] initWithImageView:self.pictureView];
    csManager.delegate = self;
    [csManager startPreview];
}

#pragma mark -

- (IBAction)takeFeaturePicture:(id)sender {
    [[SimpleAudioEngine sharedEngine] playEffect:@"i04_neemfoto_v4.wav"];

#if TARGET_IPHONE_SIMULATOR
#else
    [self.csManager captureStillImage];
#endif
    
//    double delayInSeconds = 0.5;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//    });
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == pictureView && [keyPath isEqualToString:@"image"]) {        
        featureImage = [pictureView.image imageByScalingAndCroppingForSize:CGSizeMake(612, 612)];
    }
}

#pragma mark - CaptureSessionDelegate

- (void)stillImageSucceeded {
    self.takePictureButton.hidden = YES;
    self.takePictureAgainButton.hidden = NO;
    self.doneButton.hidden = NO;
}

- (void)stillImageFailed {
    [self takeFeaturePictureAgain:self];
}

@end
