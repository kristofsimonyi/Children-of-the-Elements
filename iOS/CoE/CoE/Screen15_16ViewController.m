//
//  Screen15_16ViewController.m
//  KickOff
//
//  Created by INKOVICS Ferenc on 15/06/2012.
//  Copyright (c) 2012 No company - private person. All rights reserved.
//

/*
 Haho, ujabb screen indul. Illetve reszben, mert ugye screen 16 volt mar. (bocs, ez hosszu leiras, de nem bonyolult egyebkent).
 
 A mese kicsit alakult, ahogy egyszerusitettunk rajta, igy a 15-16 screen osszevonasra kerult, s a 16 resz modosult. Szoval hozza kell nyulnunk, de nem veszesen. A mostani screen 16ot vegyuk ki, helyette tegyuk be az alabbi screen 15-16-ot, amiben felhasznalunk majd tobb elemet a regi screen 16bol. A korhintat (last screen 16 fele leiras) kiveve minden kepdarabot ujra kuldok.
 
 Screen 15 fele:
 
 Alap fazis:
 - layerek sorrendben: 15bg, 15hullam1, 15hullam2, 15hullam3, 15ejszaka (transparency 70%), 15felho (alapbol legyen valahol a kep kozepen).
 
 Mozgasok:
 - 15felho a kep felso elehez igazitva, balrol jobbra, csigalassan atuszik a kepen. teljes atuszas ideje: 60 mp. A felhok 50 mp-kent kovessek egymast, azaz lesz atfedes.
 - hullam1 es hullam2 vertikalis iranyban 'hullamzik' (hasznaljuk a kannahoz kifejlesztett ingamozgast), alapallapotuk mint kozeppont korul 75 pixel amplitudoval, szep lassan (egy teljes ciklus mondjuk 12 mp). A ket hullam mozgasa kozott legyen mondjuk 1/4 ciklus elteres.
 
 Interakcio:
 - a jobbrol masodik csillagra tapintva a csillag kozepen apro 0x0 meretben megjelenik a 15csillag, kozeppontja korul forogva, egyre nagyobbodva beuszik a kep kozeppontjaba. Mire a kep kozepere er, a merete pont akkora hogy befedi a teljes kepernyot (sarkokat is). Itt egy 1 mp alatt teljesen elsotetul a kep (fekete), majd egy masik 1 mp alatt kivilagosodik a screen 16os felenek nyitasara (lasd alabb).
 
 Screen 16 fele:
 
 Alap fazis:
 - layerek sorrendben: 16bg, 16dune, 15hullam1 (forgatva, lasd overview), 15hullam2 (forgatva, lasd overview), 15hullam3 (forgatva, lasd overview), 16felho (alapbol a kepen kivul), korhinta (atveve a regi 16rol, lasd overview), 16ejszaka (transparency 70%)
 
 Mozgasok:
 - hullamok mint elobb, csak ugy az egesz ki van forgatva a sarokba (lasd overview)
 - felho: ugy mozogjon pont mint a regi 16on
 - korhinta: gyerekek lengedeznek rajta, pont mint regi 16on
 
 Interakcio:
 - korhinta: tapintasra alakot valt, pont mint regi 16on
 - szitakotok: inorit tapintva a 16dune mogul indulva, pont ugy mint a regi 16on.
 - (madarak voltak a regi16on, most ezek nem kellenek).
 
 
 Irj ha valami nem tiszta (a fentieket tegnap keso este irtam, lehet hogy nem figyeltem valamire..). Kovetkezo screen tolem olyan Aprilis 30 korul varhato.
*/

#define CLOUD_TIME_INTERVAL        0.03
#define CLOUD15_TIME_INTERVAL      0.01
#define CLOUD15_START_CENTER       -550,0
#define CLOUD15_STOP_X             1600  //cloud went out from the screen
#define CLOUD15_STOP_X2            1600
#define CLOUD15_SHIFT              0.16//0.16=moving along the screen in 60 sec (1000 pixel /100 run in a sec)/60 sec run
#define CLOUD15_X_DIFF             800//there should be 50 sec diff in the movement of the clouds
#define CLOUD16_START_CENTER       -1512,200
#define CLOUD16_STOP_X             2536  //cloud went out from the screen
#define CLOUD16_STOP_X2            (CLOUD16_STOP_X+(8/CLOUD_TIME_INTERVAL))  //wait about 8 seconds

