//
//  Screen13ViewController.m
//  KickOff
//
//  Created by Ferenc INKOVICS on 19/01/2013.
//  Copyright (c) 2013 No company - private person. All rights reserved.
//
/*
 Fazis 0:
 - hatter kep alapbol ott van,
 - 1 mp delay utan a 4 hangszer a 4 oldal felol egyszerre beuszik, dob balrol, citera felulrol, furulya alulrol, gitar jobbrol,
 - ahogy beertek a 4 felirat is feltunik a maga helyen, egyenkent, 1 mp kozonkent, atlatszobol es kicsibol (mint a screen 11-en a fazekban a zoldsegek)
 
 Interakcio fazis:
 - a hangszerek erintesre hangot adnak (ezt majd kesobb megoldjuk), illetve kicsit mocorognak (pl: kozeppontjuk korul kicsi amplitudoval, magas frekvenciaval, ingamozgast vegeznek random iranyban). Ez utobbi lehet mas is ha van javaslat.
*/
#define CENTER_X_SHIFT           768 //512, 768
#define CENTER_Y_SHIFT           576 //384, 576

#define DRUM_INITIAL_CENTER      512-CENTER_X_SHIFT,384
#define ZITHER_INITIAL_CENTER    512,384-CENTER_Y_SHIFT
#define GUITAR_INITIAL_CENTER    512+CENTER_X_SHIFT,384
#define FLUTE_INITIAL_CENTER     512,384+CENTER_Y_SHIFT
#define MUSICAL_INSTRUMENTS_COME_IN_TIME     3.0
#define MUSICAL_INSTRUMENTS_COME_IN_DELAY    0.0
#define MUSICAL_INSTRUMENTS_LABEL_COME_IN_TIME     0.5
#define MI_SIZE_DIFF                        0.23
#define MI_SHIFT_DIFF                       3
#define MUSICAL_INSTRUMENTS_TIMER_START     30
#define MUSICAL_INSTRUMENTS_TIMER_FREQUENCY 0.01

#import "Screen13ViewController.h"
#import "ViewController.h"

@interface Screen13ViewController ()

@end

@implementation Screen13ViewController

@synthesize compassControl, Screen13BackgroundImageView, Screen13DrumImageView, Screen13DrumLabelImageView, Screen13FluteImageView, Screen13FluteLabelImageView, Screen13GuitarImageView, Screen13GuitarLabelImageView, Screen13ZitherImageView, Screen13ZitherLabelImageView, Screen13DrumTouchView, Screen13FluteTouchView, Screen13GuitarTouchView, Screen13ZitherTouchView;

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

- (void)screen13BackToMainMenu;
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController=0;
    viewContoller = nil;
    
    [self goToNextScreen];
}

- (void)screen13NextScreenButtonTouched;
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController++;
    viewContoller = nil;
    
    [self goToNextScreen];
}

