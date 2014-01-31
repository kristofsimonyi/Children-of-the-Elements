//
//  A1ViewController.m
//  KickOff
//
//  Created by INKOVICS Ferenc on 18/03/2012.
//  Copyright (c) 2012 No company - private person. All rights reserved.
//
/*
 Interakciok:
 1:Alapbol a screenen lathato: alap, egy (random) cica, ruha 1-2-3-4, tubus, mandulak (9 db)
 2:egy mp eltelte utan (user interakcio nelkul) az ures szovegmezo benepesul a szoveggel (ugy mint a itt, 0:46-nal)
 3:Egy-egy szurke pocsolyara tapintva felul beeseik jopar megfelelo szinu esocsepp, de nem egyenesen, hanem kicsit kacskaringosan esnek, es pont mind a tapintott pocsolyaba esik, ami igy beszinezodik. Ez kesobb is megismetelheto.
 4:A lathato cicat megerintve MIAU hallatszik, s a cica eltunik, ezzel egyidoben egy masik (random) felbukkan. Ez a logika folyik a vegtelensegig.
 5:Az ablakokra, lampara tapintva azok allapotot valtanak.
 6:Ruhakra tapintva szelfuvas hang, zsalu nyikorgas hang, ruhak jobbra kilengenek (forgas), az egyik zokni kirepul jobbra porogve (majd balrol visszarepul), ablak zsaluk vizszintes iranyban torzulnak kicsit erre is arra is (mintha lengenenek).
 7:Kilenc suti: barmelyikre tapintva a tubus odafordul, s kilo egy hab-pacat, ami eloszor kicsi, de mire a sutire erkezik, eleri teljes meretet (100%).
 8:Mandulak: a mandulakat ra lehet huzni a sutikre. Ha egy mandulat nem egy mar habos, de meg nem mandulas sutin engedi el az olvaso, akkor az visszarepul az eredeti helyere.
 */

#import "A1ViewController.h"
#import "ViewController.h"

#define GAP_BETWEEN_ROWS        100
#define RAINDROP_X_MAX          15
#define RAINDROP_Y_MAX          5
#define AMPLITUDE_FOR_RAIN      12
#define CLOTHES_MIN_ROTATION    -15.00  //the 2 zeros after the point are important 
#define CLOTHES_RANDOM_VALUE_FOR_ROTATION           60
#define RAINDROP_INCOMING_DEGREE_MODIFYING_VALUE    0.50
#define DEFAULT_SFX_VOLUME                          0.25

@implementation A1ViewController

@synthesize a1View,a1Cat1Control,a1Cat2Control,a1Cat3Control,a1Cat4Control,a1Cat5Control,a1Cat6Control, a1CatImageView, a1StreetLampControl,a1StreetLampImageView,a1StreetLight1Control,a1StreetLight2Control,a1StreetLight3Control,a1StreetLight4Control,a1StreetLight5Control,a1StreetLight6Control,a1StreetLight7Control,a1StreetLight8Control,a1StreetLight9Control,a1StreetLight10Control,a1StreetLight11Control,a1StreetLight12Control,a1StreetLight13Control,a1StreetLight1ImageView,a1StreetLight2ImageView,a1StreetLight3ImageView,a1StreetLight4ImageView,a1StreetLight5ImageView,a1StreetLight6ImageView,a1StreetLight7ImageView,a1StreetLight8ImageView,a1StreetLight9ImageView,a1StreetLight10ImageView,a1StreetLight11ImageView,a1StreetLight12ImageView,a1StreetLight13ImageView,a1Puddle1Control,a1Puddle2Control,a1Puddle3Control,a1Puddle4Control,a1Puddle1ImageView,a1Puddle2ImageView,a1Puddle3ImageView,a1Puddle4ImageView,a1WhippedCream1Control,a1WhippedCream2Control,a1WhippedCream3Control,a1WhippedCream4Control,a1WhippedCream5Control,a1WhippedCream6Control,a1WhippedCream7Control,a1WhippedCream8Control,a1WhippedCream9Control,a1WhippedCream1ImageView,a1WhippedCream2ImageView,a1WhippedCream3ImageView,a1WhippedCream4ImageView,a1WhippedCream5ImageView,a1WhippedCream6ImageView,a1WhippedCream7ImageView,a1WhippedCream8ImageView,a1WhippedCream9ImageView,a1TubeImageView,a1Almond1ImageView,a1Almond2ImageView,a1Almond3ImageView,a1Almond4ImageView,a1Almond5ImageView,a1Almond6ImageView,a1Almond7ImageView,a1Almond8ImageView,a1Almond9ImageView, a1WindControl,a1ShutterLeftImageView,a1ShutterRightImageView, a1Clothes1ImageView,a1Clothes2ImageView,a1Clothes3ImageView, a1Clothes4ImageView;

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

- (IBAction)a1BackToMainMenu:(id)sender;
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController=0;
    viewContoller = nil;
    
    [self goToNextScreen];
}

- (IBAction)a1NextScreenButtonTouched:(id)sender
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController++;
    viewContoller = nil;
    
    [self goToNextScreen];
}

- (IBAction)a1PreviousScreenButtonTouched:(id)sender
{
    ViewController *viewContoller = [self.navigationController.viewControllers objectAtIndex:0];
    viewContoller.nextViewController--;
    viewContoller = nil;
    
    [self goToNextScreen];
}

- (IBAction)a1RandomCatImage:(id)sender;
{
    [a1Cat1Control setEnabled:FALSE];
    [a1Cat2Control setEnabled:FALSE];
    [a1Cat3Control setEnabled:FALSE];
    [a1Cat4Control setEnabled:FALSE];
    [a1Cat5Control setEnabled:FALSE];
    [a1Cat6Control setEnabled:FALSE];
    int newRandomCatNumber =(arc4random()%6)+1;
    while (randomCatNumber == newRandomCatNumber) {
        newRandomCatNumber =(arc4random()%6)+1;
    }
    randomCatNumber = newRandomCatNumber;
    switch (randomCatNumber) {
        case 1:
            a1CatImageView.image=[UIImage imageNamed:@"a1-1k_cica1.png"];
            [a1Cat1Control setEnabled:TRUE];
            break;
            
        case 2:
            [a1Cat2Control setEnabled:TRUE];
            a1CatImageView.image=[UIImage imageNamed:@"a1-1k_cica2.png"];
            ;
            break;
            
        case 3:
            [a1Cat3Control setEnabled:TRUE];
            a1CatImageView.image=[UIImage imageNamed:@"a1-1k_cica3.png"];
            ;
            break;
            
        case 4:
            [a1Cat4Control setEnabled:TRUE];
            a1CatImageView.image=[UIImage imageNamed:@"a1-1k_cica4.png"];
            ;
            break;
            
        case 5:
            [a1Cat5Control setEnabled:TRUE];
            a1CatImageView.image=[UIImage imageNamed:@"a1-1k_cica5.png"];
            ;
            break;
            
        case 6:
            [a1Cat6Control setEnabled:TRUE];
            a1CatImageView.image=[UIImage imageNamed:@"a1-1k_cica6.png"];
            ;
            break;
            
        default:
            break;
    }
    //start the SFX for cat
	[catSFX play];

}

- (IBAction)a1StreetLampSelected:(id)sender;
{
    [a1StreetLampImageView setAlpha:(1-a1StreetLampImageView.alpha)]; 
    //start the SFX for light
	[lightSwitchSFX play];
}

- (IBAction)a1StreetLight1Selected:(id)sender;
{
    [a1StreetLight1ImageView setAlpha:(1-a1StreetLight1ImageView.alpha)]; 
    //start the SFX for light
	[lightSwitchSFX play];
}

- (IBAction)a1StreetLight2Selected:(id)sender;
{
    [a1StreetLight2ImageView setAlpha:(1-a1StreetLight2ImageView.alpha)]; 
    //start the SFX for light
	[lightSwitchSFX play];
}

