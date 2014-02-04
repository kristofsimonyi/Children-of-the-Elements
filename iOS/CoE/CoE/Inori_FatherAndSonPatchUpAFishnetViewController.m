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

#define HINT_TIME                                       1.0

#import "Inori_FatherAndSonPatchUpAFishnetViewController.h"
#import "ViewController.h"

@interface Inori_FatherAndSonPatchUpAFishnetViewController ()

@end

@implementation Inori_FatherAndSonPatchUpAFishnetViewController

@synthesize screen09Fish01ImageView, screen09Fish02ImageView, screen09Fish03ImageView, screen09Fish04ImageView, screen09Fish05ImageView, screen09NetImageView, screen09Sea01ImageView, screen09Sea02ImageView, screen09MenuImageView, screen09InoriAndFatherControl, screen09HintLayerImageView;

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
{
    UITouch *touch = [touches anyObject];
    CGPoint translatedPoint = [touch locationInView:self.view];
    
    WavingImageView *touchedFish = nil;
    
    if (CGRectContainsPoint(screen09InoriAndFatherControl.frame, translatedPoint))
    {
        [self startsfxInoriAndFather];
        
        inoriAndFatherInteractionFound=true;
        [self allInteractionFound];
    }

    if (CGRectContainsPoint(screen09Fish01ImageView.frame, translatedPoint))
    {
        touchedFish = screen09Fish01ImageView;
        
        fish1InteractionFound=true;
        [self allInteractionFound];
    }
    if (CGRectContainsPoint(screen09Fish02ImageView.frame, translatedPoint))
    {
        touchedFish = screen09Fish02ImageView;

        fish2InteractionFound=true;
        [self allInteractionFound];
    }
    if (CGRectContainsPoint(screen09Fish03ImageView.frame, translatedPoint))
    {
        touchedFish = screen09Fish03ImageView;

        fish3InteractionFound=true;
        [self allInteractionFound];
    }
    if (CGRectContainsPoint(screen09Fish04ImageView.frame, translatedPoint))
    {
        touchedFish = screen09Fish04ImageView;

        fish4InteractionFound=true;
        [self allInteractionFound];
    }
    if (CGRectContainsPoint(screen09Fish05ImageView.frame, translatedPoint))
    {
        touchedFish = screen09Fish05ImageView;

        fish5InteractionFound=true;
        [self allInteractionFound];
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
        [self startsfxFish];
    }

}

- (void)startsfxInoriAndFather;
{
    //set the SFX then start playing
    if (sfxInoriAndFather==nil)
    {
        NSString *inoriAndFatherSFXPath = [[NSBundle mainBundle] pathForResource:@"004_sohaj" ofType:@"mp3"];
        sfxInoriAndFather = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:inoriAndFatherSFXPath] error:NULL];
        sfxInoriAndFather.delegate = self;
        [sfxInoriAndFather setNumberOfLoops:0]; // when the value is negativ, the sound will be played until you call STOP method
        
        inoriAndFatherSFXPath= nil;
    }
    
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    if (viewContoller.musicIsOn)
    {
        [sfxInoriAndFather setVolume:1.0];
    }
    else
    {
        [sfxInoriAndFather setVolume:0.0];
    }
    
    if (![sfxInoriAndFather isPlaying])
    {
        [sfxInoriAndFather play];
    }

    viewContoller=nil;
}

- (void)startsfxFish;
{
    //set the SFX then start playing
    if (sfxFish1==nil)
    {
        NSString *fishSFXPath = [[NSBundle mainBundle] pathForResource:@"004_hal1" ofType:@"mp3"];
        sfxFish1 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:fishSFXPath] error:NULL];
        sfxFish1.delegate = self;
        [sfxFish1 setNumberOfLoops:0]; // when the value is negativ, the sound will be played until you call STOP method
        
        fishSFXPath= nil;
    }
    
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    if (viewContoller.musicIsOn)
    {
        [sfxFish1 setVolume:1.0];
    }
    else
    {
        [sfxFish1 setVolume:0.0];
    }
    
    if (![sfxFish1 isPlaying])
    {
        [sfxFish1 play];
    }
    viewContoller=nil;

    //set the SFX then start playing
    if (sfxFish2==nil)
    {
        NSString *fishSFXPath = [[NSBundle mainBundle] pathForResource:@"004_hal2" ofType:@"mp3"];
        sfxFish2 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:fishSFXPath] error:NULL];
        sfxFish2.delegate = self;
        [sfxFish2 setNumberOfLoops:0]; // when the value is negativ, the sound will be played until you call STOP method
        
        fishSFXPath= nil;
    }
    
    viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    if (viewContoller.musicIsOn)
    {
        [sfxFish2 setVolume:1.0];
    }
    else
    {
        [sfxFish2 setVolume:0.0];
    }
    
    if (![sfxFish2 isPlaying])
    {
        [sfxFish2 play];
    }

    viewContoller=nil;
}

