//
//  Clipper2Wrapper.m
//  LPAlgorithm
//
//  Created by 黄耀红 on 2025/2/13.
//

#import "Clipper2Wrapper.h"
//#import "clipper2/clipper.h"
#import "clipper.h"
//#import ""
//#import "Clipper2Lib/include/clipper2/clipper.h"

/**
 https://github.com/lrtitze/Swift-VectorBoolean
 https://github.com/adamwulf/ClippingBezier
 https://github.com/verven/contourklip
 https://github.com/AngusJohnson/Clipper2/tree/main/CPP/Clipper2Lib
 https://github.com/iShape-Swift/iOverlay?tab=readme-ov-file
 */


using namespace Clipper2Lib;

@implementation Clipper2Wrapper

+ (CGPathRef)v3_xorPathWithPath1:(CGPathRef)path1 path2:(CGPathRef)path2 {
    // 转换 CGPath 到 Clipper2 PathD
    PathsD subject, clip;
    
    // 转换 path1 和 path2
    auto convertCGPathToClipper = [](CGPathRef cgPath, PathsD &paths) {
        CGPathApply(cgPath, &paths, [](void *info, const CGPathElement *element) {
            PathsD *paths = static_cast<PathsD *>(info);
            if (element->type == kCGPathElementMoveToPoint) {
                paths->push_back(PathD{});
                paths->back().push_back(PointD(element->points[0].x, element->points[0].y));
            } else if (element->type == kCGPathElementAddLineToPoint) {
                paths->back().push_back(PointD(element->points[0].x, element->points[0].y));
            } else if (element->type == kCGPathElementCloseSubpath) {
                // 闭合路径
            }
        });
    };
    
    convertCGPathToClipper(path1, subject);
    convertCGPathToClipper(path2, clip);
    
    
    
    
    // 计算 XOR
    PathsD solution = BooleanOp(ClipType::Xor, FillRule::EvenOdd, subject, clip);
    //    PathsD solution = BooleanOp(ClipType::Xor, subject, clip, FillRule::EvenOdd);
    
    // 转换 Clipper2 PathD 到 CGMutablePathRef
    CGMutablePathRef resultPath = CGPathCreateMutable();
    for (const auto &subpath : solution) {
        if (!subpath.empty()) {
            CGPathMoveToPoint(resultPath, NULL, subpath[0].x, subpath[0].y);
            for (size_t i = 1; i < subpath.size(); i++) {
                CGPathAddLineToPoint(resultPath, NULL, subpath[i].x, subpath[i].y);
            }
            CGPathCloseSubpath(resultPath);
        }
    }
    
    
    return resultPath;
//    return NULL;
}


+ (CGPathRef)xorPathWithPath1:(CGPathRef)path1 path2:(CGPathRef)path2 {
    auto subjPaths = [Clipper2Wrapper toPathsFromCGPath:path1];
    auto clipPaths = [Clipper2Wrapper toPathsFromCGPath:path2];
    Clipper2Lib::Paths64 solution = Clipper2Lib::Xor(subjPaths, clipPaths, Clipper2Lib::FillRule::EvenOdd);
    return [Clipper2Wrapper fromPathsToCGPath:solution];
}

+ (CGPathRef)unionPathWithPath1:(CGPathRef)path1 path2:(CGPathRef)path2 {
    auto subjPaths = [Clipper2Wrapper toPathsFromCGPath:path1];
    auto clipPaths = [Clipper2Wrapper toPathsFromCGPath:path2];
    Clipper2Lib::Paths64 solution = Clipper2Lib::Union(subjPaths, clipPaths, Clipper2Lib::FillRule::NonZero);
    return [Clipper2Wrapper fromPathsToCGPath:solution];
}

+ (CGPathRef)differencePathWithPath1:(CGPathRef)path1 path2:(CGPathRef)path2 {
    auto subjPaths = [Clipper2Wrapper toPathsFromCGPath:path1];
    auto clipPaths = [Clipper2Wrapper toPathsFromCGPath:path2];
    Clipper2Lib::Paths64 solution = Clipper2Lib::Difference(subjPaths, clipPaths, Clipper2Lib::FillRule::NonZero);
    return [Clipper2Wrapper fromPathsToCGPath:solution];
}

+ (CGPathRef)intersectionPathWithPath1:(CGPathRef)path1 path2:(CGPathRef)path2 {
    auto subjPaths = [Clipper2Wrapper toPathsFromCGPath:path1];
    auto clipPaths = [Clipper2Wrapper toPathsFromCGPath:path2];
    Clipper2Lib::Paths64 solution = Clipper2Lib::Intersect(subjPaths, clipPaths, Clipper2Lib::FillRule::NonZero);
    return [Clipper2Wrapper fromPathsToCGPath:solution];
}

void CGPathApplierFunction2(void *info, const CGPathElement *element) {
    auto *path = static_cast<Clipper2Lib::Path64 *>(info);
    CGPoint *points = element->points;

    switch (element->type) {
        case kCGPathElementMoveToPoint:
            path->emplace_back(points[0].x, points[0].y);
            break;
        case kCGPathElementAddLineToPoint:
            path->emplace_back(points[0].x, points[0].y);
            break;
        case kCGPathElementAddQuadCurveToPoint:
            // Clipper doesn't support quadratic curves directly, you might need to approximate them with lines
            break;
        case kCGPathElementAddCurveToPoint:
            // Clipper doesn't support cubic curves directly, you might need to approximate them with lines
            break;
        case kCGPathElementCloseSubpath:
            // Close the current subpath
            break;
    }
}

+ (Clipper2Lib::Paths64)toPathsFromCGPath:(CGPathRef)cgPath {
    Clipper2Lib::Paths64 paths;
    Clipper2Lib::Path64 path;
    
    CGPathApply(cgPath, &path, CGPathApplierFunction2);
    
    if (!path.empty()) {
        paths.push_back(path);
    }
    
    return paths;
}

+ (CGPathRef)fromPathsToCGPath:(const Clipper2Lib::Paths64 &)paths {
    CGMutablePathRef cgPath = CGPathCreateMutable();
    
    for (const auto &path : paths) {
        if (path.empty()) continue;
        
        auto it = path.begin();
        CGPathMoveToPoint(cgPath, nullptr, it->x, it->y);
        ++it;
        
        for (; it != path.end(); ++it) {
            CGPathAddLineToPoint(cgPath, nullptr, it->x, it->y);
        }
        
        CGPathCloseSubpath(cgPath);
    }
    
    return cgPath;
}

@end
