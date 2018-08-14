//
//  GPUEDrawTexture.m
//  GPUEngine
//
//  Created by Brent Gulanowski on 2018-06-20.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import "GPUEDrawTexture.h"

#import "GPUEShaderTypes.h"

static Vertex quadVertices[] = {
    {{ -1,  1, 0, 1 }, {  0,  1 }},
    {{ -1, -1, 0, 1 }, {  0,  0 }},
    {{  1,  1, 0, 1 }, {  1,  1 }},
    {{  1, -1, 0, 1 }, {  1,  0 }}
};

@interface GPUEDrawTexture ()
@property (nonatomic, readonly) id<MTLBuffer> quadData;
@property (nonatomic, readonly) id<MTLSamplerState> sampler;
@end

@implementation GPUEDrawTexture

@synthesize inTexture=_inTexture;

- (instancetype)initWithLibrary:(id<MTLLibrary>)library texture:(id<MTLTexture>)texture host:(id<GPUERenderHost>)host {
    self = [super initWithWithLibrary:library vertexFunction:@"vertexPassThrough" fragmentFunction:@"textureLookup" host:host];
    if (self) {
        MTLResourceOptions options;
#if TARGET_OS_IPHONE
        options = MTLResourceStorageModeShared;
#else
        options = MTLResourceStorageModeManaged;
#endif
        _quadData = [library.device newBufferWithBytes:&quadVertices length:(sizeof(Vertex) * 4) options:options];
        _sampler = [library.device newSamplerStateWithDescriptor:[MTLSamplerDescriptor repeatingSampler]];
        _inTexture = texture;
    }
    return self;
}

- (void)configureEncoderResources:(id<MTLRenderCommandEncoder>)encoder {
    [super configureEncoderResources:encoder];
    [encoder setVertexBuffer:self.quadData offset:0 atIndex:0];
    [encoder setFragmentTexture:_inTexture atIndex:0];
    [encoder setFragmentSamplerState:self.sampler atIndex:0];
}

- (void)drawWithEncoder:(id<MTLRenderCommandEncoder>)encoder {
    [encoder drawPrimitives:MTLPrimitiveTypeTriangleStrip vertexStart:0 vertexCount:4];
}

@end

@implementation MTLSamplerDescriptor (RepeatingSampler)

+ (instancetype)repeatingSampler {
    MTLSamplerDescriptor *samplerDesc = [self new];
    samplerDesc.sAddressMode = MTLSamplerAddressModeRepeat;
    samplerDesc.tAddressMode = MTLSamplerAddressModeRepeat;
    samplerDesc.minFilter = MTLSamplerMinMagFilterNearest;
    samplerDesc.magFilter = MTLSamplerMinMagFilterLinear;
    return samplerDesc;
}

@end
