//
//  Screen04ViewController.m
//  KickOff
//
//  Created by INKOVICS Ferenc on 29/03/2012.
//  Copyright (c) 2012 No company - private person. All rights reserved.
//

/*
 1. Alap: statikus tenger, dunek hatter. 4 extra hullam jon-megy (fenti allapotban attunessel megjelenik, lefele jon, alul attunessel eltunik), egymassal szinkronban (egymas utan, legfelso indul eloszor).
 2. 1 mp utan megjelenik a szoveg, 5 mp utan megjelenik Inori (ulo alak).
 3. Inorit megerintve attunik az allo, integeto pozba
 4. rakocska a jobb oldali dune felszinen tud mozogni, athuzasa a jobb oldalra csuszkakent szolgal a hajok megjelenitesehez:
 5. hajok: fent indulnak kicsiben a hatter szellemhajoin, alapbol a transparency 100%-on. Ahogy huzod at a rakot jobbra, ugy jonnek szepen lefele, s nagyobbodnak az overview-n lathato allapotba, illetve a transparency is lemegy 0%-ra. A hajok alapbol magukhoz kepest ringanak is (jobbra, balra dulongelnek kicsit, kozeppontjuk is mozog egy kis lapos ovalis menten lassan).
*/

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

@implementation Inori_InoriIsWaitingForTheFishermenOnTheBeachViewController

@synthesize screen04StoryTextView, screen04InoriSitting, screen04InoriStanding, screen04Wave1ImageView, screen04Wave2ImageView, screen04Wave3ImageView, screen04Wave4ImageView, screen04SnailImageView, screen04SnailControl, screen04BigShipView, screen04SmallShipView, screen04BigShipControl, screen04SmallShipControl, screen04InoriControl, screen04BigShipImageView, screen04SmallShipImageView, screen04MusicControl, screen04NextScreenControl, screen04PreviousScreenContol, screen04CompassContol;

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

- (void) screen04BackToMainMenu;
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController=0;
    viewContoller = nil;
    
    [self goToNextScreen];
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

- (void)screen04InoriTapped;
{
    if (screen04InoriSitting.alpha == 0) 
    {
        [UIView animateWithDuration: 1.0
                              delay: 0.0
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^
         {
             [screen04InoriStanding setAlpha:1-screen04InoriStanding.alpha];
         }
                         completion:nil];
        
        [UIView animateWithDuration: 1.0
                              delay: 0.5
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^
         {
             [screen04InoriSitting setAlpha:1-screen04InoriSitting.alpha];
         }
                         completion:nil];
        if (screen04InoriStanding.alpha==0)
        {
            [self startsfxInori];
        }
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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
    
    if ([self.view window] == nil)
        self.view = nil;
}

- (void) textAppear;
{
    for (UIView *view in screen04StoryTextView.subviews) {
        [view removeFromSuperview];
    }
    
    UILabel *newLabel;
    NSString *string;
    
    UILabel *origLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 500, 10, 12)];
    [origLabel setText:@" abcd efgh ijkl mnopqr stuvxyz valaminek jonnie kell..."];
    
    CGAffineTransform previousTransformMatrixForText;
    previousTransformMatrixForText = [origLabel transform];
    
    CGAffineTransform newTransform = CGAffineTransformRotate(previousTransformMatrixForText,M_PI/2.00);
    
    for (int i=0; i<17; i++) 
        for (int j=0; j<11; j++) 
        {
            newLabel = [[UILabel alloc] initWithFrame:CGRectMake(i*20-20, j*20-20, 20, 20)];
            string = [NSString stringWithFormat:@"%c",[origLabel.text characterAtIndex:arc4random()%30+1]];
            [newLabel setText:string];
            [screen04StoryTextView addSubview:newLabel]; 
            [newLabel setAlpha:0];
            [newLabel setTransform:newTransform];
            [newLabel setBackgroundColor:[UIColor clearColor]];
            [newLabel setTextAlignment:NSTextAlignmentRight];
            
            [UIView animateWithDuration:((i%3)*0.5+0.5)
                                  delay: 3+arc4random()%3*0.5
                                options: UIViewAnimationOptionCurveEaseIn
                             animations:^
             {
                 [newLabel setTransform:previousTransformMatrixForText];
                 [newLabel setAlpha:1];
                 [newLabel setCenter:CGPointMake(newLabel.center.x+20,newLabel.center.y+40)];
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

                CGRect frame = self.screen04BigShipControl.frame;
                CGRect frame1 = self.screen04BigShipImageView.frame;
                CGRect frame2 = self.screen04BigShipView.frame;
                NSLog(@"%@",[NSString stringWithFormat:@"\n\nControl: %f,%f,%f,%f \nImage: %f,%f,%f,%f \nView %f,%f,%f,%f\n\n",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height,frame1.origin.x,frame1.origin.y,frame1.size.width,frame1.size.height,frame2.origin.x,frame2.origin.y,frame2.size.width,frame2.size.height]);

            }
        }
        else
            if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) 
            {
                isSnailMoving=false;
                [sfxSnail stop];
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
    if ((smallShipRockingClock < SMALL_SHIP_ROTATE_LEFT)||(smallShipRockingClock > SMALL_SHIP_ROTATE_RIGHT)) {
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

- (IBAction)screen04MusicControlTapped;
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    if (viewContoller.musicIsOn)
    {
        [backgroundMusic setVolume:0.0];
        [sfxInori setVolume:0.0];
        [sfxBoatsAreClose setVolume:0.0];
        [sfxBoat setVolume:0.0];
        [sfxSnail setVolume:0.0];
        
        viewContoller.musicIsOn=FALSE;
    }
    else
    {
        [backgroundMusic setVolume:1.0];
        [sfxInori setVolume:1.0];
        [sfxBoatsAreClose setVolume:boatsAreCloseVolumePercentage];
        [sfxBoat setVolume:1.0];
        [sfxSnail setVolume:1.0];
        
        viewContoller.musicIsOn=TRUE;
    }
    viewContoller = nil;
}

- (void)startsfxBoatsAreClose;
{
    //set the SFX then start playing
	NSString *teapotSFXPath = [[NSBundle mainBundle] pathForResource:@"002_hajohajo" ofType:@"mp3"];
	sfxBoatsAreClose = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:teapotSFXPath] error:NULL];
	sfxBoatsAreClose.delegate = self;
	[sfxBoatsAreClose setNumberOfLoops:-1]; // when the value is negativ, the sound will be played until you call STOP method
    
    [sfxBoatsAreClose setVolume:boatsAreCloseVolumePercentage];
    
    [sfxBoatsAreClose play];
}

