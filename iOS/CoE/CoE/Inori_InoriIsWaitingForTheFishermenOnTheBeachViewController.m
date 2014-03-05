//
//  Screen04ViewController.m
//  KickOff
//
//  Created by INKOVICS Ferenc on 29/03/2012.
//  Copyright (c) 2012 No company - private person. All rights reserved.
//

#import "Inori_InoriIsWaitingForTheFishermenOnTheBeachViewController.h"
#import "ViewController.h"

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

#define SNAIL_LEFT_X               512
#define SNAIL_LEFT_Y               384
#define SNAIL_RIGHT_X              850
#define SNAIL_RIGHT_Y              335

#define SNAIL_CONTROL_X            593
#define SNAIL_CONTROL_Y            656

#define BIG_SHIP_MIN_SIZE          0.30
#define SMALL_SHIP_MIN_SIZE        0.30

#define BIG_SHIP_START_WIDTH       400
#define BIG_SHIP_STOP_WIDTH        1024
#define BIG_SHIP_START_X           0
#define BIG_SHIP_START_Y           0
#define BIG_SHIP_STOP_X            574
#define BIG_SHIP_STOP_Y            0

#define SMALL_SHIP_START_WIDTH       400
#define SMALL_SHIP_STOP_WIDTH        1024
#define SMALL_SHIP_START_X           500
#define SMALL_SHIP_START_Y           0
#define SMALL_SHIP_STOP_X            0
#define SMALL_SHIP_STOP_Y            0

#define SMALL_SHIP_ROTATE_LEFT       -500
#define SMALL_SHIP_ROTATE_RIGHT      500

#define BIG_SHIP_ROTATE_LEFT         -250
#define BIG_SHIP_ROTATE_RIGHT        250

#define SMALL_SHIP_ROTATE_SHIFT      25
#define BIG_SHIP_ROTATE_SHIFT        10

#define HINT_TIME                                       1.0

@implementation Inori_InoriIsWaitingForTheFishermenOnTheBeachViewController

@synthesize screen04BaseImageView, screen04InoriSitting, screen04InoriStanding, screen04Wave1ImageView, screen04Wave2ImageView, screen04Wave3ImageView, screen04Wave4ImageView, screen04SnailImageView, screen04SnailControl, screen04BigShipView, screen04SmallShipView, screen04BigShipControl, screen04SmallShipControl, screen04InoriControl, screen04BigShipImageView, screen04SmallShipImageView, screen04MusicButton, screen04NextScreenButton, screen04PreviousScreenButton, screen04HintButton, screen04MenuImageView, screen04NarrationButton, hintLayerImageView;

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

- (void)screen04NextScreenControlTapped;
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController++;
    viewContoller = nil;
    
    [self goToNextScreen];
}

- (void)screen04PreviousScreenControlTapped;
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController--;
    viewContoller = nil;
    
    [self goToNextScreen];
}

- (void)allInteractionFound;
{
    if (snailInteractionFound&&inoriInteractionFound&&shipsInteractionFound)
    {
        self.screen04MenuImageView.image=nil;
        [self.screen04MenuImageView setImage:[UIImage imageNamed:@"menu_set-top-g.png"]];
    }
}

- (void)screen04InoriTapped;
{
    inoriInteractionFound = true;
    [self allInteractionFound];

    if (screen04InoriSitting.alpha == 0)
    {
        [self startsfxInori];
    }
    else
    {
        [UIView animateWithDuration: 1.0
                              delay: 0.0
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^
         {
             [screen04InoriSitting setAlpha:1-screen04InoriSitting.alpha];
         }
                         completion:nil];
        
        [UIView animateWithDuration: 1.0
                              delay: 0.5
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^
         {
             [screen04InoriStanding setAlpha:1-screen04InoriStanding.alpha];
         }
                         completion:nil];

    }
}

