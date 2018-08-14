//
//  GPUBlitTask.h
//  Noise Lab-Mac
//
//  Created by Brent Gulanowski on 2018-06-20.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GPUTask.h"

NS_ASSUME_NONNULL_BEGIN

@interface GPUBlitTask : NSObject<GPUTask>

@property (nonatomic, readonly) id<MTLResource> resource;

- (instancetype)initWithResource:(id<MTLResource>)resource;
- (void)performBlitWithEncoder:(id<MTLBlitCommandEncoder>)encoder;

@end

NS_ASSUME_NONNULL_END
