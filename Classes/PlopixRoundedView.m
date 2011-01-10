//
//  PlopixRoundedView.h
//  Plopix
//
//  Created by Plopix on 14/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PlopixRoundedView.h"


@implementation PlopixRoundedView

@synthesize strokeWidth,cornerRadius,cornerColor,strokeColor;


- (void)drawRect:(CGRect)rect {
	CGContextRef context;
	self.opaque = NO;	
    context = UIGraphicsGetCurrentContext();
	CGContextClearRect(context, rect);
	CGContextSetLineWidth(context, strokeWidth);
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
    CGContextSetFillColorWithColor(context, cornerColor.CGColor);
	
	CGRect rrect = self.bounds;
    CGRect bgrect = CGRectMake(0, 0, rrect.size.width, rrect.size.height);
	CGContextFillRect(context, bgrect);
	
	CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    CGFloat radius = cornerRadius;
    CGFloat width = CGRectGetWidth(rrect);
    CGFloat height = CGRectGetHeight(rrect);
	
    if (radius > width/2.0)
        radius = width/2.0;
    if (radius > height/2.0)
        radius = height/2.0;    
    
    CGFloat minx = CGRectGetMinX(rrect);
    CGFloat midx = CGRectGetMidX(rrect);
    CGFloat maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect);
    CGFloat midy = CGRectGetMidY(rrect);
    CGFloat maxy = CGRectGetMaxY(rrect);
    CGContextMoveToPoint(context, minx, midy);
    CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
}

- (void) updateRect:(CGRect)rect {
	[self clearsContextBeforeDrawing];
	self.frame = rect;
	[self setNeedsDisplay];
}

- (void)dealloc {
    [super dealloc];
}


@end
