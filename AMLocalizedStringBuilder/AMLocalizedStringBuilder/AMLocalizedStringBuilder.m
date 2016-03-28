//
//  AMLocalizedStringBuilder.m
//  AMLocalizedStringBuilder
//
//  Created by Mellong on 16/3/28.
//  Copyright © 2016年 tendencystudio. All rights reserved.
//

#import "AMLocalizedStringBuilder.h"
#import "XcodeHelper.h"
#import "ConfigurationWindowController.h"
#import "AMMenuGenerator.h"

@interface AMLocalizedStringBuilder()

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@property (nonatomic, strong) ConfigurationWindowController * settingWindowController;

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
    [AMMenuGenerator generateMenuItems:self.bundle version:[self getBundleVersion] target:self];
    
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
    NSString* projectName = [[filePath lastPathComponent] stringByDeletingPathExtension];
    NSString *path = [[NSUserDefaults standardUserDefaults] objectForKey:projectName];
    if (path == nil) {
        NSArray *pathList = [XcodeHelper findLocalizedStringFilesPath:projectDir];
        if (pathList.count > 0) {
            [[NSUserDefaults standardUserDefaults] setObject:pathList.firstObject forKey:projectName];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else {
            NSLog(@"Error: no localized string file found!");
            return;
        }
        
    }

    NSTask* task = [[NSTask alloc] init];
    [task setLaunchPath:@"/bin/bash"];
    NSString* shellPath =
    [[NSBundle bundleForClass:[self class]] pathForResource:@"AutoGenLocalizedString"
                                                     ofType:@"sh"];
    NSString *localizedStringFilePath = [[NSUserDefaults standardUserDefaults] objectForKey:projectName];
    [task setArguments:@[ shellPath , projectDir, localizedStringFilePath]];
    
    [task launch];
}

- (void)showSettingWindow
{
    self.settingWindowController = [[ConfigurationWindowController alloc] initWithWindowNibName:@"ConfigurationWindowController"];
    [self.settingWindowController showWindow:self.settingWindowController];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
