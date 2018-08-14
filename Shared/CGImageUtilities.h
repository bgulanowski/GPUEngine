//
//  CGImageUtilities.h
//  NoiseLab
//
//  Created by Brent Gulanowski on 2018-06-20.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#ifndef CGImageUtilities_h
#define CGImageUtilities_h

@import Foundation;
@import QuartzCore;
@import Metal;
@import simd;

typedef NS_ENUM(NSUInteger) {
    ColourTypeByte,
    ColourTypeByteRGB,
    ColourTypeByteRGBA,
    ColourTypeByteARGB,
    ColourTypeFloat,
    ColourTypeFloatRGB,
    ColourTypeFloatRGBA,
    ColourTypeFloatARGB
} ColourType;

typedef struct {
    Byte r, g, b, a;
} ColourByteRGBA;

// passed in bytes are now owned by the context - do not free!
extern CGContextRef BitmapWithBytes(Byte * const bytes, vector_uint2 size);
extern CGContextRef BitmapWithRGBABytes(ColourByteRGBA * const bytes, vector_uint2 size);
extern CGContextRef BitmapWithFloats(float * const bytes, vector_uint2 size);

extern CGContextRef BitmapWithRawBytes(void * const data, vector_uint2 size, ColourType type);

extern CGContextRef BitmapWithData(NSData *data, vector_uint2 size, ColourType type);

extern CGImageRef CGImageWithTexture(id<MTLTexture> texture);

#endif /* CGImageUtilities_h */
