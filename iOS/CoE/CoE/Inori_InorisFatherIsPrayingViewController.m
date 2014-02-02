//
//  Screen01ViewController.m
//  KickOff
//
//  Created by Ferenc INKOVICS on 11/02/2013.
//  Copyright (c) 2013 No company - private person. All rights reserved.
//
#define PHASE_01_PERIOD                                 300.00  //300, 3 sec long
#define PHASE_01_DISSOLVE_START                         200.00  //200, after 2 sec
#define PHASE_01_TIMER_STEP                             1.00

#define PHASE_02_PERIOD                                 40.00  //40, 2 sec long

#define NIGHT_01_OPACITY_START                          0.89
#define NIGHT_01_OPACITY_FINISH                         0.75

#define NIGHT_02_OPACITY_START                          0.89
#define NIGHT_02_OPACITY_FINISH                         0.00
#define NIGHT_02_OPACITY_RANDOM_MIN                     0.00
#define NIGHT_02_OPACITY_RANDOM_MAX                     0.35
#define NIGHT_02_OPACITY_RANDOM_CHANGE_MIN              0.03
#define NIGHT_02_OPACITY_RANDOM_CHANGE_MAX              0.08
#define NIGHT_02_TIMER_FREQUENCY                        1.00/10 //10 times in a second

#define FIRE_OPACITY_START                              0.00
#define FIRE_OPACITY_FINISH                             100.00

#define TEAPOT_TIMER_FREQUENCY                          1.00/100 //20 TimesInASec
#define TEAPOT_TIMER_FIRST_CURRENT_MAX                  20
#define TEAPOT_TIMER_CURRENT_MAX_DIFF                   1
#define TEAPOT_TIMER_CHANGE_FIRST                       1

#define TEAPOT_MAX_ROTATION                             5
#define TEAPOT_ROTATION_STEP                            0.05
#define TEAPOT_ROTATION_INCREMENT                       1.03
#define TEAPOT_ROTATION_DECREMENT_PER_ROUND             0.5

#define FATHER_TIMER_CLOCK_MAX                          70//original was 17
#define FATHER_TIMER_CLOCK_CHANGE_START                 0.1
#define FATHER_TIMER_CLOCK_CHANGE_INCREMENT             1.05

#define HINT_TIME                                       1.0

#import "Inori_InorisFatherIsPrayingViewController.h"
#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface Inori_InorisFatherIsPrayingViewController ()

@end

@implementation Inori_InorisFatherIsPrayingViewController

@synthesize riceFieldBaseImageView, phase01View, phase02View, windowImageView, bedImageView, baseImageView, fatherImageView, night1ImageView, night2ImageView, teaPotImageView, frameImageView, fireImageView, transitionToPhase02ImageView, fatherControl, teaPotControl, hintLayerImageView;

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

-(IBAction)screen01BackToMainMenu:(id)sender;
{
//*
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController=0;
    viewContoller = nil;
    
    [self goToNextScreen];
// */
}

- (IBAction)Screen01nextScreenButtonTouched:(id)sender
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController++;
    viewContoller = nil;
    
    [self goToNextScreen];
}

- (IBAction)screen01PreviousButtonTouched:(id)sender
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController--;
    viewContoller = nil;
    
    [self goToNextScreen];
}

-(void)startBackgroundMusic1st;
{
    //set the Music for intro then start playing
	NSString *backgroundMusicPath = [[NSBundle mainBundle] pathForResource:@"001_Atm_tucsok" ofType:@"mp3"];
	backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:backgroundMusicPath] error:NULL];
	backgroundMusic.delegate = self;

    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    if (viewContoller.musicIsOn)
    {
        [backgroundMusic setVolume:1.0];
    }
    else
    {
        [backgroundMusic setVolume:0.0];
    }
    
	[backgroundMusic setNumberOfLoops:-1]; // when the value is negativ, the sound will be played until you call STOP method
    [backgroundMusic play];
    
    viewContoller = nil;
    backgroundMusicPath = nil;
    viewContoller = nil;
}

