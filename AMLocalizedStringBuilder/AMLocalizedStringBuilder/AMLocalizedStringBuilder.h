//
//  AMLocalizedStringBuilder.h
//  AMLocalizedStringBuilder
//
//  Created by Mellong on 16/3/28.
//  Copyright © 2016年 tendencystudio. All rights reserved.
//

#import <AppKit/AppKit.h>

@class AMLocalizedStringBuilder;

static AMLocalizedStringBuilder *sharedPlugin;

@interface AMLocalizedStringBuilder : NSObject

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end