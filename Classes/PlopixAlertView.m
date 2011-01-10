//
//  PlopixAlertView.m
//  Plopix
//
//  Created by Plopix on 14/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PlopixAlertView.h"


@implementation PlopixAlertView

-(NSString *) imageNamed {
	return @"xxxx";
}

- (void)drawRect:(CGRect)rect {
	UIImage *backgroundImage = [UIImage imageNamed:[self imageNamed]];
	[backgroundImage drawInRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
}

- (void)layoutSubviews {
	for (int i = 0;i<[self.subviews count];i++) {
		UIView *v =   [[self subviews] objectAtIndex:i];
		if([[[v class]description]isEqualToString:@"UIImageView"]){
			[v removeFromSuperview];
		}
	}
}

- (void)dealloc {
    [super dealloc];
}


@end
