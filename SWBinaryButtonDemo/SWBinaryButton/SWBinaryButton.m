//
//  SWBinaryButton.m
//  ParallaxTableview
//
//  Created by WANG ShengJia on 2/12/13.
//  Copyright (c) 2013 WANG ShengJia. All rights reserved.
//

#import "SWBinaryButton.h"
#import <QuartzCore/QuartzCore.h>

#define MAX_RADIUS 70.0f
#define MIN_RADIUS 30.0f

@implementation SWBinaryButton

- (id)initWithFirstButton:(UIButton *)button1 secondButton:(UIButton *)button2 frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
	    if(!button1 || !button2) {
		    NSAssert(NO, @"Button Nil Error");
	    }

	    button1.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
	    button2.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);

	    UIPanGestureRecognizer *panGestureRecognizer1 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveButton:)];
	    UIPanGestureRecognizer *panGestureRecognizer2 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveButton:)];

	    [button1 addGestureRecognizer:panGestureRecognizer1];
	    [button2 addGestureRecognizer:panGestureRecognizer2];

	    [self addSubview:button2];
	    [self addSubview:button1];
	    self.backgroundColor = [UIColor clearColor];

    }
    return self;
}


- (void)moveButton:(UIPanGestureRecognizer *)gesture{
	CGPoint oldPos = [gesture.view convertPoint:CGPointMake(gesture.view.frame.size.width*0.5, gesture.view.frame.size.height*0.5) toView:self.superview];
	CGPoint translation = [gesture translationInView:self.superview];
	CGPoint location = [gesture locationInView:self.superview];
	CGPoint newPos = [gesture.view convertPoint:CGPointMake(gesture.view.center.x + translation.x, gesture.view.center.y + translation.y) toView:self.superview];

	CGPoint oldPos2 = [gesture.view convertPoint:oldPos fromView:self.superview];
	CGPoint newPos2 = [gesture.view convertPoint:newPos fromView:self.superview];

	double distance = sqrt(pow((newPos.x - oldPos.x), 2.0) + pow((newPos.y - oldPos.y), 2.0));

	if(gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {

		double distance2 = sqrt(pow((location.x - oldPos.x), 2.0) + pow((location.y - oldPos.y), 2.0));

		if(distance <= MAX_RADIUS && distance2 <= MAX_RADIUS) {
			[gesture.view setCenter:newPos2];
		}else{
			gesture.view.center = CGPointMake((CGFloat) (oldPos2.x + (newPos.x- oldPos.x)* MAX_RADIUS/distance), (CGFloat) (oldPos2.y + (newPos.y- oldPos.y)* MAX_RADIUS/distance));
		}

		if(distance > MIN_RADIUS && gesture.view.superview.subviews[0]!=gesture.view) {
			UIView *view = gesture.view.superview.subviews[0];
			[gesture.view.superview sendSubviewToBack:gesture.view];
			[UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
				view.frame = CGRectMake(view.frame.origin.x-5, view.frame.origin.y-5, view.frame.size.width+10, view.frame.size.height+10);
			} completion:^(BOOL finished) {
				[UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
					view.frame = CGRectMake(view.frame.origin.x+5, view.frame.origin.y+5, view.frame.size.width-10, view.frame.size.height-10);
				} completion:^(BOOL finished1) {
					// the small jump animation finished
				}];
			}];
		}
		[gesture setTranslation:CGPointZero inView:self.superview];

	}else{
		[UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
			[gesture.view setCenter:oldPos2];
		} completion:^(BOOL finished) {
            // button replace to the original position
		}];
	}

}

@end
