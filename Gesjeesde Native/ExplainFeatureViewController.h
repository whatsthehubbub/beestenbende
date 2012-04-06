//
//  ExplainFeatureViewController.h
//  Gesjeesde Beesten
//
//  Created by Alper Çuğun on 6/4/12.
//  Copyright (c) 2012 Hubbub. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ExplainFeatureViewController;

@protocol ExplainFeatureViewControllerDelegate <NSObject>

- (void)explainFeatureViewControllerWasDone:(ExplainFeatureViewController *)controller;

@end

@interface ExplainFeatureViewController : UIViewController {
    NSDictionary *feature;
    
    UILabel *featureLabel;
    UILabel *explanationLabel;
}

@property (nonatomic, weak) id <ExplainFeatureViewControllerDelegate> delegate;

@property (nonatomic, retain) NSDictionary *feature;

@property (nonatomic, retain) IBOutlet UILabel *featureLabel;
@property (nonatomic, retain) IBOutlet UILabel *explanationLabel;

- (IBAction)done:(id)sender;

@end
