//
//  PlopixPendingActionsManager.h
//  PlopixPendingActionsManager
//
//  Created by Plopix on 11/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlopixService.h"

@interface PlopixPendingActionsManager : NSObject {
	NSMutableArray* serviceRunDelegates;
}

+(PlopixPendingActionsManager *) sharedInstance;
@property (nonatomic,retain) NSMutableArray* serviceRunDelegates;

-(void) interruptAllServices;

-(BOOL) addPendingAction:(NSString *) action withParams:(NSMutableDictionary*) params andCommit:(BOOL) commit;
-(BOOL) addPendingAction:(NSString *) action forObject:(id) object withParams:(NSMutableDictionary*) params andCommit:(BOOL) commit;
-(BOOL) commit;


@end