- (IBAction)a1StreetLight3Selected:(id)sender;
{
    [a1StreetLight3ImageView setAlpha:(1-a1StreetLight3ImageView.alpha)]; 
    //start the SFX for light
	[lightSwitchSFX play];
}

- (IBAction)a1StreetLight4Selected:(id)sender;
{
    [a1StreetLight4ImageView setAlpha:(1-a1StreetLight4ImageView.alpha)]; 
    //start the SFX for light
	[lightSwitchSFX play];
}

- (IBAction)a1StreetLight5Selected:(id)sender;
{
    [a1StreetLight5ImageView setAlpha:(1-a1StreetLight5ImageView.alpha)]; 
    //start the SFX for light
	[lightSwitchSFX play];
}

- (IBAction)a1StreetLight6Selected:(id)sender;
{
    [a1StreetLight6ImageView setAlpha:(1-a1StreetLight6ImageView.alpha)]; 
    //start the SFX for light
	[lightSwitchSFX play];
}

- (IBAction)a1StreetLight7Selected:(id)sender;
{
    [a1StreetLight7ImageView setAlpha:(1-a1StreetLight7ImageView.alpha)]; 
    //start the SFX for light
	[lightSwitchSFX play];
}

- (IBAction)a1StreetLight8Selected:(id)sender;
{
    [a1StreetLight8ImageView setAlpha:(1-a1StreetLight8ImageView.alpha)]; 
    //start the SFX for light
	[lightSwitchSFX play];
}

- (IBAction)a1StreetLight9Selected:(id)sender;
{
    [a1StreetLight9ImageView setAlpha:(1-a1StreetLight9ImageView.alpha)]; 
    //start the SFX for light
	[lightSwitchSFX play];
}

- (IBAction)a1StreetLight10Selected:(id)sender;
{
    [a1StreetLight10ImageView setAlpha:(1-a1StreetLight10ImageView.alpha)]; 
    //start the SFX for light
	[lightSwitchSFX play];
}

- (IBAction)a1StreetLight11Selected:(id)sender;
{
    [a1StreetLight11ImageView setAlpha:(1-a1StreetLight11ImageView.alpha)]; 
    //start the SFX for light
	[lightSwitchSFX play];
}

- (IBAction)a1StreetLight12Selected:(id)sender;
{
    [a1StreetLight12ImageView setAlpha:(1-a1StreetLight12ImageView.alpha)]; 
    //start the SFX for light
	[lightSwitchSFX play];
}

- (IBAction)a1StreetLight13Selected:(id)sender;
{
    [a1StreetLight13ImageView setAlpha:(1-a1StreetLight13ImageView.alpha)]; 
    //start the SFX for light
	[lightSwitchSFX play];
}

- (IBAction)a1Puddle1Selected:(id)sender;
{
    
    [a1Puddle1Control setEnabled:FALSE];
    UIImageView *rainDropImageAtPoint;
    int raindropX = arc4random()%(RAINDROP_X_MAX-10)+10;
    int rainDropY = arc4random()%(RAINDROP_Y_MAX-3)+3;
    int rainDropSteps;
    CGPoint startPoint,stopPoint;
    puddle1MaxSteps = 0;
    float calculatedY;
    for (int i=0; i<raindropX; i++) 
    {
        for (int j=0; j<rainDropY; j++) 
        {
            calculatedY = (arc4random()%GAP_BETWEEN_ROWS+j*GAP_BETWEEN_ROWS);
            startPoint = CGPointMake(arc4random()%1024,-roundf(calculatedY));
            
            stopPoint = CGPointMake(a1Puddle1Control.center.x+arc4random()%100-50,a1Puddle1Control.center.y+arc4random()%40-30); 
            
            [rainDrops1Array addObject:[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 16, 42)]];   
            [rainDrops1StartArray addObject:[NSValue valueWithCGPoint:startPoint]];   
            [rainDrops1StopArray addObject:[NSValue valueWithCGPoint:stopPoint]];   
            rainDropSteps = stopPoint.y-startPoint.y;
            if (rainDropSteps>puddle1MaxSteps) {
                puddle1MaxSteps = rainDropSteps;
            }
            [rainDrops1StepsArray addObject:[NSNumber numberWithInteger:rainDropSteps]];   
        }
    }
    
    NSEnumerator *enumerator = [rainDrops1Array objectEnumerator];
    NSEnumerator *enumeratorStartPoint = [rainDrops1StartArray objectEnumerator];
    NSEnumerator *enumeratorStopPoint = [rainDrops1StopArray objectEnumerator];
    id obj, objStartPoint, objStopPoint;
    int i,j=0;
    float f;
    while (obj = [enumerator nextObject]) 
    {
        objStartPoint = [enumeratorStartPoint nextObject];
        objStopPoint = [enumeratorStopPoint nextObject];
        
        startPoint = [objStartPoint CGPointValue];        
        stopPoint = [objStopPoint CGPointValue];  
        
        rainDropImageAtPoint = obj;
        [rainDropImageAtPoint setCenter:startPoint];
        switch (arc4random()%3) {
            case 0:
                rainDropImageAtPoint.image=[UIImage imageNamed:@"csepp_1_a.png"];
                break;
                
            case 1:
                rainDropImageAtPoint.image=[UIImage imageNamed:@"csepp_1_b.png"];
                break;
                
            case 2:
                rainDropImageAtPoint.image=[UIImage imageNamed:@"csepp_1_c.png"];
                break;
                
            case 3:
                rainDropImageAtPoint.image=[UIImage imageNamed:@"csepp_4_a.png"];
                break;
                
            default:
                rainDropImageAtPoint.image=[UIImage imageNamed:@"csepp_1_a.png"];
                break;
        }

        f=1.00*(arc4random()%41);
        f=0.01*f+0.60;
        [rainDropImageAtPoint setTransform:CGAffineTransformMakeScale(f, f)];

        CGFloat rainDropIncomingDegree = atanf((stopPoint.x-startPoint.x)/(startPoint.y-stopPoint.y))*RAINDROP_INCOMING_DEGREE_MODIFYING_VALUE;

        CGAffineTransform newTransform = [rainDropImageAtPoint transform];
        newTransform = CGAffineTransformRotate(newTransform, rainDropIncomingDegree);
        [rainDropImageAtPoint setTransform:newTransform];
        
        [self.view addSubview:rainDropImageAtPoint];  
        
        
        j++;
        if (j==rainDropY)
        {
            j=0;
            i=i+1;
        }
    }
    
    itIsRaining1Timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(itIsRaining1Action) userInfo:nil repeats:YES];
    itIsRaining1Clock=0;
	[itIsRaining1Timer fire];
    
    rainSFXVolumeTimer= [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(rainSFXVolumeAction) userInfo:nil repeats:YES];
    rainSFXVolumeClockChange=0.01;
	[rainSFXVolumeTimer fire];
    
}

- (void)rainSFXVolumeAction
{
    [itIsRainingSFX setVolume:[itIsRainingSFX volume]+rainSFXVolumeClockChange];
    if (rainSFXVolumeClockChange>0) 
    {
        if (![itIsRainingSFX isPlaying]) 
        {
            [itIsRainingSFX play];
        }
        if ([itIsRainingSFX volume]>=1) 
        {
            [rainSFXVolumeTimer invalidate];            
        }
    } else 
    {
        if ([itIsRainingSFX volume]<=0) 
        {
            [itIsRainingSFX stop];
            [rainSFXVolumeTimer invalidate];
        }
    }
}

