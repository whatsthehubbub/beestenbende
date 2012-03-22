//
//  TeamPictureViewController.h
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 22/3/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamPictureViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    UIImageView *teamPictureView;
    UIButton *takeTeamPictureButton;
}

@property (retain, nonatomic) IBOutlet UIImageView *teamPictureView;

- (IBAction)takeTeamPicture:(id)sender;

@end