-(void)screen04Move:(id)sender
{
    CGPoint locatedPoint = [(UIPanGestureRecognizer*)sender locationInView:self.view];
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
    CGPoint calculatedCenter;
    CGRect calculatedFrame;
    CGFloat sliderPercentage;
    
	if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan)
    {        
        if (CGRectContainsPoint(screen04SnailControl.frame, locatedPoint)) 
        {
            isSnailMoving=true;
            [self startsfxSnail];
            previousSnailCenter=screen04SnailImageView.center;
        }
	}
    else
        if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged) 
        {            
            if (isSnailMoving) 
            {
                calculatedCenter.x=previousSnailCenter.x+translatedPoint.x;
                if (calculatedCenter.x<SNAIL_LEFT_X) 
                {
                    calculatedCenter.x=SNAIL_LEFT_X;
                }
                if (calculatedCenter.x>SNAIL_RIGHT_X) 
                {
                    calculatedCenter.x=SNAIL_RIGHT_X;
                    snailInteractionFound = true;
                    [self allInteractionFound];
                }
                sliderPercentage=(calculatedCenter.x-SNAIL_LEFT_X)/(SNAIL_RIGHT_X-SNAIL_LEFT_X);
                calculatedCenter.y=SNAIL_LEFT_Y+sliderPercentage*(SNAIL_RIGHT_Y-SNAIL_LEFT_Y);
                [screen04SnailImageView setCenter:calculatedCenter];
                [screen04SnailControl setCenter:CGPointMake(SNAIL_CONTROL_X+calculatedCenter.x-512, SNAIL_CONTROL_Y+calculatedCenter.y-374)];
                

                //calculating the new frame for the big ship
                calculatedFrame.origin.x = (BIG_SHIP_STOP_X-BIG_SHIP_START_X)*(1-sliderPercentage)+BIG_SHIP_START_X;
                calculatedFrame.origin.y = BIG_SHIP_START_Y+(1-sliderPercentage)*(BIG_SHIP_STOP_Y-BIG_SHIP_START_Y);
                calculatedFrame.size.width = 1024-calculatedFrame.origin.x;
                calculatedFrame.size.height = 768*((1024-calculatedFrame.origin.x)/1024);
                
                //to avoid the unwanted transformation of the ship frame transformation should be changed back to the original transformation then back to the latest transformation
                CGAffineTransform transformSave = [screen04BigShipView transform];
                [screen04BigShipView setTransform:bigShipOriginalTransform];
                [screen04BigShipView setFrame:calculatedFrame];
                [screen04BigShipView setTransform:transformSave];
                
                //calculating the new frame for the small ship
                calculatedFrame.origin.x = SMALL_SHIP_STOP_X-((1-sliderPercentage)*(SMALL_SHIP_STOP_X-SMALL_SHIP_START_X));
                calculatedFrame.origin.y = SMALL_SHIP_START_Y+(1-sliderPercentage)*(SMALL_SHIP_STOP_Y-SMALL_SHIP_START_Y);
                calculatedFrame.size.width = SMALL_SHIP_START_WIDTH+((1024-SMALL_SHIP_START_WIDTH)*(sliderPercentage));
                calculatedFrame.size.height = 768*(calculatedFrame.size.width/1024);
                
                //to avoid the unwanted transformation of the ship frame transformation should be changed back to the original transformation then back to the latest transformation
                transformSave = [screen04SmallShipView transform];
                [screen04SmallShipView setTransform:smallShipOriginalTransform];
                [screen04SmallShipView setFrame:calculatedFrame];
                [screen04SmallShipView setTransform:transformSave];

                [self setSmallShipRockingState];
                [self setBigShipRockingState];

                //set the volume for SFX for the boats - the closer the boats are the higher the volume of the sfx is
                ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
                boatsAreCloseVolumePercentage=sliderPercentage;
                if (viewContoller.musicIsOn)
                {
                    [sfxBoatsAreClose setVolume:boatsAreCloseVolumePercentage];
                }
                else
                {
                    [sfxBoatsAreClose setVolume:0.0];
                }
                
                [screen04BigShipView setAlpha:sliderPercentage];
                [screen04SmallShipView setAlpha:sliderPercentage];

            }
        }
        else
            if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) 
            {
                isSnailMoving=false;
                [sfxSnail1 stop];
                [sfxSnail2 stop];
                [sfxSnail3 stop];
            }
    
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    if (viewContoller.musicIsOn)
    {
        CGFloat volume1 = (boatsAreCloseVolumePercentage)/0.33;
        CGFloat volume2 = (boatsAreCloseVolumePercentage-0.33)/0.33;
        CGFloat volume3 = (boatsAreCloseVolumePercentage-0.66)/0.33;
        if (volume1>1.0)
        {
            volume1=1.0;
        }
        if (volume2<0)
        {
            volume2=0;
        }
        else
            if (volume2>1.0)
            {
                volume2=1.0;
            }
        if (volume3<0)
        {
            volume3=0;
        }
        else
            if (volume3>1.0)
            {
                volume3=1.0;
            }

//        NSLog([NSString stringWithFormat:@"%f, %f, %f",volume1,volume2,volume3]);
        
        [sfxSnail1 setVolume:volume1];
        [sfxSnail2 setVolume:volume2];
        [sfxSnail3 setVolume:volume3];
    }
    else
    {
        [sfxSnail1 setVolume:0.0];
        [sfxSnail2 setVolume:0.0];
        [sfxSnail3 setVolume:0.0];
    }
    

}