-(void)startBackgroundMusic2nd;
{
    //set the Music for intro then start playing
    backgroundMusic = nil;
	NSString *backgroundMusicPath = [[NSBundle mainBundle] pathForResource:@"001_Atm_tucsok_tuz_zene" ofType:@"mp3"];
	backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:backgroundMusicPath] error:NULL];
	backgroundMusic.delegate = self;

    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    if (viewContoller.musicIsOn)
    {
        [backgroundMusic setVolume:1.0];
    }
    else
    {
        [backgroundMusic setVolume:0.0];
    }

	[backgroundMusic setNumberOfLoops:-1]; // when the value is negativ, the sound will be played until you call STOP method
    [backgroundMusic play];
}

- (void)stopMusicAndSfx;
{
    [backgroundMusic stop];
    [sfxFather stop];
    [sfxHouse stop];
    [sfxTeaPot stop];
}

- (void)startSFXHouse;
{
    //set the SFX then start playing
	NSString *houseSFXPath = [[NSBundle mainBundle] pathForResource:@"001_rakozelithazra2OK" ofType:@"mp3"];
	sfxHouse = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:houseSFXPath] error:NULL];
	sfxHouse.delegate = self;

    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    if (viewContoller.musicIsOn)
    {
        [sfxHouse setVolume:1.0];
    }
    else
    {
        [sfxHouse setVolume:0.0];
    }

	[sfxHouse setNumberOfLoops:0]; // when the value is negativ, the sound will be played until you call STOP method
    [sfxHouse play];
}

- (void)startSFXFather;
{
    //set the SFX then start playing
	NSString *fatherSFXPath = [[NSBundle mainBundle] pathForResource:@"001_ima" ofType:@"mp3"];
	sfxFather = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:fatherSFXPath] error:NULL];
	sfxFather.delegate = self;

    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    if (viewContoller.musicIsOn)
    {
        [sfxFather setVolume:1.0];
    }
    else
    {
        [sfxFather setVolume:0.0];
    }
    
	[sfxFather setNumberOfLoops:0]; // when the value is negativ, the sound will be played until you call STOP method
    [sfxFather play];
}

- (void)startSFXTeapot;
{
    //set the SFX then start playing
	NSString *teapotSFXPath = [[NSBundle mainBundle] pathForResource:@"001_foarizstea" ofType:@"mp3"];
	sfxTeaPot = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:teapotSFXPath] error:NULL];
	sfxTeaPot.delegate = self;

    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    if (viewContoller.musicIsOn)
    {
        [sfxTeaPot setVolume:1.0];
    }
    else
    {
        [sfxTeaPot setVolume:0.0];
    }
    
	[sfxTeaPot setNumberOfLoops:0]; // when the value is negativ, the sound will be played until you call STOP method
    [sfxTeaPot play];
}

- (IBAction)screen01MusicButtonTouched:(id)sender;
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    if (viewContoller.musicIsOn)
    {
        [backgroundMusic setVolume:0.0];
        [sfxTeaPot setVolume:0.0];
        [sfxHouse setVolume:0.0];
        [sfxFather setVolume:0.0];
        
        viewContoller.musicIsOn=FALSE;
    }
    else
    {
        [backgroundMusic setVolume:1.0];
        [sfxTeaPot setVolume:1.0];
        [sfxHouse setVolume:1.0];
        [sfxFather setVolume:1.0];

        viewContoller.musicIsOn=TRUE;
    }
    viewContoller = nil;
}

