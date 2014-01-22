//
//  EViewController.m
//  KickOff
//
//  Created by INKOVICS Ferenc on 04/06/2012.
//  Copyright (c) 2012 No company - private person. All rights reserved.
//

#define ACCELERATOR_UPDATE_FREQUENCY            20.0//20.0
#define ACCELERATOR_FILTER_CUTOFF_FREQUENCY     100.0//100.0

#define CLOUDS_COME_IN_TIME                     3.0//3.0
#define CLOUDS_COME_IN_DELAY_TIME               2.0//2.0
#define CHILDREN_COME_IN_TIME                   6.0//6.0
#define AMIHAN_COME_IN_DELAY_TIME               1.0//1.0
#define AMIHAN_COME_IN_ARC_AID_X                -300//300
#define AMIHAN_COME_IN_ARC_AID_Y                0//0
#define KUSINI_COME_IN_DELAY_TIME               1.0//1.0
#define KUSINI_COME_IN_ARC_AID_X                300//300
#define KUSINI_COME_IN_ARC_AID_Y                0//0
#define TALAMH_COME_IN_DELAY_TIME               1.0//1.0
#define TALAMH_COME_IN_ARC_AID_X                -400//400
#define TALAMH_COME_IN_ARC_AID_Y                0//0
#define ZIEMELU_COME_IN_DELAY_TIME              1.0//1.0
#define ZIEMELU_COME_IN_ARC_AID_X               400//400
#define ZIEMELU_COME_IN_ARC_AID_Y               0//0
#define CHILDREN_FLY_START_SIZE                 2.5//1.0
#define CHILDREN_FLY_FINISH_SIZE                0.25//0.25
#define CHILDREN_FINISH_POINT                   500,370
#define AMIHAN_START_POINT                      1000,1050    //yellow (5:00)
#define KUSINI_START_POINT                      -330,550    //red (9:00)
#define TALAMH_START_POINT                      1250,450    //green (3:30)
#define ZIEMELU_START_POINT                     150,1180    //blue (7:30)
#define CAROUSEL_COME_IN_TIME                   3.0//3.0
#define CAROUSEL_COME_IN_DELAY_TIME             1.0//1.0
#define CAROUSEL_COME_IN_TIME2                  3.0//3.0
#define CAROUSEL_PHASE1_ENDFRAME                462, 250, 100, 100

//carousel tight order: kusini, ziemelu, amihan, talamh
#define AMIHAN_HANG_CENTER_TIGHT_CAROUSEL       650*(screenECarouselView.frame.size.width/1024),400*(screenECarouselView.frame.size.width/1024)
#define KUSINI_HANG_CENTER_TIGHT_CAROUSEL       350*(screenECarouselView.frame.size.width/1024),390*(screenECarouselView.frame.size.width/1024)
#define TALAMH_HANG_CENTER_TIGHT_CAROUSEL       780*(screenECarouselView.frame.size.width/1024),370*(screenECarouselView.frame.size.width/1024)
#define ZIEMELU_HANG_CENTER_TIGHT_CAROUSEL      500*(screenECarouselView.frame.size.width/1024),440*(screenECarouselView.frame.size.width/1024)

//carousel risen order: ziemelu, talamh, kusini, amihan
#define AMIHAN_HANG_CENTER_RISEN_CAROUSEL       740*(screenECarouselView.frame.size.width/1024),470*(screenECarouselView.frame.size.width/1024)
#define KUSINI_HANG_CENTER_RISEN_CAROUSEL       610*(screenECarouselView.frame.size.width/1024),500*(screenECarouselView.frame.size.width/1024)
#define TALAMH_HANG_CENTER_RISEN_CAROUSEL       450*(screenECarouselView.frame.size.width/1024),520*(screenECarouselView.frame.size.width/1024)
#define ZIEMELU_HANG_CENTER_RISEN_CAROUSEL      310*(screenECarouselView.frame.size.width/1024),520*(screenECarouselView.frame.size.width/1024)

#define AMIHAN_ROTATE_LEFT       -500
#define AMIHAN_ROTATE_RIGHT      500
#define AMIHAN_ROTATE_SHIFT      25

#define KUSINI_ROTATE_LEFT       -400
#define KUSINI_ROTATE_RIGHT      400
#define KUSINI_ROTATE_SHIFT      30

#define TALAMH_ROTATE_LEFT       -600
#define TALAMH_ROTATE_RIGHT      600
#define TALAMH_ROTATE_SHIFT      20

#define ZIEMELU_ROTATE_LEFT       -500
#define ZIEMELU_ROTATE_RIGHT      500
#define ZIEMELU_ROTATE_SHIFT      40

#define CAROUSEL_CHANGE_TIME      0.1

#define CLOUD_IMAGEVIEW_MIN_X     512
#define CLOUD_IMAGEVIEW_MAX_X     950

#define CAROUSEL_START_X          375
#define CAROUSEL_START_Y          150
#define CAROUSEL_START_HEIGHT          200
#define CAROUSEL_START_WIDTH          274

#define TELESCOPE_COME_IN          3.0
#define TELESCOPE_ROTATION_STEP    3.0

#define MAX_ACTUAL_ROTATION        720
#define MIN_ACTUAL_ROTATION        0
#define TRANSFORM_VALUE_FOR_BLUR   50

#define TELESCOPE_ORIGINAL_INORI_IMAGE   @"e_1k_inorix0.50.png"
//#define TELESCOPE_ORIGINAL_INORI_IMAGE   @"e_1k_inorix0.25.png"

#import "EViewController.h"
#import "UIImage+StackBlur.h"

@interface EViewController ()

@end

@implementation EViewController

