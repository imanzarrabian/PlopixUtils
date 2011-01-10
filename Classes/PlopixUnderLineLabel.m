//
//  UnderLineLabel.m
//  Plopix
//
//  Created by Plopix on 14/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PlopixUnderLineLabel.h"


@implementation PlopixUnderLineLabel

@synthesize underline; 


- (void)drawTextInRect:(CGRect)rect { 
    [super drawTextInRect:rect]; 
	
    //if ([self isUnderlined]) { 
        // Get the size of the label 
        CGSize dynamicSize = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(99999, 99999)
									   lineBreakMode:self.lineBreakMode]; 
		
        // Get the current graphics context 
        CGContextRef context = UIGraphicsGetCurrentContext(); 
		
        // Make it a while line 1.0 pixels wide 
        CGContextSetStrokeColorWithColor(context, [self.textColor CGColor]); 
        CGContextSetLineWidth(context, 1.5); 
		
        // find the origin point 
        CGPoint origin = CGPointMake(0, 0); 
		
        // horizontal alignment depends on the alignment of the text 
        if (self.textAlignment == UITextAlignmentCenter) 
            origin.x = (self.frame.size.width / 2) - (dynamicSize.width / 2); 
        else if (self.textAlignment == UITextAlignmentRight) 
            origin.x = self.frame.size.width - dynamicSize.width; 
		
        // vertical alignment is always middle/centre plus half the height of the text 
        origin.y = (self.frame.size.height / 2) + (dynamicSize.height / 2); 
		
        // Draw the line 
        CGContextMoveToPoint(context, origin.x, origin.y); 
        CGContextAddLineToPoint(context, origin.x + dynamicSize.width, origin.y); 
        CGContextStrokePath(context); 
   // } 
} 

- (void)dealloc { 
    [super dealloc]; 
} 


@end
