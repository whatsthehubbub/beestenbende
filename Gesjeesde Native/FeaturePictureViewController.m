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
	// Do any additional setup after loading the view.
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    game = appDelegate.game;
    
    // Start capture session and bind it to the image view
    csManager = [[CaptureSessionManager alloc] initWithImageView:self.pictureView];
    csManager.continuous = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pictureTaken:) name:kImageCapturedSuccessfully object:nil];
    
    secondsLeft = 60;
    timeLabel.text =[NSString stringWithFormat:@"%d", secondsLeft];
    
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
    
    if (self.secondsLeft < 0) {
        [self.timer invalidate];
        // If the time is up, call the next method
        
        [takePictureButton setHidden:YES];
        [doneButton setHidden:NO];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SwitchTeams"]) {
        
        SwitchTeamViewController *stvc = segue.destinationViewController;
        stvc.delegate = self;
    }
}

- (void)startTimer {
    // Timer code from: http://www.herbert-siojo.com/2011/04/19/drawing-a-countdown-timer-ios/
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(decrementTimer:) userInfo:nil repeats:YES];
}

- (IBAction)next:(id)sender {
    [self.timer invalidate];
    
    if (game.team1.tookFeaturePictures) {
        // TODO these need resetting for the next round of picture taking
        game.team2.tookFeaturePictures = YES;
        // Go on to labelling
        [self performSegueWithIdentifier:@"PicturesDone" sender:self];
    } else {
        // Go back again to have team 2 take their pictures
        game.team1.tookFeaturePictures = YES;
        [self performSegueWithIdentifier:@"NextTeamPrepare" sender:self];
    }
}

- (void)pictureTaken:(NSNotification *)notification {
    UIImage *image = [notification.userInfo valueForKey:@"image"];
    
    // Find the current team
    Team *team = game.team1;
    if (team.tookFeaturePictures) {
        team = game.team2;
    }
    imagesLabel.text = [NSString stringWithFormat:@"%d", team.featurePictures.count];
    
    // Save UIImage to team object
    [team.featurePictures addObject:[[FeaturePicture alloc] initWithImage:
                                     [image imageByScalingAndCroppingForSize:CGSizeMake(612, 612)]]];
}

#pragma mark - SwitchTeamViewControllerDelegate

- (void)switchDone:(SwitchTeamViewController *)controller {
    // set everything in order here for team 2
//    self.currentTeamNumber = 2;
//    [self.titleLabel setText:@"Team Seba: fotografeer bewijs"];        
    
//    for (UIView *view in self.imagesView.subviews) {
//        [view removeFromSuperview];
//    }
    
    [self startTimer];
    
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

#pragma mark -

- (IBAction)takeFeaturePicture:(id)sender {
    // TODO check if the time is not over yet.
    
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.delegate = self;
//    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//    
//    [self presentModalViewController:picker animated:YES];
    
    [csManager captureStillImage];
}

#pragma mark - UIImagePickerControllerDelegate

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
//    Team *team = game.team1;
//    if (self.currentTeamNumber == 2) {
//        team = game.team2;
//    }
//    
//    UIGraphicsBeginImageContext(CGSizeMake(200, 200));
//    [image drawInRect:CGRectMake(0, 0, 200, 200)];
//    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    UIImageView *newImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 + (team.featurePictures.count % 3 * 80), 10 + 90 * ([team.featurePictures count] / 3), 80, 80)];
//    newImageView.clipsToBounds = YES;
//    newImageView.contentMode = UIViewContentModeScaleAspectFit;
//    newImageView.image = smallImage;
//    
//    [self.imagesView addSubview:newImageView];
//    
//    // Save UIImage to team object
//    [team.featurePictures addObject:[[FeaturePicture alloc] initWithImage:smallImage]];
//    
//    [picker dismissModalViewControllerAnimated:YES];
    
//    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
//    
//    Team *team;
//    if (self.currentTeamNumber==1) {
//        team = game.team1;
//    } else {
//        team = game.team2;
//    }
//    
//    [imageData writeToFile:[team getPicturePath] atomically:NO];
//}

//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//    [picker dismissModalViewControllerAnimated:YES];
//}
//

@end
