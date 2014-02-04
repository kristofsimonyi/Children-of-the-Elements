//
//  Screen10ViewController.m
//  KickOff
//
//  Created by Ferenc INKOVICS on 19/01/2013.
//  Copyright (c) 2013 No company - private person. All rights reserved.
//
/*
 http://stackoverflow.com/questions/1144768/how-can-i-change-the-saturation-of-an-uiimage

// Adding Saturation and Contrast to an UIImage using Core Image Filters
 http://iosnotes.com/?p=41
 https://developer.apple.com/library/mac/#documentation/graphicsimaging/reference/CoreImageFilterReference/Reference/reference.html
 */

#define BACKGROUND_DESATURIZATION       1.0//0.0
#define BACKGROUND_BRIGHTNESS           0.0//-0.2
#define BACKGROUND_CONTRAST             0.5//1.0

#define DUNE_DESATURIZATION             0.5//0.0
#define DUNE_BRIGHTNESS                 -0.2//-0.2
#define DUNE_CONTRAST                   0.6//1.0

#define WAVE01_DESATURIZATION           -0.0//0.0
#define WAVE01_BRIGHTNESS               -0.3//-0.2
#define WAVE01_CONTRAST                 0.4//1.0

#define WAVE02_DESATURIZATION           -0.0//0.0
#define WAVE02_BRIGHTNESS               -0.3//-0.2
#define WAVE02_CONTRAST                 0.4//1.0

#define WAVE03_DESATURIZATION           -0.0//0.0
#define WAVE03_BRIGHTNESS               -0.3//-0.2
#define WAVE03_CONTRAST                 0.4//1.0

#define WAVE04_DESATURIZATION           -0.0//0.0
#define WAVE04_BRIGHTNESS               -0.3//-0.2
#define WAVE04_CONTRAST                 0.4//1.0

#define SMALL_SHIP_DESATURIZATION       0.3//0.3
#define SMALL_SHIP_BRIGHTNESS           -0.2//-0.2
#define SMALL_SHIP_CONTRAST             0.6//1.0

#define BIG_SHIP_DESATURIZATION         0.9//0.3
#define BIG_SHIP_BRIGHTNESS             -0.0//-0.2
#define BIG_SHIP_CONTRAST               1.0//1.0

#define INORI_DESATURIZATION            1.0//1.0
#define INORI_BRIGHTNESS                0.0//0.0
#define INORI_CONTRAST                  1.0//1.0

#define SMALL_SHIP_ROTATE_LEFT          -500
#define SMALL_SHIP_ROTATE_RIGHT         500

#define BIG_SHIP_ROTATE_LEFT            -250
#define BIG_SHIP_ROTATE_RIGHT           250

#define SMALL_SHIP_ROTATE_SHIFT         25
#define BIG_SHIP_ROTATE_SHIFT           10

#define WAVE_TIMER_PERIOD          0.08

#define WAVE_1_START_CENTER_Y      300
#define WAVE_1_APPEAR_CENTER_Y     400
#define WAVE_1_DISAPPEAR_CENTER_Y  500
#define WAVE_1_STOP_CENTER_Y       550

#define WAVE_2_START_CENTER_Y      300
#define WAVE_2_APPEAR_CENTER_Y     430
#define WAVE_2_DISAPPEAR_CENTER_Y  650
#define WAVE_2_STOP_CENTER_Y       700

#define WAVE_3_START_CENTER_Y      100
#define WAVE_3_APPEAR_CENTER_Y     230
#define WAVE_3_DISAPPEAR_CENTER_Y  450
#define WAVE_3_STOP_CENTER_Y       500

#define WAVE_4_START_CENTER_Y      300
#define WAVE_4_APPEAR_CENTER_Y     400
#define WAVE_4_DISAPPEAR_CENTER_Y  600
#define WAVE_4_STOP_CENTER_Y       650

