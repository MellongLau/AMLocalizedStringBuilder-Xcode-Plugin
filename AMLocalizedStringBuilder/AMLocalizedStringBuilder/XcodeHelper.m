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

@end
