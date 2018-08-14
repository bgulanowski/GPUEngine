//
//  NSImage+Bitmap.m
//  Noise Lab-Mac
//
//  Created by Brent Gulanowski on 2018-06-09.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import "NSImage+Bitmap.h"
#import "GPUECGImageUtilities.h"

@implementation NSImage (Bitmap)

+ (instancetype)imageWithCGImage:(CGImageRef)cgImage {
    return [[NSImage alloc] initWithCGImage:cgImage size:NSZeroSize];
}

+ (instancetype)imageWithBitmap:(CGContextRef)bitmap {
    
    CGImageRef cgImage = CGBitmapContextCreateImage(bitmap);
    NSImage *image = [NSImage imageWithCGImage:cgImage];
    
    CFRelease(cgImage);
    
    return image;
}

+ (instancetype)imageWithTexture:(id<MTLTexture>)texture {
    
    CGImageRef cgImage = CGImageWithTexture(texture);
    NSImage *image = [[NSImage alloc] initWithCGImage:cgImage size:NSZeroSize];
    
    CFRelease(cgImage);
    return image;
}

@end
