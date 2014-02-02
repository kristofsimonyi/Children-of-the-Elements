//
//  ViewController.m
//  KickOff
//
//  Created by INKOVICS Ferenc on 29/02/2012.
//  Copyright (c) 2012 No company - private person. All rights reserved.
//

/*

infinite scrolling in uiscrollview
http://www.youtube.com/watch?v=vLUQz7TeE7w
 
*/
#define MINI_SERIES_2_BOUGHT @"MiniSeries2"
#define MINI_SERIES_3_BOUGHT @"MiniSeries3"
#define MINI_SERIES_4_BOUGHT @"MiniSeries4"
#define MINI_SERIES_5_BOUGHT @"MiniSeries5"
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

#define NEXT_SCREEN_INORI_MINIEPISODE02_SCREEN01 201
#define NEXT_SCREEN_INORI_MINIEPISODE02_SCREEN02 202
#define NEXT_SCREEN_INORI_MINIEPISODE02_SCREEN03 203

#define NEXT_SCREEN_INORI_MINIEPISODE03_SCREEN01 301
#define NEXT_SCREEN_INORI_MINIEPISODE03_SCREEN02 302

#define NEXT_SCREEN_INORI_MINIEPISODE04_SCREEN01 401
#define NEXT_SCREEN_INORI_MINIEPISODE04_SCREEN02 402

#define NEXT_SCREEN_INORI_MINIEPISODE05_SCREEN01 501
#define NEXT_SCREEN_INORI_MINIEPISODE05_SCREEN02 502

#import "ViewController.h"
#import "A1ViewController.h"
#import "EViewController.h"
#import "Inori_InorisFatherIsPrayingViewController.h"
#import "Screen02_03ViewController.h"
#import "Inori_InoriIsWaitingForTheFishermenOnTheBeachViewController.h"
#import "Inori_FatherAndSonSwimInTheSeaViewController.h"
#import "Screen08ViewController.h"
#import "Inori_FatherAndSonPatchUpAFishnetViewController.h"
#import "Screen10ViewController.h"
#import "Screen11ViewController.h"
#import "Screen12ViewController.h"
#import "Screen13ViewController.h"
#import "Screen12ViewController.h"
#import "Screen15_16ViewController.h"
#import "ScrollingPagesViewController.h"
#import "FontsViewController.h"
#import "FeedbackScreenViewController.h"
#import "StaticScreenViewController.h"

@implementation ViewController

@synthesize miniEpisode02Padlock, miniEpisode03Padlock, miniEpisode04Padlock, miniEpisode05Padlock, miniEpisode01View, miniEpisode02View, miniEpisode03View, miniEpisode04View, miniEpisode05View, backgroundMusic, nextViewController, musicIsOn;

-(void)startMusic;
{
    //set the Music for intro then start playing
    if (backgroundMusic==Nil)
    {
        NSString *backgroundMusicPath = [[NSBundle mainBundle] pathForResource:@"The story of the Sea_OK" ofType:@"mp3"];
        backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:backgroundMusicPath] error:NULL];
        backgroundMusic.delegate = self;
        [backgroundMusic setVolume:1.0];
        [backgroundMusic setNumberOfLoops:-1]; // when the value is negativ, the sound will be played until you call STOP method
    }

    if (![backgroundMusic isPlaying])
    {
        [backgroundMusic play];
    }
    
}

-(void)hideAllMiniEpisodeViews;
{
    miniEpisode01View.hidden = YES;
    miniEpisode02View.hidden = YES;
    miniEpisode03View.hidden = YES;
    miniEpisode04View.hidden = YES;
    miniEpisode05View.hidden = YES;
}

- (IBAction)mainscreenScreenMiniEpisode01Selected:(id)sender;
{
    [self hideAllMiniEpisodeViews];
    miniEpisode01View.hidden = NO;
}

