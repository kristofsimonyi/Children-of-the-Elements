//
//  Screen06_07ViewController.m
//  KickOff
//
//  Created by Ferenc INKOVICS on 19/02/2013.
//  Copyright (c) 2013 No company - private person. All rights reserved.
//

#define WAVING_TIMER_CLOCK_INTERVAL         0.02
#define WAVING_TIMER_CLOCK_SHIFT_AT_START   30.00
#define WAVING_TIMER_CLOCK_CHANGE           0.50
#define MAX_TILTING_DEGREE                  2.50

#define WAVE_APPEAR_TIME        3.00
#define WAVE_APPEAR_DELAY       0.00
#define PEOPLE_APPEAR_DELAY     0.00
#define PEOPLE_APPEAR_TIME      3.00
#define ROTATION_CENTER         512,360

#define SMALL_FISH_SWARM_ARC_WIDTH          1050
#define SMALL_FISH_SWARM_ARC_HEIGHT         651
#define SMALL_FISH_SWARM_ARC_SHIFT          1
#define SMALL_FISH_SWARM_STRAIGHT_SHIFT     2
#define SMALL_FISH_SWARM_STRAIGHT_WIDTH     651
#define SMALL_FISH_SWARM_STRAIGHT_HEIGHT    173

#define NUMBER_OF_CREATURES          14
#define NUMBER_OF_CREATURES_APPEAR_AFTER_EACHOTHER   3
#define DELAY_BETWEEN_CREATURES      0.5
#define CREATURE01_START_FRAME       0,0,84,102
#define CREATURE02_START_FRAME       0,0,115,103
#define CREATURE03_START_FRAME       0,0,91,107
#define CREATURE04_START_FRAME       0,0,94,97
#define CREATURE05_START_FRAME       0,0,115,109
#define CREATURE06_START_FRAME       0,0,133,66
#define CREATURE07_START_FRAME       0,0,62,114
#define CREATURE08_START_FRAME       0,0,61,112
#define CREATURE09_START_FRAME       0,0,82,105
#define CREATURE10_START_FRAME       0,0,73,107
#define CREATURE11_START_FRAME       0,0,48,115
#define CREATURE12_START_FRAME       0,0,94,115
#define CREATURE13_START_FRAME       0,0,106,92
#define CREATURE14_START_FRAME       0,0,106,106
#define CREATURE_POSITION_CHANGE_INCREMENT          0.995
#define CREATURE_POSITION_CHANGE_DECREMENT          1.005

#define HINT_TIME                                       1.0

#import "Inori_FatherAndSonSwimInTheSeaViewController.h"
#import "ViewController.h"

@interface Inori_FatherAndSonSwimInTheSeaViewController ()

@end

@implementation Inori_FatherAndSonSwimInTheSeaViewController

@synthesize screen06_07FatherImageView, screen06_07InoriImageView, screen06_07Wave01ImageView, screen06_07Wave02ImageView, screen06_07Wave03ImageView, screen06_07Wave04ImageView, screen06_07Wave05ImageView, screen06_07Wave06ImageView, screen06_07Wave07ImageView, screen06_07Wave08ImageView, screen06_07Wave09ImageView, screen06_07FatherControlView, screen06_07InoriControlView, screen06_07FatherControl, screen06_07InoriControl, screen06_07SmallFishSwarmView, hintLayerImageView, screen06_07MenuImageView;

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

/*
- (IBAction)screen06_07BackToMainMenu:(id)sender;
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController=0;
    viewContoller = nil;
    
    [self goToNextScreen];
}
     */

- (IBAction)screen06_07NextScreenControlTapped:(id)sender
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController++;
    viewContoller = nil;
    
    [self goToNextScreen];
}

- (IBAction)screen06_07PreviousScreenControlTapped:(id)sender
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController--;
    viewContoller = nil;
    
    [self goToNextScreen];
}

