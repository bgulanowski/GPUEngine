//
//  Process.h
//  GPU Demo Mac
//
//  Created by Brent Gulanowski on 2018-08-14.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@import GPUEngine;

@interface Process : NSObject<GPUEProcess>

- (instancetype)initWithEngine:(GPUEEngine *)engine host:(id<GPUERenderHost>)renderHost;

@end