- (IBAction)mainscreenScreenMiniEpisode02Selected:(id)sender;
{
    if (miniEpisode02Padlock.hidden)
    {
        [self hideAllMiniEpisodeViews];
        miniEpisode02View.hidden = NO;
    }
    else
    {
        [self presentPurchaseMiniEpisodesViewController];
        [_purchaseMiniEpisodesViewController connectViewControllerToThisView:self];
    }
}

- (IBAction)mainscreenScreenMiniEpisode03Selected:(id)sender;
{
    if (miniEpisode03Padlock.hidden)
    {
        [self hideAllMiniEpisodeViews];
        miniEpisode03View.hidden = NO;
    }
    else
    {
        [self presentPurchaseMiniEpisodesViewController];
        [_purchaseMiniEpisodesViewController connectViewControllerToThisView:self];
    }
}

- (IBAction)mainscreenScreenMiniEpisode04Selected:(id)sender;
{
    if (miniEpisode04Padlock.hidden)
    {
        [self hideAllMiniEpisodeViews];
        miniEpisode04View.hidden = NO;
    }
    else
    {
        [self presentPurchaseMiniEpisodesViewController];
        [_purchaseMiniEpisodesViewController connectViewControllerToThisView:self];
    }
}

- (IBAction)mainscreenScreenMiniEpisode05Selected:(id)sender;
{
    if (miniEpisode05Padlock.hidden)
    {
        [self hideAllMiniEpisodeViews];
        miniEpisode05View.hidden = NO;
    }
    else
    {
        [self presentPurchaseMiniEpisodesViewController];
        [_purchaseMiniEpisodesViewController connectViewControllerToThisView:self];
    }
}

-(void)presentPurchaseMiniEpisodesViewController;
{
    //Go to theScreenFonts that is on the MainStoryboard
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    _purchaseMiniEpisodesViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"PurchaseViewController"];
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    //transition.subtype = kCATransitionFromLeft; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [self.navigationController pushViewController:_purchaseMiniEpisodesViewController animated:NO];
    
}

- (void)miniEpisode02Purchased;
{
    self.miniEpisode02Padlock.hidden=TRUE;

    NSUserDefaults *saveApp = [NSUserDefaults standardUserDefaults];
    [saveApp setBool:TRUE forKey:MINI_SERIES_2_BOUGHT];
    [saveApp synchronize];
}

- (void)miniEpisode03Purchased;
{
    self.miniEpisode03Padlock.hidden=true;
    NSUserDefaults *saveApp = [NSUserDefaults standardUserDefaults];
    [saveApp setBool:TRUE forKey:MINI_SERIES_3_BOUGHT];
    [saveApp synchronize];
}

- (void)miniEpisode04Purchased;
{
    self.miniEpisode04Padlock.hidden=true;
    NSUserDefaults *saveApp = [NSUserDefaults standardUserDefaults];
    [saveApp setBool:TRUE forKey:MINI_SERIES_4_BOUGHT];
    [saveApp synchronize];
}

- (void)miniEpisode05Purchased;
{
    self.miniEpisode05Padlock.hidden=true;
    NSUserDefaults *saveApp = [NSUserDefaults standardUserDefaults];
    [saveApp setBool:TRUE forKey:MINI_SERIES_5_BOUGHT];
    [saveApp synchronize];
    
}

-(IBAction)mainscreenScreenA1ControlSelected:(id)sender;
{
    nextViewController = NEXT_SCREEN_INORI_MINIEPISODE02_SCREEN01;
    [self pushNextViewController];
}

-(IBAction)mainscreenScreenEControlSelected:(id)sender;
{
    nextViewController = NEXT_SCREEN_INORI_MINIEPISODE02_SCREEN02;
    [self pushNextViewController];
}

- (IBAction)mainscreenScreen01ControlSelected:(id)sender;
{
    nextViewController = NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN02;
    [self pushNextViewController];
}

- (IBAction)mainscreenScreen02_03ControlSelected:(id)sender;
{
    nextViewController = NEXT_SCREEN_INORI_MINIEPISODE02_SCREEN03;
    [self pushNextViewController];
}