- (IBAction)screen06_07MusicButtonTapped:(UITapGestureRecognizer *) sender;
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    if (viewContoller.musicIsOn)
    {
        [backgroundMusic setVolume:0.0];
        [sfx2Swimmwers setVolume:0.0];
        [sfxCreatures1 setVolume:0.0];
        [sfxCreatures1 setVolume:0.0];
        [sfxCreatures1 setVolume:0.0];
        [sfxFishSwarmArc setVolume:0.0];
        [sfxFishSwarmStraight setVolume:0.0];
        [narration setVolume:0.0];
        
        viewContoller.musicIsOn=FALSE;
    }
    else
    {
        [backgroundMusic setVolume:1.0];
        [sfx2Swimmwers setVolume:1.0];
        [sfxCreatures1 setVolume:1.0];
        [sfxCreatures2 setVolume:1.0];
        [sfxCreatures3 setVolume:1.0];
        [sfxFishSwarmArc setVolume:1.0];
        [sfxFishSwarmStraight setVolume:1.0];
        [narration setVolume:1.0];
        
        viewContoller.musicIsOn=TRUE;
    }
    viewContoller = nil;
}

-(void)startBackgroundMusic;
{
    //set the Music for intro then start playing
	NSString *backgroundMusicPath = [[NSBundle mainBundle] pathForResource:@"003_vizalatt" ofType:@"mp3"];
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

- (void) start2Swimmers;
{
    //set the Music for screen then start playing
	NSString *twoSwimmersMusicPath = [[NSBundle mainBundle] pathForResource:@"003_ketten usznak" ofType:@"mp3"];
	sfx2Swimmwers = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:twoSwimmersMusicPath] error:NULL];
	sfx2Swimmwers.delegate = self;
    
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    if (viewContoller.musicIsOn)
    {
        [sfx2Swimmwers setVolume:1.0];
    }
    else
    {
        [sfx2Swimmwers setVolume:0.0];
    }
    
	[sfx2Swimmwers setNumberOfLoops:0]; // when the value is negativ, the sound will be played until you call STOP method
    [sfx2Swimmwers play];
    
    twoSwimmersMusicPath=nil;
}

-(void)stopMusicAndSfx;
{
    [backgroundMusic stop];
    [sfx2Swimmwers stop];
    [sfxCreatures1 stop];
    [sfxCreatures2 stop];
    [sfxCreatures3 stop];
    [sfxFishSwarmArc stop];
    [sfxFishSwarmStraight stop];
    [narration stop];
}

- (IBAction)screen06_07HintButtonTapped:(UITapGestureRecognizer *)sender;
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

- (IBAction)screen06_07NarrationButtonTapped:(UITapGestureRecognizer *)sender;
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
{
	NSUInteger touchCount = 0;
	for (UITouch *touch in touches)
	{
		CGPoint translatedPoint = [touch locationInView:self.view];
		
        if (CGRectContainsPoint(screen06_07InoriControl.frame, translatedPoint))
        {
            [self screen06_07InoriTouched];
        }
        else
            if (CGRectContainsPoint(screen06_07FatherControl.frame, translatedPoint))
            {
                [self screen06_07FatherTouched];
            }
            else
                if ([screen06_07FatherImageView alpha]==1)
                {
                    [self screen06_07WavesTouched];
                }
        
        touchCount++;
    }
}

