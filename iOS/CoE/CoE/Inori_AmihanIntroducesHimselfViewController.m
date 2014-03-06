//
//  Inori_AmihanIntroducesHimselfViewController.m
//  CoE
//
//  Created by Ferenc INKOVICS on 02/03/14.
//  Copyright (c) 2014 No company - private person. All rights reserved.
//
#define HINT_TIME                                       1.0

#define CLOUD_FLOATING_SHIFT                            25
#define CLOUD_FLOAT_LEFT                                -500
#define CLOUD_FLOAT_RIGHT                               500

#define WAVE1_ORIG_CENTER                               512,384 //512,384
#define CLOUD_NEW_CENTER                                1200,384
#define AMIHAN_NEW_CENTER                               1024,-100
#define WAVING_MAX_Y                                    75
#define WAVING_ROTATION_STEP                            0.05
#define WAVING_ROTATION_INCREMENT                       1.03
#define WAVING_SHIFT_BETWEEN_WAVES                      4 //that means 1/4 of the WAVING_MAX_Y

#define BACKGROUND_TRANSITION_TIME                      3.0

#define AMIHAN_ROTATE_LEFT                              -500
#define AMIHAN_ROTATE_RIGHT                             500
#define AMIHAN_ROTATE_SHIFT                             25

#import "Inori_AmihanIntroducesHimselfViewController.h"
#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface Inori_AmihanIntroducesHimselfViewController ()

@end

@implementation Inori_AmihanIntroducesHimselfViewController

@synthesize backgroundImageView, backgroundImageView2, hintLayerImageView, menuImageView, cloudImageView, wave1ImageView, wave2ImageView, wavesImagevView, cloudControl, inoriSittingImageView, inoriStandingImageView, amihanImageView, sand2ImageView, sandImageView;

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
    if ([narration isPlaying]||[narration2 isPlaying])
    {
        [self stopNarration];
        narrationToPlay=1;
    } else {
        [self startNarration];
    }
}

- (IBAction)musicButtonTapped:(UITapGestureRecognizer *) sender;
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    if (viewContoller.musicIsOn)
    {
        [backgroundMusic setVolume:0.0];
        [sfxInoriPrays setVolume:0.0];
        [narration setVolume:0.0];
        [narration2 setVolume:0.0];
        
        viewContoller.musicIsOn=FALSE;
    }
    else
    {
        [backgroundMusic setVolume:1.0];
        [sfxInoriPrays setVolume:1.0];
        [narration setVolume:1.0];
        [narration2 setVolume:1.0];
        
        viewContoller.musicIsOn=TRUE;
    }
    viewContoller = nil;
}

- (IBAction)inoriTapped:(UITapGestureRecognizer *) sender;
{
    sfxInoriPrays=[self startsfx:sfxInoriPrays named:@"007_sound-of-prayer"];
}

- (IBAction)cloudTapped:(UITapGestureRecognizer *) sender;
{
    sfxWind=[self startsfx:sfxWind named:@"008_wind"];
    
    sfxDistantCry=[self startsfx:sfxDistantCry named:@"007_Laughing woohooo"];

    sfxMiraculous=[self startsfx:sfxMiraculous named:@"007_miraculous happens"];

    [UIView animateWithDuration:BACKGROUND_TRANSITION_TIME animations:^{
        [backgroundImageView setAlpha:0];
        [backgroundImageView2 setAlpha:1.0];

        [cloudImageView setCenter:CGPointMake(CLOUD_NEW_CENTER)];
        
        [inoriSittingImageView setAlpha:0];
        [inoriStandingImageView setAlpha:1.0];

        [amihanImageView setCenter:CGPointMake(AMIHAN_NEW_CENTER)];
        
    }];
    
    [cloudControl setEnabled:false];
    
    [self startAmihanRocking];
}

- (void) setAmihanRockingState;
{
    CGAffineTransform newTransform = CGAffineTransformRotate(amihanHangOriginalTransform,(1.00*amihanRockingClock/18000.00*M_PI));
    [amihanImageView setTransform:newTransform];
}

-(void)amihanRockingAction;
{
    amihanRockingClock=amihanRockingClock+amihanRockingClockChange;
    if ((amihanRockingClock < AMIHAN_ROTATE_LEFT)||(amihanRockingClock > AMIHAN_ROTATE_RIGHT)) {
        amihanRockingClockChange=-amihanRockingClockChange;
    }
    [self setAmihanRockingState];
}

-(void)startAmihanRocking;
{
    amihanHangOriginalTransform=[amihanImageView transform];

    amihanImageView.layer.anchorPoint = CGPointMake(1.0, -0.2);
    
    amihanRockingClock=0;
    amihanRockingTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(amihanRockingAction) userInfo:nil repeats:YES];
    amihanRockingClockChange=AMIHAN_ROTATE_SHIFT;
    [amihanRockingTimer fire];
}