#define CLOUD16_SHIFT_MAX             4.00//for 6 sec moving speed
#define CLOUD16_SHIFT_MIN             2.00//for 10 sec moving speed

#define WAVE1_ORIG_CENTER                               512,384
#define WAVE2_ORIG_CENTER                               512,384
#define WAVING_MAX_Y                                    75
#define WAVING_ROTATION_STEP                            0.05
#define WAVING_ROTATION_INCREMENT                       1.03
#define WAVING_SHIFT_BETWEEN_WAVES                      4 //that means 1/4 of the WAVING_MAX_Y
#define WAVES_ROTATION_FOR_SCREEN16                     23.00/180.00*M_PI
#define WAVE1_ORIG_CENTER_FOR_SCREEN16                  462,534

#define STAR_COME_IN_TIME                               4.00

#define CAROUSEL_CENTER_1ST_STAGE     312,-374
#define CAROUSEL_CENTER_2ND_STAGE     312,200
#define CAROUSEL_COME_IN_TIME           3.0
#define CAROUSEL_COME_IN_TIME_DELAY     2.0

#define CAROUSEL_CHANGE_TIME      0.1

//carousel tight order: kusini, ziemelu, amihan, talamh
#define AMIHAN_HANG_CENTER_TIGHT_CAROUSEL       650*(screen16CarouselView.frame.size.width/1024),400*(screen16CarouselView.frame.size.width/1024)
#define KUSINI_HANG_CENTER_TIGHT_CAROUSEL       350*(screen16CarouselView.frame.size.width/1024),390*(screen16CarouselView.frame.size.width/1024)
#define TALAMH_HANG_CENTER_TIGHT_CAROUSEL       780*(screen16CarouselView.frame.size.width/1024),370*(screen16CarouselView.frame.size.width/1024)
#define ZIEMELU_HANG_CENTER_TIGHT_CAROUSEL      500*(screen16CarouselView.frame.size.width/1024),440*(screen16CarouselView.frame.size.width/1024)

//carousel risen order: ziemelu, talamh, kusini, amihan
#define AMIHAN_HANG_CENTER_RISEN_CAROUSEL       740*(screen16CarouselView.frame.size.width/1024),470*(screen16CarouselView.frame.size.width/1024)
#define KUSINI_HANG_CENTER_RISEN_CAROUSEL       610*(screen16CarouselView.frame.size.width/1024),500*(screen16CarouselView.frame.size.width/1024)
#define TALAMH_HANG_CENTER_RISEN_CAROUSEL       450*(screen16CarouselView.frame.size.width/1024),520*(screen16CarouselView.frame.size.width/1024)
#define ZIEMELU_HANG_CENTER_RISEN_CAROUSEL      310*(screen16CarouselView.frame.size.width/1024),520*(screen16CarouselView.frame.size.width/1024)

#define AMIHAN_ROTATE_LEFT       -500
#define AMIHAN_ROTATE_RIGHT      500
#define AMIHAN_ROTATE_SHIFT      25

#define KUSINI_ROTATE_LEFT       -400
#define KUSINI_ROTATE_RIGHT      400
#define KUSINI_ROTATE_SHIFT      30

#define TALAMH_ROTATE_LEFT       -600
#define TALAMH_ROTATE_RIGHT      600
#define TALAMH_ROTATE_SHIFT      20

#define ZIEMELU_ROTATE_LEFT      -500
#define ZIEMELU_ROTATE_RIGHT     500
#define ZIEMELU_ROTATE_SHIFT     40

#define BUTTERFLY1_START_FRAME       0,400,184,143
#define BUTTERFLY2_START_FRAME       0,400,226,159

#import "Screen15_16ViewController.h"
#import "ViewController.h"

@interface Screen15_16UIImageViewButterfly ()

@end

@implementation Screen15_16UIImageViewButterfly

@synthesize xChange, xChangeType, yChange;

- (id)initWithFrame:(CGRect)frame;
{
    self=[super initWithFrame:frame];
    xChangeType=arc4random()%2;
    xChange=(1.000*(arc4random()%50)-25)/50;
    if (xChange>=0)
    {
        xChange=0.300+xChange;
    } else
    {
        xChange=-0.300-xChange;
    }
    if (xChangeType==0)
    {
        if (xChange>=0)
        {
            xChange=2.000+xChange;
        } else
        {
            xChange=-2.000-xChange;
        }
    }
    yChange=2;
    return self;
}

