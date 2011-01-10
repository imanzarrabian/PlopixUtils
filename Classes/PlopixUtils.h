//
//  PlopixUtils.h
//  PlopixUtils
//
//  Created by Plopix on 05/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PlopixUtils : NSObject {

}

+ (NSString *) md5:(NSString*) string;
+ (NSString *) md5Minuscule:(NSString*) string;

+ (UIImage *) roundCorners: (UIImage*) img;

+ (UIImage*)   resizedImage:(UIImage *) inImage withRect:(CGRect) thumbRect;
+ (UIImage*)   imageByCropping:(UIImage *)imageToCrop toRect:(CGRect)rect;
+ (NSString *) flattenHTML:(NSString *)html;
+ (UIImage*)   imageWithImage:(UIImage*)sourceImage scaledToSizeWithSameAspectRatio:(CGSize)newSize;
+ (NSString *)getMobileUserAgent;


@end
