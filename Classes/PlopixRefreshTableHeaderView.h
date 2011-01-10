//
//  PlopixRefreshTableHeaderView.h
//  Plopix
//
//  Created by Plopix on 29/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum{
	PlopixPullRefreshPulling = 0,
	PlopixPullRefreshNormal,
	PlopixPullRefreshLoading,	
} PlopixPullRefreshState;


@interface PlopixRefreshTableHeaderView : UIView {
	IBOutlet UILabel *lastUpdatedLabel;
	IBOutlet UILabel *statusLabel;
	CALayer *arrowImage;
	IBOutlet UIActivityIndicatorView *activityView;
	PlopixPullRefreshState state;
}

@property (nonatomic,assign) PlopixPullRefreshState state;
@property (nonatomic,retain) IBOutlet UILabel *lastUpdatedLabel;
@property (nonatomic,retain) IBOutlet UILabel *statusLabel;
@property (nonatomic,retain) IBOutlet UIActivityIndicatorView *activityView;

- (void)setCurrentDate;
- (void)initialize;
- (void)setState:(PlopixPullRefreshState)aState;
@end