@synthesize screenEBackgroundViewImageView, screenEcloud01ImageView, screenEcloud02ImageView, screenEcloud03ImageView, screenEAmihanImageView, screenEKusiniImageView, screenETalamhImageView, screenEZiemeluImageView, screenECarouselView, screenECarouselTightImageView, screenECarouselRisenImageView, screenEAmihanHangImageView, screenEKusiniHangImageView, screenETalamhHangImageView, screenEZiemeluHangImageView, screenECarouselTouchView, screenECarouselSliderView, screenECompassControl, screenETelescopeImageView, screenETelescopeView,screenETelescopeTouchControl, screenETelescopeViewView, screenETelescopeViewImageView, screenEInoriTelescopeViewImageView;

- (CGPoint)rotatePoint:(CGPoint)pointToRotate around:(CGPoint)center withDegree:(float)degree
{
	pointToRotate = CGPointMake(pointToRotate.x-center.x,pointToRotate.y-center.y);
	CGPoint rotatedPoint = CGPointMake(pointToRotate.x*cos(degree)-pointToRotate.y*sin(degree),pointToRotate.x*sin(degree)+pointToRotate.y*cos(degree));
	rotatedPoint.x=center.x+rotatedPoint.x;
	rotatedPoint.y=center.y+rotatedPoint.y;
	return rotatedPoint;
}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration 
{

    CGFloat valueX = -1.0*acceleration.y;  // -1 <=  x,y,z => 1

//    CGFloat prevoiusCarouselAccelerationX=carouselAccelerationX;
    
    carouselAccelerationX=valueX*alphaValue+carouselAccelerationX*(1.0-alphaValue);
    
    CGAffineTransform newTransform = CGAffineTransformRotate(carouselTightOriginalTransform, carouselAccelerationX);
    
    [screenECarouselTightImageView setTransform:newTransform];
    [screenECarouselRisenImageView setTransform:newTransform];
    
    if ([screenECarouselTightImageView alpha]==1)
    {
        [screenEAmihanHangImageView setCenter:[self rotatePoint:CGPointMake(AMIHAN_HANG_CENTER_TIGHT_CAROUSEL) around:[screenECarouselTightImageView center] withDegree:carouselAccelerationX]];
        [screenEKusiniHangImageView setCenter:[self rotatePoint:CGPointMake(KUSINI_HANG_CENTER_TIGHT_CAROUSEL) around:[screenECarouselTightImageView center] withDegree:carouselAccelerationX]];
        [screenETalamhHangImageView setCenter:[self rotatePoint:CGPointMake(TALAMH_HANG_CENTER_TIGHT_CAROUSEL) around:[screenECarouselTightImageView center] withDegree:carouselAccelerationX]];
        [screenEZiemeluHangImageView setCenter:[self rotatePoint:CGPointMake(ZIEMELU_HANG_CENTER_TIGHT_CAROUSEL) around:[screenECarouselTightImageView center] withDegree:carouselAccelerationX]];
    } else
    {
        [screenEAmihanHangImageView setCenter:[self rotatePoint:CGPointMake(AMIHAN_HANG_CENTER_RISEN_CAROUSEL) around:[screenECarouselRisenImageView center] withDegree:carouselAccelerationX]];
        [screenEKusiniHangImageView setCenter:[self rotatePoint:CGPointMake(KUSINI_HANG_CENTER_RISEN_CAROUSEL) around:[screenECarouselRisenImageView center] withDegree:carouselAccelerationX]];
        [screenETalamhHangImageView setCenter:[self rotatePoint:CGPointMake(TALAMH_HANG_CENTER_RISEN_CAROUSEL) around:[screenECarouselRisenImageView center] withDegree:carouselAccelerationX]];
        [screenEZiemeluHangImageView setCenter:[self rotatePoint:CGPointMake(ZIEMELU_HANG_CENTER_RISEN_CAROUSEL) around:[screenECarouselRisenImageView center] withDegree:carouselAccelerationX]];
    }
}

-(IBAction)screenEBackToMainMenu:(id)sender;
{
    //    ViewController *mainViewController=[[ViewController alloc] init];
    //    [self presentViewController:mainViewController animated:NO completion:Nil];
    
    if (isInoriTelescopeViewModeActive)
    {
        [self.view addSubview:screenETelescopeViewView];
        isInoriTelescopeViewModeActive=false;

        [UIView animateWithDuration: 2.0
                              delay: 0.0
                            options: UIViewAnimationOptionCurveLinear
                         animations:^
         {
             [screenECarouselView setCenter:CGPointMake(512, 374)];
             [screenETelescopeViewView setCenter:CGPointMake(1536, 374)];
             [screenEBackgroundViewImageView setAlpha:1];
             [screenEcloud01ImageView setAlpha:1];
             [screenEcloud02ImageView setAlpha:1];
             [screenEcloud03ImageView setAlpha:1];
         }
                         completion:nil];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:Nil];
    }
}

-(BOOL)carouselTouched:(CGPoint) translatedPoint;
{
    BOOL carouselIsTouched=false;
    CGRect frame;
    frame=screenECarouselTouchView.frame;
    frame=CGRectMake(frame.origin.x+screenECarouselView.frame.origin.x, frame.origin.y+screenECarouselView.frame.origin.y, frame.size.width, frame.size.height);
    if (CGRectContainsPoint(frame, translatedPoint))
    {
        carouselIsTouched=TRUE;
    }
    
    frame=screenEAmihanHangImageView.frame;
    frame=CGRectMake(frame.origin.x+screenECarouselView.frame.origin.x, frame.origin.y+screenECarouselView.frame.origin.y, frame.size.width, frame.size.height);
    if (CGRectContainsPoint(frame, translatedPoint))
    {
        carouselIsTouched=TRUE;
    }
    
    frame=screenEKusiniHangImageView.frame;
    frame=CGRectMake(frame.origin.x+screenECarouselView.frame.origin.x, frame.origin.y+screenECarouselView.frame.origin.y, frame.size.width, frame.size.height);
    if (CGRectContainsPoint(frame, translatedPoint))
    {
        carouselIsTouched=TRUE;
    }
    
    frame=screenETalamhHangImageView.frame;
    frame=CGRectMake(frame.origin.x+screenECarouselView.frame.origin.x, frame.origin.y+screenECarouselView.frame.origin.y, frame.size.width, frame.size.height);
    if (CGRectContainsPoint(frame, translatedPoint))
    {
        carouselIsTouched=TRUE;
    }
    
    frame=screenEZiemeluHangImageView.frame;
    frame=CGRectMake(frame.origin.x+screenECarouselView.frame.origin.x, frame.origin.y+screenECarouselView.frame.origin.y, frame.size.width, frame.size.height);
    if (CGRectContainsPoint(frame, translatedPoint))
    {
        carouselIsTouched=TRUE;
    }
    
    return carouselIsTouched;
}

