//
//  PlopixInterfaceUtils.h
//  Plopix
//
//  Created by Plopix on 15/01/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PlopixInterfaceUtils : NSObject {

}

+ (CGFloat) manageTextFieldDidBeginEditing:(UIView *)view withField:(UIView *) field commitAnimation:(BOOL) commit;
+ (void) manageTextFieldDidEndEditing:(UIView *)view withField:(UIView *) field withAnimDistance:(CGFloat)animatedDistance commitAnimation:(BOOL) commit;


@end
