//
//  NSImage+Addition.m
//  ICONDrawable
//
//  Created by czm on 16/7/17.
//  Copyright © 2016年 gaodosoft. All rights reserved.
//

#import "NSImage+Addition.h"

@implementation NSImage (Addition)
- (NSImage *)transformToSize:(CGSize)newSize
{
    NSRect newRect = NSMakeRect(0, 0, newSize.width, newSize.height);
    NSImage *image = [[NSImage alloc] initWithSize:newSize];
    if (image.size.width > 0) {
        [image lockFocus];
        [self drawInRect:newRect];
        [image unlockFocus];
    }
    
    return image;
}

- (void)saveToPath:(NSString *)path
{
    NSData *imageData = [self TIFFRepresentation];
    NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];
    [imageRep setSize:[self size]];
    
    // png
    imageData = [imageRep representationUsingType:NSPNGFileType properties:nil];
    [imageData writeToFile:path atomically:YES];
    // jpg
//    NSDictionary *imageProps = nil;
//    NSNumber *quality = [NSNumber numberWithFloat:.85];
//    imageProps = [NSDictionary dictionaryWithObject:quality forKey:NSImageCompressionFactor];
//    NSData * imageData1 = [imageRep representationUsingType:NSJPEGFileType properties:imageProps];

}
@end
