//
//  PlopixService.m
//  PlopixPendingActionsManager
//
//  Created by Plopix on 11/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PlopixService.h"


@implementation PlopixService

@synthesize object,delegate,p_request,action,results;


- (BOOL) wrapAndAuthenticateRequestAndSetDelegate:(BOOL) delegateSelf {
	/* Globals Values on each Request */
	[p_request setTimeOutSeconds:CONNECTION_TIMEOUT];
	[p_request setShouldContinueWhenAppEntersBackground:YES];
	[p_request addRequestHeader:@"User-Agent" value:USERAPPS_AGENT];
	[p_request setShouldUseRFC2616RedirectBehaviour:YES];
	if (delegateSelf == YES) [p_request setDelegate:self];
	/* ** */
#if HTTPS == 1
	[p_request setValidatesSecureCertificate:NO]; 
#endif
#if HTTP_REQUEST_NEED_AUTH
	[request setUsername:HTA_USER];
	[request setPassword:HTA_PASS];
#endif
	//PlopixWSLog(@"URL: %@",[p_request url]);
	return YES;
}

-(BOOL) start {
	@throw [NSException exceptionWithName:@"NONE OVERRIDE METHOD" reason:@"You must recode -(BOOL) start" userInfo:nil];
}

-(BOOL) stop {
	[p_request cancel];
	PlopixWSLog(@"RequestCancel %@",[p_request description]);
	[self.delegate serviceFailed:self];
	return YES;
}


// @TODO : not tested
- (id) initWithPendingAction:(PendingAction *) _action {
	self = [super init];
	self.object = nil;
	self.action = _action;
	if (action.params != nil) { 
		// can be useless BUT we can have a service without pending action,
		// so we decide to fill everytime le params attribute for coherrence
		NSInteger PendingActionIDOBJect = [[action.params objectForKey:PAIDOBJ] integerValue];
		if (PendingActionIDOBJect>0) {
			// find className
			NSString *serviceClassName = NSStringFromClass([self class]);
			Class metierClass = NSClassFromString([serviceClassName stringByReplacingOccurrencesOfString:@"Service" withString:@""]);
			self.object = [[metierClass alloc] initWithKey:(id)PendingActionIDOBJect];
			[self.action.params removeObjectForKey:PAIDOBJ];
		}
	}
	return self;
}

// _object can be nil, it's ok
- (id) initWithAction:(NSString*) _action forObject:(id) _object withParams:(NSMutableDictionary*) _params {
	self = [super init];
	self.object = _object;
	self.action = [[PendingAction alloc] init];
	action.action = _action;
	action.params = _params;
	return self;
}

- (void) requestFinished:(ASIHTTPRequest*) _p_request {
	if ([self checkRequestValidity:_p_request andHeaderToken:NO]) {
		PlopixWSLog(@"RequestFinished %@",[p_request description]);
		[self.delegate serviceFinished:self];
	}
}

- (void) requestFailed:(ASIHTTPRequest*) _p_request {
	if ([self checkRequestValidity:_p_request andHeaderToken:NO]) {
		PlopixWSLog(@"Transfert failed! %@", [p_request error]);      
		[self.delegate serviceFailed:self];
	}
}

-(NSString *) headerSecureKey {
	return @"PlopixHeaderKey";
}

-(NSString *) headerSecureValue {
	return @"PlopixAuthResponse";
}

- (BOOL) checkRequestValidity:(ASIFormDataRequest*) r andHeaderToken:(BOOL) ht {
	NSString *secuHeader = [[p_request responseHeaders] objectForKey:[self headerSecureKey]];
	if (r == p_request)  {
		if (ht) {
			if ([secuHeader isEqualToString:[self headerSecureValue]])
				return YES;
			else
				return NO;
		}else 
			return YES;
	}
	return NO;
}

- (void) dealloc {
	[super dealloc];
	object = nil; 
	p_request = nil;
	action = nil;
}



@end