#define CLOUD_TIME_INTERVAL      0.03
#define CLOUD_START_CENTER       -1512,200
#define CLOUD_STOP_X             2536  //cloud went out from the screen
#define CLOUD_STOP_X2            (CLOUD_STOP_X+(8/CLOUD_TIME_INTERVAL))  //wait about 8 seconds

#define CLOUD_SHIFT_MAX             4.00//for 6 sec moving speed
#define CLOUD_SHIFT_MIN             2.00//for 10 sec moving speed

#import "StaticScreenViewController.h"
#import <CoreImage/CoreImage.h>
#import "ViewController.h"

@interface StaticScreenViewController ()

@end

@implementation StaticScreenViewController

@synthesize compassControl, Screen10BackgroundImageView, Screen10DuneImageView, Screen10BigShipImageView, Screen10SmallShipImageView, Screen10CloudImageView, Screen10InoriImageView, staticTextView, Screen10MenuImageView;

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

- (void)screen10BackToMainMenu;
{
    /*
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController=0;
    viewContoller = nil;
    
    [self goToNextScreen];
     */
}

- (IBAction)screen10NextScreenButtonTouched:(id)sender;
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController++;
    viewContoller = nil;
    
    [self goToNextScreen];
}

- (IBAction)screen10PreviousScreenButtonTouched:(id)sender;
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    if (viewContoller.nextViewController>101)
    {
        viewContoller.nextViewController--;
        
        [self goToNextScreen];
    }
    viewContoller = nil;
}

- (void) setSmallShipRockingState;
{
    CGAffineTransform newTransform = CGAffineTransformRotate(smallShipOriginalTransform,1.00*smallShipRockingClock/18000.00*M_PI);
    [Screen10SmallShipImageView setTransform:newTransform];
}

- (void) setBigShipRockingState;
{
    CGAffineTransform newTransform = CGAffineTransformRotate(bigShipOriginalTransform,1.00*bigShipRockingClock/18000.00*M_PI);
    [Screen10BigShipImageView setTransform:newTransform];
}

-(void)startCloud;
{
    [Screen10CloudImageView setCenter:CGPointMake(CLOUD_START_CENTER)];
    cloudMovingTimerClock=Screen10CloudImageView.center.x;
    cloudMovingTimer = [NSTimer scheduledTimerWithTimeInterval:CLOUD_TIME_INTERVAL target:self selector:@selector(Screen10CloudMovingAction) userInfo:nil repeats:YES];
    int rndShift=roundf((CLOUD_SHIFT_MAX-CLOUD_SHIFT_MIN)*1000)+1;
    cloudMovingTimerClockChange=CLOUD_SHIFT_MIN+(arc4random()%rndShift)/1000;
    [cloudMovingTimer fire];
}