-(void)startBackgroundMusic;
{
    //set the Music then start playing
	NSString *backgroundMusicPath = [[NSBundle mainBundle] pathForResource:@"006_melytenger" ofType:@"mp3"];
	backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:backgroundMusicPath] error:NULL];
	backgroundMusic.delegate = self;
	[backgroundMusic setVolume:1.0];
	[backgroundMusic setNumberOfLoops:-1]; // when the value is negativ, the sound will be played until you call STOP method
    [backgroundMusic play];
    backgroundMusicPath=nil;
}

-(void)startWaving;
{
    wavingClock=0;
    wavingClockChange=WAVING_ROTATION_STEP;
    wavingClockMin=0;
    wavingClockMax=WAVING_MAX_Y;
    isWavingUpward=true;
    
    wavingClock2=0;
    wavingClockChange2=WAVING_ROTATION_STEP;
    wavingClockMin2=0;
    wavingClockMax2=WAVING_MAX_Y;
    isWavingUpward2=true;
    
    while (wavingClock<=WAVING_MAX_Y/WAVING_SHIFT_BETWEEN_WAVES)
    {
        [self wave1Steps];
    }
    
    wavingTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(wavingTimerActionMethod) userInfo:nil repeats:YES];
	[wavingTimer fire];
}

-(void)wavingTimerActionMethod;
{
    [self wave1Steps];
    
    [self wave2Steps];
    
}

-(void) wave1Steps;
{
    if (isWavingUpward)
    {
        if (wavingClock<(wavingClockMax+wavingClockMin)/2)
        {
            wavingClockChange=wavingClockChange*WAVING_ROTATION_INCREMENT;
        } else
        {
            wavingClockChange=wavingClockChange/WAVING_ROTATION_INCREMENT;
        }
    } else {
        if (wavingClock<(wavingClockMax+wavingClockMin)/2)
        {
            wavingClockChange=wavingClockChange/WAVING_ROTATION_INCREMENT;
        } else
        {
            wavingClockChange=wavingClockChange*WAVING_ROTATION_INCREMENT;
        }
    }
    
    if (wavingClock>wavingClockMax)
    {
        wavingClockChange=-WAVING_ROTATION_STEP;
        isWavingUpward=!isWavingUpward;
        wavingClock=wavingClockMax;
    }
    
    if (wavingClock<wavingClockMin)
    {
        wavingClockChange=WAVING_ROTATION_STEP;
        isWavingUpward=!isWavingUpward;
        wavingClock=wavingClockMin;
    }
    
    wavingClock=wavingClock+wavingClockChange;
    
    CGPoint newCenter;
    newCenter=CGPointMake(WAVE1_ORIG_CENTER);
    newCenter.y=newCenter.y-wavingClock+(WAVING_MAX_Y/2);
    [wave1ImageView setCenter:newCenter];
}

-(void) wave2Steps;
{
    if (isWavingUpward2)
    {
        if (wavingClock2<(wavingClockMax2+wavingClockMin2)/2)
        {
            wavingClockChange2=wavingClockChange2*WAVING_ROTATION_INCREMENT;
        } else
        {
            wavingClockChange2=wavingClockChange2/WAVING_ROTATION_INCREMENT;
        }
    } else {
        if (wavingClock2<(wavingClockMax2+wavingClockMin2)/2)
        {
            wavingClockChange2=wavingClockChange2/WAVING_ROTATION_INCREMENT;
        } else
        {
            wavingClockChange2=wavingClockChange2*WAVING_ROTATION_INCREMENT;
        }
    }
    
    if (wavingClock2>wavingClockMax2)
    {
        wavingClockChange2=-WAVING_ROTATION_STEP;
        isWavingUpward2=!isWavingUpward2;
        wavingClock2=wavingClockMax2;
    }
    
    if (wavingClock2<wavingClockMin2)
    {
        wavingClockChange2=WAVING_ROTATION_STEP;
        isWavingUpward2=!isWavingUpward2;
        wavingClock2=wavingClockMin2;
    }
    
    wavingClock2=wavingClock2+wavingClockChange2;
    
    CGPoint newCenter;
    newCenter=CGPointMake(WAVE1_ORIG_CENTER);
    newCenter.y=newCenter.y-wavingClock2+(WAVING_MAX_Y/2);
    [wave2ImageView setCenter:newCenter];
}

-(void)startCloudFloating;
{
    cloudOriginalTransform = [cloudImageView transform];
    cloudFloatingTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(cloudFloatingActionMwethod) userInfo:nil repeats:YES];
    cloudFloatingTimerClock=0;
    cloudFloatingTimerClockChange=CLOUD_FLOATING_SHIFT;
	[cloudFloatingTimer fire];
}

- (void) cloudFloatingActionMwethod;
{
    cloudFloatingTimerClock=cloudFloatingTimerClock+cloudFloatingTimerClockChange;
    if ((cloudFloatingTimerClock < CLOUD_FLOAT_LEFT)||(cloudFloatingTimerClock > CLOUD_FLOAT_RIGHT))
    {
        cloudFloatingTimerClockChange=-cloudFloatingTimerClockChange;
    }
    [self setCloudFloatingState];
}

