//
//  PlopixRefreshTableHeaderView.m
//  Plopix
//
//  Created by Plopix on 29/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PlopixRefreshTableHeaderView.h"
#define FLIP_ANIMATION_DURATION 0.18f

@implementation PlopixRefreshTableHeaderView


@synthesize state, lastUpdatedLabel,statusLabel,activityView;
CALayer *_arrowImage;

-(void) initialize {
	self.frame= CGRectMake(0.0f, 0.0f - self.frame.size.height, 320.0f, self.frame.size.height);
	[self setState:PlopixPullRefreshNormal];
	CALayer *layer = [[CALayer alloc] init];
	layer.frame = CGRectMake(activityView.frame.origin.x-10.0f, activityView.frame.origin.y-15.0f, 30.0f, 55.0f);
	layer.contentsGravity = kCAGravityResizeAspect;
	layer.contents = (id)[UIImage imageNamed:@"blackArrow.png"].CGImage;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
	if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
		layer.contentsScale = [[UIScreen mainScreen] scale];
	}
#endif
	[[self layer] addSublayer:layer];
	_arrowImage=layer;
	[layer release];	
}

- (void)setCurrentDate {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setAMSymbol:@"AM"];
	[formatter setPMSymbol:@"PM"];
	//[formatter setDateFormat:@"MM/dd/yyyy hh:mm:a"];
	[formatter setDateFormat:@"hh:mm:ss"];
	lastUpdatedLabel.text = [NSString stringWithFormat:@"Mis-à-jour à : %@", [formatter stringFromDate:[NSDate date]]];
	[formatter release];
}

- (void)setState:(PlopixPullRefreshState)aState{
	
	switch (aState) {
		case PlopixPullRefreshPulling:
			statusLabel.text = @"Relâcher pour actualiser...";
			activityView.hidden	= YES;
			 [CATransaction begin];
			[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
			_arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
			[CATransaction commit];
		break;
		case PlopixPullRefreshNormal:
			if (state == PlopixPullRefreshPulling) {
				[CATransaction begin];
				[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
				_arrowImage.transform = CATransform3DIdentity;
				[CATransaction commit];
			}
			activityView.hidden	= YES;
			statusLabel.text = @"Tirer pour actualiser...";
			[activityView stopAnimating];
			 [CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
			_arrowImage.hidden = NO;
			_arrowImage.transform = CATransform3DIdentity;
			[CATransaction commit];
			break;
		case PlopixPullRefreshLoading:
			activityView.hidden	= NO;
			statusLabel.text = @"Chargement...";
			[activityView startAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
			_arrowImage.hidden = YES;
			[CATransaction commit];
			break;
		default:
			break;
	}
	state = aState;
}

- (void)dealloc {
	activityView = nil;
	statusLabel = nil;
	arrowImage = nil;
	lastUpdatedLabel = nil;
	[super dealloc];
}


@end