-(void) Screen10CloudMovingAction;
{
    cloudMovingTimerClock=cloudMovingTimerClock+cloudMovingTimerClockChange;
    [Screen10CloudImageView setCenter:CGPointMake(cloudMovingTimerClock,Screen10CloudImageView.center.y )];
    if (cloudMovingTimerClock>CLOUD_STOP_X) {
        cloudMovingTimerClockChange=1;
    }
    if (cloudMovingTimerClock>CLOUD_STOP_X2) {
        [Screen10CloudImageView setCenter:CGPointMake(CLOUD_START_CENTER)];
        cloudMovingTimerClock=Screen10CloudImageView.center.x;
        int rndShift=roundf((CLOUD_SHIFT_MAX-CLOUD_SHIFT_MIN)*1000)+1;
        cloudMovingTimerClockChange=CLOUD_SHIFT_MIN+(arc4random()%rndShift)/1000;
        CGAffineTransform newTransform=CGAffineTransformRotate([Screen10CloudImageView transform], M_PI);
        [Screen10CloudImageView setTransform:newTransform];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
{
	NSUInteger touchCount = 0;
	for (UITouch *touch in touches)
	{
		CGPoint translatedPoint = [touch locationInView:self.view];
        
        if (CGRectContainsPoint(compassControl.frame, translatedPoint))
        {
            [self screen10BackToMainMenu];
        }
        touchCount++;
    }
}

- (UIImage*)adjustImage:(UIImage *)sourceImage saturation:(CGFloat)saturationAmount brightness:(CGFloat) brightnessAmount contrast:(CGFloat) contrastAmount;
{
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CIFilter *filter= [CIFilter filterWithName:@"CIColorControls"];
    
    CIImage *inputImage = [[CIImage alloc] initWithImage:sourceImage];
    
    [filter setValue:inputImage forKey:@"inputImage"];
    
    [filter setValue:[NSNumber numberWithFloat:saturationAmount] forKey:@"inputSaturation"];
    
    [filter setValue:[NSNumber numberWithFloat:brightnessAmount] forKey:@"inputBrightness"];
    
    [filter setValue:[NSNumber numberWithFloat:contrastAmount] forKey:@"inputContrast"];
    
    UIImage *image = [UIImage imageWithCGImage:[context createCGImage:filter.outputImage fromRect:filter.outputImage.extent]];
    
    context = nil;
    filter = nil;
    inputImage = nil;

    return image;
    image = nil;
    
}

- (void) Screen10SmallShipRockingAction;
{
    smallShipRockingClock=smallShipRockingClock+smallShipRockingClockChange;
    if ((smallShipRockingClock < SMALL_SHIP_ROTATE_LEFT)||(smallShipRockingClock > SMALL_SHIP_ROTATE_RIGHT)) {
        smallShipRockingClockChange=-smallShipRockingClockChange;
    }
    [self setSmallShipRockingState];
}

- (void) Screen10BigShipRockingAction;
{
    bigShipRockingClock=bigShipRockingClock+bigShipRockingClockChange;
    if ((bigShipRockingClock < BIG_SHIP_ROTATE_LEFT)||(bigShipRockingClock > BIG_SHIP_ROTATE_RIGHT)) {
        bigShipRockingClockChange=-bigShipRockingClockChange;
    }
    [self setBigShipRockingState];
}

- (void)loadStaticText;
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    NSString *screenName = [NSString stringWithFormat:@"%i:", viewContoller.nextViewController ];
    viewContoller = nil;
    
    //name the file to read
    NSString* aPath = [[NSBundle mainBundle] pathForResource:@"StaticScreenTexts" ofType:@"txt"];
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
    
    NSString *newText = nil;
    i++;
    while ((i!=[lines count])&&(![[lines objectAtIndex:i] isEqual:@"***"]))
    {
        if (newText==nil)
        {
            newText=[NSString stringWithFormat:@"%@",[lines objectAtIndex:i]];
        }
        else
        {
            newText=[NSString stringWithFormat:@"%@\n%@",newText, [lines objectAtIndex:i]];
        }
        i++;
    }
    
    lines=nil;
    [staticTextView setText:newText];
    [staticTextView setFont:[UIFont systemFontOfSize:20]];
}

-(void)setImageEffects;
{
    UIImage *newImage;
    
    newImage=[self adjustImage:Screen10BackgroundImageView.image saturation:BACKGROUND_DESATURIZATION brightness:BACKGROUND_BRIGHTNESS contrast:BACKGROUND_CONTRAST];
    Screen10BackgroundImageView.image=newImage;
    newImage=nil;
    //    newImage=[self adjustImage:nil saturation:DUNE_DESATURIZATION brightness:DUNE_BRIGHTNESS contrast:DUNE_CONTRAST];
    
    newImage=[self adjustImage:Screen10DuneImageView.image saturation:DUNE_DESATURIZATION brightness:DUNE_BRIGHTNESS contrast:DUNE_CONTRAST];
    Screen10DuneImageView.image=newImage;
    newImage=nil;
    
    newImage=[self adjustImage:Screen10SmallShipImageView.image saturation:SMALL_SHIP_DESATURIZATION brightness:SMALL_SHIP_BRIGHTNESS contrast:SMALL_SHIP_CONTRAST];
    Screen10SmallShipImageView.image=newImage;
    newImage=nil;
    
    newImage=[self adjustImage:Screen10BigShipImageView.image saturation:BIG_SHIP_DESATURIZATION brightness:BIG_SHIP_BRIGHTNESS contrast:BIG_SHIP_CONTRAST];;
    Screen10BigShipImageView.image=newImage;
    newImage=nil;
    
    newImage=[self adjustImage:Screen10InoriImageView.image saturation:INORI_DESATURIZATION brightness:INORI_BRIGHTNESS contrast:INORI_CONTRAST];
    Screen10InoriImageView.image=newImage;
    newImage=nil;
}

-(void)setSettingsForShipRocking;
{
    smallShipOriginalTransform = [Screen10SmallShipImageView transform];
    smallShipRockingTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(Screen10SmallShipRockingAction) userInfo:nil repeats:YES];
    smallShipRockingClock=0;
    smallShipRockingClockChange=SMALL_SHIP_ROTATE_SHIFT;
	[smallShipRockingTimer fire];
    
    bigShipOriginalTransform = [Screen10BigShipImageView transform];
    bigShipRockingTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(Screen10BigShipRockingAction) userInfo:nil repeats:YES];
    bigShipRockingClock=0;
    bigShipRockingClockChange=BIG_SHIP_ROTATE_SHIFT;
	[bigShipRockingTimer fire];
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