@end

@interface Screen15_16ViewController ()

@end

@implementation Screen15_16ViewController

@synthesize screen15BackgroundImageView, screen15NightImageView, screen15Wave1ImageView, screen15Wave2ImageView, screen15Wave3ImageView, screen15Cloud01ImageView, screen15Cloud02ImageView,screen15Cloud03ImageView, screen15StarImageView, screen15StarControl, screen15BlackImageView, screen16View, screen16CarouselView, screen16AmihanHangImageView, screen16KusiniHangImageView, screen16TalamhHangImageView, screen16ZiemeluHangImageView, screen16CarouselTouchView, screen16CarouselRisenImageView, screen16CarouselTightImageView,screen16CloudImageView, screen16InoriControl, screen16ButterfliesView, screen16NightImageView;

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

- (IBAction)screen15_16BackToMainMenu:(id)sender;
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController=0;
    viewContoller = nil;
    
    [self goToNextScreen];
}

- (IBAction)screen15_16NextScreenButtonTouched:(id)sender
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController++;
    viewContoller = nil;
    
    [self goToNextScreen];
}

- (IBAction)screen15_16PreviousScreenButtonTouched:(id)sender
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController--;
    viewContoller = nil;
    
    [self goToNextScreen];
}

-(void)screen15StartCloud;
{
    cloudMovingTimerClock=screen15Cloud01ImageView.center.x;
    cloudMovingTimer = [NSTimer scheduledTimerWithTimeInterval:CLOUD15_TIME_INTERVAL target:self selector:@selector(screen15CloudMovingAction:) userInfo:nil repeats:YES];
    cloudMovingTimerClockChange=CLOUD15_SHIFT;
    [cloudMovingTimer fire];
}

-(void) screen15CloudMovingAction:(id)sender;
{
    cloudMovingTimerClock=cloudMovingTimerClock+cloudMovingTimerClockChange;
    [screen15Cloud01ImageView setCenter:CGPointMake(cloudMovingTimerClock,screen15Cloud01ImageView.center.y )];
    [screen15Cloud02ImageView setCenter:CGPointMake(cloudMovingTimerClock-CLOUD15_X_DIFF,screen15Cloud02ImageView.center.y )];
    [screen15Cloud03ImageView setCenter:CGPointMake(cloudMovingTimerClock-(CLOUD15_X_DIFF*2),screen15Cloud03ImageView.center.y )];

    if (cloudMovingTimerClock>CLOUD15_STOP_X) {
        UIImageView *swapImageView = screen15Cloud01ImageView;
        screen15Cloud01ImageView=screen15Cloud02ImageView;
        screen15Cloud02ImageView=screen15Cloud03ImageView;
        screen15Cloud03ImageView=swapImageView;
        
        cloudMovingTimerClock=screen15Cloud01ImageView.center.x;
        [screen15Cloud02ImageView setCenter:CGPointMake(cloudMovingTimerClock-CLOUD15_X_DIFF,screen15Cloud02ImageView.center.y )];
        [screen15Cloud03ImageView setCenter:CGPointMake(cloudMovingTimerClock-(CLOUD15_X_DIFF*2),screen15Cloud02ImageView.center.y )];
    }
}

-(void)screen15StartWaving;
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
    if ([screen16View superview]==nil)
    {
        newCenter=CGPointMake(WAVE1_ORIG_CENTER);
    } else {
        newCenter=CGPointMake(WAVE1_ORIG_CENTER_FOR_SCREEN16);
    }
    newCenter.y=newCenter.y-wavingClock+(WAVING_MAX_Y/2);
    [screen15Wave1ImageView setCenter:newCenter];
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
    if ([screen16View superview]==nil)
    {
        newCenter=CGPointMake(WAVE1_ORIG_CENTER);
    } else {
        newCenter=CGPointMake(WAVE1_ORIG_CENTER_FOR_SCREEN16);
    }
    newCenter.y=newCenter.y-wavingClock2+(WAVING_MAX_Y/2);
    [screen15Wave2ImageView setCenter:newCenter];
}