-(void)screen06_07AppearWaves;
{
    [UIView animateWithDuration: WAVE_APPEAR_TIME
                          delay: WAVE_APPEAR_DELAY
                        options: UIViewAnimationOptionCurveLinear
                     animations:^
     {
         [screen06_07Wave01ImageView setAlpha:1];
         [screen06_07Wave02ImageView setAlpha:1];
         [screen06_07Wave03ImageView setAlpha:1];
         [screen06_07Wave04ImageView setAlpha:1];
         [screen06_07Wave05ImageView setAlpha:1];
         [screen06_07Wave06ImageView setAlpha:1];
         [screen06_07Wave07ImageView setAlpha:1];
         [screen06_07Wave08ImageView setAlpha:1];
         [screen06_07Wave09ImageView setAlpha:1];
     }
                     completion:^(BOOL finished)
        {
            [UIView animateWithDuration: PEOPLE_APPEAR_TIME
                    delay: PEOPLE_APPEAR_DELAY
                    options: UIViewAnimationOptionCurveLinear
                    animations:^
                {
                    [screen06_07FatherImageView setAlpha:1];
                    [screen06_07InoriImageView setAlpha:1];
                                                  }
                    completion:nil];}];
    
    int i=0;
    NSArray *subviews = [self.view subviews];
    for (WavingImageView *subview in subviews)
    {
        if ([subview isKindOfClass:[WavingImageView class]])
        {
            [subview setOriginalCenter:subview.center];
            subview.rotationCenter=CGPointMake(ROTATION_CENTER);
            subview.actualCirclingRotation=i*WAVING_TIMER_CLOCK_SHIFT_AT_START;
            subview.actualTiltingRotation=0.00;
            subview.actualCirclingRotationChange=WAVING_TIMER_CLOCK_CHANGE;
            i++;
        }
    }
    
    screen06_07FatherImageView.actualCirclingRotation=(screen06_07Wave01ImageView.actualCirclingRotation+screen06_07Wave03ImageView.actualCirclingRotation)/2;
    screen06_07InoriImageView.actualCirclingRotation=(screen06_07Wave03ImageView.actualCirclingRotation+screen06_07Wave06ImageView.actualCirclingRotation)/2;

    wavingTimer = [NSTimer scheduledTimerWithTimeInterval:WAVING_TIMER_CLOCK_INTERVAL target:self selector:@selector(wavingTimerActionMethod) userInfo:nil repeats:YES];
    [wavingTimer fire];

}

-(void)wavingTimerActionMethod;
{
    NSArray *subviews = [self.view subviews];
    for (WavingImageView *subview in subviews)
    {
        if ([subview isKindOfClass:[WavingImageView class]])
        {
            if (subview.actualCirclingRotation>360)
            {
                subview.actualCirclingRotation=subview.actualCirclingRotation-360;
            }
            subview.actualCirclingRotation=subview.actualCirclingRotation+subview.actualCirclingRotationChange;
            
            CGFloat newDegree = 1.00*subview.actualCirclingRotation/180.00*M_PI;
            
            [subview setCenter: [[CommonLibrary alloc] rotatePoint:subview.originalCenter around:subview.rotationCenter withDegree:newDegree]];
            
            CGFloat newTiltingRotation=(MAX_TILTING_DEGREE/180.00*M_PI)*sinf(subview.actualCirclingRotation/180.00*M_PI);
            
            CGAffineTransform newTransform = CGAffineTransformMakeRotation(newTiltingRotation);
            [subview setTransform:newTransform];
        }
    }
    
    [screen06_07FatherControlView setCenter:screen06_07FatherImageView.center];
    [screen06_07FatherControlView setTransform:[screen06_07FatherImageView transform]];
    [screen06_07InoriControlView setCenter:screen06_07InoriImageView.center];
    [screen06_07InoriControlView setTransform:[screen06_07InoriImageView transform]];

    [self smallFishSwarmArcTimerActionMethod];
    [self smallFishSwarmStraightTimerActionMethod];
    [self screen06_07CreaturesMovingActionMethod];
}

-(void)smallFishSwarmArcTimerActionMethod;
{
    NSArray *subviews = [screen06_07SmallFishSwarmView subviews];
    for (SmallFishSwarmArcImageView *subview in subviews)
    {
        if ([subview isKindOfClass:[SmallFishSwarmArcImageView class]])
        {
            CGFloat rotation = 0;
            if (subview.isMirrored)
            {
                subview.actualRotation=subview.actualRotation+SMALL_FISH_SWARM_STRAIGHT_SHIFT;
                if (subview.center.x == 1024)
                {
                    rotation = 180;
                }
            }
            else
            {
                subview.actualRotation=subview.actualRotation-SMALL_FISH_SWARM_STRAIGHT_SHIFT;
                if (subview.center.x == 0)
                {
                    rotation = 180;
                }
            }
            rotation=rotation+subview.actualRotation;
            CGAffineTransform newTransform = CGAffineTransformMakeRotation(rotation/180*M_PI);
            [subview setTransform:newTransform];
            if (abs(subview.actualRotation)==360)
            {
                [subview removeFromSuperview];
            }
        }
    }
}