- (void) screen04ItIsWavingAction;
{
    CGFloat f;
    if ((screen04Wave1ImageView.alpha<1.0)&&(screen04Wave1ImageView.center.y>WAVE_1_APPEAR_CENTER_Y)) 
    {
        [screen04Wave1ImageView setAlpha:screen04Wave1ImageView.alpha+0.05];
    }
    if ((screen04Wave1ImageView.alpha>0.0)&&(screen04Wave1ImageView.center.y> WAVE_1_DISAPPEAR_CENTER_Y)) 
    {
        f=screen04Wave1ImageView.alpha;
        f=f-0.1;
        [screen04Wave1ImageView setAlpha:f];
        ;
    }
    [screen04Wave1ImageView setCenter:CGPointMake(screen04Wave1ImageView.center.x, screen04Wave1ImageView.center.y+1)];
    if (screen04Wave1ImageView.center.y>WAVE_1_STOP_CENTER_Y) 
    {
        [screen04Wave1ImageView setCenter:CGPointMake(screen04Wave1ImageView.center.x, WAVE_1_START_CENTER_Y)];
    }
    
    
    if ((screen04Wave2ImageView.alpha<1.0)&&(screen04Wave2ImageView.center.y>WAVE_2_APPEAR_CENTER_Y)) 
    {
        [screen04Wave2ImageView setAlpha:screen04Wave2ImageView.alpha+0.05];
    }
    if ((screen04Wave2ImageView.alpha>0.0)&&(screen04Wave2ImageView.center.y> WAVE_2_DISAPPEAR_CENTER_Y)) 
    {
        f=screen04Wave2ImageView.alpha;
        f=f-0.1;
        [screen04Wave2ImageView setAlpha:f];
        ;
    }
    [screen04Wave2ImageView setCenter:CGPointMake(screen04Wave2ImageView.center.x, screen04Wave2ImageView.center.y+1)];
    if (screen04Wave2ImageView.center.y>WAVE_2_STOP_CENTER_Y) 
    {
        [screen04Wave2ImageView setCenter:CGPointMake(screen04Wave2ImageView.center.x, WAVE_2_START_CENTER_Y)];
    }
    
    
    if ((screen04Wave3ImageView.alpha<1.0)&&(screen04Wave3ImageView.center.y>WAVE_3_APPEAR_CENTER_Y)) 
    {
        [screen04Wave3ImageView setAlpha:screen04Wave3ImageView.alpha+0.05];
    }
    if ((screen04Wave3ImageView.alpha>0.0)&&(screen04Wave3ImageView.center.y> WAVE_3_DISAPPEAR_CENTER_Y)) 
    {
        f=screen04Wave3ImageView.alpha;
        f=f-0.1;
        [screen04Wave3ImageView setAlpha:f];
        ;
    }
    [screen04Wave3ImageView setCenter:CGPointMake(screen04Wave3ImageView.center.x, screen04Wave3ImageView.center.y+1)];
    if (screen04Wave3ImageView.center.y>WAVE_3_STOP_CENTER_Y) 
    {
        [screen04Wave3ImageView setCenter:CGPointMake(screen04Wave3ImageView.center.x, WAVE_3_START_CENTER_Y)];
    }
    
    
    if ((screen04Wave4ImageView.alpha<1.0)&&(screen04Wave4ImageView.center.y>WAVE_4_APPEAR_CENTER_Y)) 
    {
        [screen04Wave4ImageView setAlpha:screen04Wave4ImageView.alpha+0.05];
    }
    if ((screen04Wave4ImageView.alpha>0.0)&&(screen04Wave4ImageView.center.y> WAVE_4_DISAPPEAR_CENTER_Y)) 
    {
        f=screen04Wave4ImageView.alpha;
        f=f-0.1;
        [screen04Wave4ImageView setAlpha:f];
        ;
    }
    [screen04Wave4ImageView setCenter:CGPointMake(screen04Wave4ImageView.center.x, screen04Wave4ImageView.center.y+1)];
    if (screen04Wave4ImageView.center.y>WAVE_4_STOP_CENTER_Y) 
    {
        [screen04Wave4ImageView setCenter:CGPointMake(screen04Wave4ImageView.center.x, WAVE_4_START_CENTER_Y)];
    }
    
}