- (IBAction)hintButtonTapped
{
    if (hintLayerImageView.alpha==0.0)
    {
//        [hintLayerImageView removeFromSuperview];
//        [self.view addSubview:hintLayerImageView];
        [UIView animateWithDuration:HINT_TIME animations:^{
            [hintLayerImageView setAlpha:1.0];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:HINT_TIME animations:^{
                [hintLayerImageView setAlpha:0.01];
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:HINT_TIME animations:^{
                    [hintLayerImageView setAlpha:1.0];
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:HINT_TIME animations:^{
                        [hintLayerImageView setAlpha:0.0];
                    }];
                }];
            }];
        }];
    }
}

- (IBAction)narrationButtonTapped
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
{
    
	NSUInteger touchCount = 0;
	for (UITouch *touch in touches)
	{
		CGPoint translatedPoint = [touch locationInView:self.view];

        if (phase01TimerClock==0)
            if (CGRectContainsPoint(riceFieldBaseImageView.frame, translatedPoint))
            {
                [phase02View setAlpha:1];
                transitionToPhase02ImageView.image=[self captureScreen:phase02View];
                [phase02View setAlpha:0];
                
                phase01Timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(phase01TimerActionMethod) userInfo:nil repeats:YES];
                [phase01Timer fire];
                
                [self startSFXHouse];
            }
        if ((phase01TimerClock==PHASE_01_PERIOD)&(phase02TimerClock==0))
            if (CGRectContainsPoint(baseImageView.frame, translatedPoint))
            {
                [self erasePhase01Images];
                
                phase02Timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(phase02TimerActionMethod) userInfo:nil repeats:YES];
                [phase02Timer fire];
                
            }
		touchCount++;
	}
    
}

-(void)erasePhase01Images;
{
    NSArray *views=[phase01View subviews];
    for (UIView *subview in views)
    {
        [subview removeFromSuperview];
    }
    [phase01View removeFromSuperview];
    phase01View=nil;
}

-(IBAction)fatherTouched:(id)sender;
{
    [fatherControl setUserInteractionEnabled:false];
    fatherTimerClock=0;
    fatherTimerClockChange=FATHER_TIMER_CLOCK_CHANGE_START;
    isFatherRotationClockwise=true;

    fatherTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(fatherTimerActionMethod) userInfo:nil repeats:YES];
    [fatherTimer fire];
    
    [self startSFXFather];
}