-(void)carouselChange;
{
    [UIView animateWithDuration:CAROUSEL_CHANGE_TIME
                          delay: 0.0
                        options: UIViewAnimationOptionCurveLinear
                     animations:^
     {
         [screenECarouselRisenImageView setAlpha:1-screenECarouselRisenImageView.alpha];
         [screenECarouselTightImageView setAlpha:1-screenECarouselTightImageView.alpha];

         if ([screenECarouselTightImageView alpha]==1)
         {
             [screenEAmihanHangImageView setCenter:CGPointMake(AMIHAN_HANG_CENTER_TIGHT_CAROUSEL)];
             [screenEKusiniHangImageView setCenter:CGPointMake(KUSINI_HANG_CENTER_TIGHT_CAROUSEL)];
             [screenETalamhHangImageView setCenter:CGPointMake(TALAMH_HANG_CENTER_TIGHT_CAROUSEL)];
             [screenEZiemeluHangImageView setCenter:CGPointMake(ZIEMELU_HANG_CENTER_TIGHT_CAROUSEL)];
         } else
         {
             [screenEAmihanHangImageView setCenter:CGPointMake(AMIHAN_HANG_CENTER_RISEN_CAROUSEL)];
             [screenEKusiniHangImageView setCenter:CGPointMake(KUSINI_HANG_CENTER_RISEN_CAROUSEL)];
             [screenETalamhHangImageView setCenter:CGPointMake(TALAMH_HANG_CENTER_RISEN_CAROUSEL)];
             [screenEZiemeluHangImageView setCenter:CGPointMake(ZIEMELU_HANG_CENTER_RISEN_CAROUSEL)];
         }
         
     }
                     completion:nil];
    
}

-(void)cloudSliderIsOnTheMove:(CGPoint) translatedPoint;
{
    CGPoint newCenter=CGPointMake(firstCloud01Center.x+translatedPoint.x-firstTranslatedPoint.x, screenEcloud01ImageView.center.y);
    if (newCenter.x<CLOUD_IMAGEVIEW_MIN_X) {
        newCenter.x=CLOUD_IMAGEVIEW_MIN_X;
    }
    if (newCenter.x>CLOUD_IMAGEVIEW_MAX_X) {
        newCenter.x=CLOUD_IMAGEVIEW_MAX_X;
    }
    [screenEcloud01ImageView setCenter:newCenter];
    
    newCenter=CGPointMake(newCenter.x+256, screenECarouselSliderView.center.y);
    [screenECarouselSliderView setCenter:newCenter];
    
    CGFloat sliderStatusInPercent=(screenEcloud01ImageView.center.x-CLOUD_IMAGEVIEW_MIN_X)/(CLOUD_IMAGEVIEW_MAX_X-CLOUD_IMAGEVIEW_MIN_X);

    [screenEcloud02ImageView setAlpha:1.00-sliderStatusInPercent/2];
    [screenEcloud03ImageView setAlpha:1.00-sliderStatusInPercent/2];
    
    newCenter=CGPointMake(screenEcloud01ImageView.frame.size.width/2+screenEcloud01ImageView.frame.size.width*sliderStatusInPercent/4, 0.00+(screenEcloud02ImageView.frame.size.height/2)+(screenEcloud02ImageView.frame.size.height/2*sliderStatusInPercent/8));
    [screenEcloud02ImageView setCenter:newCenter];

    newCenter=CGPointMake(screenEcloud01ImageView.frame.size.width/2-screenEcloud01ImageView.frame.size.width*sliderStatusInPercent/4, 0.00+(screenEcloud01ImageView.frame.size.height/2)+(screenEcloud01ImageView.frame.size.height/2*sliderStatusInPercent/2));
    [screenEcloud03ImageView setCenter:newCenter];
    
    CGAffineTransform newTransform=CGAffineTransformMakeScale(1.00+sliderStatusInPercent, 1.00+sliderStatusInPercent);
    [screenEcloud02ImageView setTransform:newTransform];
    [screenEcloud03ImageView setTransform:newTransform];


    
    
    
    CGAffineTransform carouselTightActualTransform=[screenECarouselTightImageView transform];
    CGAffineTransform carouselRisenActualTransform=[screenECarouselRisenImageView transform];
    CGAffineTransform amihanHangActualTransform=[screenEAmihanHangImageView transform];
    CGAffineTransform kusiniHangActualTransform=[screenEKusiniHangImageView transform];
    CGAffineTransform talamhHangActualTransform=[screenETalamhHangImageView transform];
    CGAffineTransform ziemeluHangActualTransform=[screenEZiemeluHangImageView transform];

    blockChildrenTransform=true;
        
    [screenECarouselTightImageView setTransform:carouselTightOriginalTransform];
    [screenECarouselRisenImageView setTransform:carouselRisenOriginalTransform];
    [screenEAmihanHangImageView setTransform:amihanHangOriginalTransform];
    [screenEKusiniHangImageView setTransform:kusiniHangOriginalTransform];
    [screenETalamhHangImageView setTransform:talamhHangOriginalTransform];
    [screenEZiemeluHangImageView setTransform:ziemeluHangOriginalTransform];
    
    CGRect newFrame=CGRectMake(CAROUSEL_START_X*(1-sliderStatusInPercent), CAROUSEL_START_Y*(1-sliderStatusInPercent), CAROUSEL_START_WIDTH+(1024-CAROUSEL_START_WIDTH)*sliderStatusInPercent, CAROUSEL_START_HEIGHT+(748-CAROUSEL_START_HEIGHT)*sliderStatusInPercent);
    [screenECarouselView setFrame:newFrame];
    
    [screenECarouselTightImageView setTransform:carouselTightActualTransform];
    [screenECarouselRisenImageView setTransform:carouselRisenActualTransform];
    [screenEAmihanHangImageView setTransform:amihanHangActualTransform];
    [screenEKusiniHangImageView setTransform:kusiniHangActualTransform];
    [screenETalamhHangImageView setTransform:talamhHangActualTransform];
    [screenEZiemeluHangImageView setTransform:ziemeluHangActualTransform];

    blockChildrenTransform=false;

    if (screenEcloud01ImageView.center.x==CLOUD_IMAGEVIEW_MAX_X)
    {
        isTelescopeComeIn=TRUE;
        isCarouselSliderActive=false;

        [amihanRockingTimer invalidate];
        [kusiniRockingTimer invalidate];
        [talamhRockingTimer invalidate];
        [ziemeluRockingTimer invalidate];
        [[UIAccelerometer sharedAccelerometer] setUpdateInterval:TELESCOPE_COME_IN];

        telescopeRotatesTimerClock = 100*TELESCOPE_COME_IN*TELESCOPE_ROTATION_STEP;
        telescopeRotatesTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(telescopeRotatesActionMethod) userInfo:nil repeats:YES];
        [telescopeRotatesTimer fire];

        [UIView animateWithDuration: TELESCOPE_COME_IN
                              delay: 0.0
                            options: UIViewAnimationOptionCurveLinear
                         animations:^
         {
             [screenETelescopeView setCenter:screenEKusiniHangImageView.center];
             [screenETelescopeView setTransform:[screenEKusiniHangImageView transform]];

         }
                         completion:^(BOOL finished)
        {
            isTelescopeRocking=true;
            isTelescopeComeIn=false;

            
            amihanRockingTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(screenEAmihanRockingAction:) userInfo:nil repeats:YES];
            [amihanRockingTimer fire];
            
            kusiniRockingTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(screenEKusiniRockingAction:) userInfo:nil repeats:YES];
            [kusiniRockingTimer fire];
            
            talamhRockingTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(screenETalamhRockingAction:) userInfo:nil repeats:YES];
            [talamhRockingTimer fire];
            
            ziemeluRockingTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(screenEZiemeluRockingAction:) userInfo:nil repeats:YES];
            [ziemeluRockingTimer fire];

            
            [[UIAccelerometer sharedAccelerometer] setUpdateInterval:1.0/ACCELERATOR_UPDATE_FREQUENCY];
        }];
        
    
    }
    
}

