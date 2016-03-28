//
//  NSObject_Extension.m
//  AMLocalizedStringBuilder
//
//  Created by Mellong on 16/2/16.
//  Copyright © 2016年 tendencystudio. All rights reserved.
//


#import "NSObject_Extension.h"
#import "AMLocalizedStringBuilder.h"

@implementation NSObject (Xcode_Plugin_Template_Extension)

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[AMLocalizedStringBuilder alloc] initWithBundle:plugin];
        });
    }
}
@end
