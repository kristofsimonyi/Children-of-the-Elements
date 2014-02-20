//
//  FeedbackScreenViewController.h
//  CoE
//
//  Created by Ferenc INKOVICS on 28/01/14.
//  Copyright (c) 2014 No company - private person. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedbackScreenViewController : UIViewController{
    
}

@property (nonatomic, weak) IBOutlet UIImageView *backgroundImageView, *logoImageView;

- (IBAction)feedbackScreenPreviousScreenButtonTouched:(id)sender;
- (IBAction)feedbackScreenFeedbackLinkTapped:(id)sender;
- (IBAction)feedbackScreenCallForArtistLinkTapped:(id)sender;
- (IBAction)feedbackScreenFaceBookPageLinkTapped:(id)sender;
- (IBAction)feedbackScreenCoEHomePageLinkTapped:(id)sender;

@end
