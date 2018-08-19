//
//  GPUEComputeTask.m
//  GPUEngine
//
//  Created by Brent Gulanowski on 2018-06-20.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import "GPUEComputeTask.h"

@interface GPUEComputeTask ()

@property (nonatomic, readonly) id<MTLComputePipelineState> pipeline;

@end

@implementation GPUEComputeTask

@dynamic threadCount;

- (instancetype)initWithLibrary:(id<MTLLibrary>)library kernelFunction:(NSString *)kernelName {
    self = [super init];
    if (self) {
        
        id<MTLFunction> kernelFunction = [library newFunctionWithName:kernelName];
        NSError *error;
        _pipeline = [library.device newComputePipelineStateWithFunction:kernelFunction error:&error];
        if(!_pipeline) {
            NSLog(@"Failed to create compute pipeline state: %@", error);
            return nil;
        }
        
        _threadgroupSize = MTLSizeMake(16, 16, 1);
        _shouldRun = YES;
    }
    return self;
}

- (void)encodeTaskWithCommandBuffer:(id<MTLCommandBuffer>)commandBuffer {
    
    id<MTLComputeCommandEncoder> encoder = [commandBuffer computeCommandEncoder];
    [encoder setComputePipelineState:self.pipeline];
    [self configureEncoder:encoder];
    [encoder endEncoding];
}

- (void)configureEncoder:(id<MTLComputeCommandEncoder>)encoder {
    [self configureEncoderResources:encoder];
    [self dispatchWithEncoder:encoder];
}

- (void)configureEncoderResources:(id<MTLComputeCommandEncoder>)encoder {}

- (void)dispatchWithEncoder:(id<MTLComputeCommandEncoder>)encoder {
    MTLSize count = self.threadCount;
    MTLSize groups = MTLSizeMake((count.width  - 1) / _threadgroupSize.width  + 1,
                                 (count.height - 1) / _threadgroupSize.height + 1,
                                 (count.depth  - 1) / _threadgroupSize.depth  + 1);
    [encoder dispatchThreadgroups:groups threadsPerThreadgroup:_threadgroupSize];
//    [encoder dispatchThreads:self.threadCount threadsPerThreadgroup:self.threadgroupSize];
    _hasRun = YES;
}

@end