-(UIImage *)captureScreen:(UIView *) currentView;
{
	UIGraphicsBeginImageContext(currentView.frame.size);
	[self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return viewImage;
}

- (void)phase01TimerActionMethod;
{
    phase01TimerClock=phase01TimerClock+PHASE_01_TIMER_STEP;
    
    CGFloat newScale =1.00/(1.00+phase01TimerClock/150.00);
    
    CGRect cropRect = CGRectMake(512-(1024*newScale/2), phase01TimerClock/5, 1024*newScale, 748*newScale);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([[UIImage imageNamed:@"1_2k_riszfoldalap.png"] CGImage], cropRect);
    UIImage *newImage = [UIImage imageWithCGImage:imageRef scale:1.00 orientation:riceFieldBaseImageView.image.imageOrientation];
    [riceFieldBaseImageView setImage:newImage];
    CGImageRelease(imageRef);
        
    if (phase01TimerClock>=PHASE_01_DISSOLVE_START)
    {
//        [phase01View setAlpha:1.00*(300-phase01TimerClock)/100];
        CGFloat newAlpha=1.00*(phase01TimerClock-PHASE_01_DISSOLVE_START)/(PHASE_01_PERIOD-PHASE_01_DISSOLVE_START);
        [transitionToPhase02ImageView setAlpha:newAlpha];
    }
    if (phase01TimerClock==PHASE_01_PERIOD)
    {
        [phase01Timer invalidate];
        [phase02View setAlpha:1];
        [self startBackgroundMusic2nd];
    }
}

- (void)phase02TimerActionMethod;
{
    phase02TimerClock++;

    CGFloat newOpacity;
    CGFloat percentage;
    percentage=phase02TimerClock/PHASE_02_PERIOD;
    [fireImageView setAlpha:percentage];

    
    newOpacity=NIGHT_01_OPACITY_START+(NIGHT_01_OPACITY_FINISH-NIGHT_01_OPACITY_START)*percentage;
    [night1ImageView setAlpha:newOpacity];

    newOpacity=NIGHT_02_OPACITY_START+(NIGHT_02_OPACITY_FINISH-NIGHT_02_OPACITY_START)*percentage;
    [night2ImageView setAlpha:newOpacity];

    
    if (phase02TimerClock==PHASE_02_PERIOD)
    {
        [phase02Timer invalidate];
        [self startPhase03];
    }
}

- (void)night02TimerActionMethod;
{
    int newIntChange=(NIGHT_02_OPACITY_RANDOM_CHANGE_MAX-NIGHT_02_OPACITY_RANDOM_CHANGE_MIN)*100+1;
    CGFloat newRandomChange=(arc4random()%newIntChange)/100.00;
    newRandomChange=NIGHT_02_OPACITY_RANDOM_CHANGE_MIN+newRandomChange;
    if (arc4random()%2==0) newRandomChange=-newRandomChange;
    CGFloat newRandomValue=[night2ImageView alpha]+newRandomChange;
    if (newRandomValue<NIGHT_02_OPACITY_RANDOM_MIN)
    {
        newRandomValue=NIGHT_02_OPACITY_RANDOM_MIN;
    }
    else
        if (newRandomValue>NIGHT_02_OPACITY_RANDOM_MAX)
        {
            newRandomValue=NIGHT_02_OPACITY_RANDOM_MAX;
        }
    [night2ImageView setAlpha:newRandomValue];
}

-(IBAction)teaPotTouched_old:(id)sender;
{
    [teaPotControl setUserInteractionEnabled:false];
    teaPotTimerClock=0;
    teaPotTimerClockChange=TEAPOT_TIMER_CHANGE_FIRST;
    teaPotTimerChangeCurrentMax=TEAPOT_TIMER_FIRST_CURRENT_MAX;
    if (arc4random()%2==1) teaPotTimerClockChange=-teaPotTimerClockChange;
    
    teaPotOriginalTransform = [teaPotImageView transform]; // ez lehet nem lesz jó... mert lehet nem 0 ha már nem előszőr van megérintve
    
    teaPotTimer = [NSTimer scheduledTimerWithTimeInterval:TEAPOT_TIMER_FREQUENCY target:self selector:@selector(teaPotTimerActionMethod) userInfo:nil repeats:YES];
    [teaPotTimer fire];
}

- (void)teaPotTimerActionMethodOld;
{
    if (abs(teaPotTimerClock+teaPotTimerClockChange)>teaPotTimerChangeCurrentMax)
    {
        if (abs(teaPotTimerClock+teaPotTimerClockChange)>abs(teaPotTimerClock))
        {
            teaPotTimerClockChange=-teaPotTimerClockChange;
            teaPotTimerChangeCurrentMax=teaPotTimerChangeCurrentMax-TEAPOT_TIMER_CURRENT_MAX_DIFF;
            if (teaPotTimerChangeCurrentMax<0) teaPotTimerChangeCurrentMax=0;
        }
    }
    teaPotTimerClock=teaPotTimerClock+teaPotTimerClockChange;
    CGAffineTransform newTransform=CGAffineTransformMakeRotation(1.00*teaPotTimerClock/180*M_2_PI);
    [teaPotImageView setTransform:newTransform];
    if ((teaPotTimerChangeCurrentMax==0)&(teaPotTimerClock==0))
    {
        [teaPotControl setUserInteractionEnabled:true];
        [teaPotTimer invalidate];
        teaPotTimerClockChange=0;
    }
}

-(void)teaPotTimerActionMethod;
{
    if (isTeaPotRockingClockwise)
    {
        if (teaPotTimerClock<(teaPotTimerClockMax+teaPotTimerClockMin)/2)
        {
            teaPotTimerClockChange=teaPotTimerClockChange*TEAPOT_ROTATION_INCREMENT;
        } else
        {
            teaPotTimerClockChange=teaPotTimerClockChange/TEAPOT_ROTATION_INCREMENT;
        }
    } else {
        if (teaPotTimerClock<(teaPotTimerClockMax+teaPotTimerClockMin)/2)
        {
            teaPotTimerClockChange=teaPotTimerClockChange/TEAPOT_ROTATION_INCREMENT;
        } else
        {
            teaPotTimerClockChange=teaPotTimerClockChange*TEAPOT_ROTATION_INCREMENT;
        }
    }
    
    if (teaPotTimerClock>teaPotTimerClockMax)
    {
        teaPotTimerClockChange=-TEAPOT_ROTATION_STEP;
        isTeaPotRockingClockwise=!isTeaPotRockingClockwise;
        teaPotTimerClock=teaPotTimerClockMax;
        teaPotTimerClockMin=-(teaPotTimerClockMax-TEAPOT_ROTATION_DECREMENT_PER_ROUND);
        if (teaPotTimerClockMin>0)
        {
            teaPotTimerClockMin=0;
        }
    }
    
    if (teaPotTimerClock<teaPotTimerClockMin)
    {
        teaPotTimerClockChange=TEAPOT_ROTATION_STEP;
        isTeaPotRockingClockwise=!isTeaPotRockingClockwise;
        teaPotTimerClock=teaPotTimerClockMin;
        teaPotTimerClockMax=-(teaPotTimerClockMin+TEAPOT_ROTATION_DECREMENT_PER_ROUND);
        if (teaPotTimerClockMax<0)
        {
            teaPotTimerClockMax=0;
        }
    }
    
    if ((teaPotTimerClockMax==0)&(teaPotTimerClockMin==0))
    {
        [teaPotControl setUserInteractionEnabled:true];
        teaPotTimerClock=0;
        [teaPotTimer invalidate];
    }
    
    teaPotTimerClock=teaPotTimerClock+teaPotTimerClockChange;
    
    CGAffineTransform newTransform=CGAffineTransformMakeRotation( teaPotTimerClock*M_PI/180);
    [teaPotImageView setTransform:newTransform];
    
}

-(IBAction)teaPotTouched:(id)sender;
{
    [teaPotControl setUserInteractionEnabled:false];
    teaPotTimerClock=0;
    teaPotTimerClockChange=TEAPOT_ROTATION_STEP;
    teaPotTimerClockMin=0;
    teaPotTimerClockMax=TEAPOT_MAX_ROTATION;
    isTeaPotRockingClockwise=true;
    teaPotTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(teaPotTimerActionMethod) userInfo:nil repeats:YES];
	[teaPotTimer fire];

    [self startSFXTeapot];
}

