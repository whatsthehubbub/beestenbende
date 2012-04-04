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

@synthesize titleLabel;
@synthesize timeLabel;
@synthesize timer;
@synthesize secondsLeft;
@synthesize imagesView;

@synthesize currentTeamNumber;

@synthesize game;

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
    
    self.currentTeamNumber = 1;
    
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
    
    [self.timeLabel setText:[NSString stringWithFormat:@"%d", self.secondsLeft]];
    
    self.secondsLeft -= 1;
    
    if (self.secondsLeft < 0) {
        [self.timer invalidate];
        // If the time is up, call the next method
        
        [self next:self];
        // [self performSegueWithIdentifier:@"FeaturePicturesDone" sender:self];
        
        // TODO also break picture taking if we're busy with that?
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SwitchTeams"]) {
        
        SwitchTeamViewController *stvc = segue.destinationViewController;
        stvc.delegate = self;
    }
}

- (void)startTimer {
    self.secondsLeft = 60;

    // Timer code from: http://www.herbert-siojo.com/2011/04/19/drawing-a-countdown-timer-ios/
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(decrementTimer:) userInfo:nil repeats:YES];
}

- (IBAction)next:(id)sender {
    [self.timer invalidate];
    if (self.currentTeamNumber == 1) {
        [self performSegueWithIdentifier:@"SwitchTeams" sender:self];
    } else {
        [self performSegueWithIdentifier:@"FeaturePicturesDone" sender:self];
    }
}

#pragma mark - SwitchTeamViewControllerDelegate

- (void)switchDone:(SwitchTeamViewController *)controller {
    // set everything in order here for team 2
    self.currentTeamNumber = 2;
    [self.titleLabel setText:@"Team Seba: fotografeer bewijs"];        
    
    for (UIView *view in self.imagesView.subviews) {
        [view removeFromSuperview];
    }
    
    [self startTimer];
    
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

#pragma mark -

- (IBAction)takeFeaturePicture:(id)sender {
    // TODO check if the time is not over yet.
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentModalViewController:picker animated:YES];
}

//- (IBAction)doneWithPicture:(id)sender {
//    if ([self currentTeamNumber] == 1) {
//        // TODO save picture for team 1
//        
//        // Start segue back to this view for other team to take picture
//        // Maybe wiser to 
//        
//        [UIView beginAnimations:@"View Flip" context:nil];
//        [UIView setAnimationDuration:0.80];
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:NO];
//        
//        // Changes to this ViewController
//        self.currentTeamNumber = 2;
//        
//        [self.titleLabel setText:[NSString stringWithFormat:@"Team %@ neem je foto", [game.team2 getTeamName]]];
//        
//        // Blank image
//        teamPictureView.image = nil;    
//        
//        
//        [UIView commitAnimations];
//        
//    } else {
//        // Start segue to the next view to start the game
//        [self performSegueWithIdentifier:@"PastTeamPicture" sender:sender];
//    }
//}

#pragma mark - UIIMagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
    Team *team = game.team1;
    if (self.currentTeamNumber == 2) {
        team = game.team2;
    }
    
    UIGraphicsBeginImageContext(CGSizeMake(200, 200));
    [image drawInRect:CGRectMake(0, 0, 200, 200)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *newImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 + (team.featurePictures.count * 80), 10, 80, 80)];
    newImageView.clipsToBounds = YES;
    newImageView.contentMode = UIViewContentModeScaleAspectFit;
    newImageView.image = smallImage;
    
    [self.imagesView addSubview:newImageView];
    
    // Save UIImage to team object
    [team.featurePictures addObject:[[FeaturePicture alloc] initWithImage:smallImage]];
    
    [picker dismissModalViewControllerAnimated:YES];
    
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
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissModalViewControllerAnimated:YES];
}


@end