- (IBAction)screen15_16StarControlTouched:(id)sender;
{
    [screen15StarImageView setFrame:CGRectMake(0,0,1,1)];
    [screen15StarImageView setCenter:screen15StarControl.center];
    
    CGAffineTransform newTransform = CGAffineTransformMakeRotation(M_PI);
    
    [UIView animateWithDuration: STAR_COME_IN_TIME
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^
     {
         [screen15StarImageView setFrame:CGRectMake(-150,-278,1324,1324)];
         [screen15StarImageView setTransform:newTransform];
     }  completion:^(BOOL finished)
        {
         [screen15BlackImageView setHidden:false];
         [UIView animateWithDuration: 1.0
                               delay: 0
                             options: UIViewAnimationOptionCurveLinear
                          animations:^
          {
              [screen15BlackImageView setAlpha:1];
          }
                          completion:^(BOOL finished)
            {
                //stop timers on screen15 that are not necessary on screen16
                [cloudMovingTimer invalidate];
                
                //remove non-used imageviews from screen15
                [screen15BackgroundImageView removeFromSuperview];
                screen15BackgroundImageView=nil;
                [screen15Wave1ImageView removeFromSuperview];
                [screen15Wave2ImageView removeFromSuperview];
                [screen15Wave3ImageView removeFromSuperview];
                [screen15Cloud01ImageView removeFromSuperview];
                screen15Cloud01ImageView=nil;
                [screen15Cloud02ImageView removeFromSuperview];
                screen15Cloud02ImageView=nil;
                [screen15Cloud03ImageView removeFromSuperview];
                screen15Cloud03ImageView=nil;
                [screen15NightImageView removeFromSuperview];
                screen15NightImageView=nil;
                [screen15StarControl removeFromSuperview];
                screen15StarControl=nil;
                [screen15StarImageView removeFromSuperview];
                screen15StarImageView=nil;
                
                //add waves to screen16
                [screen16View addSubview:screen15Wave1ImageView];
                [screen16View addSubview:screen15Wave2ImageView];
                [screen16View addSubview:screen15Wave3ImageView];
                CGAffineTransform newtransform = CGAffineTransformMakeRotation(WAVES_ROTATION_FOR_SCREEN16);
                [screen15Wave1ImageView setTransform:newtransform];
                [screen15Wave2ImageView setTransform:newtransform];
                [screen15Wave3ImageView setTransform:newtransform];
                [screen15Wave3ImageView setCenter:CGPointMake(WAVE1_ORIG_CENTER_FOR_SCREEN16)];
                
                //place carousel and night layer to the top of all
                [screen16CarouselView removeFromSuperview];
                [screen16View addSubview:screen16CarouselView];
                [screen16NightImageView removeFromSuperview];
                [screen16View addSubview:screen16NightImageView];
                
                //put screen16 in place
                [self.view addSubview:screen16View];
                [screen15BlackImageView removeFromSuperview];
                [self.view addSubview:screen15BlackImageView];
                
                //fade screen16 in
                [UIView animateWithDuration:1.0 animations:^
                {
                    [screen15BlackImageView setAlpha:0];
                } completion:^(BOOL finished)
                {
                    [screen15BlackImageView removeFromSuperview];
                    screen15BlackImageView=nil;
                    
                     [self carouselComeIn];
                     [self startChildrenRocking];
                     [self screen16StartCloud];
                     [self butterflyInit];

                }];
                //*****
            }];
        }
     ];

}

-(void)carouselComeIn;
{
    [UIView animateWithDuration: 0.0
                          delay: CAROUSEL_COME_IN_TIME_DELAY
                        options: UIViewAnimationOptionCurveLinear
                     animations:^
     {
         [screen16CarouselView setAlpha:1];
     }
                     completion:nil];
    [screen16CarouselView setCenter:CGPointMake(CAROUSEL_CENTER_1ST_STAGE)];
    [UIView animateWithDuration: CAROUSEL_COME_IN_TIME
                          delay: CAROUSEL_COME_IN_TIME_DELAY
                        options: UIViewAnimationOptionCurveLinear
                     animations:^
     {
         [screen16CarouselView setCenter:CGPointMake(CAROUSEL_CENTER_2ND_STAGE)];
     }
                     completion:nil];
    

}

