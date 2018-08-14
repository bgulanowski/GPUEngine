//
//  ComputePyramid.m
//  GPUEngine
//
//  Created by Brent Gulanowski on 2018-07-20.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import "GPUEComputePyramid.h"

@implementation GPUEComputePyramid

@synthesize threadCount=_threadCount;
@synthesize outBuffer=_outBuffer;

- (instancetype)initWithLibrary:(id<MTLLibrary>)library size:(vector_uint2)size {
    self = [super initWithLibrary:library kernelFunction:@"computePyramid"];
    if (self) {
        _threadCount = MTLSizeMake(size.x, size.y, 1);
        _outBuffer = [library.device newBufferWithLength:1024*1024*sizeof(float) options:MTLResourceStorageModeShared];
    }
    return self;
}

- (void)configureEncoderResources:(id<MTLComputeCommandEncoder>)encoder {
    [encoder setBuffer:_outBuffer offset:0 atIndex:0];
}

@end
