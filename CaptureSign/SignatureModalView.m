//
//  SignatureModalView.m
//  CaptureSign
//
//  Created by ArunMak on 31/08/18.
//  Copyright © 2018 ArunMak. All rights reserved.
//

#import "SignatureModalView.h"
#import <QuartzCore/QuartzCore.h>

#define SIGN_PATH  @"sign_path"

static CGPoint midpoint(CGPoint p0, CGPoint p1) {
    return (CGPoint) {
        (p0.x + p1.x) / 2.0,
        (p0.y + p1.y) / 2.0
    };
}

@implementation SignatureModalView


- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) [self initialize];
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) [self initialize];
    return self;
}

- (void)initialize {
    
    signPath = [UIBezierPath bezierPath];
    [signPath setLineWidth:2.0];
    [signPath setLineCapStyle:kCGLineCapRound];
    [signPath setLineJoinStyle:kCGLineJoinRound];
    
    
    UITapGestureRecognizer *tapReconizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapReconizer:)];
    [tapReconizer setNumberOfTouchesRequired : 1];
    [tapReconizer setNumberOfTapsRequired: 1];
    [self addGestureRecognizer:tapReconizer];
    
   
    UIPanGestureRecognizer *panReconizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panReconizer:)];
    panReconizer.maximumNumberOfTouches = panReconizer.minimumNumberOfTouches = 1;
    [self addGestureRecognizer:panReconizer];
    
    
}

- (void)captureSign {
    [_pathArray addObject:signPath];
    NSData *saveData = [NSKeyedArchiver archivedDataWithRootObject:_pathArray];
    [[NSUserDefaults standardUserDefaults] setObject:saveData forKey:SIGN_PATH];
    [[NSUserDefaults standardUserDefaults] synchronize];
   
}

- (UIImage *)signImage  {
    UIGraphicsBeginImageContext(self.bounds.size);
    for (UIBezierPath *path in self.pathArray) {
        [self.lineColor setStroke];
        [path stroke];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //we are first getting the image from a drawn view and cropping the bezier path alone below 
    UIImage *cropPathImage = [self cropImage:image withPath:signPath];
    
    return cropPathImage;
}

-(UIImage*) cropImage:(UIImage*)image withPath:(UIBezierPath*)path {
    CGRect r = CGPathGetBoundingBox(path.CGPath);
    UIGraphicsBeginImageContextWithOptions(r.size, NO, image.scale);     CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(ctx, -r.origin.x, -r.origin.y);
    CGContextAddPath(ctx, path.CGPath);
    CGContextClip(ctx);
    
    [image drawInRect:(CGRect){CGPointZero, image.size}];
    
    UIImage* i = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return i;
}



- (UIColor *)lineColor {
    if (_lineColor == nil) {
        _lineColor = [UIColor blackColor];
    }
    return _lineColor;
}

- (CGFloat)lineWidth {
    if (_lineWidth == 0) {
        _lineWidth = 1;
    }
    return _lineWidth;
}

- (NSMutableArray *)pathArray {
    if (_pathArray == nil) {
        _pathArray = [NSMutableArray new];
    }
    return _pathArray;
}


- (NSArray *)backgroundLines {
    if (backgroundLines == nil) {
        CGFloat width = self.bounds.size.width;
        CGFloat height = self.bounds.size.height;
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        CGFloat bottom = 0.90;
        {
            CGFloat x1 = 0;
            CGFloat x2 = width;
            
            CGFloat y1 = height*bottom;
            CGFloat y2 = height*bottom;
            
            [path moveToPoint:CGPointMake(x1, y1)];
            [path addLineToPoint:CGPointMake(x2, y2)];
        }
        
        backgroundLines = @[path];
    }
    return backgroundLines;
}




- (void)tapReconizer:(UITapGestureRecognizer *)tab {
    
    CGPoint currentPoint = [tab locationInView:self];
    
    CGPoint prevPoint = CGPointMake(currentPoint.x, currentPoint.y-2);
    CGPoint midPoint = midpoint(currentPoint, prevPoint);
    [signPath moveToPoint:currentPoint];
    [signPath addLineToPoint:midPoint];
    
    [self setNeedsDisplay];
}


- (void)panReconizer:(UIPanGestureRecognizer *)pan {
    
    CGPoint currentPoint = [pan locationInView:self];
    CGPoint midPoint = midpoint(currentPoint, previousPoint);
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            [signPath moveToPoint:currentPoint];
            break;
            
        case UIGestureRecognizerStateChanged:
            [signPath addQuadCurveToPoint:midPoint controlPoint:previousPoint];
            break;
            
        case UIGestureRecognizerStateRecognized:
            [signPath addQuadCurveToPoint:midPoint controlPoint:previousPoint];
            break;
            
        case UIGestureRecognizerStatePossible:
            [signPath addQuadCurveToPoint:midPoint controlPoint:previousPoint];
            break;
            
        default:
            break;
    }
    
    previousPoint = currentPoint;
    
    [self setNeedsDisplay];
}

- (void)erase {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SIGN_PATH];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [_pathArray removeAllObjects];
    signPath = [UIBezierPath bezierPath];
    [signPath setLineWidth:2.0];
    [signPath setLineCapStyle:kCGLineCapRound];
    [signPath setLineJoinStyle:kCGLineJoinRound];
    [self setNeedsDisplay];
}

- (BOOL)signatureExists {
    return self.pathArray.count > 0;
}



- (void)drawRect:(CGRect)rect {
    [[UIColor whiteColor] setFill];
    CGContextFillRect(UIGraphicsGetCurrentContext(), rect);
    
    for (UIBezierPath *path in self.backgroundLines) {
        [[[UIColor blackColor] colorWithAlphaComponent:0.2] setStroke];
        [path stroke];
    }
    
   
    for (UIBezierPath *path in self.pathArray) {
        [self.lineColor setStroke];
        [path stroke];
    }
    
    [self.lineColor setStroke];
    [signPath stroke];
}


@end