-(BOOL)carouselTouched:(CGPoint) translatedPoint;
{
    BOOL carouselIsTouched=false;
    CGRect frame;
    frame=screen16CarouselTouchView.frame;
    frame=CGRectMake(frame.origin.x+screen16CarouselView.frame.origin.x, frame.origin.y+screen16CarouselView.frame.origin.y, frame.size.width, frame.size.height);
    if (CGRectContainsPoint(frame, translatedPoint))
    {
        carouselIsTouched=TRUE;
    }
    
    frame=screen16AmihanHangImageView.frame;
    frame=CGRectMake(frame.origin.x+screen16CarouselView.frame.origin.x, frame.origin.y+screen16CarouselView.frame.origin.y, frame.size.width, frame.size.height);
    if (CGRectContainsPoint(frame, translatedPoint))
    {
        carouselIsTouched=TRUE;
    }
    
    frame=screen16KusiniHangImageView.frame;
    frame=CGRectMake(frame.origin.x+screen16CarouselView.frame.origin.x, frame.origin.y+screen16CarouselView.frame.origin.y, frame.size.width, frame.size.height);
    if (CGRectContainsPoint(frame, translatedPoint))
    {
        carouselIsTouched=TRUE;
    }
    
    frame=screen16TalamhHangImageView.frame;
    frame=CGRectMake(frame.origin.x+screen16CarouselView.frame.origin.x, frame.origin.y+screen16CarouselView.frame.origin.y, frame.size.width, frame.size.height);
    if (CGRectContainsPoint(frame, translatedPoint))
    {
        carouselIsTouched=TRUE;
    }
    
    frame=screen16ZiemeluHangImageView.frame;
    frame=CGRectMake(frame.origin.x+screen16CarouselView.frame.origin.x, frame.origin.y+screen16CarouselView.frame.origin.y, frame.size.width, frame.size.height);
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
         [screen16CarouselRisenImageView setAlpha:1-screen16CarouselRisenImageView.alpha];
         [screen16CarouselTightImageView setAlpha:1-screen16CarouselTightImageView.alpha];
         
         if ([screen16CarouselTightImageView alpha]==1)
         {
             [screen16AmihanHangImageView setCenter:CGPointMake(AMIHAN_HANG_CENTER_TIGHT_CAROUSEL)];
             [screen16KusiniHangImageView setCenter:CGPointMake(KUSINI_HANG_CENTER_TIGHT_CAROUSEL)];
             [screen16TalamhHangImageView setCenter:CGPointMake(TALAMH_HANG_CENTER_TIGHT_CAROUSEL)];
             [screen16ZiemeluHangImageView setCenter:CGPointMake(ZIEMELU_HANG_CENTER_TIGHT_CAROUSEL)];
         } else
         {
             [screen16AmihanHangImageView setCenter:CGPointMake(AMIHAN_HANG_CENTER_RISEN_CAROUSEL)];
             [screen16KusiniHangImageView setCenter:CGPointMake(KUSINI_HANG_CENTER_RISEN_CAROUSEL)];
             [screen16TalamhHangImageView setCenter:CGPointMake(TALAMH_HANG_CENTER_RISEN_CAROUSEL)];
             [screen16ZiemeluHangImageView setCenter:CGPointMake(ZIEMELU_HANG_CENTER_RISEN_CAROUSEL)];
         }
         
     }
                     completion:nil];
    
}