- (void)itIsRaining1Action
{
    int rainDropsReachedThePuddle = 0;
    itIsRaining1Clock=itIsRaining1Clock+4;
    if (itIsRaining1Clock<=puddle1MaxSteps) {
        NSEnumerator *enumerator = [rainDrops1Array objectEnumerator];
        id obj,objStartPoint,objStopPoint,objStepValue;
        int stepValue;
        UIImageView *rainDropImageAtPoint;
        
        NSEnumerator *enumeratorStartPoint = [rainDrops1StartArray objectEnumerator];
        NSEnumerator *enumeratorStopPoint = [rainDrops1StopArray objectEnumerator];
        NSEnumerator *enumeratorStepPoint = [rainDrops1StepsArray objectEnumerator];
        CGPoint startPoint,stopPoint;
        
        float calculatedX,calculatedY;
        int everySecond = 1;
        CGFloat rainDropRotate;
        
        while (obj = [enumerator nextObject]) 
        {
            objStartPoint = [enumeratorStartPoint nextObject];
            objStopPoint = [enumeratorStopPoint nextObject];
            objStepValue = [enumeratorStepPoint nextObject];
            startPoint = [objStartPoint CGPointValue];        
            stopPoint = [objStopPoint CGPointValue];  
            
            stepValue = [objStepValue integerValue];
            
            rainDropImageAtPoint = obj;
            
            everySecond = -1*everySecond;
            
            calculatedX = -((100.00*itIsRaining1Clock/stepValue)/100.00)*(startPoint.x-stopPoint.x)+startPoint.x+everySecond*sinf(itIsRaining1Clock*M_PI/180)*AMPLITUDE_FOR_RAIN;
            calculatedY = roundf(((stopPoint.y-startPoint.y)*(100.00*itIsRaining1Clock/stepValue))/100.00)+startPoint.y;
            [rainDropImageAtPoint setCenter:CGPointMake(roundf(calculatedX),roundf(calculatedY))];
            
            rainDropRotate = -cosf(itIsRaining1Clock*M_PI/180)/2*M_PI/180;
            CGAffineTransform newTransform = [rainDropImageAtPoint transform];
            newTransform = CGAffineTransformRotate(newTransform,rainDropRotate);
            [rainDropImageAtPoint setTransform:newTransform];

            if (calculatedY>stopPoint.y) {
                [rainDropImageAtPoint removeFromSuperview];
                rainDropsReachedThePuddle++;
            }
        }
        ;
    }

    if ((rainDropsReachedThePuddle>0)&&(a1Puddle1ImageView.alpha != 1)) 
    {
        [a1Puddle1ImageView setAlpha:1.00*rainDropsReachedThePuddle/[rainDrops1Array count]];
    }
    
    if (itIsRaining1Clock>puddle1MaxSteps) 
    {
        
        NSEnumerator *enumerator = [rainDrops1Array objectEnumerator];
        id obj;
        UIImageView *rainDropImageAtPoint;
        while (obj = [enumerator nextObject]) 
        {
            rainDropImageAtPoint = obj;
            [rainDropImageAtPoint removeFromSuperview];
        }
        
        
        [rainDrops1Array removeAllObjects];
        
        //        [a1Puddle1ImageView setAlpha:0];     
        
        [a1Puddle1Control setEnabled:TRUE];
        
        rainSFXVolumeTimer= [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(rainSFXVolumeAction) userInfo:nil repeats:YES];
        rainSFXVolumeClockChange=-0.01;
        [rainSFXVolumeTimer fire];

        [itIsRaining1Timer invalidate];
        [a1Puddle1ImageView setAlpha:1];
    }
}

- (IBAction)a1Puddle2Selected:(id)sender;
{
    [a1Puddle2Control setEnabled:FALSE];
    UIImageView *rainDropImageAtPoint;
    int raindropX = arc4random()%(RAINDROP_X_MAX-10)+10;
    int rainDropY = arc4random()%(RAINDROP_Y_MAX-3)+3;
    int rainDropSteps;
    CGPoint startPoint,stopPoint;
    puddle2MaxSteps = 0;
    float calculatedY;
    for (int i=0; i<raindropX; i++) 
    {
        for (int j=0; j<rainDropY; j++) 
        {
            calculatedY = (arc4random()%GAP_BETWEEN_ROWS+j*GAP_BETWEEN_ROWS);
            startPoint = CGPointMake(arc4random()%1024,-roundf(calculatedY));
            
            stopPoint = CGPointMake(a1Puddle2Control.center.x+arc4random()%80-40,a1Puddle2Control.center.y+arc4random()%40-30); 
            
            [rainDrops2Array addObject:[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 16, 42)]];   
            [rainDrops2StartArray addObject:[NSValue valueWithCGPoint:startPoint]];   
            [rainDrops2StopArray addObject:[NSValue valueWithCGPoint:stopPoint]];   
            rainDropSteps = stopPoint.y-startPoint.y;
            if (rainDropSteps>puddle2MaxSteps) {
                puddle2MaxSteps = rainDropSteps;
            }
            [rainDrops2StepsArray addObject:[NSNumber numberWithInteger:rainDropSteps]];   
        }
    }
    
    NSEnumerator *enumerator = [rainDrops2Array objectEnumerator];
    NSEnumerator *enumeratorStartPoint = [rainDrops2StartArray objectEnumerator];
    NSEnumerator *enumeratorStopPoint = [rainDrops2StopArray objectEnumerator];
    id obj, objStartPoint, objStopPoint;
    int i,j=0;
    float f;
    while (obj = [enumerator nextObject]) 
    {
        objStartPoint = [enumeratorStartPoint nextObject];
        objStopPoint = [enumeratorStopPoint nextObject];
        
        startPoint = [objStartPoint CGPointValue];        
        stopPoint = [objStopPoint CGPointValue];  
        
        rainDropImageAtPoint = obj;
        [rainDropImageAtPoint setCenter:startPoint];
        switch (arc4random()%4) {
            case 0:
                rainDropImageAtPoint.image=[UIImage imageNamed:@"csepp_2_a.png"];
                break;
                
            case 1:
                rainDropImageAtPoint.image=[UIImage imageNamed:@"csepp_2_b.png"];
                break;
                
            case 2:
                rainDropImageAtPoint.image=[UIImage imageNamed:@"csepp_2_c.png"];
                break;
                
            case 3:
                rainDropImageAtPoint.image=[UIImage imageNamed:@"csepp_2_d.png"];
                break;
                
            default:
                rainDropImageAtPoint.image=[UIImage imageNamed:@"csepp_2_a.png"];
                break;
        }        
        
        f=1.00*(arc4random()%41);
        f=0.01*f+0.60;
        [rainDropImageAtPoint setTransform:CGAffineTransformMakeScale(f, f)];
        
        CGFloat rainDropIncomingDegree = atanf((stopPoint.x-startPoint.x)/(startPoint.y-stopPoint.y))*RAINDROP_INCOMING_DEGREE_MODIFYING_VALUE;
        
        CGAffineTransform newTransform = [rainDropImageAtPoint transform];
        newTransform = CGAffineTransformRotate(newTransform, rainDropIncomingDegree);
        [rainDropImageAtPoint setTransform:newTransform];
        
        [self.view addSubview:rainDropImageAtPoint];   

        j++;
        if (j==rainDropY) {
            j=0;
            i=i+1;
        }
    }
    
    itIsRaining2Timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(itIsRaining2Action) userInfo:nil repeats:YES];
    itIsRaining2Clock=0;
	[itIsRaining2Timer fire];
    
    rainSFXVolumeTimer= [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(rainSFXVolumeAction) userInfo:nil repeats:YES];
    rainSFXVolumeClockChange=0.01;
	[rainSFXVolumeTimer fire];
    

}