-(void)smallFishSwarmStraightTimerActionMethod;
{
    NSArray *subviews = [screen06_07SmallFishSwarmView subviews];
    for (SmallFishSwarmStraightImageView *subview in subviews)
    {
        if ([subview isKindOfClass:[SmallFishSwarmStraightImageView class]])
        {
            CGPoint newCenter = subview.center;
            if (subview.isMirrored)
            {
                newCenter.x = newCenter.x+SMALL_FISH_SWARM_STRAIGHT_SHIFT;
            }
            else
            {
                newCenter.x = newCenter.x-SMALL_FISH_SWARM_STRAIGHT_SHIFT;
            }
            newCenter.y = (subview.finishCenter.y-subview.startCenter.y)*(subview.center.x-subview.startCenter.x)/(subview.finishCenter.x-subview.startCenter.x)+subview.startCenter.y;
            [subview setCenter:newCenter];
            if ((newCenter.x<-SMALL_FISH_SWARM_STRAIGHT_WIDTH/2)||(newCenter.x>SMALL_FISH_SWARM_STRAIGHT_WIDTH/2+1024))
            {
                [subview removeFromSuperview];
            }
        }
    }
    
}

-(void)screen06_07CreaturesMovingActionMethod;
{
    NSArray *subviews = [self.view subviews];
    for (Screen06_07CreaturesImageView *subview in subviews)
    {
        if ([subview isKindOfClass:[Screen06_07CreaturesImageView class]])
        {
            if (subview.xChangeType==0)
            {
                subview.xChange=subview.xChange*CREATURE_POSITION_CHANGE_DECREMENT;
            } else
            {
                subview.xChange=subview.xChange*CREATURE_POSITION_CHANGE_INCREMENT;
            }
            subview.normalCenter=CGPointMake(subview.normalCenter.x+subview.xChange, subview.normalCenter.y-subview.yChange);
            [subview setCalculatedCenterBasedOnDirection];
            
            if (subview.normalCenter.y<-200)
            {
                [subview removeFromSuperview];
            }
            
            [subview setCalculatedRotationBasedOnDirection];
            
        }
    }
    
}

-(void)screen06_07FatherTouched;
{
    BOOL isMirrored=arc4random()%2;
    SmallFishSwarmArcImageView *smallFishSwarmArcImageView = [[SmallFishSwarmArcImageView alloc] initWithFrame:CGRectMake(0, 768, SMALL_FISH_SWARM_ARC_WIDTH, SMALL_FISH_SWARM_ARC_HEIGHT)];

    NSString* imagePath;
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"6-7_1k_kishal_raj_2" ofType:@"png"];

    if (isMirrored)
    {
        UIImage *mirroredImage = [UIImage imageWithContentsOfFile:imagePath];
        smallFishSwarmArcImageView.image = [UIImage imageWithCGImage:[mirroredImage CGImage] scale:1.0 orientation:UIImageOrientationUpMirrored];
    }
    else
    {
        smallFishSwarmArcImageView.image = [UIImage imageWithContentsOfFile:imagePath];
    }
    smallFishSwarmArcImageView.actualRotation=0;
    smallFishSwarmArcImageView.isMirrored=isMirrored;
    CGPoint newCenter = CGPointMake(1024*(arc4random()%2), arc4random()%749);
    if (((isMirrored)&(newCenter.x==1024))||((!isMirrored)&(newCenter.x==0)))
    {
        CGAffineTransform newTransform = CGAffineTransformMakeRotation(M_PI);
        [smallFishSwarmArcImageView setTransform:newTransform];
    }
    
    [smallFishSwarmArcImageView setCenter:newCenter];
    [screen06_07SmallFishSwarmView addSubview:smallFishSwarmArcImageView];
    smallFishSwarmArcImageView=nil;
    
    [self startsfxFishSwarmArc];
    
    fatherInteractionFound=true;
    [self allInteractionFound];
}

