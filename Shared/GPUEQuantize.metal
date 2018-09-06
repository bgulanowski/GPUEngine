//
//  GPUEQuantize.metal
//  GPUEngine
//
//  Created by Brent Gulanowski on 2018-09-06.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

kernel void quantize(device float *source [[buffer(0)]],
                device float *destination [[buffer(1)]],
                uint2 size [[threads_per_grid]],
                uint2 gid [[thread_position_in_grid]]) {
    
    uint index = size.x * gid.y + gid.x;

    destination[index] = source[index] > 0 ? 0 : 1;
}
