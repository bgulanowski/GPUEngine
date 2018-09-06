//
//  GPUEQuantize.m
//  GPUEngine
//
//  Created by Brent Gulanowski on 2018-09-06.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import "GPUEQuantize.h"

@implementation GPUEQuantize

@synthesize threadCount=_threadCount;
@synthesize inBuffer=_inBuffer;
@synthesize outBuffer=_outBuffer;

- (instancetype)initWithLibrary:(id<MTLLibrary>)library buffer:(id<MTLBuffer>)buffer size:(vector_uint2)size {
    self = [super initWithLibrary:library kernelFunction:@"quantize"];
    if (self) {
        _threadCount = MTLSizeMake(size.x, size.y, 1);
        _inBuffer = buffer;
        _outBuffer = [library.device newBufferWithLength:buffer.length options:MTLResourceStorageModeShared];
    }
    return self;
}

- (void)configureEncoderResources:(id<MTLComputeCommandEncoder>)encoder {
    [encoder setBuffer:_inBuffer offset:0 atIndex:0];
    [encoder setBuffer:_outBuffer offset:0 atIndex:1];
}

@end