- (void) setSmallShipRockingState;
{
    CGAffineTransform newTransform = CGAffineTransformRotate(smallShipOriginalTransform,1.00*smallShipRockingClock/18000.00*M_PI);
    [screen04SmallShipView setTransform:newTransform];    
}

- (void) setBigShipRockingState;
{
    CGAffineTransform newTransform = CGAffineTransformRotate(bigShipOriginalTransform,1.00*bigShipRockingClock/18000.00*M_PI);
    [screen04BigShipView setTransform:newTransform];    
}

- (void) screen04SmallShipRockingAction;
{
    smallShipRockingClock=smallShipRockingClock+smallShipRockingClockChange;
    if ((smallShipRockingClock < SMALL_SHIP_ROTATE_LEFT)||(smallShipRockingClock > SMALL_SHIP_ROTATE_RIGHT))
    {
        smallShipRockingClockChange=-smallShipRockingClockChange;
    }
    [self setSmallShipRockingState];
}

- (void) screen04BigShipRockingAction;
{
    bigShipRockingClock=bigShipRockingClock+bigShipRockingClockChange;
    if ((bigShipRockingClock < BIG_SHIP_ROTATE_LEFT)||(bigShipRockingClock > BIG_SHIP_ROTATE_RIGHT)) {
        bigShipRockingClockChange=-bigShipRockingClockChange;
    }
    [self setBigShipRockingState];
}

- (void)screen04MusicButtonTapped;
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    if (viewContoller.musicIsOn)
    {
        [backgroundMusic setVolume:0.0];
        [narration setVolume:0.0];
        [sfxInori setVolume:0.0];
        [sfxBoatsAreClose setVolume:0.0];
        [sfxBoat setVolume:0.0];
        [sfxSnail1 setVolume:0.0];
        [sfxSnail2 setVolume:0.0];
        [sfxSnail3 setVolume:0.0];
        
        viewContoller.musicIsOn=FALSE;
    }
    else
    {
        [backgroundMusic setVolume:1.0];
        [narration setVolume:1.0];
        [sfxInori setVolume:1.0];
        [sfxBoatsAreClose setVolume:boatsAreCloseVolumePercentage];
        [sfxBoat setVolume:1.0];

        CGFloat volume1 = (boatsAreCloseVolumePercentage)/0.33;
        CGFloat volume2 = (boatsAreCloseVolumePercentage-0.33)/0.33;
        CGFloat volume3 = (boatsAreCloseVolumePercentage-0.66)/0.33;
        if (volume1>1.0)
        {
            volume1=1.0;
        }
        if (volume2<0)
        {
            volume2=0;
        }
        else
            if (volume2>1.0)
            {
                volume2=1.0;
            }
        if (volume3<0)
        {
            volume3=0;
        }
        else
            if (volume3>1.0)
            {
                volume3=1.0;
            }
        
        [sfxSnail1 setVolume:volume1];
        [sfxSnail2 setVolume:volume2];
        [sfxSnail3 setVolume:volume3];

        viewContoller.musicIsOn=TRUE;
    }
    viewContoller = nil;
}

- (void)startsfxBoatsAreClose;
{
    //set the SFX then start playing
	NSString *boatsAreCloseSFXPath = [[NSBundle mainBundle] pathForResource:@"002_hajohajo" ofType:@"mp3"];
	sfxBoatsAreClose = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:boatsAreCloseSFXPath] error:NULL];
	sfxBoatsAreClose.delegate = self;
	[sfxBoatsAreClose setNumberOfLoops:-1]; // when the value is negativ, the sound will be played until you call STOP method
    
    [sfxBoatsAreClose setVolume:boatsAreCloseVolumePercentage];
    
    [sfxBoatsAreClose play];
    
    boatsAreCloseSFXPath=nil;
}