-(void)telescopeRotatesActionMethod;
{
    telescopeRotatesTimerClock=telescopeRotatesTimerClock-TELESCOPE_ROTATION_STEP;
    CGAffineTransform newTransform = CGAffineTransformMakeRotation(telescopeRotatesTimerClock*M_PI/180);
    [screenETelescopeImageView setTransform:newTransform];
    if (telescopeRotatesTimerClock<=0)
    {
        [telescopeRotatesTimer invalidate];
    }
}

-(IBAction)screenETelescopeTouched:(id)sender;
{
    [screenETelescopeViewView setCenter:CGPointMake(1536, 374)];
    [self.view addSubview:screenETelescopeViewView];
    isInoriTelescopeViewModeActive=true;

    [UIView animateWithDuration: 2.0
                          delay: 0.0
                        options: UIViewAnimationOptionCurveLinear
                     animations:^
     {
         [screenECarouselView setCenter:CGPointMake(-512, 374)];
         [screenETelescopeViewView setCenter:CGPointMake(512, 374)];
         [screenEBackgroundViewImageView setAlpha:0];
         [screenEcloud01ImageView setAlpha:0];
         [screenEcloud02ImageView setAlpha:0];
         [screenEcloud03ImageView setAlpha:0];
     }
                     completion:nil];
    
    [self setTelescopeStandarsSettings];
    [self.view addSubview:screenECompassControl];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
{
    cloudSliderOntheMove=false;

	NSUInteger touchCount = 0;
	for (UITouch *touch in touches)
	{
		CGPoint translatedPoint = [touch locationInView:self.view];
		
        firstTranslatedPoint=translatedPoint;
        
        if (isInoriTelescopeViewModeActive)
        {
            CGFloat x = firstTranslatedPoint.x-screenETelescopeViewImageView.center.x;
            CGFloat y = firstTranslatedPoint.y-screenETelescopeViewImageView.center.y;
            if (x!=0) {
                originalDegree = atanf(y/x);
            }
            else {
                if (y>0)
                {
                    originalDegree =M_PI/2;
                }
                else {
                    originalDegree =-M_PI/2;
                }
                
            }
            
            originalDegree = originalDegree*180/M_PI;
            if ((x>=0)&&(y<0)) {
                originalDegree = -originalDegree;
            }
            if (x<0) {
                originalDegree = 180-originalDegree;
            }
            if ((x>=0)&&(y>0)) {
                originalDegree= 360-originalDegree;
            }

            rotation=0.00;
            previousRotation=0.00;
            newDegree=originalDegree;
            oldDegree=originalDegree;

//            NSLog(@"\n**********\n**********\nTouchesBegin\n; originalDegree:%f, oldDegree:%f, newDegree:%f\nrotation: %f, prevoiusRotation:%f\n**********\n**********\n",originalDegree, oldDegree, newDegree, rotation, previousRotation);
            
            
        } else
        {
            if ([self carouselTouched:translatedPoint] && !isTelescopeComeIn)
            {
                [self carouselChange];
            }
            if (isCarouselSliderActive)
            {
                if (CGRectContainsPoint(screenECarouselSliderView.frame, translatedPoint))
                {
                    cloudSliderOntheMove=true;
                    firstCloud01Center=screenEcloud01ImageView.center;
                }
            }
        }

        previousTranslatedPoint=translatedPoint;
		touchCount++;
	}
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
{  
	NSUInteger touchCount = 0;
	for (UITouch *touch in touches)
	{
		CGPoint translatedPoint = [touch locationInView:self.view];

        if (isInoriTelescopeViewModeActive)
        {
            oldDegree=newDegree;
            CGFloat newX = translatedPoint.x-screenETelescopeViewImageView.center.x;
            CGFloat newY = translatedPoint.y-screenETelescopeViewImageView.center.y;
            if (newX != 0)
            {
                newDegree = atanf(newY/newX);
            }
            else {
                if (newY > 0)
                {
                    newDegree = M_PI/2;
                }
                else {
                    newDegree = -M_PI/2;
                }
                
            }
            newDegree = newDegree*180/M_PI;
            if ((newX>=0)&&(newY<0)) {
                newDegree = -newDegree;
            }
            if (newX<0) {
                newDegree = 180-newDegree;
            }
            if ((newX>=0)&&(newY>0)) {
                newDegree = 360-newDegree;
            }

            rotation = (originalDegree-newDegree)/180*M_PI;
            
            
            CGFloat degreeChange=oldDegree-newDegree;
            if (oldDegree!=0.00)
            {
                if ((degreeChange)>180)
                {
                    degreeChange=degreeChange-360;
                }
                else
                {
                    if ((degreeChange)<-180)
                    {
                        degreeChange=degreeChange+360;
                    }
                }
            }
            
//            NSLog(@"\n\nTouchesMoved\n; originalDegree:%f, oldDegree:%f, newDegree:%f\nrotation: %f, prevoiusRotation:%f\n degreeChange:%f, actualRotation:%f\n\n ",originalDegree, oldDegree, newDegree, rotation, previousRotation, degreeChange, actualrotation);
            
            if ((actualrotation+degreeChange<MAX_ACTUAL_ROTATION)&&(actualrotation+degreeChange>MIN_ACTUAL_ROTATION))
            {
                actualrotation=actualrotation+degreeChange;
                
                newTelescopeTransform = CGAffineTransformRotate(previousTelescopeTransform,actualrotation/180*M_PI);
                
                [screenETelescopeViewImageView setTransform:newTelescopeTransform];
                
                previousBlurRadius=blurRadius;
                blurRadius=abs(roundf(actualrotation/TRANSFORM_VALUE_FOR_BLUR));
                
                screenEInoriTelescopeViewImageView.image=[inoriBluredImageArray objectAtIndex: blurRadius];
            }
            else
            {
                originalDegree=originalDegree-degreeChange;
            }
            previousRotation=rotation;
            
        } else
        {
            if (cloudSliderOntheMove && isCarouselSliderActive && !isTelescopeComeIn)
            {
                [self cloudSliderIsOnTheMove:translatedPoint];
            }
        }
        
        previousTranslatedPoint=translatedPoint;

		touchCount++;
	}
	
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
{
    cloudSliderOntheMove=false;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)cloudsComeIn;
{
    [UIView animateWithDuration: 0.0
                          delay: CLOUDS_COME_IN_DELAY_TIME
                        options: UIViewAnimationOptionCurveLinear
                     animations:^
     {
         [screenEcloud01ImageView setCenter:CGPointMake(1536, 374)];
         [screenEcloud02ImageView setCenter:CGPointMake(1536, 374)];
         [screenEcloud03ImageView setCenter:CGPointMake(-512, 374)];
     }
                     completion:^(BOOL finished) {[self calculateInoriBlurImages];}];
    
    [UIView animateWithDuration:CLOUDS_COME_IN_TIME
                          delay: CLOUDS_COME_IN_DELAY_TIME
                        options: UIViewAnimationOptionCurveLinear
                     animations:^
     {
         [screenEcloud01ImageView setCenter:CGPointMake(512, 374)];
         [screenEcloud02ImageView setCenter:CGPointMake(512, 374)];
         [screenEcloud03ImageView setCenter:CGPointMake(512, 374)];
     }
                     completion:nil];
    
}

- (void)childrenComeIn;
{
    CGAffineTransform newTransform=CGAffineTransformMakeScale(CHILDREN_FLY_START_SIZE, CHILDREN_FLY_START_SIZE);
    [screenEAmihanImageView setTransform:newTransform];
    [screenEKusiniImageView setTransform:newTransform];
    [screenETalamhImageView setTransform:newTransform];
    [screenEZiemeluImageView setTransform:newTransform];
    
    [screenEAmihanImageView setCenter:CGPointMake(AMIHAN_START_POINT)];
    [screenEKusiniImageView setCenter:CGPointMake(KUSINI_START_POINT)];
    [screenETalamhImageView setCenter:CGPointMake(TALAMH_START_POINT)];
    [screenEZiemeluImageView setCenter:CGPointMake(ZIEMELU_START_POINT)];
    
    childrenComeInTimerClock=0;
    childrenComeInTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(childrenComeInActionMethod) userInfo:nil repeats:YES];
    [childrenComeInTimer fire];
   
    /*
    [UIView animateWithDuration:CHILDREN_COME_IN_TIME
                          delay: CLOUDS_COME_IN_TIME+CLOUDS_COME_IN_DELAY_TIME+AMIHAN_COME_IN_DELAY_TIME+KUSINI_COME_IN_DELAY_TIME
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^
     {
         [screenEKusiniImageView setTransform:newTransform];
         [screenEKusiniImageView setCenter:CGPointMake(CHILDREN_FINISH_POINT)];
     }
                     completion:nil];
    [UIView animateWithDuration:CHILDREN_COME_IN_TIME
                          delay: CLOUDS_COME_IN_TIME+CLOUDS_COME_IN_DELAY_TIME+AMIHAN_COME_IN_DELAY_TIME+KUSINI_COME_IN_DELAY_TIME+TALAMH_COME_IN_DELAY_TIME
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^
     {
         [screenETalamhImageView setTransform:newTransform];
         [screenETalamhImageView setCenter:CGPointMake(CHILDREN_FINISH_POINT)];
     }
                     completion:nil];
    [UIView animateWithDuration:CHILDREN_COME_IN_TIME
                          delay: CLOUDS_COME_IN_TIME+CLOUDS_COME_IN_DELAY_TIME+AMIHAN_COME_IN_DELAY_TIME+KUSINI_COME_IN_DELAY_TIME+TALAMH_COME_IN_DELAY_TIME+ZIEMELU_COME_IN_DELAY_TIME
                        options: UIViewAnimationOptionCurveEaseOut
                     animations:^
     {
         [screenEZiemeluImageView setTransform:newTransform];
         [screenEZiemeluImageView setCenter:CGPointMake(CHILDREN_FINISH_POINT)];
     }
                     completion:nil];
    */
}

-(void)childrenComeInActionMethod;
{
    childrenComeInTimerClock++;

    //AMIHAN
    if ((childrenComeInTimerClock>=100*(CLOUDS_COME_IN_TIME+AMIHAN_COME_IN_DELAY_TIME))&(childrenComeInTimerClock<=100*(CLOUDS_COME_IN_TIME+AMIHAN_COME_IN_DELAY_TIME+CHILDREN_COME_IN_TIME)))
    {
        [self moveTheChild:screenEAmihanImageView fromStartCenter:CGPointMake(AMIHAN_START_POINT) toFinishCenter:CGPointMake(CHILDREN_FINISH_POINT) startingWithSize:CHILDREN_FLY_START_SIZE finishingWithSize:CHILDREN_FLY_FINISH_SIZE basedOnPercentage:(childrenComeInTimerClock-100*(CLOUDS_COME_IN_TIME+AMIHAN_COME_IN_DELAY_TIME))/(CHILDREN_COME_IN_TIME*100) withAidForCreateArcX:AMIHAN_COME_IN_ARC_AID_X andArcY:AMIHAN_COME_IN_ARC_AID_Y];
    }
    
    //KUSINI
    if ((childrenComeInTimerClock>=100*(CLOUDS_COME_IN_TIME+AMIHAN_COME_IN_DELAY_TIME+KUSINI_COME_IN_DELAY_TIME))&(childrenComeInTimerClock<=100*(CLOUDS_COME_IN_TIME+AMIHAN_COME_IN_DELAY_TIME+KUSINI_COME_IN_DELAY_TIME+CHILDREN_COME_IN_TIME)))
    {
        [self moveTheChild:screenEKusiniImageView fromStartCenter:CGPointMake(KUSINI_START_POINT) toFinishCenter:CGPointMake(CHILDREN_FINISH_POINT) startingWithSize:CHILDREN_FLY_START_SIZE finishingWithSize:CHILDREN_FLY_FINISH_SIZE basedOnPercentage:(childrenComeInTimerClock-100*(CLOUDS_COME_IN_TIME+AMIHAN_COME_IN_DELAY_TIME+KUSINI_COME_IN_DELAY_TIME))/(CHILDREN_COME_IN_TIME*100) withAidForCreateArcX:KUSINI_COME_IN_ARC_AID_X andArcY:KUSINI_COME_IN_ARC_AID_Y];
    }
    
    //TALAMH
    if ((childrenComeInTimerClock>=100*(CLOUDS_COME_IN_TIME+AMIHAN_COME_IN_DELAY_TIME+KUSINI_COME_IN_DELAY_TIME+TALAMH_COME_IN_DELAY_TIME))&(childrenComeInTimerClock<=100*(CLOUDS_COME_IN_TIME+AMIHAN_COME_IN_DELAY_TIME+KUSINI_COME_IN_DELAY_TIME+TALAMH_COME_IN_DELAY_TIME+CHILDREN_COME_IN_TIME)))
    {
        [self moveTheChild:screenETalamhImageView fromStartCenter:CGPointMake(TALAMH_START_POINT) toFinishCenter:CGPointMake(CHILDREN_FINISH_POINT) startingWithSize:CHILDREN_FLY_START_SIZE finishingWithSize:CHILDREN_FLY_FINISH_SIZE basedOnPercentage:(childrenComeInTimerClock-100*(CLOUDS_COME_IN_TIME+AMIHAN_COME_IN_DELAY_TIME+KUSINI_COME_IN_DELAY_TIME+TALAMH_COME_IN_DELAY_TIME))/(CHILDREN_COME_IN_TIME*100) withAidForCreateArcX:TALAMH_COME_IN_ARC_AID_X andArcY:TALAMH_COME_IN_ARC_AID_Y];
    }
    
    //ZIEMELU
    if ((childrenComeInTimerClock>=100*(CLOUDS_COME_IN_TIME+AMIHAN_COME_IN_DELAY_TIME+KUSINI_COME_IN_DELAY_TIME+TALAMH_COME_IN_DELAY_TIME+ZIEMELU_COME_IN_DELAY_TIME))&(childrenComeInTimerClock<=100*(CLOUDS_COME_IN_TIME+AMIHAN_COME_IN_DELAY_TIME+KUSINI_COME_IN_DELAY_TIME+TALAMH_COME_IN_DELAY_TIME+ZIEMELU_COME_IN_DELAY_TIME+CHILDREN_COME_IN_TIME)))
    {
        [self moveTheChild:screenEZiemeluImageView fromStartCenter:CGPointMake(ZIEMELU_START_POINT) toFinishCenter:CGPointMake(CHILDREN_FINISH_POINT) startingWithSize:CHILDREN_FLY_START_SIZE finishingWithSize:CHILDREN_FLY_FINISH_SIZE basedOnPercentage:(childrenComeInTimerClock-100*(CLOUDS_COME_IN_TIME+AMIHAN_COME_IN_DELAY_TIME+KUSINI_COME_IN_DELAY_TIME+TALAMH_COME_IN_DELAY_TIME+ZIEMELU_COME_IN_DELAY_TIME))/(CHILDREN_COME_IN_TIME*100) withAidForCreateArcX:ZIEMELU_COME_IN_ARC_AID_X andArcY:ZIEMELU_COME_IN_ARC_AID_Y];
    }
    
    if (childrenComeInTimerClock>100*(CLOUDS_COME_IN_TIME+AMIHAN_COME_IN_DELAY_TIME+KUSINI_COME_IN_DELAY_TIME+TALAMH_COME_IN_DELAY_TIME+ZIEMELU_COME_IN_DELAY_TIME+CHILDREN_COME_IN_TIME))
    {
        [childrenComeInTimer invalidate];
        [self carouselComeOut];
    }
}

-(void)moveTheChild:(UIImageView *)child fromStartCenter:(CGPoint)startCenter toFinishCenter:(CGPoint)finishCenter startingWithSize:(CGFloat)startSize finishingWithSize:(CGFloat)finishSize basedOnPercentage:(CGFloat)percentage withAidForCreateArcX:(CGFloat)arcAidX andArcY:(CGFloat)arcAidY;
{
    CGAffineTransform newTransform=CGAffineTransformMakeScale(startSize+(finishSize-startSize)*percentage, startSize+(finishSize-startSize)*percentage);
    [child setTransform:newTransform];
    CGPoint newCenter = CGPointMake(arcAidX*sin(percentage*M_PI)+startCenter.x+(finishCenter.x-startCenter.x)*percentage,arcAidY*sin(percentage*M_PI)+startCenter.y+(finishCenter.y-startCenter.y)*percentage);
    [child setCenter:newCenter];

}

- (void) setAmihanRockingState;
{
    CGAffineTransform newTransform = CGAffineTransformRotate(amihanHangOriginalTransform,(1.00*amihanRockingClock/18000.00*M_PI)+carouselAccelerationX);
    [screenEAmihanHangImageView setTransform:newTransform];
}

-(void) screenEAmihanRockingAction:(id)sender;
{
    amihanRockingClock=amihanRockingClock+amihanRockingClockChange;
    if ((amihanRockingClock < AMIHAN_ROTATE_LEFT)||(amihanRockingClock > AMIHAN_ROTATE_RIGHT)) {
        amihanRockingClockChange=-amihanRockingClockChange;
    }
    [self setAmihanRockingState];
}


- (void) setKusiniRockingState;
{
    CGAffineTransform newTransform = CGAffineTransformRotate(kusiniHangOriginalTransform,(1.00*kusiniRockingClock/18000.00*M_PI)+carouselAccelerationX);
    [screenEKusiniHangImageView setTransform:newTransform];

    if (isTelescopeRocking) {
        [screenETelescopeView setCenter:screenEKusiniHangImageView.center];
        
        [screenETelescopeView setTransform:[screenEKusiniHangImageView transform]];
    }
}

-(void) screenEKusiniRockingAction:(id)sender;
{
    kusiniRockingClock=kusiniRockingClock+kusiniRockingClockChange;
    if ((kusiniRockingClock < KUSINI_ROTATE_LEFT)||(kusiniRockingClock > KUSINI_ROTATE_RIGHT)) {
        kusiniRockingClockChange=-kusiniRockingClockChange;
    }
    [self setKusiniRockingState];
}

- (void) setTalamhRockingState;
{
    CGAffineTransform newTransform = CGAffineTransformRotate(talamhHangOriginalTransform,(1.00*talamhRockingClock/18000.00*M_PI)+carouselAccelerationX);
    [screenETalamhHangImageView setTransform:newTransform];
}

-(void) screenETalamhRockingAction:(id)sender;
{
    talamhRockingClock=talamhRockingClock+talamhRockingClockChange;
    if ((talamhRockingClock < TALAMH_ROTATE_LEFT)||(talamhRockingClock > TALAMH_ROTATE_RIGHT)) {
        talamhRockingClockChange=-talamhRockingClockChange;
    }
    [self setTalamhRockingState];
}

- (void) setZiemeluRockingState;
{
    CGAffineTransform newTransform = CGAffineTransformRotate(ziemeluHangOriginalTransform,(1.00*ziemeluRockingClock/18000.00*M_PI)+carouselAccelerationX);
    [screenEZiemeluHangImageView setTransform:newTransform];
}

-(void) screenEZiemeluRockingAction:(id)sender;
{
    ziemeluRockingClock=ziemeluRockingClock+ziemeluRockingClockChange;
    if ((ziemeluRockingClock < ZIEMELU_ROTATE_LEFT)||(ziemeluRockingClock > ZIEMELU_ROTATE_RIGHT)) {
        ziemeluRockingClockChange=-ziemeluRockingClockChange;
    }
    [self setZiemeluRockingState];
}

-(void)carouselComeOut;
{    
    [screenECarouselView setFrame:CGRectMake(507, 370, 10, 10)];
    [screenECarouselView setAlpha:1];

    [UIView animateWithDuration: CAROUSEL_COME_IN_TIME
                          delay: 0.0
                        options: UIViewAnimationOptionCurveLinear
                     animations:^
     {
         [screenECarouselView setFrame:CGRectMake(CAROUSEL_PHASE1_ENDFRAME)];
     }
                     completion:^(BOOL finished)
                    {   [screenECarouselView removeFromSuperview];
                        [self.view addSubview:screenECarouselView];
                        [screenECarouselView addSubview:screenETelescopeView];
                        [screenETelescopeView setCenter:CGPointMake(1300, 250)];
                        [screenECompassControl removeFromSuperview];
                        [self.view addSubview:screenECompassControl];                        
                        
                        [UIView animateWithDuration:CAROUSEL_COME_IN_TIME2
                                                        delay: 0.0
                                                      options: UIViewAnimationOptionCurveLinear
                                                   animations:^
                                   {
                                       [screenECarouselView setFrame:CGRectMake(CAROUSEL_START_X, CAROUSEL_START_Y, CAROUSEL_START_WIDTH, CAROUSEL_START_HEIGHT)];
                                   }
                                         completion:^(BOOL finished)
                         {[self switchOnTheAcceleratorAndRocking];}];
                        
                     }];

    ;
    
    [UIView animateWithDuration: 0.0
                          delay: CHILDREN_COME_IN_TIME+3.0+CAROUSEL_COME_IN_TIME+CAROUSEL_COME_IN_TIME2
                        options: UIViewAnimationOptionCurveLinear
                     animations:^
     {
     }
                     completion:nil];
    carouselTightOriginalTransform=[screenECarouselTightImageView transform];
    carouselRisenOriginalTransform=[screenECarouselRisenImageView transform];

}

-(void) delayedStartAction:(id)sender;
{
    if (delayedStartClock!=0)
    {
        [delayedStartTimer invalidate];

//        [self calculateInoriBlurImages];
        
    }
    delayedStartClock++;
}

-(void) switchOnTheAcceleratorAndRocking;
{
        amihanHangOriginalTransform=[screenEAmihanHangImageView transform];
        amihanRockingClock=0;
        amihanRockingTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(screenEAmihanRockingAction:) userInfo:nil repeats:YES];
        amihanRockingClockChange=AMIHAN_ROTATE_SHIFT;
        [amihanRockingTimer fire];
        
        kusiniHangOriginalTransform=[screenEKusiniHangImageView transform];
        kusiniRockingClock=0;
        kusiniRockingTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(screenEKusiniRockingAction:) userInfo:nil repeats:YES];
        kusiniRockingClockChange=KUSINI_ROTATE_SHIFT;
        [kusiniRockingTimer fire];
        
        talamhHangOriginalTransform=[screenETalamhHangImageView transform];
        talamhRockingClock=0;
        talamhRockingTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(screenETalamhRockingAction:) userInfo:nil repeats:YES];
        talamhRockingClockChange=TALAMH_ROTATE_SHIFT;
        [talamhRockingTimer fire];
        
        ziemeluHangOriginalTransform=[screenEZiemeluHangImageView transform];
        ziemeluRockingClock=0;
        ziemeluRockingTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(screenEZiemeluRockingAction:) userInfo:nil repeats:YES];
        ziemeluRockingClockChange=ZIEMELU_ROTATE_SHIFT;
        [ziemeluRockingTimer fire];
        
        [screenECarouselSliderView setAlpha:1];
        
        [screenEAmihanImageView removeFromSuperview];
        [screenEKusiniImageView removeFromSuperview];
        [screenETalamhImageView removeFromSuperview];
        [screenEZiemeluImageView removeFromSuperview];
        
        [[UIAccelerometer sharedAccelerometer] setUpdateInterval:1.0/ACCELERATOR_UPDATE_FREQUENCY];
        [[UIAccelerometer sharedAccelerometer] setDelegate:self];
        double dt = 1.0 / ACCELERATOR_FILTER_CUTOFF_FREQUENCY;
        double RC = 1.0 / ACCELERATOR_UPDATE_FREQUENCY;
        alphaValue = dt / (dt + RC);
        
        isCarouselSliderActive=true;
        
}

