//
//  NSImage+Bitmap.h
//  Noise Lab-Mac
//
//  Created by Brent Gulanowski on 2018-06-09.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSImage (Bitmap)

+ (instancetype)imageWithCGImage:(CGImageRef)cgImage;
+ (instancetype)imageWithBitmap:(CGContextRef)bitmap;

+ (instancetype)imageWithTexture:(id<MTLTexture>)texture;

@end
