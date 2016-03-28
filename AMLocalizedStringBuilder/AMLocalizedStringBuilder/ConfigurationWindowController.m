//
//  ConfigruationWindowController.m
//  AMLocalizedStringBuilder
//
//  Created by Mellong on 16/3/28.
//  Copyright © 2016年 tendencystudio. All rights reserved.
//

#import "ConfigurationWindowController.h"
#import "XcodeHelper.h"
#import "AMConstString.h"

@interface ConfigurationWindowController () <NSTextFieldDelegate>

@property (weak) IBOutlet NSTableView *tableView;
@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) NSString *projectName;

@end

@implementation ConfigurationWindowController


- (void)windowDidLoad {
    [super windowDidLoad];
    
    NSString* filePath = [[XcodeHelper currentWorkspaceDocument].workspace.representingFilePath.fileURL path];
    NSString* projectDir = [filePath stringByDeletingLastPathComponent];
    _projectName = [[filePath lastPathComponent] stringByDeletingPathExtension];
    
    self.window.title = [NSString stringWithFormat:@"AMLocalizedStringBuilder-%@", _projectName];
    
    self.dataList = [XcodeHelper findLocalizedStringFilesPath:projectDir];
    [self.tableView reloadData];

}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.dataList.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    if ([tableColumn.title isEqualToString:@"Selection"]) {
        NSString *path = [[NSUserDefaults standardUserDefaults] objectForKey:_projectName];
        if (path) {
            return @([self.dataList[row] isEqualToString:path]);
        }
        return nil;
    }
    NSArray *result = [self.dataList[row] componentsSeparatedByString:@"/"];
    return [NSString stringWithFormat:@".../%@/%@", result[result.count-2], result.lastObject];
}

- (void)tableView:(NSTableView *)tableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    [self.tableView reloadData];
    [[NSUserDefaults standardUserDefaults] setObject:self.dataList[row] forKey:_projectName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)onCloseButtonClicked:(NSButton *)sender {
    [self close];
}


@end