-(void)setTelescopeStandarsSettings;
{
    actualrotation=MAX_ACTUAL_ROTATION;
    screenEInoriTelescopeViewImageView.image=[UIImage imageNamed:@"e_1k_inori 15.png"];

    ///*
    blurRadius=abs(roundf(actualrotation/TRANSFORM_VALUE_FOR_BLUR));
    
    if (blurRadius!=0)
    {
        if (blurRadius!=previousBlurRadius)
        {
            screenEInoriTelescopeViewImageView.image=[screenETelescopeOrigialImage stackBlur:blurRadius];
        }
    }
    else
    {
        screenEInoriTelescopeViewImageView.image=screenETelescopeOrigialImage;
    }
     //*/
    
}

-(void)calculateInoriBlurImages;
{
    int inoriBluredImageArrayCapacity=MAX_ACTUAL_ROTATION/TRANSFORM_VALUE_FOR_BLUR;
	
    NSMutableArray *inoriBluredImageMutableArray=[[NSMutableArray alloc] initWithCapacity:inoriBluredImageArrayCapacity+1];

	// Build arrays of images
    [inoriBluredImageMutableArray addObject:screenETelescopeOrigialImage];
	for (int i = 1; i <= inoriBluredImageArrayCapacity; i++)
		[inoriBluredImageMutableArray addObject:[screenETelescopeOrigialImage stackBlur:i]];

    inoriBluredImageArray=[NSArray arrayWithArray:inoriBluredImageMutableArray];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    screenETelescopeOrigialImage=[UIImage imageNamed:TELESCOPE_ORIGINAL_INORI_IMAGE];
        
    [self cloudsComeIn];
    
    [self childrenComeIn];
    
    canAccelerometerBeStarted=false;
    delayedStartClock=0;
    delayedStartTimer = [NSTimer scheduledTimerWithTimeInterval: CLOUDS_COME_IN_DELAY_TIME target:self selector:@selector(delayedStartAction:) userInfo:nil repeats:YES];
    [delayedStartTimer fire];
    
    previousTelescopeTransform=[screenETelescopeViewImageView transform];
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[UIAccelerometer sharedAccelerometer] setDelegate:Nil];
    [super viewWillDisappear:animated];
        
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ((interfaceOrientation==UIInterfaceOrientationLandscapeLeft)||(interfaceOrientation==UIInterfaceOrientationLandscapeRight)) {
        return YES;
    }
    // Return YES for supported orientations
	return NO;
}

@end
