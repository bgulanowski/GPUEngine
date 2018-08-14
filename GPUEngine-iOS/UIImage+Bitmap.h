//
//  UIImage+Bitmap.h
//  NoiseLab-iOS
//
//  Created by Brent Gulanowski on 2018-06-09.
//  Copyright © 2018 Lichen Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Bitmap)
+ (UIImage *)imageWithBitmap:(CGContextRef)bitmap;
@end
