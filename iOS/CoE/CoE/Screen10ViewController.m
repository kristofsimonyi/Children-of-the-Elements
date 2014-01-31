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

#import "Screen10ViewController.h"
#import <CoreImage/CoreImage.h>
#import "ViewController.h"

@interface Screen10ViewController ()

@end

@implementation Screen10ViewController

@synthesize compassControl, Screen10BackgroundImageView, Screen10DuneImageView, Screen10Wave01ImageView, Screen10Wave02ImageView, Screen10Wave03ImageView, Screen10Wave04ImageView, Screen10BigShipImageView, Screen10SmallShipImageView, Screen10CloudImageView, Screen10InoriImageView;

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
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController=0;
    viewContoller = nil;
    
    [self goToNextScreen];
}

- (void)screen10NextScreenButtonTouched;
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController++;
    viewContoller = nil;
    
    [self goToNextScreen];
}

- (void)screen10PreviousScreenButtonTouched;
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController--;
    viewContoller = nil;
    
    [self goToNextScreen];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    
}

- (void) Screen10ItIsWavingAction;
{
    CGFloat f;
    if ((Screen10Wave01ImageView.alpha<1.0)&&(Screen10Wave01ImageView.center.y>WAVE_1_APPEAR_CENTER_Y))
    {
        [Screen10Wave01ImageView setAlpha:Screen10Wave01ImageView.alpha+0.05];
    }
    if ((Screen10Wave01ImageView.alpha>0.0)&&(Screen10Wave01ImageView.center.y> WAVE_1_DISAPPEAR_CENTER_Y))
    {
        f=Screen10Wave01ImageView.alpha;
        f=f-0.1;
        [Screen10Wave01ImageView setAlpha:f];
    }
    [Screen10Wave01ImageView setCenter:CGPointMake(Screen10Wave01ImageView.center.x, Screen10Wave01ImageView.center.y+1)];
    if (Screen10Wave01ImageView.center.y>WAVE_1_STOP_CENTER_Y)
    {
        [Screen10Wave01ImageView setCenter:CGPointMake(Screen10Wave01ImageView.center.x, WAVE_1_START_CENTER_Y)];
    }
    
    
    if ((Screen10Wave02ImageView.alpha<1.0)&&(Screen10Wave02ImageView.center.y>WAVE_2_APPEAR_CENTER_Y))
    {
        [Screen10Wave02ImageView setAlpha:Screen10Wave02ImageView.alpha+0.05];
    }
    if ((Screen10Wave02ImageView.alpha>0.0)&&(Screen10Wave02ImageView.center.y> WAVE_2_DISAPPEAR_CENTER_Y))
    {
        f=Screen10Wave02ImageView.alpha;
        f=f-0.1;
        [Screen10Wave02ImageView setAlpha:f];
    }
    [Screen10Wave02ImageView setCenter:CGPointMake(Screen10Wave02ImageView.center.x, Screen10Wave02ImageView.center.y+1)];
    if (Screen10Wave02ImageView.center.y>WAVE_2_STOP_CENTER_Y)
    {
        [Screen10Wave02ImageView setCenter:CGPointMake(Screen10Wave02ImageView.center.x, WAVE_2_START_CENTER_Y)];
    }
    
    
    if ((Screen10Wave03ImageView.alpha<1.0)&&(Screen10Wave03ImageView.center.y>WAVE_3_APPEAR_CENTER_Y))
    {
        [Screen10Wave03ImageView setAlpha:Screen10Wave03ImageView.alpha+0.05];
    }
    if ((Screen10Wave03ImageView.alpha>0.0)&&(Screen10Wave03ImageView.center.y> WAVE_3_DISAPPEAR_CENTER_Y))
    {
        f=Screen10Wave03ImageView.alpha;
        f=f-0.1;
        [Screen10Wave03ImageView setAlpha:f];
        ;
    }
    [Screen10Wave03ImageView setCenter:CGPointMake(Screen10Wave03ImageView.center.x, Screen10Wave03ImageView.center.y+1)];
    if (Screen10Wave03ImageView.center.y>WAVE_3_STOP_CENTER_Y)
    {
        [Screen10Wave03ImageView setCenter:CGPointMake(Screen10Wave03ImageView.center.x, WAVE_3_START_CENTER_Y)];
    }
    
    
    if ((Screen10Wave04ImageView.alpha<1.0)&&(Screen10Wave04ImageView.center.y>WAVE_4_APPEAR_CENTER_Y))
    {
        [Screen10Wave04ImageView setAlpha:Screen10Wave04ImageView.alpha+0.05];
    }
    if ((Screen10Wave04ImageView.alpha>0.0)&&(Screen10Wave04ImageView.center.y> WAVE_4_DISAPPEAR_CENTER_Y))
    {
        f=Screen10Wave04ImageView.alpha;
        f=f-0.1;
        [Screen10Wave04ImageView setAlpha:f];
    }
    [Screen10Wave04ImageView setCenter:CGPointMake(Screen10Wave04ImageView.center.x, Screen10Wave04ImageView.center.y+1)];
    if (Screen10Wave04ImageView.center.y>WAVE_4_STOP_CENTER_Y)
    {
        [Screen10Wave04ImageView setCenter:CGPointMake(Screen10Wave04ImageView.center.x, WAVE_4_START_CENTER_Y)];
    }
    
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImage *newImage;
    
    newImage=[self adjustImage:Screen10BackgroundImageView.image saturation:BACKGROUND_DESATURIZATION brightness:BACKGROUND_BRIGHTNESS contrast:BACKGROUND_CONTRAST];
    Screen10BackgroundImageView.image=newImage;

    newImage=[self adjustImage:Screen10DuneImageView.image saturation:DUNE_DESATURIZATION brightness:DUNE_BRIGHTNESS contrast:DUNE_CONTRAST];
    Screen10DuneImageView.image=newImage;
    
    newImage=[self adjustImage:Screen10Wave01ImageView.image saturation:WAVE01_DESATURIZATION brightness:WAVE01_BRIGHTNESS contrast:WAVE01_CONTRAST];
    Screen10Wave01ImageView.image=newImage;
    
    newImage=[self adjustImage:Screen10Wave02ImageView.image saturation:WAVE02_DESATURIZATION brightness:WAVE02_BRIGHTNESS contrast: WAVE02_CONTRAST];
    Screen10Wave02ImageView.image=newImage;
    
    newImage=[self adjustImage:Screen10Wave03ImageView.image saturation:WAVE03_DESATURIZATION brightness:WAVE03_BRIGHTNESS contrast:WAVE03_CONTRAST];
    Screen10Wave03ImageView.image=newImage;
    
    newImage=[self adjustImage:Screen10Wave04ImageView.image saturation:WAVE04_DESATURIZATION brightness:WAVE04_BRIGHTNESS contrast:WAVE04_CONTRAST];
    Screen10Wave04ImageView.image=newImage;
    
    newImage=[self adjustImage:Screen10SmallShipImageView.image saturation:SMALL_SHIP_DESATURIZATION brightness:SMALL_SHIP_BRIGHTNESS contrast:SMALL_SHIP_CONTRAST];
    Screen10SmallShipImageView.image=newImage;
    
    newImage=[self adjustImage:Screen10BigShipImageView.image saturation:BIG_SHIP_DESATURIZATION brightness:BIG_SHIP_BRIGHTNESS contrast:BIG_SHIP_CONTRAST];;
    Screen10BigShipImageView.image=newImage;
    
    newImage=[self adjustImage:Screen10InoriImageView.image saturation:INORI_DESATURIZATION brightness:INORI_BRIGHTNESS contrast:INORI_CONTRAST];
    Screen10InoriImageView.image=newImage;
        
    itIsWavingTimer = [NSTimer scheduledTimerWithTimeInterval:WAVE_TIMER_PERIOD target:self selector:@selector(Screen10ItIsWavingAction) userInfo:nil repeats:YES];
    itIsWavingClock=0;
	[itIsWavingTimer fire];
    
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
    
    [self startCloud];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
