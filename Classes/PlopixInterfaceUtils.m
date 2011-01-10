//
//  interfaceUtils.m
//  Plopix
//
//  Created by Plopix on 15/01/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PlopixInterfaceUtils.h"

#define KEYBOARD_ANIMATION_DURATION		0.3
#define MINIMUM_SCROLL_FRACTION			0.2
#define MAXIMUM_SCROLL_FRACTION			0.8
#define PORTRAIT_KEYBOARD_HEIGHT		216
#define LANDSCAPE_KEYBOARD_HEIGHT		162

@implementation PlopixInterfaceUtils

/*
 Thanks to Matt Gallagher for its great work : manageTextFieldDidBeginEditing, manageTextFieldDidEndEditing
 http://cocoawithlove.com/2008/10/sliding-uitextfields-around-to-avoid.html
 */

+ (CGFloat) manageTextFieldDidBeginEditing:(UIView *)view withField:(UIView *) field commitAnimation:(BOOL) commit {
	CGFloat animatedDistance;
	CGRect textFieldRect	=	[view.window convertRect:field.bounds fromView:field];
	CGRect viewRect			=	[view.window convertRect:view.bounds fromView:view];
	CGFloat midline			=	textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
	CGFloat numerator		=	midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
	CGFloat denominator		=	(MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
	CGFloat heightFraction = numerator / denominator;
	if (heightFraction < 0.0)		heightFraction = 0.0;
	else if (heightFraction > 1.0)	heightFraction = 1.0;
	
	UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
	if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
		animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction) - 44;
	else
		animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
	CGRect viewFrame = view.frame;
	viewFrame.origin.y -= animatedDistance;

	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
	[view setFrame:viewFrame];
	if (commit) [UIView commitAnimations];
	
	return animatedDistance;
}

+ (void) manageTextFieldDidEndEditing:(UIView *)view withField:(UIView *) field withAnimDistance:(CGFloat)animatedDistance commitAnimation:(BOOL) commit {
	CGRect viewFrame = view.frame;
    viewFrame.origin.y += animatedDistance;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [view setFrame:viewFrame];
    if (commit) [UIView commitAnimations];
}


@end
