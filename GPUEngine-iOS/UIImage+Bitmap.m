//
//  UIImage+Bitmap.m
//  NoiseLab-iOS
//
//  Created by Brent Gulanowski on 2018-06-09.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import "UIImage+Bitmap.h"

@implementation UIImage (Bitmap)

+ (UIImage *)imageWithBitmap:(CGContextRef)bitmap {
    
    CGImageRef cgImage = CGBitmapContextCreateImage(bitmap);
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    
    CFRelease(cgImage);
    
    return image;
}

@end