- (IBAction)mainscreenScreen03ControlSelected:(id)sender;
{
    nextViewController = NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN06;
    [self pushNextViewController];
}

- (IBAction)mainscreenScreen04ControlSelected:(id)sender;
{
    nextViewController = NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN08;
    [self pushNextViewController];
}

- (IBAction)mainscreenScreen06_07ControlSelected:(id)sender;
{
    nextViewController = NEXT_SCREEN_INORI_MINIEPISODE03_SCREEN01;
    [self pushNextViewController];
}

- (IBAction)mainscreenScreen08ControlSelected:(id)sender;
{
    nextViewController = NEXT_SCREEN_INORI_MINIEPISODE03_SCREEN02;
    [self pushNextViewController];
}


- (IBAction)mainscreenScreen09ControlSelected:(id)sender;
{
    nextViewController = NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN04;
    [self pushNextViewController];
}

- (IBAction)mainscreenScreen10ControlSelected:(id)sender;
{
    nextViewController = NEXT_SCREEN_INORI_MINIEPISODE04_SCREEN01;
    [self pushNextViewController];
}

- (IBAction)mainscreenScreen11ControlSelected:(id)sender;
{
    nextViewController = NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN05;
    [self pushNextViewController];
}

-(IBAction)mainscreenScreen12ControlSelected:(id)sender;
{
    nextViewController = NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN12;
    [self pushNextViewController];
}

-(IBAction)mainscreenScreen13ControlSelected:(id)sender;
{
    nextViewController = NEXT_SCREEN_INORI_MINIEPISODE05_SCREEN01;
    [self pushNextViewController];
}

-(IBAction)mainscreenScreen14ControlSelected:(id)sender;
{
    nextViewController = NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN06;
    [self pushNextViewController];
}

- (IBAction)mainscreenScreen15_16ControlSelected:(id)sender;
{
    nextViewController = NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN14;
    [self pushNextViewController];
}

- (IBAction)mainscreenScrollingPagesControlSelected:(id)sender;
{
    nextViewController = NEXT_SCREEN_INORI_MINIEPISODE05_SCREEN02;
    [self pushNextViewController];
}

- (IBAction)mainscreenScreenFontsSelected:(id)sender;
{
    
    //Go to theScreenFonts that is on the MainStoryboard
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    FontsViewController *fontsViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"ScreenFonts"];

    // UIModalTransitionStyleCrossDissolve;

    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    //transition.subtype = kCATransitionFromLeft; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [self.navigationController pushViewController:fontsViewController animated:NO];
    fontsViewController =nil;
}