-(void)inoriTouched;
{
    Screen15_16UIImageViewButterfly *newButterflyImageView=[Screen15_16UIImageViewButterfly alloc];
    if (arc4random()%2==0)
    {
        newButterflyImageView=[newButterflyImageView initWithFrame:CGRectMake(BUTTERFLY1_START_FRAME)];
        newButterflyImageView.image=[UIImage imageNamed:@"16_1k_szita1.png"];
    } else
    {
        newButterflyImageView=[newButterflyImageView initWithFrame:CGRectMake(BUTTERFLY2_START_FRAME)];
        newButterflyImageView.image=[UIImage imageNamed:@"16_1k_szita2.png"];
        
    }
    
    [newButterflyImageView setCenter:CGPointMake(arc4random()%1024, 748)];
    
    [screen16ButterfliesView addSubview:newButterflyImageView];
    originalButterflyTransform=[newButterflyImageView transform];
    
    newButterflyImageView=nil;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
{    
	NSUInteger touchCount = 0;
	for (UITouch *touch in touches)
	{
		CGPoint translatedPoint = [touch locationInView:self.view];
		
        if ([self carouselTouched:translatedPoint])
        {
            [self carouselChange];
        }
        
        if (CGRectContainsPoint(screen16InoriControl.frame, translatedPoint))
        {
            [self inoriTouched];
        }

        touchCount++;
	}
}

-(void)startChildrenRocking;
{
    amihanHangOriginalTransform=[screen16AmihanHangImageView transform];
    amihanRockingClock=0;
    amihanRockingTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(screen15_16AmihanRockingAction:) userInfo:nil repeats:YES];
    amihanRockingClockChange=AMIHAN_ROTATE_SHIFT;
    [amihanRockingTimer fire];
    
    kusiniHangOriginalTransform=[screen16KusiniHangImageView transform];
    kusiniRockingClock=0;
    kusiniRockingTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(screen15_16KusiniRockingAction:) userInfo:nil repeats:YES];
    kusiniRockingClockChange=KUSINI_ROTATE_SHIFT;
    [kusiniRockingTimer fire];
    
    talamhHangOriginalTransform=[screen16TalamhHangImageView transform];
    talamhRockingClock=0;
    talamhRockingTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(screen15_16TalamhRockingAction:) userInfo:nil repeats:YES];
    talamhRockingClockChange=TALAMH_ROTATE_SHIFT;
    [talamhRockingTimer fire];
    
    ziemeluHangOriginalTransform=[screen16ZiemeluHangImageView transform];
    ziemeluRockingClock=0;
    ziemeluRockingTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(screen15_16ZiemeluRockingAction:) userInfo:nil repeats:YES];
    ziemeluRockingClockChange=ZIEMELU_ROTATE_SHIFT;
    [ziemeluRockingTimer fire];
}

- (void) setAmihanRockingState;
{
    CGAffineTransform newTransform = CGAffineTransformRotate(amihanHangOriginalTransform,(1.00*amihanRockingClock/18000.00*M_PI));
    [screen16AmihanHangImageView setTransform:newTransform];
}

-(void) screen15_16AmihanRockingAction:(id)sender;
{
    amihanRockingClock=amihanRockingClock+amihanRockingClockChange;
    if ((amihanRockingClock < AMIHAN_ROTATE_LEFT)||(amihanRockingClock > AMIHAN_ROTATE_RIGHT)) {
        amihanRockingClockChange=-amihanRockingClockChange;
    }
    [self setAmihanRockingState];
}


- (void) setKusiniRockingState;
{
    CGAffineTransform newTransform = CGAffineTransformRotate(kusiniHangOriginalTransform,(1.00*kusiniRockingClock/18000.00*M_PI));
    [screen16KusiniHangImageView setTransform:newTransform];
}

-(void) screen15_16KusiniRockingAction:(id)sender;
{
    kusiniRockingClock=kusiniRockingClock+kusiniRockingClockChange;
    if ((kusiniRockingClock < KUSINI_ROTATE_LEFT)||(kusiniRockingClock > KUSINI_ROTATE_RIGHT)) {
        kusiniRockingClockChange=-kusiniRockingClockChange;
    }
    [self setKusiniRockingState];
}

- (void) setTalamhRockingState;
{
    CGAffineTransform newTransform = CGAffineTransformRotate(talamhHangOriginalTransform,(1.00*talamhRockingClock/18000.00*M_PI));
    [screen16TalamhHangImageView setTransform:newTransform];
}

-(void) screen15_16TalamhRockingAction:(id)sender;
{
    talamhRockingClock=talamhRockingClock+talamhRockingClockChange;
    if ((talamhRockingClock < TALAMH_ROTATE_LEFT)||(talamhRockingClock > TALAMH_ROTATE_RIGHT)) {
        talamhRockingClockChange=-talamhRockingClockChange;
    }
    [self setTalamhRockingState];
}

- (void) setZiemeluRockingState;
{
    CGAffineTransform newTransform = CGAffineTransformRotate(ziemeluHangOriginalTransform,(1.00*ziemeluRockingClock/18000.00*M_PI));
    [screen16ZiemeluHangImageView setTransform:newTransform];
}

