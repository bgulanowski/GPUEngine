//
//  DrawFlatMesh.m
//  NoiseLab
//
//  Created by Brent Gulanowski on 2018-06-27.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import "DrawFlatMesh.h"

#import "Mesh.h"

@implementation DrawFlatMesh

- (instancetype)initWithWithLibrary:(id<MTLLibrary>)library host:(id<GPURenderHost>)host {
    return [super initWithWithLibrary:library vertexFunction:@"vertexPassThrough" fragmentFunction:@"constantColor" host:host];
}

- (void)configureEncoderResources:(id<MTLRenderCommandEncoder>)encoder {
    [super configureEncoderResources:encoder];
    [encoder setVertexBuffer:_mesh.vertexBuffer offset:0 atIndex:0];
}

- (void)drawWithEncoder:(id<MTLRenderCommandEncoder>)encoder {
    if (_mesh) {
        [encoder drawIndexedPrimitives:MTLPrimitiveTypeTriangle indexCount:_mesh.indexCount indexType:MTLIndexTypeUInt32 indexBuffer:_mesh.indexBuffer indexBufferOffset:0];
    }
}

@end
