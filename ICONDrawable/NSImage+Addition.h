//
//  NSImage+Addition.h
//  ICONDrawable
//
//  Created by czm on 16/7/17.
//  Copyright © 2016年 gaodosoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSImage (Addition)

- (NSImage *)transformToSize:(NSSize)newSize;
- (void)saveToPath:(NSString *)path;

@end
