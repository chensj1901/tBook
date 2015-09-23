//
//  UIImage+SJImage.m
//  tBook
//
//  Created by 陈少杰 on 15/9/22.
//  Copyright © 2015年 陈少杰. All rights reserved.
//

#import "UIImage+SJImage.h"

@implementation UIImage (SJImage)

- (UIImage *) imageWithTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn alpha:1];
}

- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor
{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay alpha:1];
}

-(UIImage *)imageWithTintColor:(UIColor *)tintColor alpha:(CGFloat)alpha{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay alpha:alpha];
}


- (UIImage *) imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha
{
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [[tintColor colorWithAlphaComponent:alpha] setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.f];
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}
@end
