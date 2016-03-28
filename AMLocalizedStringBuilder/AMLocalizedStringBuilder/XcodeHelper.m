//
//  XcodeHelper.m
//  AMLocalizedStringBuilder
//
//  Created by Mellong on 16/3/28.
//  Copyright © 2016年 tendencystudio. All rights reserved.
//


#import "XcodeHelper.h"

@implementation XcodeHelper

+ (IDEWorkspaceDocument*)currentWorkspaceDocument
{
    NSWindowController* currentWindowController =
    [[NSApp mainWindow] windowController];
    id document = [currentWindowController document];
    if (currentWindowController &&
        [document isKindOfClass:NSClassFromString(@"IDEWorkspaceDocument")]) {
        return (IDEWorkspaceDocument*)document;
    }
    return nil;
}


+ (NSArray *)findLocalizedStringFilesPath:(NSString *)projectDir
{
    NSTask* task = [[NSTask alloc] init];
    [task setLaunchPath:@"/bin/bash"];
    NSString* shellPath =
    [[NSBundle bundleForClass:[self class]] pathForResource:@"FindLocalizedStringFiles"
                                                     ofType:@"sh"];
    [task setArguments:@[ shellPath , projectDir]];
    
    
    NSPipe * result = [NSPipe pipe];
    NSFileHandle *file = result.fileHandleForReading;
    [task setStandardOutput:result];
    
    [task launch];
    
    NSMutableData *data = [NSMutableData dataWithCapacity:512];
    while ([task isRunning]) {
        [data appendData:[file readDataToEndOfFile]];
    }
    
    [file closeFile];
    NSString * stringRead = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self != ''"];
    NSArray *pathList = [[stringRead componentsSeparatedByString:@"\n"] filteredArrayUsingPredicate:predicate];
    return pathList;
}

@end
