//
//  GPUEngine.m
//  GPUEngine
//
//  Created by Brent Gulanowski on 2018-06-20.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import "GPUEngine.h"

@interface GPUEngine ()

@property (nonatomic) id<MTLDevice> device;
@property (nonatomic) id<MTLCommandQueue> commandQueue;

@end

@implementation GPUEngine

#pragma mark - NSOBject

- (instancetype)init {
    id<MTLDevice> device = MTLCreateSystemDefaultDevice();
    id<MTLLibrary> library = [device newDefaultLibrary];
    return [self initWithDevice:device library:library];
}

#pragma mark - Designated Initializer

- (instancetype)initWithDevice:(id<MTLDevice>)device library:(id<MTLLibrary>)library {
    self = [super init];
    if (self) {
        _device = device;
        _library = library;
        _commandQueue = [device newCommandQueue];
    }
    return self;
}

#pragma mark - Convenience Initializer

- (instancetype)initWithDevice:(id<MTLDevice>)device {
    return [self initWithDevice:device library:[device newDefaultLibrary]];
}

#pragma mark - GPUEngine

- (void)runTasks:(NSArray<id<GPUTask>> *)tasks withDrawable:(id<MTLDrawable>)drawable {
    
    id<MTLCommandBuffer> commandBuffer = [_commandQueue commandBuffer];
    for (id<GPUTask> task in tasks) {
        [task encodeTaskWithCommandBuffer:commandBuffer];
    }
    
    if (drawable) {
        [commandBuffer presentDrawable:drawable];
    }
    [commandBuffer commit];
    [commandBuffer waitUntilCompleted];
    
    for (id<GPUTask> task in tasks) {
        if ([task respondsToSelector:@selector(didComplete)]) {
            [task didComplete];
        }
    }
}

- (void)runTasks:(NSArray<id<GPUTask>> *)tasks {
    [self runTasks:tasks withDrawable:nil];
}

@end
