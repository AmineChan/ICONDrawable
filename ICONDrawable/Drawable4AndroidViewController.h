//
//  Drawable4AndroidViewController.h
//  ICONDrawable
//
//  Created by czm on 2017/1/6.
//  Copyright © 2017年 taide. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DragDropTableView.h"

@interface Drawable4AndroidViewController : NSViewController <DragDropDelegate>
{
    NSMutableArray *_fileArray;
    NSMutableArray *_subFileArray;
    NSDictionary *_densityMultipliersDic;
}
@property (weak) IBOutlet DragDropTableView *tableView;
@property (weak) IBOutlet NSPopUpButton *originDpiSelect;
@property (weak) IBOutlet NSButton *ldpiCB;
@property (weak) IBOutlet NSButton *mdpiCB;
@property (weak) IBOutlet NSButton *hdpiCB;
@property (weak) IBOutlet NSButton *xhdpiCB;
@property (weak) IBOutlet NSButton *xxhdpiCB;
@property (weak) IBOutlet NSButton *xxxhdpiCB;
@property (weak) IBOutlet NSTextField *destDirTV;
@property (weak) IBOutlet NSButton *destDirSelectBtn;
@property (weak) IBOutlet NSButton *startBtn;

@end