-(void)screen06_07InoriTouched;
{
    BOOL isMirrored=arc4random()%2;
    SmallFishSwarmStraightImageView *smallFishSwarmStraightImageView = [[SmallFishSwarmStraightImageView alloc] initWithFrame:CGRectMake(0, 768, SMALL_FISH_SWARM_STRAIGHT_WIDTH, SMALL_FISH_SWARM_STRAIGHT_HEIGHT)];

    NSString* imagePath;
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"6-7_1k_kishal_raj_1" ofType:@"png"];
    if (isMirrored)
    {
        smallFishSwarmStraightImageView.image = [UIImage imageWithContentsOfFile:imagePath];
        smallFishSwarmStraightImageView.image = [UIImage imageWithCGImage:[smallFishSwarmStraightImageView.image CGImage] scale:1.0 orientation:UIImageOrientationUpMirrored];
    }
    else
    {
        smallFishSwarmStraightImageView.image = [UIImage imageWithContentsOfFile:imagePath];
    }
    smallFishSwarmStraightImageView.isMirrored=isMirrored;
    CGPoint newCenter = CGPointMake((1024+SMALL_FISH_SWARM_STRAIGHT_WIDTH)*(!isMirrored), arc4random()%749);

    newCenter.x=newCenter.x-SMALL_FISH_SWARM_STRAIGHT_WIDTH/2;
    [smallFishSwarmStraightImageView setCenter:newCenter];
    smallFishSwarmStraightImageView.startCenter=newCenter;
    
    if (newCenter.x<0)
    {
        newCenter = CGPointMake((1024+SMALL_FISH_SWARM_STRAIGHT_WIDTH/2), arc4random()%749);
    }
    else
    {
        newCenter = CGPointMake((-SMALL_FISH_SWARM_STRAIGHT_WIDTH/2), arc4random()%749);
    }
    smallFishSwarmStraightImageView.finishCenter=newCenter;

    CGFloat x,y,rotation;
    x= smallFishSwarmStraightImageView.finishCenter.x-smallFishSwarmStraightImageView.startCenter.x;
    y= smallFishSwarmStraightImageView.finishCenter.y-smallFishSwarmStraightImageView.startCenter.y;
    rotation = atanf(y/x); //****
    
    CGAffineTransform newTransform = CGAffineTransformMakeRotation(rotation);
    [smallFishSwarmStraightImageView setTransform:newTransform];
    [screen06_07SmallFishSwarmView addSubview:smallFishSwarmStraightImageView];
    smallFishSwarmStraightImageView=nil;
    
    [self startsfxFishSwarmStraight];
    
    inoriInteractionFound=true;
    [self allInteractionFound];
}

-(void)screen06_07WavesTouched;
{
    /*

     az alakokon kivul barhova tapintva 'random leny trio' effekt: random pont a kepernyo peremen, innen indul 3 random valaszott leny (ossz 14 fele leny van), ugy 0.5 mp kesessel kovetve egymast. mozgasuk a screen 16 szitakotoihez hasonlo, valami random iven atszelik a kepernyot, mindig az ivre fordulva, majd eltunnek. sebesseguk is lehet a szitakotokkel egyezo. (Az osszes leny alapbol egyenesen felfele nez eredeti allapotaban a kepeken).
    */
    
    if (newCreatureTimer==nil)
    {
        newXForCreature = 1.00*(arc4random()%1024);
        newDirectionForCreature=arc4random()%4;
        newCreatureTimerClock = 0;
        newCreatureTimer = [NSTimer scheduledTimerWithTimeInterval:DELAY_BETWEEN_CREATURES target:self selector:@selector(placeARandomCreatureAtNewX) userInfo:nil repeats:YES];
        [newCreatureTimer fire];
        [self startsfxCreatures];
    }
    wavesInteractionFound=true;
    [self allInteractionFound];
}

