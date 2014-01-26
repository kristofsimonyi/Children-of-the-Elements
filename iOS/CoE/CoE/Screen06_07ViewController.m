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

#import "Screen06_07ViewController.h"
#import "ViewController.h"

@interface Screen06_07ViewController ()

@end

@implementation Screen06_07ViewController

@synthesize screen06_07FatherImageView, screen06_07InoriImageView, screen06_07Wave01ImageView, screen06_07Wave02ImageView, screen06_07Wave03ImageView, screen06_07Wave04ImageView, screen06_07Wave05ImageView, screen06_07Wave06ImageView, screen06_07Wave07ImageView, screen06_07Wave08ImageView, screen06_07Wave09ImageView, screen06_07FatherControlView, screen06_07InoriControlView, screen06_07FatherControl, screen06_07InoriControl, screen06_07SmallFishSwarmView;

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

- (IBAction)screen06_07BackToMainMenu:(id)sender;
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController=0;
    viewContoller = nil;
    
    [self goToNextScreen];
}

- (IBAction)screen06_07NextScreenButtonTouched:(id)sender
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController++;
    viewContoller = nil;
    
    [self goToNextScreen];
}

- (IBAction)screen06_07PreviousScreenButtonTouched:(id)sender
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController--;
    viewContoller = nil;
    
    [self goToNextScreen];
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
    if (isMirrored)
    {
        UIImage *mirroredImage = [UIImage imageNamed:@"6-7_1k_kishal_raj_2.png"];
        smallFishSwarmArcImageView.image = [UIImage imageWithCGImage:[mirroredImage CGImage] scale:1.0 orientation:UIImageOrientationUpMirrored];
    }
    else
    {
        smallFishSwarmArcImageView.image = [UIImage imageNamed:@"6-7_1k_kishal_raj_2.png"];
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
}

-(void)screen06_07InoriTouched;
{
    BOOL isMirrored=arc4random()%2;
    SmallFishSwarmStraightImageView *smallFishSwarmStraightImageView = [[SmallFishSwarmStraightImageView alloc] initWithFrame:CGRectMake(0, 768, SMALL_FISH_SWARM_STRAIGHT_WIDTH, SMALL_FISH_SWARM_STRAIGHT_HEIGHT)];
    if (isMirrored)
    {
        smallFishSwarmStraightImageView.image = [UIImage imageNamed:@"6-7_1k_kishal_raj_1.png"];
        smallFishSwarmStraightImageView.image = [UIImage imageWithCGImage:[smallFishSwarmStraightImageView.image CGImage] scale:1.0 orientation:UIImageOrientationUpMirrored];
    }
    else
    {
        smallFishSwarmStraightImageView.image = [UIImage imageNamed:@"6-7_1k_kishal_raj_1.png"];
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
    }
}

