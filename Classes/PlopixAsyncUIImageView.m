//
//  PlopixAsyncUIImageView.m
//  PlopixUtils
//
//  Created by Plopix on 18/01/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PlopixAsyncUIImageView.h"
#import <QuartzCore/QuartzCore.h>
#import "PlopixFileManager.h"
#import "PlopixUtils.h"

@implementation PlopixAsyncUIImageView

@synthesize delegate,p_request;

- (void)loadImageFromURL:(NSString*)_urlString withDefaultImageNamed:(NSString *) named {
	if(p_request != nil) {
		[p_request cancel];
	}
	self.image = [UIImage imageNamed:named];
	if ((_urlString != nil ) && ([_urlString length] > 0)) {
		UIImage *i = [PlopixFileManager getCachedImage:[PlopixUtils md5:_urlString] In:APP_DOCUMENTS];
		if (i!=nil) {
			PlopixFLog(@"on prend l'image  locale : %@ [%@]",_urlString,[PlopixUtils md5:_urlString]);
			[self setMyImage:i];
		}else {
			PlopixFLog(@"on load l'image distante : %@ [%@]",_urlString,[PlopixUtils md5:_urlString]);
			
			self.p_request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString: _urlString]];
#if HTTP_REQUEST_NEED_AUTH
			[p_request setUsername:HTA_USER];
			[p_request setPassword:HTA_PASS];
#endif
			[p_request setDelegate:self];
			[p_request startAsynchronous];
		}
	}
}

		 
- (void) setMyImage:(UIImage *)img {
	CATransition *animation = [CATransition animation];
	[animation setType:kCATransitionFade];
	[[self layer] addAnimation:animation forKey:@"PlopixAsyncUIImageView"];	
	self.image = img;
    [self setNeedsLayout];
}

- (void)requestFinished:(ASIHTTPRequest *)request {
	NSString *_urlString = [request.originalURL absoluteString];
	NSMutableData *data = (NSMutableData*)[request responseData];
	[self setMyImage:[UIImage imageWithData:data]];
	[PlopixFileManager cacheImage:[PlopixUtils md5:_urlString] withData:data In:APP_DOCUMENTS];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	PlopixFLog(@"requestFailed[%@]: %@",[request.originalURL absoluteString],[[request error] description]);
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	if([touch view] == self){
		[self.delegate imageViewClicked:self];
	}
}

- (void)dealloc {
	if(p_request != nil) {
		[p_request cancel];
	}
    [super dealloc];
}
@end