-(void)placeARandomCreatureAtNewX;
{
    NSInteger randomNumber = (arc4random()%NUMBER_OF_CREATURES)+1;
    
    Screen06_07CreaturesImageView *randomCreatureImageView;
    NSString* imagePath;
    switch (randomNumber)
    {
        case 1:
            randomCreatureImageView = [[Screen06_07CreaturesImageView alloc] initWithFrame:CGRectMake(CREATURE01_START_FRAME)];
            imagePath = [ [ NSBundle mainBundle] pathForResource:@"6-7_1k_leny1" ofType:@"png"];
            break;
            
        case 2:
            randomCreatureImageView = [[Screen06_07CreaturesImageView alloc] initWithFrame:CGRectMake(CREATURE02_START_FRAME)];
            imagePath = [ [ NSBundle mainBundle] pathForResource:@"6-7_1k_leny2" ofType:@"png"];
            break;
            
        case 3:
            randomCreatureImageView = [[Screen06_07CreaturesImageView alloc] initWithFrame:CGRectMake(CREATURE03_START_FRAME)];
            imagePath = [ [ NSBundle mainBundle] pathForResource:@"6-7_1k_leny3" ofType:@"png"];
            break;
            
        case 4:
            randomCreatureImageView = [[Screen06_07CreaturesImageView alloc] initWithFrame:CGRectMake(CREATURE04_START_FRAME)];
            imagePath = [ [ NSBundle mainBundle] pathForResource:@"6-7_1k_leny4" ofType:@"png"];
            break;
            
        case 5:
            randomCreatureImageView = [[Screen06_07CreaturesImageView alloc] initWithFrame:CGRectMake(CREATURE05_START_FRAME)];
            imagePath = [ [ NSBundle mainBundle] pathForResource:@"6-7_1k_leny5" ofType:@"png"];
            break;
            
        case 6:
            randomCreatureImageView = [[Screen06_07CreaturesImageView alloc] initWithFrame:CGRectMake(CREATURE06_START_FRAME)];
            imagePath = [ [ NSBundle mainBundle] pathForResource:@"6-7_1k_leny6" ofType:@"png"];
            break;
            
        case 7:
            randomCreatureImageView = [[Screen06_07CreaturesImageView alloc] initWithFrame:CGRectMake(CREATURE07_START_FRAME)];
            imagePath = [ [ NSBundle mainBundle] pathForResource:@"6-7_1k_leny7" ofType:@"png"];
            break;
            
        case 8:
            randomCreatureImageView = [[Screen06_07CreaturesImageView alloc] initWithFrame:CGRectMake(CREATURE08_START_FRAME)];
            imagePath = [ [ NSBundle mainBundle] pathForResource:@"6-7_1k_leny8" ofType:@"png"];
            break;
            
        case 9:
            randomCreatureImageView = [[Screen06_07CreaturesImageView alloc] initWithFrame:CGRectMake(CREATURE09_START_FRAME)];
            imagePath = [ [ NSBundle mainBundle] pathForResource:@"6-7_1k_leny9" ofType:@"png"];
            break;
            
        case 10:
            randomCreatureImageView = [[Screen06_07CreaturesImageView alloc] initWithFrame:CGRectMake(CREATURE10_START_FRAME)];
            imagePath = [ [ NSBundle mainBundle] pathForResource:@"6-7_1k_leny10" ofType:@"png"];
            break;
            
        case 11:
            randomCreatureImageView = [[Screen06_07CreaturesImageView alloc] initWithFrame:CGRectMake(CREATURE11_START_FRAME)];
            imagePath = [ [ NSBundle mainBundle] pathForResource:@"6-7_1k_leny11" ofType:@"png"];
            break;
            
        case 12:
            randomCreatureImageView = [[Screen06_07CreaturesImageView alloc] initWithFrame:CGRectMake(CREATURE12_START_FRAME)];
            imagePath = [ [ NSBundle mainBundle] pathForResource:@"6-7_1k_leny12" ofType:@"png"];
            break;
            
        case 13:
            randomCreatureImageView = [[Screen06_07CreaturesImageView alloc] initWithFrame:CGRectMake(CREATURE13_START_FRAME)];
            imagePath = [ [ NSBundle mainBundle] pathForResource:@"6-7_1k_leny13" ofType:@"png"];
            break;
            
        case 14:
            randomCreatureImageView = [[Screen06_07CreaturesImageView alloc] initWithFrame:CGRectMake(CREATURE14_START_FRAME)];
            imagePath = [ [ NSBundle mainBundle] pathForResource:@"6-7_1k_leny14" ofType:@"png"];
            break;
            
        default:
            ;
            break;
    }
    randomCreatureImageView.image = [UIImage imageWithContentsOfFile:imagePath];
    
    randomCreatureImageView.direction=newDirectionForCreature;
    CGPoint newCenter;
    newCenter=CGPointMake(newXForCreature, (randomCreatureImageView.frame.size.height/2)+749);
    randomCreatureImageView.normalCenter=newCenter;
    [randomCreatureImageView setCalculatedCenterBasedOnDirection];
    [self.view addSubview:randomCreatureImageView];
    randomCreatureImageView = nil;
    
    newCreatureTimerClock++;
    if (newCreatureTimerClock==NUMBER_OF_CREATURES_APPEAR_AFTER_EACHOTHER)
    {
        [newCreatureTimer invalidate];
        newCreatureTimer=nil;
    }

}