-(void)placeARandomCreatureAtNewX;
{
    NSInteger randomNumber = (arc4random()%NUMBER_OF_CREATURES)+1;
    
    Screen06_07CreaturesImageView *randomCreatureImageView;
    switch (randomNumber)
    {
        case 1:
            randomCreatureImageView = [[Screen06_07CreaturesImageView alloc] initWithFrame:CGRectMake(CREATURE01_START_FRAME)];
            randomCreatureImageView.image = [UIImage imageNamed:@"6-7_1k_leny1.png"];
            break;
            
        case 2:
            randomCreatureImageView = [[Screen06_07CreaturesImageView alloc] initWithFrame:CGRectMake(CREATURE02_START_FRAME)];
            randomCreatureImageView.image = [UIImage imageNamed:@"6-7_1k_leny2.png"];
            break;
            
        case 3:
            randomCreatureImageView = [[Screen06_07CreaturesImageView alloc] initWithFrame:CGRectMake(CREATURE03_START_FRAME)];
            randomCreatureImageView.image = [UIImage imageNamed:@"6-7_1k_leny3.png"];
            break;
            
        case 4:
            randomCreatureImageView = [[Screen06_07CreaturesImageView alloc] initWithFrame:CGRectMake(CREATURE04_START_FRAME)];
            randomCreatureImageView.image = [UIImage imageNamed:@"6-7_1k_leny4.png"];
            break;
            
        case 5:
            randomCreatureImageView = [[Screen06_07CreaturesImageView alloc] initWithFrame:CGRectMake(CREATURE05_START_FRAME)];
            randomCreatureImageView.image = [UIImage imageNamed:@"6-7_1k_leny5.png"];
            break;
            
        case 6:
            randomCreatureImageView = [[Screen06_07CreaturesImageView alloc] initWithFrame:CGRectMake(CREATURE06_START_FRAME)];
            randomCreatureImageView.image = [UIImage imageNamed:@"6-7_1k_leny6.png"];
            break;
            
        case 7:
            randomCreatureImageView = [[Screen06_07CreaturesImageView alloc] initWithFrame:CGRectMake(CREATURE07_START_FRAME)];
            randomCreatureImageView.image = [UIImage imageNamed:@"6-7_1k_leny7.png"];
            break;
            
        case 8:
            randomCreatureImageView = [[Screen06_07CreaturesImageView alloc] initWithFrame:CGRectMake(CREATURE08_START_FRAME)];
            randomCreatureImageView.image = [UIImage imageNamed:@"6-7_1k_leny8.png"];
            break;
            
        case 9:
            randomCreatureImageView = [[Screen06_07CreaturesImageView alloc] initWithFrame:CGRectMake(CREATURE09_START_FRAME)];
            randomCreatureImageView.image = [UIImage imageNamed:@"6-7_1k_leny9.png"];
            break;
            
        case 10:
            randomCreatureImageView = [[Screen06_07CreaturesImageView alloc] initWithFrame:CGRectMake(CREATURE10_START_FRAME)];
            randomCreatureImageView.image = [UIImage imageNamed:@"6-7_1k_leny10.png"];
            break;
            
        case 11:
            randomCreatureImageView = [[Screen06_07CreaturesImageView alloc] initWithFrame:CGRectMake(CREATURE11_START_FRAME)];
            randomCreatureImageView.image = [UIImage imageNamed:@"6-7_1k_leny11.png"];
            break;
            
        case 12:
            randomCreatureImageView = [[Screen06_07CreaturesImageView alloc] initWithFrame:CGRectMake(CREATURE12_START_FRAME)];
            randomCreatureImageView.image = [UIImage imageNamed:@"6-7_1k_leny12.png"];
            break;
            
        case 13:
            randomCreatureImageView = [[Screen06_07CreaturesImageView alloc] initWithFrame:CGRectMake(CREATURE13_START_FRAME)];
            randomCreatureImageView.image = [UIImage imageNamed:@"6-7_1k_leny13.png"];
            break;
            
        case 14:
            randomCreatureImageView = [[Screen06_07CreaturesImageView alloc] initWithFrame:CGRectMake(CREATURE14_START_FRAME)];
            randomCreatureImageView.image = [UIImage imageNamed:@"6-7_1k_leny14.png"];
            break;
            
        default:
            ;
            break;
    }
    
    randomCreatureImageView.direction=newDirectionForCreature;
    CGPoint newCenter;
    newCenter=CGPointMake(newXForCreature, (randomCreatureImageView.frame.size.height/2)+749);
    randomCreatureImageView.normalCenter=newCenter;
    [randomCreatureImageView setCalculatedCenterBasedOnDirection];
    [self.view addSubview:randomCreatureImageView];
    
    newCreatureTimerClock++;
    if (newCreatureTimerClock==NUMBER_OF_CREATURES_APPEAR_AFTER_EACHOTHER)
    {
        [newCreatureTimer invalidate];
        newCreatureTimer=nil;
    }

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ((interfaceOrientation==UIInterfaceOrientationLandscapeLeft)||(interfaceOrientation==UIInterfaceOrientationLandscapeRight)) {
        return YES;
    }
    // Return YES for supported orientations
	return NO;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self screen06_07AppearWaves];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
