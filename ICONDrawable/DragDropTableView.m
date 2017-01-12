#import "DragDropTableView.h"

@implementation DragDropTableView
- (void) awakeFromNib {
	// Register to accept filename drag/drop
	[self registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType, nil]];
}

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
    NSLog(@"-->draggingEntered");
	// Need the delegate hooked up to accept the dragged item(s) into the model
	if (self.dragDropDelegate == nil) {
		return NSDragOperationNone;
	}
	
	if ([[[sender draggingPasteboard] types] containsObject:NSFilenamesPboardType]) {
		return NSDragOperationCopy;
	}
	
	return NSDragOperationNone;
}

// Work around a bug from 10.2 onwards
- (NSDragOperation)draggingSourceOperationMaskForLocal:(BOOL)isLocal {
    NSLog(@"-->draggingSourceOperationMaskForLocal");
	return NSDragOperationEvery;
}

// Stop the NSTableView implementation getting in the way
- (NSDragOperation)draggingUpdated:(id <NSDraggingInfo>)sender {
    NSLog(@"-->draggingUpdated");
	return [self draggingEntered:sender];
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender {
    NSLog(@"-->performDragOperation");
    if (self.dragDropDelegate == nil) {
        return NO;
    }

	NSPasteboard *pboard = [sender draggingPasteboard];
	if ([[pboard types] containsObject:NSFilenamesPboardType])
	{
		NSArray *filenames = [pboard propertyListForType:NSFilenamesPboardType];
        for (NSInteger i=0; i < [filenames count]; i++) {
            [self.dragDropDelegate performSelector:@selector(acceptFilenameDrag:) withObject:[filenames objectAtIndex:i]];
        }
        
		return YES;
	}
    
	return NO;
}	

@end
