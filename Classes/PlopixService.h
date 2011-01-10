//
//  PlopixService.h
//  PlopixPendingActionsManager
//
//  Created by Plopix on 11/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "PendingAction.h"
#define PAIDOBJ	@"PendingActionIDObject"

@class PlopixService;

@protocol PlopixServiceDelegate <NSObject>
@required
-(void) serviceFinished:(PlopixService *) service;
-(void) serviceFailed:(PlopixService *) service;
@end


@interface PlopixService : NSObject {
	id delegate;
@protected
	ASIFormDataRequest *p_request;
	id object;
	PendingAction *action;
	
	NSMutableDictionary *results;
}

@property (nonatomic,retain) id delegate;
@property (nonatomic,retain) id object;
@property (nonatomic,retain) ASIFormDataRequest* p_request;
@property (nonatomic,retain) PendingAction *action;
@property (nonatomic,retain) NSMutableDictionary *results;

- (id) initWithPendingAction:(PendingAction *) _action;
- (id) initWithAction:(NSString*) _action forObject:(id) _object withParams:(NSMutableDictionary*) _params;

- (BOOL) start;
- (BOOL) stop;
- (BOOL) wrapAndAuthenticateRequestAndSetDelegate:(BOOL) delegateSelf;
- (BOOL) checkRequestValidity:(ASIHTTPRequest*) r andHeaderToken:(BOOL) ht;

@end
