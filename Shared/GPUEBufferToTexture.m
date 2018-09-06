//
//  GPUEBufferToTexture.m
//  GPUEngine
//
//  Created by Brent Gulanowski on 2018-07-22.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import "GPUEBufferToTexture.h"

#import "GPUEShaderTypes.h"

static id<MTLTexture> Texture(id<MTLDevice>device, vector_uint2 size);

@implementation GPUEBufferToTexture

@synthesize outTexture=_outTexture;
@synthesize threadCount=_threadCount;
@synthesize inBuffer=_inBuffer;

- (instancetype)initWithLibrary:(id<MTLLibrary>)library buffer:(id<MTLBuffer>)buffer size:(vector_uint2)size {
    self = [super initWithLibrary:library kernelFunction:@"bufferToTexture"];
    if (self) {
        _threadCount = MTLSizeMake(size.x, size.y, 1);
        _inBuffer = buffer;
        _outTexture = Texture(library.device, size);
        _min = 0;
        _max = 1.0f;
        _map = YES;
    }
    return self;
}

- (void)configureEncoderResources:(id<MTLComputeCommandEncoder>)encoder {
    [encoder setBuffer:_inBuffer offset:0 atIndex:0];
    ConvertOptions options;
    options.min = _min;
    options.max = _max;
    options.map = _map;
    [encoder setBytes:&options length:sizeof(options) atIndex:1];
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
