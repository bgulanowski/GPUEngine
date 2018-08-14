//
//  BufferToTexture.metal
//  NoiseLab
//
//  Created by Brent Gulanowski on 2018-07-22.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

kernel void bufferToTexture(constant float *buffer [[buffer(0)]],
                            texture2d<float, access::write> texture [[texture(0)]],
                            uint2 size [[threads_per_grid]],
                            uint2 gid [[thread_position_in_grid]]) {
    uint index = gid.y * size.x + gid.x;
    float value = buffer[index];
    float4 colour = float4(value, value, value, 1.0);
    texture.write(colour, gid);
}