- (void)itIsRaining2Action
{
    int rainDropsReachedThePuddle = 0;
    itIsRaining2Clock=itIsRaining2Clock+4;
    if (itIsRaining2Clock<=puddle2MaxSteps) {
        NSEnumerator *enumerator = [rainDrops2Array objectEnumerator];
        id obj,objStartPoint,objStopPoint,objStepValue;
        int stepValue;
        UIImageView *rainDropImageAtPoint;
        
        NSEnumerator *enumeratorStartPoint = [rainDrops2StartArray objectEnumerator];
        NSEnumerator *enumeratorStopPoint = [rainDrops2StopArray objectEnumerator];
        NSEnumerator *enumeratorStepPoint = [rainDrops2StepsArray objectEnumerator];
        CGPoint startPoint,stopPoint;
        
        float calculatedX,calculatedY;
        int everySecond = 1;
        
        CGFloat rainDropRotate;
        
        while (obj = [enumerator nextObject]) 
        {
            objStartPoint = [enumeratorStartPoint nextObject];
            objStopPoint = [enumeratorStopPoint nextObject];
            objStepValue = [enumeratorStepPoint nextObject];
            startPoint = [objStartPoint CGPointValue];        
            stopPoint = [objStopPoint CGPointValue];  
            
            stepValue = [objStepValue integerValue];
            
            rainDropImageAtPoint = obj;
            
            everySecond = -1*everySecond;
            
            calculatedX = -((100.00*itIsRaining2Clock/stepValue)/100.00)*(startPoint.x-stopPoint.x)+startPoint.x+everySecond*sinf(itIsRaining2Clock*M_PI/180)*AMPLITUDE_FOR_RAIN;
            calculatedY = roundf(((stopPoint.y-startPoint.y)*(100.00*itIsRaining2Clock/stepValue))/100.00)+startPoint.y;
            [rainDropImageAtPoint setCenter:CGPointMake(roundf(calculatedX),roundf(calculatedY))];
            
            rainDropRotate = -cosf(itIsRaining2Clock*M_PI/180)/2*M_PI/180;
            CGAffineTransform newTransform = [rainDropImageAtPoint transform];
            newTransform = CGAffineTransformRotate(newTransform,rainDropRotate);
            [rainDropImageAtPoint setTransform:newTransform];
            
            if (calculatedY>stopPoint.y) {
                [rainDropImageAtPoint removeFromSuperview];
                rainDropsReachedThePuddle++;
            }
        }
        ;
    }

    if ((rainDropsReachedThePuddle>0)&&(a1Puddle2ImageView.alpha != 1)) 
    {
        [a1Puddle2ImageView setAlpha:1.00*rainDropsReachedThePuddle/[rainDrops2Array count]];
    }
 
    if (itIsRaining2Clock>puddle2MaxSteps) {
        
        NSEnumerator *enumerator = [rainDrops2Array objectEnumerator];
        id obj;
        UIImageView *rainDropImageAtPoint;
        while (obj = [enumerator nextObject]) 
        {
            rainDropImageAtPoint = obj;
            [rainDropImageAtPoint removeFromSuperview];
        }
        
        
        [rainDrops2Array removeAllObjects];
        
        //        [a1Puddle2ImageView setAlpha:0];     
        
        [a1Puddle2Control setEnabled:TRUE];
        
        [a1Puddle2ImageView setAlpha:1];

        [itIsRaining2Timer invalidate];
        
        rainSFXVolumeTimer= [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(rainSFXVolumeAction) userInfo:nil repeats:YES];
        rainSFXVolumeClockChange=-0.01;
        [rainSFXVolumeTimer fire];
        

        
    }
}


- (IBAction)a1Puddle3Selected:(id)sender;
{
    [a1Puddle3Control setEnabled:FALSE];
    UIImageView *rainDropImageAtPoint;
    int raindropX = arc4random()%(RAINDROP_X_MAX-10)+10;
    int rainDropY = arc4random()%(RAINDROP_Y_MAX-3)+3;
    int rainDropSteps;
    CGPoint startPoint,stopPoint;
    puddle3MaxSteps = 0;
    float calculatedY;
    for (int i=0; i<raindropX; i++) 
    {
        for (int j=0; j<rainDropY; j++) 
        {
            calculatedY = (arc4random()%GAP_BETWEEN_ROWS+j*GAP_BETWEEN_ROWS);
            startPoint = CGPointMake(arc4random()%1024,-roundf(calculatedY));
            
            stopPoint = CGPointMake(a1Puddle3Control.center.x+arc4random()%146-73,a1Puddle3Control.center.y+arc4random()%40-30); 
            
            [rainDrops3Array addObject:[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 16, 42)]];   
            [rainDrops3StartArray addObject:[NSValue valueWithCGPoint:startPoint]];   
            [rainDrops3StopArray addObject:[NSValue valueWithCGPoint:stopPoint]];   
            rainDropSteps = stopPoint.y-startPoint.y;
            if (rainDropSteps>puddle3MaxSteps) {
                puddle3MaxSteps = rainDropSteps;
            }
            [rainDrops3StepsArray addObject:[NSNumber numberWithInteger:rainDropSteps]];   
        }
    }
    
    NSEnumerator *enumerator = [rainDrops3Array objectEnumerator];
    NSEnumerator *enumeratorStartPoint = [rainDrops3StartArray objectEnumerator];
    NSEnumerator *enumeratorStopPoint = [rainDrops3StopArray objectEnumerator];
    id obj, objStartPoint, objStopPoint;
    int i,j=0;
    float f;
    while (obj = [enumerator nextObject]) 
    {
        objStartPoint = [enumeratorStartPoint nextObject];
        objStopPoint = [enumeratorStopPoint nextObject];
        
        startPoint = [objStartPoint CGPointValue];        
        stopPoint = [objStopPoint CGPointValue];  
        
        rainDropImageAtPoint = obj;
        [rainDropImageAtPoint setCenter:startPoint];
        switch (arc4random()%5) {
            case 0:
                rainDropImageAtPoint.image=[UIImage imageNamed:@"csepp_3_a.png"];
                break;
                
            case 1:
                rainDropImageAtPoint.image=[UIImage imageNamed:@"csepp_3_b.png"];
                break;
                
            case 2:
                rainDropImageAtPoint.image=[UIImage imageNamed:@"csepp_3_c.png"];
                break;
                
            case 3:
                rainDropImageAtPoint.image=[UIImage imageNamed:@"csepp_3_d.png"];
                break;
                
            case 4:
                rainDropImageAtPoint.image=[UIImage imageNamed:@"csepp_3_e.png"];
                break;
                
            default:
                rainDropImageAtPoint.image=[UIImage imageNamed:@"csepp_3_a.png"];
                break;
        }
        
        f=1.00*(arc4random()%41);
        f=0.01*f+0.60;
        [rainDropImageAtPoint setTransform:CGAffineTransformMakeScale(f, f)];

        CGFloat rainDropIncomingDegree = atanf((stopPoint.x-startPoint.x)/(startPoint.y-stopPoint.y))*RAINDROP_INCOMING_DEGREE_MODIFYING_VALUE;
        
        CGAffineTransform newTransform = [rainDropImageAtPoint transform];
        newTransform = CGAffineTransformRotate(newTransform, rainDropIncomingDegree);
        [rainDropImageAtPoint setTransform:newTransform];
        
        [self.view addSubview:rainDropImageAtPoint];   

        j++;
        if (j==rainDropY) {
            j=0;
            i=i+1;
        }
    }
    
    itIsRaining3Timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(itIsRaining3Action) userInfo:nil repeats:YES];
    itIsRaining3Clock=0;
	[itIsRaining3Timer fire];
    
    rainSFXVolumeTimer= [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(rainSFXVolumeAction) userInfo:nil repeats:YES];
    rainSFXVolumeClockChange=0.01;
	[rainSFXVolumeTimer fire];
    
}