-(void)loadAppSavedStatus;
{
    NSUserDefaults *saveApp = [NSUserDefaults standardUserDefaults];

    BOOL isMiniSeries2Purchased = [saveApp boolForKey:MINI_SERIES_2_BOUGHT];
    if (isMiniSeries2Purchased)
    {
        //This MiniSeries was purchased before
        miniEpisode02Padlock.hidden = TRUE;
    }
    else
    {
        //This MiniSeries was NOT purchased before
    }

    BOOL isMiniSeries3Purchased = [saveApp boolForKey:MINI_SERIES_3_BOUGHT];
    if (isMiniSeries3Purchased)
    {
        //This MiniSeries was purchased before
        miniEpisode03Padlock.hidden = TRUE;
    }
    else
    {
        //This MiniSeries was NOT purchased before
    }
    
    BOOL isMiniSeries4Purchased = [saveApp boolForKey:MINI_SERIES_4_BOUGHT];
    if (isMiniSeries4Purchased)
    {
        //This MiniSeries was purchased before
        miniEpisode04Padlock.hidden = TRUE;
    }
    else
    {
        //This MiniSeries was NOT purchased before
    }
    
    BOOL isMiniSeries5Purchased = [saveApp boolForKey:MINI_SERIES_5_BOUGHT];
    if (isMiniSeries5Purchased)
    {
        //This MiniSeries was purchased before
        miniEpisode05Padlock.hidden = TRUE;
    }
    else
    {
        //This MiniSeries was NOT purchased before
    }
    
}

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
            Screen11ViewController *newScreenViewController=[[Screen11ViewController alloc] init];
            
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
            Screen12ViewController *newScreenViewController=[[Screen12ViewController alloc] init];
            
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
            
        case NEXT_SCREEN_INORI_MINIEPISODE02_SCREEN01:
        {
            A1ViewController *newScreenViewController=[[A1ViewController alloc] init];
            
            [self.navigationController pushViewController:newScreenViewController animated:NO];
            
            newScreenViewController=nil;
            
            break;
        }
            
        case NEXT_SCREEN_INORI_MINIEPISODE02_SCREEN02:
        {
            EViewController *newScreenViewController=[[EViewController alloc] init];
            
            [self.navigationController pushViewController:newScreenViewController animated:NO];
            
            newScreenViewController=nil;
            
            break;
        }
            
        case NEXT_SCREEN_INORI_MINIEPISODE02_SCREEN03:
        {
            Screen02_03ViewController *newScreenViewController=[[Screen02_03ViewController alloc] init];

            [self.navigationController pushViewController:newScreenViewController animated:NO];

            newScreenViewController=nil;
            
            break;
        }
            
        case NEXT_SCREEN_INORI_MINIEPISODE03_SCREEN01:
        {
            Inori_FatherAndSonSwimInTheSeaViewController *newScreenViewController=[[Inori_FatherAndSonSwimInTheSeaViewController alloc] init];
            
            [self.navigationController pushViewController:newScreenViewController animated:NO];
            
            newScreenViewController=nil;
            
            break;
        }
            
        case NEXT_SCREEN_INORI_MINIEPISODE03_SCREEN02:
        {
            Screen08ViewController *newScreenViewController=[[Screen08ViewController alloc] init];
            
            [self.navigationController pushViewController:newScreenViewController animated:NO];
            
            newScreenViewController=nil;
            
            break;
        }
            
        case NEXT_SCREEN_INORI_MINIEPISODE04_SCREEN01:
        {
            Screen10ViewController *newScreenViewController=[[Screen10ViewController alloc] init];
            
            [self.navigationController pushViewController:newScreenViewController animated:NO];
            
            newScreenViewController=nil;
            
            break;
        }
            
        case NEXT_SCREEN_INORI_MINIEPISODE04_SCREEN02:
        {
            Screen12ViewController *newScreenViewController=[[Screen12ViewController alloc] init];
            
            [self.navigationController pushViewController:newScreenViewController animated:NO];
            
            newScreenViewController=nil;
            
            break;
        }
            
        case NEXT_SCREEN_INORI_MINIEPISODE05_SCREEN01:
        {
            Screen13ViewController *newScreenViewController=[[Screen13ViewController alloc] init];
            
            [self.navigationController pushViewController:newScreenViewController animated:NO];
            
            newScreenViewController=nil;
            
            break;
        }
            
        case NEXT_SCREEN_INORI_MINIEPISODE05_SCREEN02:
        {
            ScrollingPagesViewController *newScreenViewController=[[ScrollingPagesViewController alloc] init];
            
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
            [self startMusic];
        }
    }
}

- (IBAction)mainscreenMusicButtonTouched:(id)sender;
{
    if (musicIsOn)
    {
        [backgroundMusic setVolume:0.0];
        musicIsOn=FALSE;
    }
    else
    {
        [backgroundMusic setVolume:1.0];
        musicIsOn=TRUE;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
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

    if ([backgroundMusic isPlaying])
    {
        [backgroundMusic stop];
    }

    self.view=nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self loadAppSavedStatus];
    
    //MiniSeries1 can be viewed
    [self hideAllMiniEpisodeViews];
    miniEpisode01View.hidden = NO;
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
