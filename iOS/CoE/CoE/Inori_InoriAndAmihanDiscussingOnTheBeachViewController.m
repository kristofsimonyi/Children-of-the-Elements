//
//  Inori_InoriAndAmihanDiscussingOnTheBeachViewController.m
//  CoE
//
//  Created by Ferenc INKOVICS on 02/03/14.
//  Copyright (c) 2014 No company - private person. All rights reserved.
//

#import "Inori_InoriAndAmihanDiscussingOnTheBeachViewController.h"
#import "ViewController.h"

#define HINT_TIME                                       1.0

@interface Inori_InoriAndAmihanDiscussingOnTheBeachViewController ()

@end

@implementation Inori_InoriAndAmihanDiscussingOnTheBeachViewController

@synthesize hintLayerImageView, backgroundImageView, menuImageView;

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

- (IBAction)nextScreenButtonTouched:(UITapGestureRecognizer *)sender;
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController++;
    viewContoller = nil;
    
    [self goToNextScreen];
}

- (IBAction)previousScreenButtonTouched:(UITapGestureRecognizer *)sender;
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController--;
    viewContoller = nil;
    
    [self goToNextScreen];
}

- (IBAction)hintButtonTapped:(UITapGestureRecognizer *)sender;
{
    if (hintLayerImageView.alpha==0.0)
    {
        //        [hintLayerImageView removeFromSuperview];
        //        [self.view addSubview:hintLayerImageView];
        [UIView animateWithDuration:HINT_TIME animations:^{
            [self.hintLayerImageView setAlpha:1.0];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:HINT_TIME animations:^{
                [self.hintLayerImageView setAlpha:0.01];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:HINT_TIME animations:^{
                    [self.hintLayerImageView setAlpha:1.0];
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:HINT_TIME animations:^{
                        [self.hintLayerImageView setAlpha:0.0];
                    }];
                }];
            }];
        }];
    }
}

- (IBAction)narrationButtonTapped:(UITapGestureRecognizer *)sender;
{
    
}

- (IBAction)musicButtonTapped:(UITapGestureRecognizer *) sender;
{
    
}

- (void)loadImages;
{
    NSString* imagePath;
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"hint-8" ofType:@"png"];
    [hintLayerImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];

    imagePath = [ [ NSBundle mainBundle] pathForResource:@"bg-light" ofType:@"png"];
    [backgroundImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ((interfaceOrientation==UIInterfaceOrientationLandscapeLeft)||(interfaceOrientation==UIInterfaceOrientationLandscapeRight)) {
        return YES;
    }
    // Return YES for supported orientations
	return NO;
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
}

@end