- (void)startsfxInori;
{
    //set the SFX then start playing
    if (sfxInori==nil)
    {
        NSString *inoriSFXPath = [[NSBundle mainBundle] pathForResource:@"002_ohajooK" ofType:@"mp3"];
        sfxInori = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:inoriSFXPath] error:NULL];
        sfxInori.delegate = self;
        [sfxInori setNumberOfLoops:0]; // when the value is negativ, the sound will be played until you call STOP method
        
        inoriSFXPath= nil;
    }
    
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    if (viewContoller.musicIsOn)
    {
        [sfxInori setVolume:1.0];
    }
    else
    {
        [sfxInori setVolume:0.0];
    }
    
    if (![sfxInori isPlaying])
    {
        [sfxInori play];
    }
}

- (void)startsfxBoat;
{
    //set the SFX then start playing
    if (sfxBoat==nil)
    {
        NSString *boatSFXPath = [[NSBundle mainBundle] pathForResource:@"002_wooohooooK" ofType:@"mp3"];
        sfxBoat = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:boatSFXPath] error:NULL];
        sfxBoat.delegate = self;
        [sfxBoat setNumberOfLoops:0]; // when the value is negativ, the sound will be played until you call STOP method
        
        boatSFXPath = nil;
    }
    
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    if (viewContoller.musicIsOn)
    {
        [sfxBoat setVolume:1.0];
    }
    else
    {
        [sfxBoat setVolume:0.0];
    }
    
    if (![sfxBoat isPlaying])
    {
        [sfxBoat play];
    }
}

- (void)handleTappingBigShip;
{
    shipsInteractionFound=true;
    [self allInteractionFound];

    [self startsfxBoat];
}

- (void)handleTappingSmallShip;
{
    shipsInteractionFound=true;
    [self allInteractionFound];
    
    [self startsfxBoat];
}

- (IBAction)forwardTappingToUnderlayingView:(UITapGestureRecognizer *)sender
{
    CGPoint tapLocation = [sender locationInView: self.view];
    
    //the frame shows the location of the view inside its superview. In order to be comparable to the taplocation we need to tranform it
    CGRect bigShipFrame = [screen04BigShipControl frame];
    bigShipFrame.origin.x=bigShipFrame.origin.x+screen04BigShipView.frame.origin.x;
    bigShipFrame.origin.y=bigShipFrame.origin.y+screen04BigShipView.frame.origin.y;
    CGRect smallShipFrame = [screen04SmallShipControl frame];
    smallShipFrame.origin.x=smallShipFrame.origin.x+screen04SmallShipView.frame.origin.x;
    smallShipFrame.origin.y=smallShipFrame.origin.y+screen04SmallShipView.frame.origin.y;
    
    if (CGRectContainsPoint(self.screen04MusicButton.frame, tapLocation))
    {
        [self screen04MusicButtonTapped];
    }
    else
        if (CGRectContainsPoint(self.screen04NextScreenButton.frame, tapLocation))
        {
            [self screen04NextScreenControlTapped];
        }
        else
            if (CGRectContainsPoint(self.screen04PreviousScreenButton.frame, tapLocation))
            {
                [self screen04PreviousScreenControlTapped];
            }
            else
                if (CGRectContainsPoint(self.screen04HintButton.frame, tapLocation))
                {
                    [self hintButtonTapped];
                }
                else
                    if (CGRectContainsPoint(self.screen04NarrationButton.frame, tapLocation))
                    {
                        [self narrationButtonTapped];
                    }
                    else
                        if (CGRectContainsPoint(bigShipFrame, tapLocation))
                        {
                            [self handleTappingBigShip];
                        }
                        else
                            if (CGRectContainsPoint(smallShipFrame, tapLocation))
                            {
                                [self handleTappingSmallShip];
                            }
                            else
                                if (CGRectContainsPoint(self.screen04InoriControl.frame, tapLocation))
                                {
                                    [self screen04InoriTapped];
                                }
    
}

