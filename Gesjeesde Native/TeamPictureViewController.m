//
//  TeamPictureViewController.m
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 22/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import "TeamPictureViewController.h"

@interface TeamPictureViewController ()

@end

@implementation TeamPictureViewController

@synthesize teamPictureView;
@synthesize titleLabel;

@synthesize currentTeamNumber;

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
    
    self.currentTeamNumber = 1;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    game = appDelegate.game;
    
    [self.titleLabel setText:[NSString stringWithFormat:@"Team %@ neem een foto", [game.team1 getTeamName]]];
    
    // Start capture session and bind it to the image view
    self.csManager = [[CaptureSessionManager alloc] initWithImageView:self.teamPictureView];
}

- (void)viewDidUnload
{
    [self setTeamPictureView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -

- (IBAction)takeTeamPicture:(id)sender {
    [self.csManager captureStillImage];
    
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.delegate = self;
//    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
// 
//    [self presentModalViewController:picker animated:YES];
}

- (IBAction)doneWithPicture:(id)sender {
    if ([self currentTeamNumber] == 1) {
        // TODO save picture for team 1
        
        // Start segue back to this view for other team to take picture
        // Maybe wiser to 
        
        [UIView beginAnimations:@"View Flip" context:nil];
        [UIView setAnimationDuration:0.80];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:NO];
        
        // Changes to this ViewController
        self.currentTeamNumber = 2;
        
        [self.titleLabel setText:[NSString stringWithFormat:@"Team %@ neem een foto", [game.team2 getTeamName]]];
        
        // Blank image
        teamPictureView.image = nil;    
        
        
        [UIView commitAnimations];
    
    } else {
        // Start segue to the next view to start the game
        [self performSegueWithIdentifier:@"PastTeamPicture" sender:sender];
    }
}

#pragma mark -

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
    UIGraphicsBeginImageContext(CGSizeMake(300, 400));
    [image drawInRect:CGRectMake(0, 0, 300, 400)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    teamPictureView.image = smallImage;
    [picker dismissModalViewControllerAnimated:YES];
    
    NSData *imageData = UIImageJPEGRepresentation(smallImage, 0.5);
    
    Team *team;
    if (self.currentTeamNumber==1) {
        team = game.team1;
    } else {
        team = game.team2;
    }
    
    [imageData writeToFile:[team getPicturePath] atomically:NO];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissModalViewControllerAnimated:YES];
}
@end
