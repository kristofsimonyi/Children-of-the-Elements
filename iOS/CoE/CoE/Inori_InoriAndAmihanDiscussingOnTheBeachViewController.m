//
//  Inori_InoriAndAmihanDiscussingOnTheBeachViewController.m
//  CoE
//
//  Created by Ferenc INKOVICS on 02/03/14.
//  Copyright (c) 2014 No company - private person. All rights reserved.
//
#define WAVE1_ORIG_CENTER                               512,430 //512,384
#define WAVING_MAX_Y                                    75
#define WAVING_ROTATION_STEP                            0.05
#define WAVING_ROTATION_INCREMENT                       1.03
#define WAVING_SHIFT_BETWEEN_WAVES                      4 //that means 1/4 of the WAVING_MAX_Y

#import "Inori_InoriAndAmihanDiscussingOnTheBeachViewController.h"
#import "ViewController.h"

#define HINT_TIME                                       1.0

@interface Inori_InoriAndAmihanDiscussingOnTheBeachViewController ()

@end

@implementation Inori_InoriAndAmihanDiscussingOnTheBeachViewController

@synthesize hintLayerImageView, backgroundImageView, menuImageView, wavesImagevView, wave1ImageView, wave2ImageView;

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

-(void)viewDidDisappear:(BOOL)animated;
{
    [wavingTimer invalidate];
    
    wavingTimer=nil;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self loadImages];
    
    [self startWaving];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
