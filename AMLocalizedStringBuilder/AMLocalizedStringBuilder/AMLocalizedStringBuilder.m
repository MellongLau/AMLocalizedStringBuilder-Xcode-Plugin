//
//  AMLocalizedStringBuilder.m
//  AMLocalizedStringBuilder
//
//  Created by Mellong on 16/3/28.
//  Copyright © 2016年 tendencystudio. All rights reserved.
//

#import "AMLocalizedStringBuilder.h"
#import "XcodeHelper.h"

@interface AMLocalizedStringBuilder()

@property (nonatomic, strong, readwrite) NSBundle *bundle;

@end

@implementation AMLocalizedStringBuilder

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didApplicationFinishLaunchingNotification:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
    }
    return self;
}

- (void)didApplicationFinishLaunchingNotification:(NSNotification*)noti
{
    NSMenuItem* menuItem = [[NSApp mainMenu] itemWithTitle:@"Product"];
    if (!menuItem) {
        return;
    }
    
    [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
    NSString *title = [NSString stringWithFormat:@"AMLocalizedStringBuilder (v%@)", [self getBundleVersion]];
    NSMenuItem* actionTitleMenuItem = [[NSMenuItem alloc] initWithTitle:title
                                                                 action:@selector(buildLocalizedString)
                                                          keyEquivalent:@"f"];
    
    
    [[menuItem submenu] addItem:actionTitleMenuItem];
    
    NSMenuItem* actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"Build Localized String"
                                                            action:@selector(buildLocalizedString)
                                                     keyEquivalent:@"f"];
    
    [actionMenuItem setKeyEquivalentModifierMask:NSControlKeyMask];
    
    [actionMenuItem setTarget:self];
    [[menuItem submenu] addItem:actionMenuItem];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSApplicationDidFinishLaunchingNotification
                                                  object:nil];
}

- (NSString *)getBundleVersion
{
    NSString *bundleVersion = [[self.bundle infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return bundleVersion;
}

- (void)buildLocalizedString
{
    NSString* filePath = [[XcodeHelper currentWorkspaceDocument].workspace.representingFilePath.fileURL path];
    NSString* projectDir = [filePath stringByDeletingLastPathComponent];
    //    NSString* projectName = [filePath lastPathComponent];
    
    NSTask* task = [[NSTask alloc] init];
    [task setLaunchPath:@"/bin/bash"];
    NSString* shellPath =
    [[NSBundle bundleForClass:[self class]] pathForResource:@"AutoGenLocalizedString"
                                                     ofType:@"sh"];
    [task setArguments:@[ shellPath , projectDir]];
    
    [task launch];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
