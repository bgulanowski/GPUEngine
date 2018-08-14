//
//  ShaderTypes.h
//  NoiseLab
//
//  Created by Brent Gulanowski on 2018-06-15.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#ifndef ShaderTypes_h
#define ShaderTypes_h

#import <simd/simd.h>

#if 0
typedef enum {
    Simplex,
    Voronoi,
    Ridged,
    // others as we figure them out
} GeneratorType;

typedef struct {
    unsigned octaves;
    float persistence;
    vector_float3 offset; // TODO: remove in favour of Source.transform
    vector_float2 scale; // TODO: remove in favour of Source.transform
    // TODO: more parameters affecting other noise types
} NoiseParams;

typedef struct {
    float scale;
} NormalParams;

typedef struct {
    NoiseParams noise;
    GeneratorType type;
    matrix_float4x4 transform;
} SourceParams;

typedef struct {
    vector_uint2 size;
    vector_float3 offset;
    vector_float2 scale;
    float heightFactor;
    float multiple; // the noise scale relative to the terrain scale
} TerrainParams;
#endif

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

#endif /* ShaderTypes_h */