- (void)itIsRaining3Action
{
    int rainDropsReachedThePuddle = 0;
    itIsRaining3Clock=itIsRaining3Clock+4;
    if (itIsRaining3Clock<=puddle3MaxSteps) {
        NSEnumerator *enumerator = [rainDrops3Array objectEnumerator];
        id obj,objStartPoint,objStopPoint,objStepValue;
        int stepValue;
        UIImageView *rainDropImageAtPoint;
        
        NSEnumerator *enumeratorStartPoint = [rainDrops3StartArray objectEnumerator];
        NSEnumerator *enumeratorStopPoint = [rainDrops3StopArray objectEnumerator];
        NSEnumerator *enumeratorStepPoint = [rainDrops3StepsArray objectEnumerator];
        CGPoint startPoint,stopPoint;
        
        float calculatedX,calculatedY;
        int everySecond = 1;
        
        CGFloat rainDropRotate;
        
        while (obj = [enumerator nextObject]) 
        {
            objStartPoint = [enumeratorStartPoint nextObject];
            objStopPoint = [enumeratorStopPoint nextObject];
            objStepValue = [enumeratorStepPoint nextObject];
            startPoint = [objStartPoint CGPointValue];        
            stopPoint = [objStopPoint CGPointValue];  
            
            stepValue = [objStepValue integerValue];
            
            rainDropImageAtPoint = obj;
            
            everySecond = -1*everySecond;
            
            calculatedX = -((100.00*itIsRaining3Clock/stepValue)/100.00)*(startPoint.x-stopPoint.x)+startPoint.x+everySecond*sinf(itIsRaining3Clock*M_PI/180)*AMPLITUDE_FOR_RAIN;
            calculatedY = roundf(((stopPoint.y-startPoint.y)*(100.00*itIsRaining3Clock/stepValue))/100.00)+startPoint.y;
            [rainDropImageAtPoint setCenter:CGPointMake(roundf(calculatedX),roundf(calculatedY))];
            
            rainDropRotate = -cosf(itIsRaining3Clock*M_PI/180)/2*M_PI/180;
            CGAffineTransform newTransform = [rainDropImageAtPoint transform];
            newTransform = CGAffineTransformRotate(newTransform,rainDropRotate);
            [rainDropImageAtPoint setTransform:newTransform];
            
            if (calculatedY>stopPoint.y) {
                [rainDropImageAtPoint removeFromSuperview];
                rainDropsReachedThePuddle++;
            }
        }
        ;
    }
    
    if ((rainDropsReachedThePuddle>0)&&(a1Puddle3ImageView.alpha != 1)) 
    {
        [a1Puddle3ImageView setAlpha:1.00*rainDropsReachedThePuddle/[rainDrops3Array count]];
    }
    
    if (itIsRaining3Clock>puddle3MaxSteps) {
        
        NSEnumerator *enumerator = [rainDrops3Array objectEnumerator];
        id obj;
        UIImageView *rainDropImageAtPoint;
        while (obj = [enumerator nextObject]) 
        {
            rainDropImageAtPoint = obj;
            [rainDropImageAtPoint removeFromSuperview];
        }
        
        
        [rainDrops3Array removeAllObjects];
        
        //        [a1Puddle2ImageView setAlpha:0];     
        
        [a1Puddle3Control setEnabled:TRUE];
        
        [a1Puddle3ImageView setAlpha:1];
        
        [itIsRaining3Timer invalidate];
        
        rainSFXVolumeTimer= [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(rainSFXVolumeAction) userInfo:nil repeats:YES];
        rainSFXVolumeClockChange=-0.01;
        [rainSFXVolumeTimer fire];
        

    }
}



- (IBAction)a1Puddle4Selected:(id)sender;
{
    [a1Puddle4Control setEnabled:FALSE];
    UIImageView *rainDropImageAtPoint;
    int raindropX = arc4random()%(RAINDROP_X_MAX-10)+10;
    int rainDropY = arc4random()%(RAINDROP_Y_MAX-3)+3;
    int rainDropSteps;
    CGPoint startPoint,stopPoint;
    puddle4MaxSteps = 0;
    float calculatedY;
    for (int i=0; i<raindropX; i++) 
    {
        for (int j=0; j<rainDropY; j++) 
        {
            calculatedY = (arc4random()%GAP_BETWEEN_ROWS+j*GAP_BETWEEN_ROWS);
            startPoint = CGPointMake(arc4random()%1024,-roundf(calculatedY));
            
            stopPoint = CGPointMake(a1Puddle4Control.center.x+arc4random()%146-73,a1Puddle4Control.center.y+arc4random()%40-30); 
            
            [rainDrops4Array addObject:[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 16, 42)]];   
            [rainDrops4StartArray addObject:[NSValue valueWithCGPoint:startPoint]];   
            [rainDrops4StopArray addObject:[NSValue valueWithCGPoint:stopPoint]];   
            rainDropSteps = stopPoint.y-startPoint.y;
            if (rainDropSteps>puddle4MaxSteps) {
                puddle4MaxSteps = rainDropSteps;
            }
            [rainDrops4StepsArray addObject:[NSNumber numberWithInteger:rainDropSteps]];   
        }
    }
    
    NSEnumerator *enumerator = [rainDrops4Array objectEnumerator];
    NSEnumerator *enumeratorStartPoint = [rainDrops4StartArray objectEnumerator];
    NSEnumerator *enumeratorStopPoint = [rainDrops4StopArray objectEnumerator];
    id obj, objStartPoint, objStopPoint;
    int i,j=0;
    float f;
    while (obj = [enumerator nextObject]) 
    {
        objStartPoint = [enumeratorStartPoint nextObject];
        objStopPoint = [enumeratorStopPoint nextObject];
        
        startPoint = [objStartPoint CGPointValue];        
        stopPoint = [objStopPoint CGPointValue];  
        
        rainDropImageAtPoint = obj;
        [rainDropImageAtPoint setCenter:startPoint];
        switch (arc4random()%4) {
            case 0:
                rainDropImageAtPoint.image=[UIImage imageNamed:@"csepp_4_a.png"];
                break;
                
            case 1:
                rainDropImageAtPoint.image=[UIImage imageNamed:@"csepp_4_b.png"];
                break;
                
            case 2:
                rainDropImageAtPoint.image=[UIImage imageNamed:@"csepp_4_c.png"];
                break;
                
            case 3:
                rainDropImageAtPoint.image=[UIImage imageNamed:@"csepp_4_d.png"];
                break;
                
            default:
                rainDropImageAtPoint.image=[UIImage imageNamed:@"csepp_4_a.png"];
                break;
        }
         
        f=1.00*(arc4random()%41);
        f=0.01*f+0.60;
        [rainDropImageAtPoint setTransform:CGAffineTransformMakeScale(f, f)];

        CGFloat rainDropIncomingDegree = atanf((stopPoint.x-startPoint.x)/(startPoint.y-stopPoint.y))*RAINDROP_INCOMING_DEGREE_MODIFYING_VALUE;
        
        CGAffineTransform newTransform = [rainDropImageAtPoint transform];
        newTransform = CGAffineTransformRotate(newTransform, rainDropIncomingDegree);
        [rainDropImageAtPoint setTransform:newTransform];
        
        [self.view addSubview:rainDropImageAtPoint];   

        j++;
        if (j==rainDropY) {
            j=0;
            i=i+1;
        }
    }
    
    itIsRaining4Timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(itIsRaining4Action) userInfo:nil repeats:YES];
    itIsRaining4Clock=0;
	[itIsRaining4Timer fire];
    
    rainSFXVolumeTimer= [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(rainSFXVolumeAction) userInfo:nil repeats:YES];
    rainSFXVolumeClockChange=0.01;
	[rainSFXVolumeTimer fire];
    
}