- (void)screen13PreviousScreenButtonTouched;
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
{
    if (screenIsTouchable)
    {
        NSUInteger touchCount = 0;
        for (UITouch *touch in touches)
        {
            CGPoint translatedPoint = [touch locationInView:self.view];
            
            if (CGRectContainsPoint(compassControl.frame, translatedPoint))
            {
                [self screen13BackToMainMenu];
            }

            if ([self Screen13IsMI:Screen13FluteTouchView TouchedAtPoint:translatedPoint])
            {
                fluteTimerClock=MUSICAL_INSTRUMENTS_TIMER_START;
                if (![fluteTimer isValid])
                {
                    fluteTimer = [NSTimer scheduledTimerWithTimeInterval:MUSICAL_INSTRUMENTS_TIMER_FREQUENCY target:self selector:@selector(fluteTimerActionMethod) userInfo:nil repeats:YES];
                    [fluteTimer fire];
                }
            }
            
            if ([self Screen13IsMI:Screen13GuitarTouchView TouchedAtPoint:translatedPoint])
            {
                guitarTimerClock=MUSICAL_INSTRUMENTS_TIMER_START;
                if (![guitarTimer isValid])
                {
                    guitarTimer = [NSTimer scheduledTimerWithTimeInterval:MUSICAL_INSTRUMENTS_TIMER_FREQUENCY target:self selector:@selector(guitarTimerActionMethod) userInfo:nil repeats:YES];
                    [guitarTimer fire];
                }
            }
            
            if ([self Screen13IsMI:Screen13DrumTouchView TouchedAtPoint:translatedPoint])
            {
                drumTimerClock=MUSICAL_INSTRUMENTS_TIMER_START;
                if (![drumTimer isValid])
                {
                    drumTimer = [NSTimer scheduledTimerWithTimeInterval:MUSICAL_INSTRUMENTS_TIMER_FREQUENCY target:self selector:@selector(drumTimerActionMethod) userInfo:nil repeats:YES];
                    [drumTimer fire];
                }
            }
            
            if ([self Screen13IsMI:Screen13ZitherTouchView TouchedAtPoint:translatedPoint])
            {
                zitherTimerClock=MUSICAL_INSTRUMENTS_TIMER_START;
                if (![zitherTimer isValid])
                {
                    zitherTimer = [NSTimer scheduledTimerWithTimeInterval:MUSICAL_INSTRUMENTS_TIMER_FREQUENCY target:self selector:@selector(zitherTimerActionMethod) userInfo:nil repeats:YES];
                    [zitherTimer fire];
                }
            }
            
            touchCount++;
        }
    }
}

-(void)guitarTimerActionMethod;
{
    guitarTimerClock--;
    CGFloat newRotation=(1.00*(arc4random()%5))/100;
    CGAffineTransform newTransform = CGAffineTransformMakeRotation(newRotation);
    [Screen13GuitarImageView setTransform:newTransform];
    
    if (guitarTimerClock==0)
    {
        CGAffineTransform newTransform = CGAffineTransformMakeRotation(0);
        [Screen13GuitarImageView setTransform:newTransform];
        [guitarTimer invalidate];
    }
    
}

-(void)zitherTimerActionMethod;
{
    
    zitherTimerClock--;
    CGFloat newRotation=(1.00*(arc4random()%5))/100;
    CGAffineTransform newTransform = CGAffineTransformMakeRotation(newRotation);
    [Screen13ZitherImageView setTransform:newTransform];
    
    if (zitherTimerClock==0)
    {
        CGAffineTransform newTransform = CGAffineTransformMakeRotation(0);
        [Screen13ZitherImageView setTransform:newTransform];
        [zitherTimer invalidate];
    }
}

-(void)fluteTimerActionMethod;
{
    fluteTimerClock--;
    CGFloat newRotation=(1.00*(arc4random()%5))/100;
    CGAffineTransform newTransform = CGAffineTransformMakeRotation(newRotation);
    [Screen13FluteImageView setTransform:newTransform];
    
    if (fluteTimerClock==0)
    {
        CGAffineTransform newTransform = CGAffineTransformMakeRotation(0);
        [Screen13FluteImageView setTransform:newTransform];
        [fluteTimer invalidate];
    }
}

-(void)drumTimerActionMethod;
{
/* other solution
 drumTimerClock--;
 CGFloat newRotation=(1.00*(arc4random()%5))/100;
 CGAffineTransform newTransform = CGAffineTransformMakeRotation(newRotation);
 [Screen13DrumImageView setTransform:newTransform];
 
 if (drumTimerClock==0)
 {
 CGAffineTransform newTransform = CGAffineTransformMakeRotation(0);
 [Screen13DrumImageView setTransform:newTransform];
 [drumTimer invalidate];
 }
*/
    drumTimerClock--;
    int xDiff = (arc4random()%(MI_SHIFT_DIFF*2))-MI_SHIFT_DIFF;
    int yDiff = (arc4random()%(MI_SHIFT_DIFF*2))-MI_SHIFT_DIFF;
    CGPoint newCenter = CGPointMake(512+xDiff, 384+yDiff);
    [Screen13DrumImageView setCenter:newCenter];
    
    if (drumTimerClock==0)
    {
        [Screen13DrumImageView setCenter:CGPointMake(512,384)];
        [drumTimer invalidate];
    }
    
}