- (void)startsfxSnail;
{
    //set the SFX then start playing
    if (sfxSnail1==nil)
    {
        NSString *snailSFXPath = [[NSBundle mainBundle] pathForResource:@"002_csiga1new" ofType:@"mp3"];
        sfxSnail1 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:snailSFXPath] error:NULL];
        sfxSnail1.delegate = self;
        [sfxSnail1 setNumberOfLoops:-1]; // when the value is negativ, the sound will be played until you call STOP method
        
        snailSFXPath=nil;
    }

    if (sfxSnail2==nil)
    {
        NSString *snailSFXPath = [[NSBundle mainBundle] pathForResource:@"002_csiga2new" ofType:@"mp3"];
        sfxSnail2 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:snailSFXPath] error:NULL];
        sfxSnail2.delegate = self;
        [sfxSnail2 setNumberOfLoops:-1]; // when the value is negativ, the sound will be played until you call STOP method
        
        snailSFXPath=nil;
    }
    
    if (sfxSnail3==nil)
    {
        NSString *snailSFXPath = [[NSBundle mainBundle] pathForResource:@"002_csiga3new" ofType:@"mp3"];
        sfxSnail3 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:snailSFXPath] error:NULL];
        sfxSnail3.delegate = self;
        [sfxSnail3 setNumberOfLoops:-1]; // when the value is negativ, the sound will be played until you call STOP method
        
        snailSFXPath=nil;
    }
    
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    if (viewContoller.musicIsOn)
    {
        CGFloat volume1 = (boatsAreCloseVolumePercentage)/0.33;
        CGFloat volume2 = (boatsAreCloseVolumePercentage-0.33)/0.33;
        CGFloat volume3 = (boatsAreCloseVolumePercentage-0.66)/0.33;
        if (volume1>1.0)
        {
            volume1=1.0;
        }
        if (volume2<0)
        {
            volume2=0;
        }
        else
            if (volume2>1.0)
            {
                volume2=1.0;
            }
        if (volume3<0)
        {
            volume3=0;
        }
        else
            if (volume3>1.0)
            {
                volume3=1.0;
            }
        
        [sfxSnail1 setVolume:volume1];
        [sfxSnail2 setVolume:volume2];
        [sfxSnail3 setVolume:volume3];
    }
    else
    {
        [sfxSnail1 setVolume:0.0];
        [sfxSnail2 setVolume:0.0];
        [sfxSnail3 setVolume:0.0];
    }
    
    if (![sfxSnail1 isPlaying])
    {
        [sfxSnail1 play];
    }
    if (![sfxSnail2 isPlaying])
    {
        [sfxSnail2 play];
    }
    if (![sfxSnail3 isPlaying])
    {
        [sfxSnail3 play];
    }
}

-(void)startBackgroundMusic;
{
    //set the Music for intro then start playing
	NSString *backgroundMusicPath = [[NSBundle mainBundle] pathForResource:@"002_Atm_tengermadarszel" ofType:@"mp3"];
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
    
    backgroundMusicPath=nil;
}

-(void)stopMusicAndSfx;
{
    [backgroundMusic stop];
    [narration stop];
    [sfxInori stop];
    [sfxBoatsAreClose stop];
    [sfxBoat stop];
    [sfxSnail1 stop];
    [sfxSnail2 stop];
    [sfxSnail3 stop];
    [narration stop];
}