- (void)itIsRaining4Action
{
    int rainDropsReachedThePuddle = 0;
    itIsRaining4Clock=itIsRaining4Clock+4;
    if (itIsRaining4Clock<=puddle4MaxSteps) {
        NSEnumerator *enumerator = [rainDrops4Array objectEnumerator];
        id obj,objStartPoint,objStopPoint,objStepValue;
        int stepValue;
        UIImageView *rainDropImageAtPoint;
        
        NSEnumerator *enumeratorStartPoint = [rainDrops4StartArray objectEnumerator];
        NSEnumerator *enumeratorStopPoint = [rainDrops4StopArray objectEnumerator];
        NSEnumerator *enumeratorStepPoint = [rainDrops4StepsArray objectEnumerator];
        CGPoint startPoint,stopPoint;
        
        float calculatedX,calculatedY;
        int everySecond = 1;
        
        CGFloat rainDropRotate;
        
        while (obj = [enumerator nextObject]) 
        {
            objStartPoint = [enumeratorStartPoint nextObject];
            objStopPoint = [enumeratorStopPoint nextObject];
            objStepValue = [enumeratorStepPoint nextObject];
            startPoint = [objStartPoint CGPointValue];        
            stopPoint = [objStopPoint CGPointValue];  
            
            stepValue = [objStepValue integerValue];
            
            rainDropImageAtPoint = obj;
            
            everySecond = -1*everySecond;
            
            calculatedX = -((100.00*itIsRaining4Clock/stepValue)/100.00)*(startPoint.x-stopPoint.x)+startPoint.x+everySecond*sinf(itIsRaining4Clock*M_PI/180)*AMPLITUDE_FOR_RAIN;
            calculatedY = roundf(((stopPoint.y-startPoint.y)*(100.00*itIsRaining4Clock/stepValue))/100.00)+startPoint.y;
            [rainDropImageAtPoint setCenter:CGPointMake(roundf(calculatedX),roundf(calculatedY))];
            
            rainDropRotate = -cosf(itIsRaining4Clock*M_PI/180)/2*M_PI/180;
            CGAffineTransform newTransform = [rainDropImageAtPoint transform];
            newTransform = CGAffineTransformRotate(newTransform,rainDropRotate);
            [rainDropImageAtPoint setTransform:newTransform];
            
            if (calculatedY>stopPoint.y) {
                [rainDropImageAtPoint removeFromSuperview];
                rainDropsReachedThePuddle++;
            }
        }
        ;
    }
    
    if ((rainDropsReachedThePuddle>0)&&(a1Puddle4ImageView.alpha != 1)) 
    {
        [a1Puddle4ImageView setAlpha:1.00*rainDropsReachedThePuddle/[rainDrops4Array count]];
    }
    
    if (itIsRaining4Clock>puddle4MaxSteps) {
        
        NSEnumerator *enumerator = [rainDrops4Array objectEnumerator];
        id obj;
        UIImageView *rainDropImageAtPoint;
        while (obj = [enumerator nextObject]) 
        {
            rainDropImageAtPoint = obj;
            [rainDropImageAtPoint removeFromSuperview];
        }
        
        
        [rainDrops4Array removeAllObjects];
        
        //        [a1Puddle2ImageView setAlpha:0];     
        
        [a1Puddle4Control setEnabled:TRUE];
        
        [a1Puddle4ImageView setAlpha:1];
        
        [itIsRaining4Timer invalidate];
        
        rainSFXVolumeTimer= [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(rainSFXVolumeAction) userInfo:nil repeats:YES];
        rainSFXVolumeClockChange=-0.01;
        [rainSFXVolumeTimer fire];
        
    }
}

- (IBAction)a1CakeSelected:(id)sender;
{
    UIImageView *selectedCream;
    UIControl *selectedControl;
    selectedCream = a1WhippedCream1ImageView;
    selectedControl = a1WhippedCream1Control;
    if (sender==a1WhippedCream2Control) 
    {
        selectedCream = a1WhippedCream2ImageView;
        selectedControl = a1WhippedCream2Control;
    }
    if (sender==a1WhippedCream3Control) 
    {
        selectedCream = a1WhippedCream3ImageView;
        selectedControl = a1WhippedCream3Control;
    }
    if (sender==a1WhippedCream4Control) 
    {
        selectedCream = a1WhippedCream4ImageView;
        selectedControl = a1WhippedCream4Control;
    }
    if (sender==a1WhippedCream5Control) 
    {
        selectedCream = a1WhippedCream5ImageView;
        selectedControl = a1WhippedCream5Control;
    }
    if (sender==a1WhippedCream6Control) 
    {
        selectedCream = a1WhippedCream6ImageView;
        selectedControl = a1WhippedCream6Control;
    }
    if (sender==a1WhippedCream7Control) 
    {
        selectedCream = a1WhippedCream7ImageView;
        selectedControl = a1WhippedCream7Control;
    }
    if (sender==a1WhippedCream8Control) 
    {
        selectedCream = a1WhippedCream8ImageView;
        selectedControl = a1WhippedCream8Control;
    }
    if (sender==a1WhippedCream9Control) 
    {
        selectedCream = a1WhippedCream9ImageView;
        selectedControl = a1WhippedCream9Control;
    }
    
    [selectedCream setAlpha:1];
    [selectedCream setTransform:CGAffineTransformMakeScale(0.1, 0.1)];
    
    float rotation = atanf((selectedControl.center.x-a1TubeImageView.center.x)/(a1TubeImageView.center.y-selectedControl.center.y))-(55.00/180*M_PI);
    
    CGAffineTransform newTransform = CGAffineTransformRotate(previousTransformMatrix,rotation);
    
    [selectedControl setEnabled:FALSE];
    [selectedAlmond setAlpha:1];
    [UIView animateWithDuration:0.5
						  delay: 0.0
						options: UIViewAnimationOptionCurveEaseIn
					 animations:^
     {
         [a1TubeImageView setTransform:newTransform];
     }
					 completion:^(BOOL finished)
     {
         [UIView animateWithDuration:1.0
                               delay: 0.0
                             options: UIViewAnimationOptionCurveEaseIn
                          animations:^
          {
              [selectedCream setCenter:selectedControl.center];
              
              CGFloat rotation=M_PI/2+M_PI*(arc4random()%45)/180;
              CGAffineTransform newTransform = CGAffineTransformRotate(CGAffineTransformMakeScale(1.0, 1.0),rotation);
              
              [selectedCream setTransform:newTransform];

              //start the SFX for tube firing cream
              [tubeFiresCreamSFX play];
          }
                          completion:nil];
     }];
    
}

-(IBAction)a1WindControlSelected:(id)sender;
{
    if (![clothes4Timer isValid]) 
    {
        [windSFX play];
        [windowCreekSFX play];
        [windChimesSFX play];
        clothes4Timer = [NSTimer scheduledTimerWithTimeInterval:0.013 target:self selector:@selector(clothes4Action) userInfo:nil repeats:YES];
        clothes4Clock=-360;
        [clothes4Timer fire];

        [UIView animateWithDuration:1.5
                              delay: 0.0
                            options: UIViewAnimationOptionCurveLinear
                         animations:^
         {
             [a1ShutterLeftImageView setFrame:CGRectMake(a1ShutterLeftImageView.frame.origin.x+265, a1ShutterLeftImageView.frame.origin.y, a1ShutterLeftImageView.frame.size.width-350, a1ShutterLeftImageView.frame.size.height)];
             [a1ShutterRightImageView setFrame:CGRectMake(a1ShutterRightImageView.frame.origin.x-313, a1ShutterRightImageView.frame.origin.y, a1ShutterRightImageView.frame.size.width+350, a1ShutterRightImageView.frame.size.height)];
             
             CGAffineTransform newTransform = CGAffineTransformRotate(originalTransformMatrix,(CLOTHES_MIN_ROTATION-arc4random()%CLOTHES_RANDOM_VALUE_FOR_ROTATION)/180.00*M_PI);
             [a1Clothes3ImageView setTransform:newTransform];
             //         [a1Clothes3ImageView setCenter:CGPointMake(640, 380)];
             
             //         [a1Clothes2ImageView setTransform:newTransform];
             //         [a1Clothes2ImageView setCenter:CGPointMake(645, 380)];
             
             newTransform = CGAffineTransformRotate(originalTransformMatrix,(CLOTHES_MIN_ROTATION-arc4random()%CLOTHES_RANDOM_VALUE_FOR_ROTATION)/180.00*M_PI);
             [a1Clothes2ImageView setTransform:newTransform];
             newTransform = CGAffineTransformRotate(originalTransformMatrix,(CLOTHES_MIN_ROTATION-arc4random()%CLOTHES_RANDOM_VALUE_FOR_ROTATION)/180.00*M_PI);
             [a1Clothes1ImageView setTransform:newTransform];
             
             //         [a1Clothes2ImageView setFrame:CGRectMake(0, 45, 1024, 500)];
             //         [a1Clothes1ImageView setFrame:CGRectMake(0, 45, 1024, 500)];
             
         }
                         completion:^(BOOL finished)
         {[UIView animateWithDuration:2.0
                                delay: 0.5
                              options: UIViewAnimationOptionCurveLinear
                           animations:^
           {
               [a1ShutterLeftImageView setFrame:CGRectMake(a1ShutterLeftImageView.frame.origin.x-265, a1ShutterLeftImageView.frame.origin.y, a1ShutterLeftImageView.frame.size.width+350, a1ShutterLeftImageView.frame.size.height)];
               [a1ShutterRightImageView setFrame:CGRectMake(a1ShutterRightImageView.frame.origin.x+313, a1ShutterRightImageView.frame.origin.y, a1ShutterRightImageView.frame.size.width-350, a1ShutterRightImageView.frame.size.height)];
               
               [a1Clothes3ImageView setTransform:originalTransformMatrix];
               //           [a1Clothes3ImageView setCenter:CGPointMake(512, 374)];
               
               [a1Clothes2ImageView setTransform:originalTransformMatrix];
               [a1Clothes1ImageView setTransform:originalTransformMatrix];
               //           [a1Clothes2ImageView setFrame:CGRectMake(0, 0, 1024, 748)];
               //           [a1Clothes1ImageView setFrame:CGRectMake(0, 0, 1024, 748)];
               
           }
                           completion:nil];
         }];
        
}
    
}

