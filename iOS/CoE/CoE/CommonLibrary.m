//
//  CommonLibrary.m
//  KickOff
//
//  Created by Ferenc INKOVICS on 21/02/2013.
//  Copyright (c) 2013 No company - private person. All rights reserved.
//

#import "CommonLibrary.h"

@interface CommonLibrary()

@end

@implementation Screen06_07CreaturesImageView

@synthesize xChange, xChangeType, yChange, normalCenter, direction, rotation;

-(id)initWithFrame:(CGRect)frame;
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

-(void)setCalculatedCenterBasedOnDirection;
{
    CGPoint newCenter=normalCenter;
    switch (direction)
    {
        case 1:
            newCenter.x=normalCenter.y/748*1024;
            newCenter.y=normalCenter.x/1024*748;
            break;
            
        case 2:
            newCenter.y=748-normalCenter.y;
            break;
            
        case 3:
            newCenter.x=1024-(normalCenter.y/748*1024);
            newCenter.y=normalCenter.x/1024*748;
            break;
            
        default:
            break;
    }
    [self setCenter:newCenter];
}

-(void)setCalculatedRotationBasedOnDirection;
{
    CGFloat newDegree = atanf(xChange/yChange);
    switch (direction)
    {
        case 1:
            newDegree=-M_PI_2-newDegree;
            break;
            
        case 2:
            newDegree=M_PI-newDegree;
            break;
            
        case 3:
            newDegree=newDegree+M_PI_2;
            break;
            
        default:
            break;
    }
    
    CGAffineTransform newTransform=CGAffineTransformMakeRotation(newDegree);
    [self setTransform:newTransform];
}

@end

@implementation WavingImageView

@synthesize actualCirclingRotation, actualCirclingRotationChange, actualTiltingRotation, actualTiltingRotationChange, originalCenter, rotationCenter;

-(void)setRotationCenter: (CGPoint) newRotationCenter;
{
    rotationCenter=newRotationCenter;
}

-(void)setOriginalCenter: (CGPoint) newOriginalCenter;
{
    originalCenter=newOriginalCenter;
}

@end

@implementation SmallFishSwarmArcImageView

@synthesize actualRotation,isMirrored;

@end

@implementation SmallFishSwarmStraightImageView

@synthesize startCenter, finishCenter, isMirrored;

@end

@implementation CommonLibrary

-(CGPoint)rotatePoint:(CGPoint)pointToRotate around:(CGPoint)center withDegree:(CGFloat)degree;
{
	pointToRotate = CGPointMake(pointToRotate.x-center.x,pointToRotate.y-center.y);
	CGPoint rotatedPoint = CGPointMake(pointToRotate.x*cos(degree)-pointToRotate.y*sin(degree),pointToRotate.x*sin(degree)+pointToRotate.y*cos(degree));
	rotatedPoint.x=center.x+rotatedPoint.x;
	rotatedPoint.y=center.y+rotatedPoint.y;
	return rotatedPoint;
}


@end

