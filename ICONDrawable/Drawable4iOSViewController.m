//
//  Drawable4iOSViewController.m
//  ICONDrawable
//
//  Created by czm on 2017/1/6.
//  Copyright © 2017年 taide. All rights reserved.
//

#import "Drawable4iOSViewController.h"
#import "NSImage+Addition.h"

@implementation Drawable4iOSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"iOS";

    _fileArray = [[NSMutableArray alloc] init];
    _subFileArray = [[NSMutableArray alloc] init];
    _densityMultipliersDic = @{@"1x":@1, @"2x":@2, @"3x":@3};
    [_originDpiSelect removeAllItems];
    [_originDpiSelect addItemsWithTitles:@[@"1x", @"2x", @"3x"]];
    [_originDpiSelect selectItemWithTitle:@"2x"];
    
    _tableView.dragDropDelegate = self;
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}

- (void)addfFileWithFileName:(NSString *)filePath {
    for (NSString *file in _fileArray) {
        if ([file isEqualToString:filePath]) {
            return;
        }
    }
    
    [_fileArray addObject:filePath];
    [_tableView reloadData];
}

- (void)removeFile:(NSString *)file {
    if (nil == file) {
        return;
    }
    
    [_fileArray removeObject:file];
    [_tableView reloadData];
}

- (void)mkdir:(NSString *)dir {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:dir]) {
        [fileManager createDirectoryAtPath:dir
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:nil];
    }
    
}

#pragma mark -
#pragma mark === ui event ===
#pragma mark
- (IBAction)destDirBtnTaped:(id)sender {
    NSOpenPanel *oPanel = [NSOpenPanel openPanel]; //快捷建立方式不用释放, 我还记得, 你呢?
    [oPanel setCanChooseDirectories:YES]; //可以打开目录
    [oPanel setCanChooseFiles:NO]; //不能打开文件(我需要处理一个目录内的所有文件)
    [oPanel setDirectory:NSHomeDirectory()]; //起始目录为Home
    [oPanel setCanCreateDirectories:YES];
    
    if ([oPanel runModal] == NSModalResponseOK) {
        NSString *filePath = [[oPanel filenames] objectAtIndex:0];
        _destDirTV.stringValue = filePath;
    }
}

- (IBAction)startBtnTaped:(id)sender {
    if (_destDirTV.stringValue == nil || _destDirTV.stringValue.length == 0) {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle:@"确定"];
        [alert setMessageText:@"请选择目的路径"];
        [alert setAlertStyle:NSAlertStyleWarning];
        
        [alert runModal] ;
        return;
    }
    
    NSMutableArray *checkedCBArray = [NSMutableArray array];
    if (_ldpiCB.state) {
        [checkedCBArray addObject:@"1x"];
    }
    if (_mdpiCB.state) {
        [checkedCBArray addObject:@"2x"];
    }
    if (_hdpiCB.state) {
        [checkedCBArray addObject:@"3x"];
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    BOOL exist = NO;
    
    [_subFileArray removeAllObjects];
    
    for (NSString *file in _fileArray) {
        exist = [fileManager fileExistsAtPath:file isDirectory:&isDirectory];
        if (!exist) {
            continue;
        }
        
        if (isDirectory) {
            NSArray *subFileArray = [fileManager subpathsOfDirectoryAtPath:file error:nil];
            for (NSString *filePath in subFileArray) {
                NSString *fullPath = [file stringByAppendingPathComponent:filePath];
                [fileManager fileExistsAtPath:fullPath isDirectory:&isDirectory];
                if (!isDirectory) {
                    NSString *lowercaseString = [fullPath lowercaseString];
                    if ([lowercaseString hasSuffix:@".png"]) {
                        [_subFileArray addObject:fullPath];
                    }
                }
            }
        } else {
            NSString *lowercaseString = [file lowercaseString];
            if ([lowercaseString hasSuffix:@".png"]) {
                [_subFileArray addObject:file];
            }
        }
    }
    
    for (NSString *file in _subFileArray) {
        NSString *name = [[file lastPathComponent] stringByReplacingOccurrencesOfString:@"." withString:@"."];
        NSImage *image = [[NSImage alloc] initWithContentsOfFile:file];
        CGFloat sourceMultipliers = [_densityMultipliersDic[_originDpiSelect.selectedItem.title] floatValue];
        NSBitmapImageRep *rep = [NSBitmapImageRep imageRepWithData:[image TIFFRepresentation]];
        NSSize pixelsSize = NSMakeSize([rep pixelsWide], [rep pixelsHigh]);
        
        NSString *destDir = [_destDirTV.stringValue stringByAppendingPathComponent:@"Resource"];
        [self mkdir:destDir];
        for (NSString *dpi in checkedCBArray) {
            NSString *imageName = [[name stringByReplacingOccurrencesOfString:@"." withString:[[@"@" stringByAppendingString:dpi] stringByAppendingString:@"."]] lowercaseString];
            CGFloat multipliers = [_densityMultipliersDic[dpi] floatValue];
            CGFloat scale = multipliers/sourceMultipliers;
            NSSize size = CGSizeMake(floorf(pixelsSize.width*scale+0.5)/2, floorf(pixelsSize.height*scale+0.5)/2);
            NSImage *destImage = [image transformToSize:size];
            
            [destImage saveToPath:[destDir stringByAppendingPathComponent:imageName]];
        }
    }
    
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"确定"];
    [alert setMessageText:@"完成"];
    [alert setAlertStyle:NSAlertStyleWarning];
    [alert runModal] ;
}

#pragma mark -
#pragma mark === NSTableView drag ===
#pragma mark
- (void)acceptFilenameDrag:(NSString *)filePath {
    [self addfFileWithFileName:filePath];
}

#pragma mark -
#pragma mark === NSTableView delegate ===
#pragma mark
-(NSInteger)numberOfRowsInTableView:(NSTableView *)tv {
    return [_fileArray count];
}

- (id)tableView:(NSTableView *)tv objectValueForTableColumn:(NSTableColumn *)tableColumn row:(int)row {
    NSString *strIdt=[tableColumn identifier];
    NSString *file = [_fileArray objectAtIndex:row];
    if([strIdt isEqualToString:@"filePath"]) {
        return file;
    } else {
        NSButtonCell* cell = [tableColumn dataCellForRow:row];
        [cell setImage:[NSImage imageNamed:@"cellDel.png"]];
        [cell setTarget:self];
        
        return cell;
    }
}

- (void)tableView:(NSTableView *)aTableView
   setObjectValue:(id)anObject
   forTableColumn:(NSTableColumn *)aTableColumn
              row:(NSInteger)row {
    NSString *strIdt=[aTableColumn identifier];
    NSString *file = [_fileArray objectAtIndex:row];
    if ([strIdt isEqualToString:@"del"]) {
        [self removeFile:file];
    }
}

@end