-(BOOL)Screen13IsMI: (UIView *) musicInstrimentTouchView TouchedAtPoint: (CGPoint) translatedPoint;
{
    BOOL isTouched=false;
    translatedPoint=CGPointMake(translatedPoint.x-musicInstrimentTouchView.frame.origin.x, translatedPoint.y-musicInstrimentTouchView.frame.origin.y);
    NSArray *musicInstrumentSubViews=[musicInstrimentTouchView subviews];
    for (UIView *subView in musicInstrumentSubViews)
    {
        if (CGRectContainsPoint(subView.frame, translatedPoint))
        {
            isTouched=true;
        }
    }

    return isTouched;
}

-(void) screen13MusicalInstrumentsNewSize: (float)newSize;
{
    CGAffineTransform newTransform = CGAffineTransformMakeScale(newSize, newSize);
    [Screen13FluteImageView setTransform:newTransform];
    [Screen13GuitarImageView setTransform:newTransform];
    [Screen13ZitherImageView setTransform:newTransform];
    [Screen13DrumImageView setTransform:newTransform];
//    [Screen13FluteLabelImageView setTransform:newTransform];
//    [Screen13GuitarLabelImageView setTransform:newTransform];
//    [Screen13ZitherLabelImageView setTransform:newTransform];
//    [Screen13DrumLabelImageView setTransform:newTransform];
    
}

-(void) screen13MusicalInstrumentsComeIn;
{
    [Screen13FluteImageView setCenter:CGPointMake(FLUTE_INITIAL_CENTER)];
    [Screen13GuitarImageView setCenter:CGPointMake(GUITAR_INITIAL_CENTER)];
    [Screen13ZitherImageView setCenter:CGPointMake(ZITHER_INITIAL_CENTER)];
    [Screen13DrumImageView setCenter:CGPointMake(DRUM_INITIAL_CENTER)];

    [self screen13MusicalInstrumentsNewSize:1-4*MI_SIZE_DIFF];
    
    [UIView animateWithDuration:MUSICAL_INSTRUMENTS_COME_IN_TIME delay:MUSICAL_INSTRUMENTS_COME_IN_DELAY options:UIViewAnimationOptionCurveLinear animations:^
    {
        [Screen13FluteImageView setCenter:CGPointMake(512,384)];
        [Screen13GuitarImageView setCenter:CGPointMake(512,384)];
        [Screen13ZitherImageView setCenter:CGPointMake(512,384)];
        [Screen13DrumImageView setCenter:CGPointMake(512,384)];
        [self screen13MusicalInstrumentsNewSize:1];
    } completion:^(BOOL finished)
    {
        [UIView animateWithDuration:MUSICAL_INSTRUMENTS_LABEL_COME_IN_TIME delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            [Screen13FluteLabelImageView setAlpha:1];
            
        } completion:nil];

        [UIView animateWithDuration:MUSICAL_INSTRUMENTS_LABEL_COME_IN_TIME delay:MUSICAL_INSTRUMENTS_LABEL_COME_IN_TIME options:UIViewAnimationOptionCurveLinear animations:^{
            [Screen13GuitarLabelImageView setAlpha:1];
            
        } completion:nil];
        
        [UIView animateWithDuration:MUSICAL_INSTRUMENTS_LABEL_COME_IN_TIME delay:2*MUSICAL_INSTRUMENTS_LABEL_COME_IN_TIME options:UIViewAnimationOptionCurveLinear animations:^{
            [Screen13ZitherLabelImageView setAlpha:1];
            
        } completion:nil];
        
        [UIView animateWithDuration:MUSICAL_INSTRUMENTS_LABEL_COME_IN_TIME delay:3*MUSICAL_INSTRUMENTS_LABEL_COME_IN_TIME options:UIViewAnimationOptionCurveLinear animations:^{
            [Screen13DrumLabelImageView setAlpha:1];
            
        } completion:^(BOOL finished){screenIsTouchable=true;}];
        
    }];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    screenIsTouchable=false;
    
    [self screen13MusicalInstrumentsComeIn];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