- (void) setCloudFloatingState;
{
    CGAffineTransform newTransform = CGAffineTransformRotate(cloudOriginalTransform,1.00*cloudFloatingTimerClock/18000.00*M_PI);
    [cloudImageView setTransform:newTransform];
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
        narrationFileExt = [narrationFileExt substringFromIndex:[narrationFileExt rangeOfString:@"."].location+1];
        
        NSString *narrationPath = [[NSBundle mainBundle] pathForResource:narrationFileName ofType:narrationFileExt];
        narration = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:narrationPath] error:NULL];
        narration.delegate = self;
        [narration setNumberOfLoops:0]; // when the value is negativ, the sound will be played until you call STOP method
        
        narrationFileName=nil;
        narrationFileExt=nil;
        narrationPath = nil;
        
        i++;
        if ([lines count] > i+1)
        {
            NSString *string = [lines objectAtIndex:i+1];
            if ([string rangeOfString:@":"].location == NSNotFound)
            {
                NSString *narrationFileName = [lines objectAtIndex:i+1];
                NSString *narrationFileExt = [lines objectAtIndex:i+1];
                narrationFileName = [narrationFileName substringToIndex:[narrationFileName rangeOfString:@"."].location];
                narrationFileExt = [narrationFileExt substringFromIndex:[narrationFileExt rangeOfString:@"."].location+1];
                
                NSString *narrationPath = [[NSBundle mainBundle] pathForResource:narrationFileName ofType:narrationFileExt];
                narration2 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:narrationPath] error:NULL];
                narration2.delegate = self;
                [narration2 setNumberOfLoops:0]; // when the value is negativ, the sound will be played until you call STOP method
                
                narrationFileName=nil;
                narrationFileExt=nil;
                narrationPath = nil;
            }
        }
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
    
    if (narrationToPlay==1)
    {
        [narration play];
    } else {
        [narration stop];
        [narration2 play];
    }
    
    viewContoller = nil;
    viewContoller = nil;
}

- (void)stopNarration;
{
    [narration stop];
    [narration2 stop];
}

- (AVAudioPlayer *)startsfx:(AVAudioPlayer *)audioplayer named:(NSString *)sfxFileName;
{
    //set the SFX then start playing
    if (audioplayer==nil)
    {
        NSString *audiplayerSFXPath = [[NSBundle mainBundle] pathForResource:sfxFileName ofType:@"mp3"];
        audioplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:audiplayerSFXPath] error:NULL];
        audioplayer.delegate = self;
        [audioplayer setNumberOfLoops:0]; // when the value is negativ, the sound will be played until you call STOP method
        
        audiplayerSFXPath= nil;
    }
    
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    if (viewContoller.musicIsOn)
    {
        [audioplayer setVolume:1.0];
    }
    else
    {
        [audioplayer setVolume:0.0];
    }
    
    if (![audioplayer isPlaying])
    {
        [audioplayer play];
    }
    
    viewContoller=nil;
    
    return audioplayer;
}

- (void)loadImages;
{
    NSString* imagePath;
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"hint-7" ofType:@"png"];
    [hintLayerImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"bg-dark" ofType:@"png"];
    [backgroundImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];

    imagePath = [ [ NSBundle mainBundle] pathForResource:@"bg-light" ofType:@"png"];
    [backgroundImageView2 setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"cloud" ofType:@"png"];
    [cloudImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];

    imagePath = [ [ NSBundle mainBundle] pathForResource:@"wave1" ofType:@"png"];
    [wave1ImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"wave2" ofType:@"png"];
    [wave2ImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"wavefront" ofType:@"png"];
    [wavesImagevView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"inori-parton" ofType:@"png"];
    [inoriSittingImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"inori-allo" ofType:@"png"];
    [inoriStandingImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"sand" ofType:@"png"];
    [sandImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"sand2" ofType:@"png"];
    [sand2ImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"amihan-erkezik" ofType:@"png"];
    [amihanImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
}

-(void)viewDidDisappear:(BOOL)animated;
{
    [self stopNarration];
    
    backgroundMusic.delegate=nil;
    sfxWind.delegate=nil;
    sfxInoriPrays.delegate=nil;
    sfxMiraculous.delegate=nil;
    sfxDistantCry.delegate=nil;
    narration.delegate=nil;
    narration2.delegate=nil;
    
    backgroundMusic=nil;
    sfxWind=nil;
    sfxInoriPrays=nil;
    sfxMiraculous=nil;
    sfxDistantCry=nil;
    narration=nil;
    narration2=nil;
    
    [cloudFloatingTimer invalidate];
    [wavingTimer invalidate];
    cloudFloatingTimer=nil;
    wavingTimer=nil;
    
    self.view=nil;
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
    
    [self startCloudFloating];
    
    [self startWaving];
    
    narrationToPlay=1;
    
    [self startBackgroundMusic];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
