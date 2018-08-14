//
//  Pyramid.metal
//  GPUEngine
//
//  Created by Brent Gulanowski on 2018-07-20.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

constant uint freq = 8;

kernel void computePyramid(device float *results [[buffer(0)]],
               uint2 size [[threads_per_grid]],
               uint2 gid [[thread_position_in_grid]]) {
    // Output a height value between zero and one corresponding to a square pyramid
    uint index = size.x * gid.y + gid.x;
    
    const uint period = size.x / freq;
    float d = float(period);
    
    float sx = float(gid.x % period);
    float sy = float(gid.y % period);
    bool r = (sx > sy && (period - sx) > sy);
    bool l = (sy > sx && sx > (period - sy));
    
    float v = (r || l) ? sx : sy;
    float value = abs((d - 2.0f * v) / d);
    
    results[index] = value;
}
