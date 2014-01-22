//
//  CommonLibrary.h
//  KickOff
//
//  Created by Ferenc INKOVICS on 21/02/2013.
//  Copyright (c) 2013 No company - private person. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Screen06_07CreaturesImageView: UIImageView

@property CGFloat xChange, yChange, rotation;
@property int xChangeType, direction; //value can be: 0,1,2,3
@property CGPoint normalCenter;

-(id)initWithFrame:(CGRect)frame;
-(void)setCalculatedCenterBasedOnDirection;
-(void)setCalculatedRotationBasedOnDirection;

@end

@interface WavingImageView : UIImageView
{
    CGFloat actualCirclingRotation, actualCirclingRotationChange, actualTiltingRotation, actualTiltingRotationChange;
    CGPoint rotationCenter, originalCenter;
}

@property (nonatomic) CGFloat actualCirclingRotation, actualCirclingRotationChange, actualTiltingRotation, actualTiltingRotationChange;
@property (nonatomic) CGPoint rotationCenter, originalCenter;

-(void)setRotationCenter: (CGPoint ) newRotationCenter;
-(void)setOriginalCenter: (CGPoint ) newOriginalCenter;

@end

@interface SmallFishSwarmArcImageView : UIImageView
{
    CGFloat actualRotation;
    BOOL isMirrored;
}

@property (nonatomic) CGFloat actualRotation;
@property (nonatomic) BOOL isMirrored;

@end

@interface SmallFishSwarmStraightImageView : UIImageView
{
    CGPoint startCenter, finishCenter;
    BOOL isMirrored;
}

@property (nonatomic) CGPoint startCenter, finishCenter;
@property (nonatomic) BOOL isMirrored;

@end

@interface CommonLibrary : NSObject

-(CGPoint)rotatePoint:(CGPoint)pointToRotate around:(CGPoint)center withDegree:(CGFloat)degree;

@end

