/* DragDropTableView */

#import <Cocoa/Cocoa.h>

@protocol DragDropDelegate <NSObject>
@required
- (void)acceptFilenameDrag:(NSString *)filePath;
@end

@interface DragDropTableView : NSTableView
@property (nonatomic, weak) id<DragDropDelegate> dragDropDelegate;
@end
