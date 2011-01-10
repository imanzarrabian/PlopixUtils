//
//  UnderLineLabel.h
//  Plopix
//
//  Created by Plopix on 14/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PlopixUnderLineLabel : UILabel {
	 BOOL underline;
}

@property (nonatomic,getter=isUnderlined) BOOL underline;
@end
