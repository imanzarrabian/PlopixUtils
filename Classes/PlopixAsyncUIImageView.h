//
//  PlopixAsyncUIImageView.h
//  PlopixUtils
//
//  Created by Plopix on 18/01/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"


@protocol PlopixAsyncUIImageViewDelegate <NSObject>
@required
-(void) imageViewClicked:(UIImageView*) imageView;
@end

@interface PlopixAsyncUIImageView : UIImageView {
	id delegate;
	ASIHTTPRequest *p_request;
}

- (void)loadImageFromURL:(NSString*)_urlString withDefaultImageNamed:(NSString *) named;
- (void) setMyImage:(UIImage *)img;

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) ASIHTTPRequest *p_request;

@end
