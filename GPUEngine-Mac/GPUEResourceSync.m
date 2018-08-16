//
//  GPUEResourceSync.h
//  GPUEngine
//
//  Created by Brent Gulanowski on 2018-06-20.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import "GPUEResourceSync.h"

@implementation GPUEResourceSync

- (void)performBlitWithEncoder:(id<MTLBlitCommandEncoder>)encoder {
    [encoder synchronizeResource:self.resource];
}

@end