- (void)loadSFXCreatures;
{
    NSString *creaturesSFXPath = [[NSBundle mainBundle] pathForResource:@"003_strangecreatures1" ofType:@"mp3"];
    sfxCreatures1 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:creaturesSFXPath] error:NULL];
    sfxCreatures1.delegate = self;
    [sfxCreatures1 setNumberOfLoops:0]; // when the value is negativ, the sound will be played until you call STOP method
    
    creaturesSFXPath = [[NSBundle mainBundle] pathForResource:@"003_strangecreatures2" ofType:@"mp3"];
    sfxCreatures2 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:creaturesSFXPath] error:NULL];
    sfxCreatures2.delegate = self;
    [sfxCreatures2 setNumberOfLoops:0]; // when the value is negativ, the sound will be played until you call STOP method

    creaturesSFXPath = [[NSBundle mainBundle] pathForResource:@"003_strangecreatures3" ofType:@"mp3"];
    sfxCreatures3 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:creaturesSFXPath] error:NULL];
    sfxCreatures3.delegate = self;
    [sfxCreatures3 setNumberOfLoops:0]; // when the value is negativ, the sound will be played until you call STOP method
}

- (void)startsfxCreatures;
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    if (viewContoller.musicIsOn)
    {
        [sfxCreatures1 setVolume:1.0];
    }
    else
    {
        [sfxCreatures1 setVolume:0.0];
    }
    
    if (![sfxCreatures1 isPlaying])
    {
        [sfxCreatures1 play];
    }
    
    AVAudioPlayer *player;
    player=sfxCreatures3;
    sfxCreatures3=sfxCreatures2;
    sfxCreatures2=sfxCreatures1;
    sfxCreatures1=player;
    
}

- (void)startsfxFishSwarmArc;
{
    //set the SFX then start playing
    if (sfxFishSwarmArc==nil)
    {
        NSString *fishSwarmArcSFXPath = [[NSBundle mainBundle] pathForResource:@"003_rovidhalak" ofType:@"mp3"];
        sfxFishSwarmArc = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:fishSwarmArcSFXPath] error:NULL];
        sfxFishSwarmArc.delegate = self;
        [sfxFishSwarmArc setNumberOfLoops:0]; // when the value is negativ, the sound will be played until you call STOP method
        
        fishSwarmArcSFXPath= nil;
    }
    
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    if (viewContoller.musicIsOn)
    {
        [sfxFishSwarmArc setVolume:1.0];
    }
    else
    {
        [sfxFishSwarmArc setVolume:0.0];
    }
    
    if (![sfxFishSwarmArc isPlaying])
    {
        [sfxFishSwarmArc play];
    }
}