-(void) screen15_16ZiemeluRockingAction:(id)sender;
{
    ziemeluRockingClock=ziemeluRockingClock+ziemeluRockingClockChange;
    if ((ziemeluRockingClock < ZIEMELU_ROTATE_LEFT)||(ziemeluRockingClock > ZIEMELU_ROTATE_RIGHT)) {
        ziemeluRockingClockChange=-ziemeluRockingClockChange;
    }
    [self setZiemeluRockingState];
}

-(void) screen16CloudMovingAction:(id)sender;
{
    cloudMovingTimerClock=cloudMovingTimerClock+cloudMovingTimerClockChange;
    [screen16CloudImageView setCenter:CGPointMake(cloudMovingTimerClock,screen16CloudImageView.center.y )];
    if (cloudMovingTimerClock>CLOUD16_STOP_X) {
        cloudMovingTimerClockChange=1;
    }
    if (cloudMovingTimerClock>CLOUD16_STOP_X2) {
        [screen16CloudImageView setCenter:CGPointMake(CLOUD16_START_CENTER)];
        cloudMovingTimerClock=screen16CloudImageView.center.x;
        int rndShift=roundf((CLOUD16_SHIFT_MAX-CLOUD16_SHIFT_MIN)*1000)+1;
        cloudMovingTimerClockChange=CLOUD16_SHIFT_MIN+(arc4random()%rndShift)/1000;
        CGAffineTransform newTransform=CGAffineTransformRotate([screen16CloudImageView transform], M_PI);
        [screen16CloudImageView setTransform:newTransform];
    }
}

-(void)screen16StartCloud;
{
    [screen16CloudImageView setCenter:CGPointMake(CLOUD16_START_CENTER)];
    cloudMovingTimerClock=screen16CloudImageView.center.x;
    cloudMovingTimer = [NSTimer scheduledTimerWithTimeInterval:CLOUD_TIME_INTERVAL target:self selector:@selector(screen16CloudMovingAction:) userInfo:nil repeats:YES];
    int rndShift=roundf((CLOUD16_SHIFT_MAX-CLOUD16_SHIFT_MIN)*1000)+1;
    cloudMovingTimerClockChange=CLOUD16_SHIFT_MIN+(arc4random()%rndShift)/1000;
    [cloudMovingTimer fire];
}

-(void) screen15_16ButterfliesFlyingAction:(id)sender;
{
    NSArray *subviews = [screen16ButterfliesView subviews];
    for (Screen15_16UIImageViewButterfly *subview in subviews)
    {
        if (subview.xChangeType==0)
        {
            subview.xChange=subview.xChange*0.995;
        } else
        {
            subview.xChange=subview.xChange*1.005;
        }
        [subview setCenter:CGPointMake(subview.center.x+subview.xChange, subview.center.y-subview.yChange)];

        if (subview.center.y<-200)
        {
            [subview removeFromSuperview];
        }

        CGFloat newDegree = atanf(subview.xChange/subview.yChange);
        CGAffineTransform newTransform=CGAffineTransformMakeRotation(newDegree);
        [subview setTransform:newTransform];

    }
    
}

-(void)butterflyInit;
{
    butterfliesFlyingTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(screen15_16ButterfliesFlyingAction:) userInfo:nil repeats:YES];
    [butterfliesFlyingTimer fire];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (CGPoint)rotatePoint:(CGPoint)pointToRotate around:(CGPoint)center withDegree:(float)degree
{
	pointToRotate = CGPointMake(pointToRotate.x-center.x,pointToRotate.y-center.y);
	CGPoint rotatedPoint = CGPointMake(pointToRotate.x*cos(degree)-pointToRotate.y*sin(degree),pointToRotate.x*sin(degree)+pointToRotate.y*cos(degree));
	rotatedPoint.x=center.x+rotatedPoint.x;
	rotatedPoint.y=center.y+rotatedPoint.y;
	return rotatedPoint;
}

-(void)startBackgroundMusic;
{
    //set the Music for intro then start playing
	NSString *backgroundMusicPath = [[NSBundle mainBundle] pathForResource:@"001_Atm_tucsok_tuz_zene" ofType:@"mp3"];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self screen15StartCloud];
    [self screen15StartWaving];
    
    [self startBackgroundMusic];
}

- (void)viewWillDisappear:(BOOL)animated;
{
    [self stopMusicAndSfx];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
