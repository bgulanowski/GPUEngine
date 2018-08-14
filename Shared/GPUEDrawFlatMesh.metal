//
//  DrawFlatMesh.metal
//  GPUEngine
//
//  Created by Brent Gulanowski on 2018-07-09.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

#include "GPUEShaderTypes.h"

typedef struct {
    float4 position [[position]];
    float2 uv;
} VertexOut;

vertex VertexOut vertexPassThrough(device Vertex *vertices [[buffer(0)]],
                                   uint vid [[vertex_id]]) {
    return (VertexOut){.position = vertices[vid].position, .uv = vertices[vid].uv };
}

fragment half4 constantColor() {
    return half4(1, 1, 1, 1);
}

fragment half4 textureLookup(VertexOut vert [[stage_in]],
                             texture2d<half, access::sample> texture [[texture(0)]],
                             sampler samplr [[sampler(0)]]) {
    return texture.sample(samplr, vert.uv);
}