- (void)startsfxFishSwarmStraight;
{
    //set the SFX then start playing
    if (sfxFishSwarmStraight==nil)
    {
        NSString *fishSwarmStraightSFXPath = [[NSBundle mainBundle] pathForResource:@"003_hosszuhalak" ofType:@"mp3"];
        sfxFishSwarmStraight = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:fishSwarmStraightSFXPath] error:NULL];
        sfxFishSwarmStraight.delegate = self;
        [sfxFishSwarmStraight setNumberOfLoops:0]; // when the value is negativ, the sound will be played until you call STOP method
        
        fishSwarmStraightSFXPath= nil;
    }
    
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    if (viewContoller.musicIsOn)
    {
        [sfxFishSwarmStraight setVolume:1.0];
    }
    else
    {
        [sfxFishSwarmStraight setVolume:0.0];
    }
    
    if (![sfxFishSwarmStraight isPlaying])
    {
        [sfxFishSwarmStraight play];
    }
}

- (void)allInteractionFound;
{
    if (inoriInteractionFound&&fatherInteractionFound&&wavesInteractionFound)
    {
        self.screen06_07MenuImageView.image=nil;
        [self.screen06_07MenuImageView setImage:[UIImage imageNamed:@"menu_set-top-g.png"]];
    }
}

- (void)loadImages;
{
    NSString* imagePath;
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"6-7_1k_nagyhullam1" ofType:@"png"];
    [screen06_07Wave01ImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];

    imagePath = [ [ NSBundle mainBundle] pathForResource:@"6-7_1k_nagyhullam2" ofType:@"png"];
    [screen06_07Wave02ImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];

    imagePath = [ [ NSBundle mainBundle] pathForResource:@"6-7_1k_nagyhullam3" ofType:@"png"];
    [screen06_07Wave03ImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"6-7_1k_nagyhullam4" ofType:@"png"];
    [screen06_07Wave04ImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"6-7_1k_nagyhullam5" ofType:@"png"];
    [screen06_07Wave05ImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"6-7_1k_nagyhullam6" ofType:@"png"];
    [screen06_07Wave06ImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"6-7_1k_nagyhullam7" ofType:@"png"];
    [screen06_07Wave07ImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"6-7_1k_nagyhullam8" ofType:@"png"];
    [screen06_07Wave08ImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"6-7_1k_nagyhullam9" ofType:@"png"];
    [screen06_07Wave09ImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"6-7_1k_apa" ofType:@"png"];
    [screen06_07FatherImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"6-7_1k_inori" ofType:@"png"];
    [screen06_07InoriImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    imagePath = [ [ NSBundle mainBundle] pathForResource:@"hint-3" ofType:@"png"];
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

- (void) viewDidDisappear:(BOOL)animated;
{
    [self stopMusicAndSfx];
    
    backgroundMusic.delegate=nil;
    sfx2Swimmwers.delegate=nil;
    sfxCreatures1.delegate=nil;
    sfxCreatures2.delegate=nil;
    sfxCreatures3.delegate=nil;
    sfxFishSwarmArc.delegate=nil;
    sfxFishSwarmStraight.delegate=nil;
    narration.delegate=nil;
    
    backgroundMusic=nil;
    sfx2Swimmwers=nil;
    sfxCreatures1=nil;
    sfxCreatures2=nil;
    sfxCreatures3=nil;
    sfxFishSwarmArc=nil;
    sfxFishSwarmStraight=nil;
    narration=nil;

    [wavingTimer invalidate];
    [smallFishSwarmArcTimer invalidate];
    [newCreatureTimer invalidate];

    wavingTimer=nil;
    smallFishSwarmArcTimer=nil;
    newCreatureTimer=nil;

    [self.view removeFromSuperview];
    self.view = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self loadImages];
    
    [self screen06_07AppearWaves];
    [self startBackgroundMusic];
    [self start2Swimmers];
    inoriInteractionFound=false;
    fatherInteractionFound=false;
    wavesInteractionFound=false;
    
    [self loadSFXCreatures];
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
