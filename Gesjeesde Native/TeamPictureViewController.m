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
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [self.titleLabel setText:[NSString stringWithFormat:@"Team %@ doe je foto", [defaults objectForKey:kTeam1NameKey]]];
    
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
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
 
    [self presentModalViewController:picker animated:YES];
}

#pragma mark -

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    teamPictureView.image = image;
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissModalViewControllerAnimated:YES];
}
@end