- (void)fatherTimerActionMethod;
{
    fatherTimerClock=fatherTimerClock+fatherTimerClockChange;
    if (isFatherRotationClockwise)
    {
        if (fatherTimerClock<FATHER_TIMER_CLOCK_MAX/2)
        {
            fatherTimerClockChange=fatherTimerClockChange*FATHER_TIMER_CLOCK_CHANGE_INCREMENT;
        } else
        {
            fatherTimerClockChange=fatherTimerClockChange/FATHER_TIMER_CLOCK_CHANGE_INCREMENT;
        }
    } else
    {
        if (fatherTimerClock<FATHER_TIMER_CLOCK_MAX/2)
        {
            fatherTimerClockChange=fatherTimerClockChange/FATHER_TIMER_CLOCK_CHANGE_INCREMENT;
        } else
        {
            fatherTimerClockChange=fatherTimerClockChange*FATHER_TIMER_CLOCK_CHANGE_INCREMENT;
        }
    }
    if (fatherTimerClock>=FATHER_TIMER_CLOCK_MAX)
    {
        isFatherRotationClockwise=false;
        fatherTimerClockChange=-fatherTimerClockChange;
    }
    
    CGAffineTransform newTransform=CGAffineTransformMakeRotation(-1.00*fatherTimerClock/180*M_2_PI);
    [fatherImageView setTransform:newTransform];
    if ((fatherTimerClock<=0)&(!isFatherRotationClockwise))
    {
        [fatherTimer invalidate];
        [fatherControl setUserInteractionEnabled:true];
    }
}

