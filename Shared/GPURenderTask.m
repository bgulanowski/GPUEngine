//
//  GPURenderTask.m
//  NoiseLab
//
//  Created by Brent Gulanowski on 2018-06-20.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import "GPURenderTask.h"

@interface GPURenderTask ()

@property (nonatomic, readonly) id<MTLRenderPipelineState> pipeline;
@property (nonatomic, readonly, weak) id<GPURenderHost> renderHost;

@end

@implementation GPURenderTask

- (instancetype)initWithWithLibrary:(id<MTLLibrary>)library vertexFunction:(NSString *)vertexName fragmentFunction:(NSString *)fragmentName host:(id<GPURenderHost>)host {
    self = [super init];
    if (self) {
        MTLRenderPipelineDescriptor *rpd = [[MTLRenderPipelineDescriptor alloc] init];
        rpd.vertexFunction = [library newFunctionWithName:vertexName];
        rpd.fragmentFunction = [library newFunctionWithName:fragmentName];
        rpd.colorAttachments[0].pixelFormat = host.pixelFormat;
        _renderHost = host;
        
        NSError *error = nil;
        _pipeline = [library.device newRenderPipelineStateWithDescriptor:rpd error:&error];
        if(!_pipeline) {
            NSLog(@"Failed to create render pipeline: %@", error);
            return nil;
        }
    }
    return self;
}

- (void)encodeTaskWithCommandBuffer:(id<MTLCommandBuffer>)commandBuffer {
    
    MTLRenderPassDescriptor *rpd = self.renderHost.renderPassDescriptor;
    
    if (rpd == nil) {
        return;
    }
    
    id<MTLRenderCommandEncoder> encoder = [commandBuffer renderCommandEncoderWithDescriptor:rpd];
    [encoder setViewport:_renderHost.viewport];
    [self configureEncoder:encoder];
    [encoder endEncoding];
}

- (void)configureEncoder:(id<MTLRenderCommandEncoder>)encoder {
    [self configureEncoderResources:encoder];
    [self drawWithEncoder:encoder];
}

- (void)configureEncoderResources:(id<MTLRenderCommandEncoder>)encoder {
    [encoder setRenderPipelineState:_pipeline];
}

- (void)drawWithEncoder:(id<MTLRenderCommandEncoder>)encoder {}

@end
