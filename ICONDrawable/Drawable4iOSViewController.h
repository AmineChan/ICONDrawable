//
//  Drawable4iOSViewController.h
//  ICONDrawable
//
//  Created by czm on 2017/1/6.
//  Copyright © 2017年 taide. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DragDropTableView.h"

@interface Drawable4iOSViewController : NSViewController <DragDropDelegate>
{
    NSMutableArray *_fileArray;
    NSMutableArray *_subFileArray;
    NSDictionary *_densityMultipliersDic;
}
@property (weak) IBOutlet DragDropTableView *tableView;
@property (weak) IBOutlet NSPopUpButton *originDpiSelect;
@property (weak) IBOutlet NSButton *ldpiCB;//1x
@property (weak) IBOutlet NSButton *mdpiCB;//2x
@property (weak) IBOutlet NSButton *hdpiCB;//3x
@property (weak) IBOutlet NSTextField *destDirTV;
@property (weak) IBOutlet NSButton *destDirSelectBtn;
@property (weak) IBOutlet NSButton *startBtn;

@end
