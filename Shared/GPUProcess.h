//
//  GPUProcess.h
//  NoiseLab
//
//  Created by Brent Gulanowski on 2018-07-06.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@import Metal;

#import "GPUTask.h"

@protocol GPUTask;
@class GPUEngine;

@protocol GPUProcess <NSObject>

@property (nonatomic, readonly) GPUEngine *engine;
@property (nonatomic, readonly) id<MTLDevice> device;
@property (nonatomic, readonly) NSArray<id<GPUTask>> *tasks; // provided by subclasses
@property (nonatomic, readonly) BOOL needsRefresh;
@property (nonatomic, copy) dispatch_block_t refresh;
@property (nonatomic, copy) dispatch_block_t onComplete;

- (instancetype)initWithEngine:(GPUEngine *)engine;

- (void)run;
- (void)runWithDrawable:(id<MTLDrawable>)drawable;

@optional
- (void)updateTasks;

@end

@protocol GPUBufferProducer <GPUProcess>
@property (nonatomic, readonly) id<BufferProducer> bufferProducer;
@end

@protocol GPUTextureProducer <GPUProcess>
@property (nonatomic, readonly) id<TextureProducer> textureProducer;
@end
