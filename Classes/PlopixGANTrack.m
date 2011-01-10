//
//  PlopixGANTrack.m
//  PlopixGANTrack
//
//  Created by Plopix on 05/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PlopixGANTrack.h"
#import "PlopixUtils.h"

@implementation PlopixGANTrack

+ (void) trackPage:(NSString *)_page {
	NSString *page = [NSString stringWithFormat:@"/%@",_page];
#if !TARGET_IPHONE_SIMULATOR
	[[GANTracker sharedTracker] trackPageview:page withError:nil];
#endif
	PlopixALog(@"Page: %@",page);
}

+ (void) trackEventWithCategory:(NSString *) _category Action:(NSString*) _action {
#if !TARGET_IPHONE_SIMULATOR
	[[GANTracker sharedTracker] trackEvent:_category
									action:_action
									 label:UDID
									 value:-1
								 withError:nil];
#endif
	PlopixALog(@"\nCateg:%@\nAction:%@",_category,_action);

}
@end