- (IBAction)screen09HintButtonTapped:(UITapGestureRecognizer *)sender;
{
    if (screen09HintLayerImageView.alpha==0.0)
    {
        //        [hintLayerImageView removeFromSuperview];
        //        [self.view addSubview:hintLayerImageView];
        [UIView animateWithDuration:HINT_TIME animations:^{
            [self.screen09HintLayerImageView setAlpha:1.0];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:HINT_TIME animations:^{
                [self.screen09HintLayerImageView setAlpha:0.01];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:HINT_TIME animations:^{
                    [self.screen09HintLayerImageView setAlpha:1.0];
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:HINT_TIME animations:^{
                        [self.screen09HintLayerImageView setAlpha:0.0];
                    }];
                }];
            }];
        }];
    }
}

- (IBAction)screen09NarrationButtonTapped:(UITapGestureRecognizer *)sender;
{
    if (narration==nil)
    {
        [self startNarration];
    } else
    {
        if ([narration isPlaying])
        {
            [self stopNarration];
        } else {
            [self startNarration];
        }
    }
}

- (IBAction)screen09MusicButtonTapped:(UITapGestureRecognizer *) sender;
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    if (viewContoller.musicIsOn)
    {
        [backgroundMusic setVolume:0.0];
        [sfxFish1 setVolume:0.0];
        [sfxFish2 setVolume:0.0];
        [sfxInoriAndFather setVolume:0.0];
        [narration setVolume:0.0];
        
        viewContoller.musicIsOn=FALSE;
    }
    else
    {
        [backgroundMusic setVolume:1.0];
        [sfxFish1 setVolume:1.0];
        [sfxFish2 setVolume:1.0];
        [sfxInoriAndFather setVolume:1.0];
        [narration setVolume:1.0];
        
        viewContoller.musicIsOn=TRUE;
    }
    viewContoller = nil;
}

-(void)startNarration;
{
    //set the Music for intro then start playing
    if (narration==nil)
    {
        ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
        NSString *screenName = [NSString stringWithFormat:@"%i:", viewContoller.nextViewController ];
        viewContoller = nil;
        
        //name the file to read
        NSString* aPath = [[NSBundle mainBundle] pathForResource:@"ScreenNarrations" ofType:@"txt"];
        //pull the content from the file into memory
        NSData* data = [NSData dataWithContentsOfFile:aPath];
        //convert the bytes from the file into a string
        NSString* string = [[NSString alloc] initWithBytes:[data bytes]
                                                    length:[data length]
                                                  encoding:NSUTF8StringEncoding];
        //split the string around newline characters to create an array
        NSString* delimiter = @"\n";
        NSArray* lines = [string componentsSeparatedByString:delimiter];
        string = nil;
        
        //find the screen identifier
        int i=0;
        while ((i!=[lines count])&&(![screenName isEqual:[lines objectAtIndex:i]]))
        {
            i++;
        }
        
        NSString *narrationFileName = [lines objectAtIndex:i+1];
        NSString *narrationFileExt = [lines objectAtIndex:i+1];
        narrationFileName = [narrationFileName substringToIndex:[narrationFileName rangeOfString:@"."].location];
        narrationFileExt = [narrationFileExt substringFromIndex:[narrationFileExt rangeOfString:@"."].location];
        
        NSString *narrationPath = [[NSBundle mainBundle] pathForResource:narrationFileName ofType:narrationFileExt];
        narration = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:narrationPath] error:NULL];
        narration.delegate = self;
        [narration setNumberOfLoops:0]; // when the value is negativ, the sound will be played until you call STOP method
        narrationFileName=nil;
        narrationFileExt=nil;
        narrationPath = nil;
        lines=nil;
    } else
    {
        [narration setCurrentTime:0];
    }
    
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    if (viewContoller.musicIsOn)
    {
        [narration setVolume:1.0];
    }
    else
    {
        [narration setVolume:0.0];
    }
    
    [narration play];
    
    viewContoller = nil;
    viewContoller = nil;
}

- (void)stopNarration;
{
    [narration stop];
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

- (void)allInteractionFound;
{
    if (fish1InteractionFound&&fish2InteractionFound&&fish3InteractionFound&&fish4InteractionFound&&fish5InteractionFound&&inoriAndFatherInteractionFound)
    {
        self.screen09MenuImageView.image=nil;
        [self.screen09MenuImageView setImage:[UIImage imageNamed:@"menu_set-top-g.png"]];
    }
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
//    [narration stop];
//    [sfxFish1 stop];
//    [sfxFish2 stop];
//    [sfxInoriAndFather stop];
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
    
    inoriAndFatherInteractionFound=false;
    fish1InteractionFound=false;
    fish2InteractionFound=false;
    fish3InteractionFound=false;
    fish4InteractionFound=false;
    fish5InteractionFound=false;
}

- (void)viewDidDisappear:(BOOL)animated;
{
    [self stopMusicAndSfx];
    
    backgroundMusic.delegate=nil;
    narration.delegate=nil;
    sfxFish1.delegate=nil;
    sfxFish2.delegate=nil;
    sfxInoriAndFather.delegate=nil;
    
    backgroundMusic=nil;
    narration=nil;
    sfxFish1=nil;
    sfxFish2=nil;
    sfxInoriAndFather=nil;
    
    [seaChangeTimer invalidate];
    [netMovingTimer invalidate];
    [wavingFishTimer invalidate];
    
    seaChangeTimer=nil;
    netMovingTimer=nil;
    wavingFishTimer=nil;

    [self.view removeFromSuperview];
    self.view = nil;
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