- (IBAction)screen10MusicButtonTouched:(id)sender;
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    if (viewContoller.musicIsOn)
    {
        [narration setVolume:0.0];
        
        viewContoller.musicIsOn=FALSE;
    }
    else
    {
        [narration setVolume:1.0];
        
        viewContoller.musicIsOn=TRUE;
    }
    viewContoller = nil;
}

- (IBAction)screen10NarrationButtonTouched:(id)sender;
{
    if ([narration isPlaying])
    {
        [self stopNarration];
    } else {
        [self startNarration];
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag;
{
    if (player==narration)
    {
        if (flag)
        {
            Screen10MenuImageView.image=nil;
            [Screen10MenuImageView setImage:[UIImage imageNamed:@"menu_set-top-g.png"]];
        }
    }
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
    } else {
        return FALSE;
    }
}

-(void) viewDidDisappear:(BOOL)animated;
{
    [self stopNarration];
    narration=nil;
    
    [bigShipRockingTimer invalidate];
    [smallShipRockingTimer invalidate];
    [cloudMovingTimer invalidate];
    bigShipRockingTimer=nil;
    smallShipRockingTimer=nil;
    cloudMovingTimer=nil;
    
    [Screen10MenuImageView removeFromSuperview];
    [compassControl removeFromSuperview];
    [Screen10BackgroundImageView removeFromSuperview];
    [Screen10DuneImageView removeFromSuperview];
    [Screen10SmallShipImageView removeFromSuperview];
    [Screen10BigShipImageView removeFromSuperview];
    [Screen10CloudImageView removeFromSuperview];
    [Screen10InoriImageView removeFromSuperview];
    [staticTextView removeFromSuperview];

    Screen10MenuImageView.image=nil;
    Screen10MenuImageView.image=nil;
    Screen10BackgroundImageView.image=nil;
    Screen10DuneImageView.image=nil;
    Screen10SmallShipImageView.image=nil;
    Screen10BigShipImageView.image=nil;
    Screen10CloudImageView.image=nil;
    Screen10InoriImageView.image=nil;
    Screen10BackgroundImageView=nil;
    Screen10DuneImageView=nil;
    Screen10SmallShipImageView=nil;
    Screen10BigShipImageView=nil;
    Screen10CloudImageView=nil;
    Screen10InoriImageView=nil;
    staticTextView=nil;
    
    [self.view removeFromSuperview];
    self.view=nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [self setImageEffects];
    
    [self setSettingsForShipRocking];

    [self startCloud];
    
    [self loadStaticText];
    
    [self startNarration];
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
