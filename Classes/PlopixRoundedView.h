//
//  PlopixRoundedView.h
//  Plopix
//
//  Created by Plopix on 14/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlopixRoundedView : UIView {
    CGFloat     strokeWidth;
    CGFloat     cornerRadius;
	UIColor		*cornerColor;
	UIColor		*strokeColor;
}

@property (nonatomic, assign) CGFloat strokeWidth;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, retain) UIColor *cornerColor;
@property (nonatomic, retain) UIColor *strokeColor;



@end