- (void)clothes4Action;
{
    clothes4Clock=clothes4Clock+1;
    if (a1Clothes4ImageView.center.x>1100) 
    {
        [a1Clothes4ImageView setCenter:CGPointMake(-7, 188)];
        clothes4Clock=50;
        
    } 
    if (clothes4Clock>360) 
    {
        [clothes4Timer invalidate];    
    } 
    
    CGAffineTransform newTransform = CGAffineTransformRotate(originalTransformMatrix,(clothes4Clock/180.00*M_PI));

    if (clothes4Clock<0) 
    {
        [a1Clothes4ImageView setTransform:newTransform];
        [a1Clothes4ImageView setCenter:CGPointMake(a1Clothes4ImageView.center.x+4, a1Clothes4ImageView.center.y)];
    }   
    else
        if (clothes4Clock>0) 
        {
            [a1Clothes4ImageView setTransform:newTransform];
            [a1Clothes4ImageView setCenter:CGPointMake(a1Clothes4ImageView.center.x+2, a1Clothes4ImageView.center.y)];
        }   

}
/*
- (void) textAppear;
{
    for (UIView *view in a1StoryTextView.subviews) {
        [view removeFromSuperview];
    }
    
    UILabel *newLabel;
    NSString *string;
    
    UILabel *origLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 500, 10, 12)];
    [origLabel setText:@" abcd efgh ijkl mnopqr stuvxyz valaminek jonnie kell..."];
    
    CGAffineTransform previousTransformMatrixForText;
    previousTransformMatrixForText = [origLabel transform];
    
    CGAffineTransform newTransform = CGAffineTransformRotate(previousTransformMatrixForText,M_PI/2.00);
    
    for (int i=0; i<18; i++) 
        for (int j=0; j<14; j++) 
        {
            newLabel = [[UILabel alloc] initWithFrame:CGRectMake(i*20-20, j*20-20, 20, 20)];
            string = [NSString stringWithFormat:@"%c",[origLabel.text characterAtIndex:arc4random()%30+1]];
            [newLabel setText:string];
            [a1StoryTextView addSubview:newLabel]; 
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
*/

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
///    **** itt még lesz feladatom.... lekezelni a memóriában levő dolgokat
    
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
    UITouch *touch = [touches anyObject];
    CGPoint translatedPoint = [touch locationInView:self.view];
    
    isAlmondDragging = FALSE;
    
    firstTranslatedPoint = translatedPoint;
    if (CGRectContainsPoint(a1Almond1ImageView.frame, firstTranslatedPoint)&&(a1Almond1ImageView.alpha==1)) 
    {
        isAlmondDragging = TRUE;
        selectedAlmond = a1Almond1ImageView;
    }
    if (CGRectContainsPoint(a1Almond2ImageView.frame, firstTranslatedPoint)&&(a1Almond2ImageView.alpha==1)) 
    {
        isAlmondDragging = TRUE;
        selectedAlmond = a1Almond2ImageView;
    }
    if (CGRectContainsPoint(a1Almond3ImageView.frame, firstTranslatedPoint)&&(a1Almond3ImageView.alpha==1)) 
    {
        isAlmondDragging = TRUE;
        selectedAlmond = a1Almond3ImageView;
    }
    if (CGRectContainsPoint(a1Almond4ImageView.frame, firstTranslatedPoint)&&(a1Almond4ImageView.alpha==1)) 
    {
        isAlmondDragging = TRUE;
        selectedAlmond = a1Almond4ImageView;
    }
    if (CGRectContainsPoint(a1Almond5ImageView.frame, firstTranslatedPoint)&&(a1Almond5ImageView.alpha==1)) 
    {
        isAlmondDragging = TRUE;
        selectedAlmond = a1Almond5ImageView;
    }
    if (CGRectContainsPoint(a1Almond6ImageView.frame, firstTranslatedPoint)&&(a1Almond6ImageView.alpha==1)) 
    {
        isAlmondDragging = TRUE;
        selectedAlmond = a1Almond6ImageView;
    }
    if (CGRectContainsPoint(a1Almond7ImageView.frame, firstTranslatedPoint)&&(a1Almond7ImageView.alpha==1)) 
    {
        isAlmondDragging = TRUE;
        selectedAlmond = a1Almond7ImageView;
    }
    if (CGRectContainsPoint(a1Almond8ImageView.frame, firstTranslatedPoint)&&(a1Almond8ImageView.alpha==1)) 
    {
        isAlmondDragging = TRUE;
        selectedAlmond = a1Almond8ImageView;
    }
    if (CGRectContainsPoint(a1Almond9ImageView.frame, firstTranslatedPoint)&&(a1Almond9ImageView.alpha==1)) 
    {
        isAlmondDragging = TRUE;
        selectedAlmond = a1Almond9ImageView;
    }
    
    almondOriginalCenter = selectedAlmond.center;
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{
    UITouch *touch = [touches anyObject];
    CGPoint translatedPoint = [touch locationInView:self.view];
    
    if (isAlmondDragging) 
    {
        [selectedAlmond setCenter:translatedPoint];
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
    //    UITouch *touch = [touches anyObject];
    //    CGPoint translatedPoint = [touch locationInView:self.view];
    
    if (isAlmondDragging) 
    {
        BOOL isAlmondBackToOriginalPosition = TRUE;
        
        if ((CGRectContainsPoint(a1WhippedCream1ImageView.frame, selectedAlmond.center)&&(a1WhippedCream1ImageView.alpha==1))) 
        {
            [a1WhippedCream1ImageView setAlpha:0.99];   
            [selectedAlmond setAlpha:0.99];
            isAlmondBackToOriginalPosition = FALSE;
        }
        
        if ((CGRectContainsPoint(a1WhippedCream2ImageView.frame, selectedAlmond.center)&&(a1WhippedCream2ImageView.alpha==1))) 
        {
            [a1WhippedCream2ImageView setAlpha:0.99];   
            [selectedAlmond setAlpha:0.99];
            isAlmondBackToOriginalPosition = FALSE;
        }
        
        if ((CGRectContainsPoint(a1WhippedCream3ImageView.frame, selectedAlmond.center)&&(a1WhippedCream3ImageView.alpha==1))) 
        {
            [a1WhippedCream3ImageView setAlpha:0.99];   
            [selectedAlmond setAlpha:0.99];
            isAlmondBackToOriginalPosition = FALSE;
        }
        
        if ((CGRectContainsPoint(a1WhippedCream4ImageView.frame, selectedAlmond.center)&&(a1WhippedCream4ImageView.alpha==1))) 
        {
            [a1WhippedCream4ImageView setAlpha:0.99];   
            [selectedAlmond setAlpha:0.99];
            isAlmondBackToOriginalPosition = FALSE;
        }
        
        if ((CGRectContainsPoint(a1WhippedCream5ImageView.frame, selectedAlmond.center)&&(a1WhippedCream5ImageView.alpha==1))) 
        {
            [a1WhippedCream5ImageView setAlpha:0.99];   
            [selectedAlmond setAlpha:0.99];
            isAlmondBackToOriginalPosition = FALSE;
        }
        
        if ((CGRectContainsPoint(a1WhippedCream6ImageView.frame, selectedAlmond.center)&&(a1WhippedCream6ImageView.alpha==1))) 
        {
            [a1WhippedCream6ImageView setAlpha:0.99];   
            [selectedAlmond setAlpha:0.99];
            isAlmondBackToOriginalPosition = FALSE;
        }
        
        if ((CGRectContainsPoint(a1WhippedCream7ImageView.frame, selectedAlmond.center)&&(a1WhippedCream7ImageView.alpha==1))) 
        {
            [a1WhippedCream7ImageView setAlpha:0.99];   
            [selectedAlmond setAlpha:0.99];
            isAlmondBackToOriginalPosition = FALSE;
        }
        
        if ((CGRectContainsPoint(a1WhippedCream8ImageView.frame, selectedAlmond.center)&&(a1WhippedCream8ImageView.alpha==1))) 
        {
            [a1WhippedCream8ImageView setAlpha:0.99];   
            [selectedAlmond setAlpha:0.99];
            isAlmondBackToOriginalPosition = FALSE;
        }
        
        if ((CGRectContainsPoint(a1WhippedCream9ImageView.frame, selectedAlmond.center)&&(a1WhippedCream9ImageView.alpha==1))) 
        {
            [a1WhippedCream9ImageView setAlpha:0.99];   
            [selectedAlmond setAlpha:0.99];
            isAlmondBackToOriginalPosition = FALSE;
        }
        
        if (isAlmondBackToOriginalPosition) 
        {
            [UIView animateWithDuration:0.5
                                  delay: 0.0
                                options: UIViewAnimationOptionCurveEaseIn
                             animations:^
             {
                 [selectedAlmond setCenter:almondOriginalCenter];
             }
                             completion:nil];
        }
    }
    
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self a1RandomCatImage:a1Cat1Control];
    
    rainDrops1Array =[[NSMutableArray alloc] initWithCapacity:RAINDROP_X_MAX*RAINDROP_Y_MAX];
    rainDrops1StartArray =[[NSMutableArray alloc] initWithCapacity:RAINDROP_X_MAX*RAINDROP_Y_MAX];
    rainDrops1StopArray =[[NSMutableArray alloc] initWithCapacity:RAINDROP_X_MAX*RAINDROP_Y_MAX];
    rainDrops1StepsArray =[[NSMutableArray alloc] initWithCapacity:RAINDROP_X_MAX*RAINDROP_Y_MAX];
    
    rainDrops2Array =[[NSMutableArray alloc] initWithCapacity:RAINDROP_X_MAX*RAINDROP_Y_MAX];
    rainDrops2StartArray =[[NSMutableArray alloc] initWithCapacity:RAINDROP_X_MAX*RAINDROP_Y_MAX];
    rainDrops2StopArray =[[NSMutableArray alloc] initWithCapacity:RAINDROP_X_MAX*RAINDROP_Y_MAX];
    rainDrops2StepsArray =[[NSMutableArray alloc] initWithCapacity:RAINDROP_X_MAX*RAINDROP_Y_MAX];
    
    rainDrops3Array =[[NSMutableArray alloc] initWithCapacity:RAINDROP_X_MAX*RAINDROP_Y_MAX];
    rainDrops3StartArray =[[NSMutableArray alloc] initWithCapacity:RAINDROP_X_MAX*RAINDROP_Y_MAX];
    rainDrops3StopArray =[[NSMutableArray alloc] initWithCapacity:RAINDROP_X_MAX*RAINDROP_Y_MAX];
    rainDrops3StepsArray =[[NSMutableArray alloc] initWithCapacity:RAINDROP_X_MAX*RAINDROP_Y_MAX];
    
    rainDrops4Array =[[NSMutableArray alloc] initWithCapacity:RAINDROP_X_MAX*RAINDROP_Y_MAX];
    rainDrops4StartArray =[[NSMutableArray alloc] initWithCapacity:RAINDROP_X_MAX*RAINDROP_Y_MAX];
    rainDrops4StopArray =[[NSMutableArray alloc] initWithCapacity:RAINDROP_X_MAX*RAINDROP_Y_MAX];
    rainDrops4StepsArray =[[NSMutableArray alloc] initWithCapacity:RAINDROP_X_MAX*RAINDROP_Y_MAX];
    
    previousTransformMatrix = [a1TubeImageView transform];
    originalTransformMatrix =[a1Clothes4ImageView transform];
    
//    [self textAppear];
    
    sfxVolume = DEFAULT_SFX_VOLUME;

    //set the SFX for cat
	NSString *catSFXPath = [[NSBundle mainBundle] pathForResource:@"meow" ofType:@"mp3"];
	catSFX = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:catSFXPath] error:NULL];
	catSFX.delegate = self;	
	[catSFX setVolume:sfxVolume];
	[catSFX setNumberOfLoops:0]; // when the value is negativ, the sound will be played until you call STOP method 
   
    //set the SFX for lights
	NSString *lightSFXPath = [[NSBundle mainBundle] pathForResource:@"light_switch" ofType:@"mp3"];
	lightSwitchSFX = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:lightSFXPath] error:NULL];
	lightSwitchSFX.delegate = self;	
	[lightSwitchSFX setVolume:sfxVolume];
	[lightSwitchSFX setNumberOfLoops:0]; // when the value is negativ, the sound will be played until you call STOP method 
    
    //set the SFX for tube firing cream
	NSString *tubeFiresCreamSFXPath = [[NSBundle mainBundle] pathForResource:@"tubus_hab" ofType:@"mp3"];
	tubeFiresCreamSFX = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:tubeFiresCreamSFXPath] error:NULL];
	tubeFiresCreamSFX.delegate = self;	
	[tubeFiresCreamSFX setVolume:sfxVolume];
	[tubeFiresCreamSFX setNumberOfLoops:0]; // when the value is negativ, the sound will be played until you call STOP method 
    
    //set the SFX for wind
	NSString *windSFXPath = [[NSBundle mainBundle] pathForResource:@"wind_" ofType:@"mp3"];
	windSFX = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:windSFXPath] error:NULL];
	windSFX.delegate = self;	
	[windSFX setVolume:sfxVolume];
	[windSFX setNumberOfLoops:0]; // when the value is negativ, the sound will be played until you call STOP method 
    
    //set the SFX for wind chimes
	NSString *windChimesSFXPath = [[NSBundle mainBundle] pathForResource:@"wind_chimes_" ofType:@"mp3"];
	windChimesSFX = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:windChimesSFXPath] error:NULL];
	windChimesSFX.delegate = self;	
	[windChimesSFX setVolume:sfxVolume];
	[windChimesSFX setNumberOfLoops:0]; // when the value is negativ, the sound will be played until you call STOP method 
    
    //set the SFX for window creek
	NSString *windowCreekSFXPath = [[NSBundle mainBundle] pathForResource:@"window_creek" ofType:@"mp3"];
	windowCreekSFX = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:windowCreekSFXPath] error:NULL];
	windowCreekSFX.delegate = self;	
	[windowCreekSFX setVolume:sfxVolume];
	[windowCreekSFX setNumberOfLoops:0]; // when the value is negativ, the sound will be played until you call STOP method 
    
    //set the SFX for raining
	NSString *itIsRainingSFXPath = [[NSBundle mainBundle] pathForResource:@"rain" ofType:@"mp3"];
	itIsRainingSFX = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:itIsRainingSFXPath] error:NULL];
	itIsRainingSFX.delegate = self;	
	[itIsRainingSFX setVolume:0.0];
	[itIsRainingSFX setNumberOfLoops:0]; // when the value is negativ, the sound will be played until you call STOP method 
    

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
