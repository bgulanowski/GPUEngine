//
//  GPUEShaderTypes.h
//  GPUEngine
//
//  Created by Brent Gulanowski on 2018-06-15.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#ifndef GPUEShaderTypes_h
#define GPUEShaderTypes_h

#import <simd/simd.h>

typedef struct {
    vector_float4 position;
    vector_float2 uv;
} Vertex;

typedef struct {
    vector_float4 position;
    vector_float4 colour;
    vector_float3 normal;
    vector_float2 uv;
} ColourVertex;

#endif /* GPUEShaderTypes_h */
