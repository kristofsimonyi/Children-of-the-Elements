//
//  ScrollingPagesViewController.h
//  KickOff
//
//  Created by Ferenc INKOVICS on 01/05/2013.
//  Copyright (c) 2013 No company - private person. All rights reserved.
//

#import "ViewController.h"

@interface ScrollingPagesViewController : ViewController
{
    NSArray *imageNames;
    CGPoint firstTranslatedPoint;
    CGFloat actualPositionOfScroll, firstPositionOfScroll;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scroll;

-(IBAction)scrollingPaesBackToMainMenu:(id)sender;

@end
