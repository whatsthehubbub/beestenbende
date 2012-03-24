//
//  TeamPictureViewController.h
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 22/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Constants.h"

@interface TeamPictureViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    UIImageView *teamPictureView;
    UIButton *takeTeamPictureButton;
    UILabel *titleLabel;
    
    int teamNumber;
}

@property (readwrite) int teamNumber;

@property (retain, nonatomic) IBOutlet UIImageView *teamPictureView;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;

- (IBAction)takeTeamPicture:(id)sender;
- (IBAction)doneWithPicture:(id)sender;

@end
