//
//  PlopixLoadingView.h
//  Plopix
//
//  Created by Plopix on 16/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PlopixLoadingView : UIView {
	UILabel *loadingLabel;
}

@property (nonatomic, retain) UILabel *loadingLabel;


+ (id)loadingViewInView:(UIView *)aSuperview;
- (void)removeView;
- (void)removeViewWithDelay:(NSTimeInterval)delay;



@end
