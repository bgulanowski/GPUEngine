//
//  BufferToTexture.m
//  GPUEngine
//
//  Created by Brent Gulanowski on 2018-07-22.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import "BufferToTexture.h"

static id<MTLTexture> Texture(id<MTLDevice>device, vector_uint2 size);

@implementation BufferToTexture

@synthesize outTexture=_outTexture;
@synthesize threadCount=_threadCount;
@synthesize inBuffer=_inBuffer;

- (instancetype)initWithLibrary:(id<MTLLibrary>)library buffer:(id<MTLBuffer>)buffer size:(vector_uint2)size {
    self = [super initWithLibrary:library kernelFunction:@"bufferToTexture"];
    if (self) {
        _threadCount = MTLSizeMake(size.x, size.y, 1);
        _inBuffer = buffer;
        _outTexture = Texture(library.device, size);
    }
    return self;
}

- (void)configureEncoderResources:(id<MTLComputeCommandEncoder>)encoder {
    [encoder setBuffer:_inBuffer offset:0 atIndex:0];
    [encoder setTexture:_outTexture atIndex:0];
}

@end

static id<MTLTexture> Texture(id<MTLDevice>device, vector_uint2 size) {
    MTLTextureDescriptor *desc = [MTLTextureDescriptor texture2DDescriptorWithPixelFormat:MTLPixelFormatRGBA8Unorm
                                                                                    width:size.x
                                                                                   height:size.y
                                                                                mipmapped:NO];
    desc.usage = MTLTextureUsageShaderWrite|MTLTextureUsageShaderRead;
    return [device newTextureWithDescriptor:desc];
}
