//
//  FeedbackScreenViewController.m
//  CoE
//
//  Created by Ferenc INKOVICS on 28/01/14.
//  Copyright (c) 2014 No company - private person. All rights reserved.
//

#import "FeedbackScreenViewController.h"
#import "ViewController.h"

@interface FeedbackScreenViewController ()

@end

@implementation FeedbackScreenViewController

@synthesize backgroundImageView, logoImageView;

-(void)goToNextScreen;
{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    //transition.subtype = kCATransitionFromLeft; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (IBAction)feedbackScreenPreviousScreenButtonTouched:(id)sender;
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController--;
    viewContoller = nil;
    
    [self goToNextScreen];
}

- (IBAction)feedbackScreenFeedbackLinkTapped:(id)sender;
{
 [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://docs.google.com/forms/d/1D0sUP0Kmwh9CA3_hVvlzqZHHChvWHEexth_yj_PyKKQ/viewform"]] ;
}

- (IBAction)feedbackScreenCallForArtistLinkTapped:(id)sender;
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.google.com/url?q=http%3A%2F%2Fchildrenoftheelements.org%2Fen%2Fopen-platform&sa=D&sntz=1&usg=AFQjCNHdWnWP83DF2dAT1JNatT6_KuCoSw"]] ;
}

- (IBAction)feedbackScreenFaceBookPageLinkTapped:(id)sender;
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://www.google.com/url?q=https%3A%2F%2Fwww.facebook.com%2FChildrenOfTheElements&sa=D&sntz=1&usg=AFQjCNGfmxpTMmDMz9MjyqKmudGMxlFhMQ"]] ;
}

- (IBAction)feedbackScreenCoEHomePageLinkTapped:(id)sender;
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.google.com/url?q=http%3A%2F%2Fchildrenoftheelements.org&sa=D&sntz=1&usg=AFQjCNFgLcq65rx13KkIVd3Y_GQwkRRPJw"]] ;
}

- (void)loadImages;
{
    NSString* imagePath;
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"Inori_screen_feedback" ofType:@"png"];
    [backgroundImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];

    imagePath = [ [ NSBundle mainBundle] pathForResource:@"Inori_screen_feedback_logo" ofType:@"png"];
    [logoImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];

}

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
    
    [self loadImages];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

    if ([self.view window] == nil)
    {
        // Add code to preserve data stored in the views that might be
        // needed later.
        
        // Add code to clean up other strong references to the view in
        // the view hierarchy.
        self.view = nil;
    }
}

@end
