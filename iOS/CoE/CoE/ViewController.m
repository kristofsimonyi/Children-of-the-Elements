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

#define NEXT_SCREEN_INORI_MINIEPISODE02_SCREEN01 201
#define NEXT_SCREEN_INORI_MINIEPISODE02_SCREEN02 202
#define NEXT_SCREEN_INORI_MINIEPISODE02_SCREEN03 203
#define NEXT_SCREEN_INORI_MINIEPISODE02_SCREEN04 204
#define NEXT_SCREEN_INORI_MINIEPISODE02_SCREEN05 205
#define NEXT_SCREEN_INORI_MINIEPISODE02_SCREEN06 206
#define NEXT_SCREEN_INORI_MINIEPISODE02_SCREEN07 207
#define NEXT_SCREEN_INORI_MINIEPISODE02_SCREEN08 208

#import "ViewController.h"
#import "A1ViewController.h"
#import "EViewController.h"
#import "Inori_InorisFatherIsPrayingViewController.h"
#import "Screen02_03ViewController.h"
#import "Screen04ViewController.h"
#import "Screen06_07ViewController.h"
#import "Screen08ViewController.h"
#import "Screen09ViewController.h"
#import "Screen10ViewController.h"
#import "Screen11ViewController.h"
#import "Screen12ViewController.h"
#import "Screen13ViewController.h"
#import "Screen14ViewController.h"
#import "Screen15_16ViewController.h"
#import "Screen25ViewController.h"
#import "ScrollingPagesViewController.h"
#import "FontsViewController.h"

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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

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
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    _purchaseMiniEpisodesViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"PurchaseViewController"];
    
    [self presentViewController:_purchaseMiniEpisodesViewController animated:YES completion:nil];    
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
    A1ViewController *a1ViewController=[[A1ViewController alloc] init];
    a1ViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:a1ViewController animated:YES completion:Nil];
}

-(IBAction)mainscreenScreenEControlSelected:(id)sender;
{
    EViewController *eViewController=[[EViewController alloc] init];
    eViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

    [self presentViewController:eViewController animated:YES completion:Nil];
}

- (IBAction)mainscreenScreen01ControlSelected:(id)sender;
{
    nextViewController = NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN01;
    [self pushNextViewController];
}

- (IBAction)mainscreenScreen02_03ControlSelected:(id)sender;
{
    nextViewController = NEXT_SCREEN_INORI_MINIEPISODE02_SCREEN03;
    [self pushNextViewController];
}

- (IBAction)mainscreenScreen04ControlSelected:(id)sender;
{
    nextViewController = NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN02;
    [self pushNextViewController];
}

- (IBAction)mainscreenScreen06_07ControlSelected:(id)sender;
{
    Screen06_07ViewController *screen06_07ViewController=[[Screen06_07ViewController alloc] init];
    screen06_07ViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:(UIViewController *)screen06_07ViewController animated:YES completion:nil];
    
}

- (IBAction)mainscreenScreen08ControlSelected:(id)sender;
{
    Screen08ViewController *screen08ViewController=[[Screen08ViewController alloc] init];
    screen08ViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:(UIViewController *)screen08ViewController animated:YES completion:nil];
}


- (IBAction)mainscreenScreen09ControlSelected:(id)sender;
{
    nextViewController = NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN03;
    [self pushNextViewController];
}

- (IBAction)mainscreenScreen10ControlSelected:(id)sender;
{
    Screen10ViewController *screen10ViewController=[[Screen10ViewController alloc] init];
    screen10ViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:(UIViewController *)screen10ViewController animated:YES completion:nil];
    
}

- (IBAction)mainscreenScreen11ControlSelected:(id)sender;
{
    nextViewController = NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN04;
    [self pushNextViewController];
}

-(IBAction)mainscreenScreen12ControlSelected:(id)sender;
{
    Screen12ViewController *screen12ViewController=[[Screen12ViewController alloc] init];
    screen12ViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:(UIViewController *)screen12ViewController animated:YES completion:nil];
}

-(IBAction)mainscreenScreen13ControlSelected:(id)sender;
{
    Screen13ViewController *screen13ViewController=[[Screen13ViewController alloc] init];
    screen13ViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:(UIViewController *)screen13ViewController animated:YES completion:nil];
}

-(IBAction)mainscreenScreen14ControlSelected:(id)sender;
{
    nextViewController = NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN05;
    [self pushNextViewController];
}

- (IBAction)mainscreenScreen15_16ControlSelected:(id)sender;
{
    nextViewController = NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN06;
    [self pushNextViewController];
}

- (IBAction)mainscreenScrollingPagesControlSelected:(id)sender;
{
    ScrollingPagesViewController *scrollingPagesViewController=[[ScrollingPagesViewController alloc] init];
    scrollingPagesViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:(UIViewController *)scrollingPagesViewController animated:YES completion:nil];
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
            Inori_InorisFatherIsPrayingViewController *screen01ViewController=[[Inori_InorisFatherIsPrayingViewController alloc] init];
            screen01ViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            
            [self.navigationController pushViewController:screen01ViewController animated:NO];
            
            break;
        }
            
        case NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN02:
        {
            Screen04ViewController *screen04ViewController=[[Screen04ViewController alloc] init];
            screen04ViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            
            [self.navigationController pushViewController:screen04ViewController animated:NO];
            
            break;
        }
            
        case NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN03:
        {
            Screen09ViewController *screen09ViewController=[[Screen09ViewController alloc] init];
            screen09ViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

            [self.navigationController pushViewController:screen09ViewController animated:NO];
            
            break;
        }
            
        case NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN04:
        {
            Screen11ViewController *screen11ViewController=[[Screen11ViewController alloc] init];
            screen11ViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            
            [self.navigationController pushViewController:screen11ViewController animated:NO];
            
            break;
        }
            
        case NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN05:
        {
            Screen14ViewController *screen14ViewController=[[Screen14ViewController alloc] init];
            screen14ViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            
            [self.navigationController pushViewController:screen14ViewController animated:NO];
            
            break;
        }
            
        case NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN06:
        {
            Screen15_16ViewController *screen15_16ViewController=[[Screen15_16ViewController alloc] init];
            screen15_16ViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            
            [self.navigationController pushViewController:screen15_16ViewController animated:NO];
            
            break;
        }
            
        case NEXT_SCREEN_INORI_MINIEPISODE01_SCREEN07:
        {
            nextViewController=0;
            break;
        }
            
        case NEXT_SCREEN_INORI_MINIEPISODE02_SCREEN03:
        {
            Screen02_03ViewController *screen02_03ViewController=[[Screen02_03ViewController alloc] init];
            screen02_03ViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentViewController:(UIViewController *)screen02_03ViewController animated:YES completion:nil];

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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self loadAppSavedStatus];
    
    //MiniSeries1 can be viewed
    [self hideAllMiniEpisodeViews];
    miniEpisode01View.hidden = NO;    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    
    if ([backgroundMusic isPlaying])
    {
        [backgroundMusic stop];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ((interfaceOrientation==UIInterfaceOrientationLandscapeLeft)||(interfaceOrientation==UIInterfaceOrientationLandscapeRight)) {
        return YES;
    } else {
        return FALSE;
    }
}

@end