- (void)startsfxInori;
{
    //set the SFX then start playing
    if (sfxInori==nil)
    {
        NSString *teapotSFXPath = [[NSBundle mainBundle] pathForResource:@"002_hello" ofType:@"mp3"];
        sfxInori = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:teapotSFXPath] error:NULL];
        sfxInori.delegate = self;
        [sfxInori setNumberOfLoops:0]; // when the value is negativ, the sound will be played until you call STOP method
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
        NSString *teapotSFXPath = [[NSBundle mainBundle] pathForResource:@"002_wooohooooK" ofType:@"mp3"];
        sfxBoat = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:teapotSFXPath] error:NULL];
        sfxBoat.delegate = self;
        [sfxBoat setNumberOfLoops:0]; // when the value is negativ, the sound will be played until you call STOP method
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
    [self startsfxBoat];
}

- (void)handleTappingSmallShip;
{
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
    
    if (CGRectContainsPoint(self.screen04MusicControl.frame, tapLocation))
    {
        [self screen04MusicControlTapped];
    }
    else
        if (CGRectContainsPoint(self.screen04NextScreenControl.frame, tapLocation))
        {
            [self screen04NextScreenControlTapped];
        }
        else
            if (CGRectContainsPoint(self.screen04PreviousScreenContol.frame, tapLocation))
            {
                [self screen04PreviousScreenControlTapped];
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
                        else
                            if (CGRectContainsPoint(self.screen04CompassContol.frame, tapLocation))
                            {
                                [self screen04BackToMainMenu];
                            }
    
}

- (void)startsfxSnail;
{
    //set the SFX then start playing
    if (sfxSnail==nil)
    {
        NSString *teapotSFXPath = [[NSBundle mainBundle] pathForResource:@"002_csiga1" ofType:@"mp3"];
        sfxSnail = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:teapotSFXPath] error:NULL];
        sfxSnail.delegate = self;
        [sfxSnail setNumberOfLoops:-1]; // when the value is negativ, the sound will be played until you call STOP method
    }
    
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    if (viewContoller.musicIsOn)
    {
        [sfxSnail setVolume:1.0];
    }
    else
    {
        [sfxSnail setVolume:0.0];
    }
    
    if (![sfxSnail isPlaying])
    {
        [sfxSnail play];
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
    
    
}

-(void)stopMusicAndSfx;
{
    [backgroundMusic stop];
    [sfxInori stop];
    [sfxBoatsAreClose stop];
    [sfxBoat stop];
    [sfxSnail stop];
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
    
//    [self textAppear];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(screen04Move:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:self];
    [self.view addGestureRecognizer:panRecognizer];

    [self startBackgroundMusic];
    boatsAreCloseVolumePercentage=0;
    [self startsfxBoatsAreClose];
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
    if ((interfaceOrientation==UIInterfaceOrientationLandscapeLeft)||(interfaceOrientation==UIInterfaceOrientationLandscapeRight)) {
        return YES;
    }
    // Return YES for supported orientations
	return NO;
}

@end
