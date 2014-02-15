//
//  ViewController.m
//  KickOff
//
//  Created by INKOVICS Ferenc on 29/02/2012.
//  Copyright (c) 2012 No company - private person. All rights reserved.
//

#define NEXT_SCREEN_MAIN_VIEW_CONTROLLER 0
#define NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN01 101
#define NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN02 102
#define NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN03 103
#define NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN04 104
#define NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN05 105
#define NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN06 106
#define NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN07 107
#define NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN08 108
#define NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN09 109
#define NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN10 110
#define NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN11 111
#define NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN12 112
#define NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN13 113
#define NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN14 114

#import "ViewController.h"
#import "StaticScreenViewController.h"
#import "Inori_InorisFatherIsPrayingViewController.h"
#import "Inori_InoriIsWaitingForTheFishermenOnTheBeachViewController.h"
#import "Inori_FatherAndSonSwimInTheSeaViewController.h"
#import "Inori_FatherAndSonPatchUpAFishnetViewController.h"
#import "Inori_MothersBigBowlViewController.h"
#import "GiantJellyfishArrivedViewController.h"
#import "FeedbackScreenViewController.h"

@implementation ViewController

@synthesize nextViewController, musicIsOn;

-(void)pushNextViewController;
{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    //transition.subtype = kCATransitionFromLeft; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    switch (nextViewController)
    {
        case NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN01:
        {
            StaticScreenViewController *newScreenViewController=[[StaticScreenViewController alloc] init];
            
            [self.navigationController pushViewController:newScreenViewController animated:NO];
            
            newScreenViewController=nil;
            
            break;
        }
            
        case NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN02:
        {
            Inori_InorisFatherIsPrayingViewController *newScreenViewController=[[Inori_InorisFatherIsPrayingViewController alloc] init];
            
            [self.navigationController pushViewController:newScreenViewController animated:NO];
            
            newScreenViewController=nil;
            
            break;
        }
            
        case NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN03:
        {
            StaticScreenViewController *newScreenViewController=[[StaticScreenViewController alloc] init];
            
            [self.navigationController pushViewController:newScreenViewController animated:NO];
            
            newScreenViewController=nil;
            
            break;
        }
            
        case NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN04:
        {
            Inori_InoriIsWaitingForTheFishermenOnTheBeachViewController *newScreenViewController=[[Inori_InoriIsWaitingForTheFishermenOnTheBeachViewController alloc] init];
            
            [self.navigationController pushViewController:newScreenViewController animated:NO];
            
            newScreenViewController=nil;
            
            break;
        }
            
        case NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN05:
        {
            StaticScreenViewController *newScreenViewController=[[StaticScreenViewController alloc] init];
            
            [self.navigationController pushViewController:newScreenViewController animated:NO];
            
            newScreenViewController=nil;
            
            break;
        }
            
        case NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN06:
        {
            /*
            //Go to theScreenFonts that is on the MainStoryboard
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            Inori_FatherAndSonSwimInTheSeaViewController *newScreenViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"FatherAndSonSwimInTheSea"];
            */
            Inori_FatherAndSonSwimInTheSeaViewController *newScreenViewController=[[Inori_FatherAndSonSwimInTheSeaViewController alloc] init];
            
            
            [self.navigationController pushViewController:newScreenViewController animated:NO];
            
            newScreenViewController =nil;
            
            break;
        }
            
        case NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN07:
        {
            StaticScreenViewController *newScreenViewController=[[StaticScreenViewController alloc] init];
            
            [self.navigationController pushViewController:newScreenViewController animated:NO];
            
            newScreenViewController=nil;
            
            break;
        }
            
        case NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN08:
        {
            Inori_FatherAndSonPatchUpAFishnetViewController *newScreenViewController=[[Inori_FatherAndSonPatchUpAFishnetViewController alloc] init];
            
            [self.navigationController pushViewController:newScreenViewController animated:NO];
            
            newScreenViewController=nil;
            
            break;
        }
            
        case NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN09:
        {
            StaticScreenViewController *newScreenViewController=[[StaticScreenViewController alloc] init];
            
            [self.navigationController pushViewController:newScreenViewController animated:NO];
            
            newScreenViewController=nil;
            
            break;
        }
            
        case NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN10:
        {
            Inori_MothersBigBowlViewController *newScreenViewController=[[Inori_MothersBigBowlViewController alloc] init];
            
            [self.navigationController pushViewController:newScreenViewController animated:NO];
            
            newScreenViewController=nil;
            
            break;
        }
            
        case NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN11:
        {
            StaticScreenViewController *newScreenViewController=[[StaticScreenViewController alloc] init];
            
            [self.navigationController pushViewController:newScreenViewController animated:NO];
            
            newScreenViewController=nil;
            
            break;
        }
            
        case NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN12:
        {
            GiantJellyfishArrivedViewController *newScreenViewController=[[GiantJellyfishArrivedViewController alloc] init];
            
            [self.navigationController pushViewController:newScreenViewController animated:NO];
            
            newScreenViewController=nil;
            
            break;
        }
            
        case NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN13:
        {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            Inori_FatherAndSonSwimInTheSeaViewController *newScreenViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"FeedbackScreen"];
            
            [self.navigationController pushViewController:newScreenViewController animated:NO];
            
            newScreenViewController=nil;
            
            break;
        }
            
        default:
            nextViewController=0;
            break;
    }
}

-(void)emptyViewControllers;
{
    NSMutableArray *viewcontrollers = [self.navigationController.viewControllers mutableCopy];

    while ([viewcontrollers count]>1)
    {
        [viewcontrollers removeObjectAtIndex:1];
    }
    self.navigationController.viewControllers = viewcontrollers;

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self emptyViewControllers];
    
    [self pushNextViewController];

    if (nextViewController==NEXT_SCREEN_MAIN_VIEW_CONTROLLER)
    {
        if (musicIsOn)
        {
            ;
        }
    }
}

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ((interfaceOrientation==UIInterfaceOrientationLandscapeLeft)||(interfaceOrientation==UIInterfaceOrientationLandscapeRight)) {
        return YES;
    } else {
        return FALSE;
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];

    self.view=nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
    
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