-(void)startPhase03;
{
    night02Timer = [NSTimer scheduledTimerWithTimeInterval:NIGHT_02_TIMER_FREQUENCY target:self selector:@selector(night02TimerActionMethod) userInfo:nil repeats:YES];
//    [night02Timer fire];
    [fatherControl setUserInteractionEnabled:true];
    [teaPotControl setUserInteractionEnabled:true];
    
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

#pragma mark - View lifecycle

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

- (void)viewDidDisappear:(BOOL)animated;
{
    [self stopMusicAndSfx];
    [self stopNarration];

    backgroundMusic.delegate=nil;
    sfxFather.delegate = nil;
    sfxHouse.delegate = nil;
    sfxTeaPot.delegate = nil;
    narration.delegate =nil;

    backgroundMusic = nil;
    sfxFather = nil;
    sfxHouse = nil;
    sfxTeaPot = nil;
    narration = nil;
    
    phase01Timer=nil;
    phase02Timer=nil;
    night02Timer=nil;
    teaPotTimer=nil;
    fatherTimer=nil;
    
    [riceFieldBaseImageView removeFromSuperview];
    [windowImageView removeFromSuperview];
    [bedImageView removeFromSuperview];
    [baseImageView removeFromSuperview];
    [fatherImageView removeFromSuperview];
    [night1ImageView removeFromSuperview];
    [night2ImageView removeFromSuperview];
    [teaPotImageView removeFromSuperview];
    [frameImageView removeFromSuperview];
    [fireImageView removeFromSuperview];
    [transitionToPhase02ImageView removeFromSuperview];
    [riceFieldBaseImageView removeFromSuperview];
    [phase01View removeFromSuperview];
    [phase02View removeFromSuperview];
    [bedImageView removeFromSuperview];
    [baseImageView removeFromSuperview];
    [fatherImageView removeFromSuperview];
    [night1ImageView removeFromSuperview];
    [night2ImageView removeFromSuperview];
    [teaPotImageView removeFromSuperview];
    [frameImageView removeFromSuperview];
    [fireImageView removeFromSuperview];
    [transitionToPhase02ImageView removeFromSuperview];
    [fatherControl removeFromSuperview];
    [teaPotControl removeFromSuperview];
    [hintLayerImageView removeFromSuperview];

    riceFieldBaseImageView.image=nil;
    windowImageView.image=nil;
    bedImageView.image=nil;
    baseImageView.image=nil;
    fatherImageView.image=nil;
    night1ImageView.image=nil;
    night2ImageView.image=nil;
    teaPotImageView.image=nil;
    frameImageView.image=nil;
    fireImageView.image=nil;
    transitionToPhase02ImageView.image=nil;
    riceFieldBaseImageView=nil;
    phase01View=nil;
    phase02View=nil;
    bedImageView=nil;
    baseImageView=nil;
    fatherImageView=nil;
    night1ImageView=nil;
    night2ImageView=nil;
    teaPotImageView=nil;
    frameImageView=nil;
    fireImageView=nil;
    transitionToPhase02ImageView=nil;
    fatherControl=nil;
    teaPotControl=nil;
    hintLayerImageView=nil;

    [self.view removeFromSuperview];
    self.view=nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    phase01TimerClock=0;
    phase02TimerClock=0;
    teaPotTimerClockChange=0;
    
    [self startBackgroundMusic1st];
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
