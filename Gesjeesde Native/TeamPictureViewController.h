//
//  TeamPictureViewController.h
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 22/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

@interface TeamPictureViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    UIImageView *teamPictureView;
    UIButton *takeTeamPictureButton;
    UILabel *titleLabel;
    
    int currentTeamNumber;
    
    Game *game;
}

@property (assign) int currentTeamNumber;

@property (strong) IBOutlet UIImageView *teamPictureView;
@property (strong) IBOutlet UILabel *titleLabel;

@property (strong) Game *game;

- (IBAction)takeTeamPicture:(id)sender;
- (IBAction)doneWithPicture:(id)sender;

@end
