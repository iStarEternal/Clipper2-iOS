//
//  Clipper2Wrapper.h
//  LPAlgorithm
//
//  Created by 黄耀红 on 2025/2/13.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

NS_ASSUME_NONNULL_BEGIN

@interface Clipper2Wrapper : NSObject

+ (CGPathRef)v3_xorPathWithPath1:(CGPathRef)path1 path2:(CGPathRef)path2;

+ (CGPathRef)xorPathWithPath1:(CGPathRef)path1 path2:(CGPathRef)path2;

+ (CGPathRef)unionPathWithPath1:(CGPathRef)path1 path2:(CGPathRef)path2;

+ (CGPathRef)differencePathWithPath1:(CGPathRef)path1 path2:(CGPathRef)path2;

+ (CGPathRef)intersectionPathWithPath1:(CGPathRef)path1 path2:(CGPathRef)path2;

@end

NS_ASSUME_NONNULL_END
