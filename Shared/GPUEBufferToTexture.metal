//
//  BufferToTexture.metal
//  GPUEngine
//
//  Created by Brent Gulanowski on 2018-07-22.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#include <metal_stdlib>
#include "GPUEShaderTypes.h"

using namespace metal;

kernel void bufferToTexture(device float *buffer [[buffer(0)]],
                            constant ConvertOptions *options [[buffer(1)]],
                            texture2d<float, access::write> texture [[texture(0)]],
                            uint2 size [[threads_per_grid]],
                            uint2 gid [[thread_position_in_grid]]) {
    uint index = gid.y * size.x + gid.x;
    float value = buffer[index];
    if (options->map) {
        value = smoothstep(options->min, options->max, value);
    }
    else {
        value = clamp(value, options->min, options->max);
    }
    float4 colour = float4(value, value, value, 1.0);
    texture.write(colour, gid);
}
