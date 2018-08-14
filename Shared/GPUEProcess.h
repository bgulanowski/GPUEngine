//
//  GPUEProcess.h
//  GPUEngine
//
//  Created by Brent Gulanowski on 2018-07-06.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@import Metal;

#import "GPUETask.h"

@protocol GPUETask;
@class GPUEEngine;

@protocol GPUEProcess <NSObject>

@property (nonatomic, readonly) GPUEEngine *engine;
@property (nonatomic, readonly) id<MTLDevice> device;
@property (nonatomic, readonly) NSArray<id<GPUETask>> *tasks; // provided by subclasses
@property (nonatomic, readonly) BOOL needsRefresh;
@property (nonatomic, copy) dispatch_block_t refresh;
@property (nonatomic, copy) dispatch_block_t onComplete;

- (instancetype)initWithEngine:(GPUEEngine *)engine;

- (void)run;
- (void)runWithDrawable:(id<MTLDrawable>)drawable;

@optional
- (void)updateTasks;

@end

@protocol GPUBufferProducer <GPUEProcess>
@property (nonatomic, readonly) id<GPUEBufferProducer> bufferProducer;
@end

@protocol GPUTextureProducer <GPUEProcess>
@property (nonatomic, readonly) id<GPUETextureProducer> textureProducer;
@end
