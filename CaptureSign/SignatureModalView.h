//
//  SignatureModalView.h
//  CaptureSign
//
//  Created by ArunMak on 31/08/18.
//  Copyright © 2018 ArunMak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignatureModalView : UIView{
    CGPoint previousPoint;
    UIBezierPath *signPath;
    NSArray *backgroundLines;
}

@property (nonatomic, strong, nonnull) NSMutableArray *pathArray;
@property (nonatomic, strong, nullable) UIColor *lineColor;
@property (nonatomic) CGFloat lineWidth;
@property (nonatomic, readonly) BOOL signatureExists;

- (void)captureSign;
- (UIImage*_Nullable)signImage;
- (void)erase;
@end
