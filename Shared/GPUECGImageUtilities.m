//
//  GPUECGImageUtilities.m
//  GPUEngine
//
//  Created by Brent Gulanowski on 2018-06-20.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import "GPUECGImageUtilities.h"

#include <simd/simd.h>

static void BitMapReleaseCallback(void * __nullable releaseInfo,
                                  void * __nullable data) {
    free(data);
}

CGContextRef BitmapWithBytes(Byte * const bytes, vector_uint2 size) {
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmap = CGBitmapContextCreateWithData(bytes,
                                                        size.x,
                                                        size.y,
                                                        8,
                                                        size.x,
                                                        colorSpace,
                                                        0,
                                                        BitMapReleaseCallback,
                                                        NULL);
    CGColorSpaceRelease(colorSpace);
    return bitmap;
}

CGContextRef BitmapWithRGBABytes(ColourByteRGBA * const bytes, vector_uint2 size) {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef bitmap = CGBitmapContextCreateWithData(bytes,
                                                        size.x,
                                                        size.y,
                                                        8,
                                                        size.x * sizeof(ColourByteRGBA),
                                                        colorSpace,
                                                        kCGImageAlphaPremultipliedLast,
                                                        BitMapReleaseCallback,
                                                        NULL);
    CGColorSpaceRelease(colorSpace);
    return bitmap;
}

extern CGContextRef BitmapWithFloats(float * const floats, vector_uint2 size) {
    
    // Big ending is the default
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmap = CGBitmapContextCreateWithData(floats,
                                                        size.x,
                                                        size.y,
                                                        sizeof(float) * 8,
                                                        size.x * sizeof(float),
                                                        colorSpace,
                                                        kCGImageAlphaNone | kCGBitmapFloatComponents | kCGBitmapByteOrder32Little,
                                                        BitMapReleaseCallback,
                                                        NULL);

    CGColorSpaceRelease(colorSpace);
    return bitmap;
}

CGContextRef BitmapWithData(NSData *data, vector_uint2 size, ColourType type) {
    if (type == ColourTypeFloat) {
        return BitmapWithFloats((float *)data.bytes, size);
    }
    else if (type == ColourTypeByteRGBA) {
        return BitmapWithRGBABytes((ColourByteRGBA *)data.bytes, size);
    }
    else {
        NSLog(@"Asked to create bitmap with unsupported colour type %td", type);
    }
    return NULL;
}

CGImageRef CGImageWithTexture(id<MTLTexture> texture) {
    
    NSUInteger byteCount = texture.allocatedSize;
    NSUInteger rowBytes = byteCount / texture.height;
    MTLRegion region = MTLRegionMake2D(0, 0, texture.width, texture.height);
    
    void *bytes = malloc(byteCount);
    
    [texture getBytes:bytes bytesPerRow:rowBytes fromRegion:region mipmapLevel:0];
    CGContextRef bitmap = BitmapWithRGBABytes(bytes, vector2((uint)texture.width, (uint)texture.height));
    return CGBitmapContextCreateImage(bitmap);
}