- (void)hintButtonTapped;
{
    if (self.hintLayerImageView.alpha==0.0)
    {
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

- (void)narrationButtonTapped;
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
    //set the Music then start playing
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

- (void)loadImages;
{
    NSString* imagePath;
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"4_1k_alap" ofType:@"png"];
    [screen04BaseImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];

    imagePath = [ [ NSBundle mainBundle] pathForResource:@"4_1k_inori_ul" ofType:@"png"];
    [screen04InoriSitting setImage:[UIImage imageWithContentsOfFile:imagePath]];

    imagePath = [ [ NSBundle mainBundle] pathForResource:@"4_1k_inori_all" ofType:@"png"];
    [screen04InoriStanding setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"4_1k_hullam_1" ofType:@"png"];
    [screen04Wave1ImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"4_1k_hullam_2" ofType:@"png"];
    [screen04Wave2ImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"4_1k_hullam_3" ofType:@"png"];
    [screen04Wave3ImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"4_1k_hullam_4" ofType:@"png"];
    [screen04Wave4ImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"4_1k_csiga" ofType:@"png"];
    [screen04SnailImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"4_1k_nagyhajo" ofType:@"png"];
    [screen04BigShipImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"4_1k_kishajo" ofType:@"png"];
    [screen04SmallShipImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];

    imagePath = [ [ NSBundle mainBundle] pathForResource:@"hint-2" ofType:@"png"];
    [hintLayerImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
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
    
    backgroundMusic.delegate=nil;
    narration.delegate =nil;
    sfxInori.delegate=nil;
    sfxBoatsAreClose.delegate=nil;
    sfxBoat.delegate=nil;
    sfxSnail1.delegate=nil;
    sfxSnail2.delegate=nil;
    sfxSnail3.delegate=nil;
    
    backgroundMusic = nil;
    narration = nil;
    sfxInori = nil;
    sfxBoatsAreClose = nil;
    sfxBoat = nil;
    sfxSnail1 = nil;
    sfxSnail2 = nil;
    sfxSnail3 = nil;

    [itIsWavingTimer invalidate];
    [bigShipRockingTimer invalidate];
    [smallShipRockingTimer invalidate];

    itIsWavingTimer=nil;
    bigShipRockingTimer=nil;
    smallShipRockingTimer=nil;
    
    [screen04BigShipView removeFromSuperview];
    [screen04SmallShipView removeFromSuperview];
    [screen04BigShipControl removeFromSuperview];
    [screen04SnailControl removeFromSuperview];
    [screen04SmallShipControl removeFromSuperview];
    [screen04InoriControl removeFromSuperview];
    [screen04MusicButton removeFromSuperview];
    [screen04NarrationButton removeFromSuperview];
    [screen04HintButton removeFromSuperview];
    [screen04NextScreenButton removeFromSuperview];
    [screen04PreviousScreenButton removeFromSuperview];
    [screen04InoriSitting removeFromSuperview];
    [screen04InoriStanding removeFromSuperview];
    [screen04Wave1ImageView removeFromSuperview];
    [screen04Wave2ImageView removeFromSuperview];
    [screen04Wave3ImageView removeFromSuperview];
    [screen04Wave4ImageView removeFromSuperview];
    [screen04SnailImageView removeFromSuperview];
    [screen04BigShipImageView removeFromSuperview];
    [screen04SmallShipImageView removeFromSuperview];
    [hintLayerImageView removeFromSuperview];
    [screen04MenuImageView removeFromSuperview];

    screen04BigShipView=nil;
    screen04SmallShipView=nil;
    screen04BigShipControl=nil;
    screen04SnailControl=nil;
    screen04SmallShipControl=nil;
    screen04InoriControl=nil;
    screen04MusicButton=nil;
    screen04NarrationButton=nil;
    screen04HintButton=nil;
    screen04NextScreenButton=nil;
    screen04PreviousScreenButton=nil;
    screen04InoriSitting=nil;
    screen04InoriStanding=nil;
    screen04Wave1ImageView=nil;
    screen04Wave2ImageView=nil;
    screen04Wave3ImageView=nil;
    screen04Wave4ImageView=nil;
    screen04SnailImageView=nil;
    screen04BigShipImageView=nil;
    screen04SmallShipImageView=nil;
    hintLayerImageView=nil;
    screen04MenuImageView=nil;
    
    [self.view removeFromSuperview];
    self.view=nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self loadImages];
    
    itIsWavingTimer = [NSTimer scheduledTimerWithTimeInterval:0.04 target:self selector:@selector(screen04ItIsWavingAction) userInfo:nil repeats:YES];
    itIsWavingClock=0;
	[itIsWavingTimer fire];
    
    smallShipOriginalTransform = [screen04SmallShipView transform];
    smallShipRockingTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(screen04SmallShipRockingAction) userInfo:nil repeats:YES];
    smallShipRockingClock=0;
    smallShipRockingClockChange=SMALL_SHIP_ROTATE_SHIFT;
	[smallShipRockingTimer fire];
    
    bigShipOriginalTransform = [screen04BigShipView transform];
    bigShipRockingTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(screen04BigShipRockingAction) userInfo:nil repeats:YES];
    bigShipRockingClock=0;
    bigShipRockingClockChange=BIG_SHIP_ROTATE_SHIFT;
	[bigShipRockingTimer fire];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(screen04Move:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:self];
    [self.view addGestureRecognizer:panRecognizer];
    panRecognizer = nil;
    
    [self startBackgroundMusic];
    boatsAreCloseVolumePercentage=0;
    [self startsfxBoatsAreClose];
    
    inoriInteractionFound= false;
    snailInteractionFound= false;
    shipsInteractionFound= false;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
    
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
