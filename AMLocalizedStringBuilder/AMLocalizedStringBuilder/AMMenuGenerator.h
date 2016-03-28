//
//  AMMenuGenerator.h
//  AMLocalizedStringBuilder
//
//  Created by Mellong 15/4/1.
//  Copyright (c) 2015年 Tendencystudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "AMConstString.h"

@interface AMMenuGenerator : NSObject

+ (void)generateMenuItems:(NSBundle *)bundle version:(NSString *)version target:(id)target;
+ (NSUInteger)getKeyEquivalentModifierMaskWithKey:(NSString *)key;

@end
