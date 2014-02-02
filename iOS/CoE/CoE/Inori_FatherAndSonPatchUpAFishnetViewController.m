//
//  Screen09ViewController.m
//  KickOff
//
//  Created by Ferenc INKOVICS on 19/02/2013.
//  Copyright (c) 2013 No company - private person. All rights reserved.
//

#define SEA_CHANGE_ACTION_METHOD_INTERVAL     6.0
#define SEA_CHANGE_INTERVAL                   3.0

#define NET_MOVING_ACTION_METHOD_INTERVAL     0.01
#define NET_MOVING_CLOCK_CHANGE               0.005
#define NET_MOVING_CLOCK_CHANGE_INCREMENT     1.01
#define NET_MOVING_CLOCK_MAX                  5.00

#define WAVING_FISH_TIMER_CLOCK_INTERVAL         0.02
#define WAVING_FISH_TIMER_CLOCK_CHANGE           1.00
#define WAVING_FISH_TIMER_CLOCK_SHIFT_AT_START   60.00
#define WAVING_FISH_ROTATION_X_DIFFERENCE        5.00
#define WAVING_FISH_ROTATION_Y_DIFFERENCE        5.00

#define FISH_ESPACE_X_DIFFERENE                 200.00
#define FISH_ESPACE_TIME_INTERVAL               2.00

#import "Inori_FatherAndSonPatchUpAFishnetViewController.h"
#import "ViewController.h"

@interface Inori_FatherAndSonPatchUpAFishnetViewController ()

@end

@implementation Inori_FatherAndSonPatchUpAFishnetViewController

@synthesize screen09Fish01ImageView, screen09Fish02ImageView, screen09NetImageView, screen09Sea01ImageView, screen09Sea02ImageView;

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
{
    UITouch *touch = [touches anyObject];
    CGPoint translatedPoint = [touch locationInView:self.view];
    
    WavingImageView *touchedFish = nil;
    
    if (CGRectContainsPoint(screen09Fish01ImageView.frame, translatedPoint))
    {
        touchedFish = screen09Fish01ImageView;
    }
    if (CGRectContainsPoint(screen09Fish02ImageView.frame, translatedPoint))
    {
        touchedFish = screen09Fish02ImageView;
    }
    if (touchedFish!=nil)
    {
        touchedFish.actualCirclingRotationChange=0;
        [UIView animateWithDuration: FISH_ESPACE_TIME_INTERVAL
                              delay: 0
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^
         {
             [touchedFish setAlpha:0];
             [touchedFish setCenter:CGPointMake(touchedFish.center.x-FISH_ESPACE_X_DIFFERENE, touchedFish.center.y)];
         }
                         completion:nil];
    }

}

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

-(IBAction)screen09BackToMainMenu:(id)sender;
{
    /*
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController=0;
    viewContoller = nil;
    
    [self goToNextScreen];
     */
}

- (IBAction)screen09NextScreenButtonTouched:(id)sender
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController++;
    viewContoller = nil;
    
    [self goToNextScreen];
}

- (IBAction)screen09PreviousButtonTouched:(id)sender
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController--;
    viewContoller = nil;
    
    [self goToNextScreen];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ((interfaceOrientation==UIInterfaceOrientationLandscapeLeft)||(interfaceOrientation==UIInterfaceOrientationLandscapeRight)) {
        return YES;
    }
    // Return YES for supported orientations
	return NO;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)screen09SeaChangeStart;
{
    seaChangeTimer = [NSTimer scheduledTimerWithTimeInterval:SEA_CHANGE_ACTION_METHOD_INTERVAL target:self selector:@selector(screen09SeaChangeActionMethod) userInfo:nil repeats:YES];
    [seaChangeTimer fire];
    
}

-(void)screen09SeaChangeActionMethod;
{
    [UIView animateWithDuration: SEA_CHANGE_INTERVAL
                          delay: 0.0
                        options: UIViewAnimationOptionCurveLinear
                     animations:^
     {
         [screen09Sea01ImageView setAlpha:1-screen09Sea01ImageView.alpha];
         [screen09Sea02ImageView setAlpha:1-screen09Sea02ImageView.alpha];
     }
                     completion:nil];

}

-(void)screen09NetMovingStart;
{
    netMovingTimerClock=-NET_MOVING_CLOCK_MAX;
    netMovingTimerClockChange=NET_MOVING_CLOCK_CHANGE;
    netMovingTimer = [NSTimer scheduledTimerWithTimeInterval:NET_MOVING_ACTION_METHOD_INTERVAL target:self selector:@selector(screen09NetMovingActionMethod) userInfo:nil repeats:YES];
    [netMovingTimer fire];
    
}

-(void)screen09NetMovingActionMethod;
{
    netMovingTimerClock=netMovingTimerClock+netMovingTimerClockChange;
    if (netMovingTimerClock<=0)
    {
        if (netMovingTimerClockChange>0) {
            netMovingTimerClockChange=netMovingTimerClockChange*NET_MOVING_CLOCK_CHANGE_INCREMENT;
        } else {
            netMovingTimerClockChange=netMovingTimerClockChange/NET_MOVING_CLOCK_CHANGE_INCREMENT;
        }
    }
    else
    {
        if (netMovingTimerClockChange>0) {
            netMovingTimerClockChange=netMovingTimerClockChange/NET_MOVING_CLOCK_CHANGE_INCREMENT;
        } else {
            netMovingTimerClockChange=netMovingTimerClockChange*NET_MOVING_CLOCK_CHANGE_INCREMENT;
        }
    }
    
    if (abs(netMovingTimerClock)>=NET_MOVING_CLOCK_MAX)
    {
        netMovingTimerClockChange=-netMovingTimerClockChange;
        if (netMovingTimerClock>0)
        {
            netMovingTimerClock=NET_MOVING_CLOCK_MAX;
        } else {
            netMovingTimerClock=-NET_MOVING_CLOCK_MAX;
        }
    }
    CGAffineTransform newTransform = CGAffineTransformMakeRotation(netMovingTimerClock/180*M_PI);
    
    [screen09NetImageView setTransform:newTransform];
}

-(void)screen09WavingFishStart;
{
    int i=0;
    NSArray *subviews = [self.view subviews];
    for (WavingImageView *subview in subviews)
    {
        if ([subview isKindOfClass:[WavingImageView class]])
        {
            [subview setOriginalCenter:subview.center];
            subview.rotationCenter=CGPointMake(subview.center.x+WAVING_FISH_ROTATION_X_DIFFERENCE, subview.center.y+WAVING_FISH_ROTATION_Y_DIFFERENCE);
            subview.actualCirclingRotation=i*WAVING_FISH_TIMER_CLOCK_SHIFT_AT_START;
            subview.actualTiltingRotation=0.00;
            subview.actualCirclingRotationChange=WAVING_FISH_TIMER_CLOCK_CHANGE;
            i++;
        }
    }
    

    wavingFishTimer = [NSTimer scheduledTimerWithTimeInterval:WAVING_FISH_TIMER_CLOCK_INTERVAL target:self selector:@selector(screen09WavingFishActionMethod) userInfo:nil repeats:YES];
    [wavingFishTimer fire];
    

}

-(void)screen09WavingFishActionMethod;
{
    NSArray *subviews = [self.view subviews];
    for (WavingImageView *subview in subviews)
    {
        if ([subview isKindOfClass:[WavingImageView class]])
        {
            if (subview.actualCirclingRotationChange!=0)
            {
                if (subview.actualCirclingRotation>360)
                {
                    subview.actualCirclingRotation=subview.actualCirclingRotation-360;
                }
                subview.actualCirclingRotation=subview.actualCirclingRotation+subview.actualCirclingRotationChange;
                
                CGFloat newDegree = 1.00*subview.actualCirclingRotation/180.00*M_PI;
                
                [subview setCenter: [[CommonLibrary alloc] rotatePoint:subview.originalCenter around:subview.rotationCenter withDegree:newDegree]];
            }            
        }
    }
}

-(void)startBackgroundMusic;
{
    //set the Music for intro then start playing
	NSString *backgroundMusicPath = [[NSBundle mainBundle] pathForResource:@"004_Atm_hullamszelmadarhang" ofType:@"mp3"];
	backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:backgroundMusicPath] error:NULL];
	backgroundMusic.delegate = self;
	[backgroundMusic setVolume:1.0];
	[backgroundMusic setNumberOfLoops:-1]; // when the value is negativ, the sound will be played until you call STOP method
    [backgroundMusic play];
}

-(void)stopMusicAndSfx;
{
    [backgroundMusic stop];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self screen09SeaChangeStart];
    [self screen09NetMovingStart];
    [self screen09WavingFishStart];
    
    [self startBackgroundMusic];
}

- (void)viewWillDisappear:(BOOL)animated;
{
    [self stopMusicAndSfx];
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
