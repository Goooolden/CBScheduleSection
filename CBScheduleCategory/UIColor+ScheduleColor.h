//
//  UIColor+ScheduleColor.h
//  CombancScheduleSection
//
//  Created by Golden on 2019/5/22.
//  Copyright © 2019 Golden. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (ScheduleColor)

@property (nonatomic, readonly) CGFloat red;
@property (nonatomic, readonly) CGFloat green;
@property (nonatomic, readonly) CGFloat blue;
@property (nonatomic, readonly) CGFloat alpha;

+ (UIColor *)colorWithHex:(NSString *)hexColor;
+ (UIColor *)colorWithRandom6;
+ (UIColor *)colorWithRandom;
- (UIColor *)colorByAddRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;
- (UIColor *)colorByMinusRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;
+ (UIColor *)colorWithHexColor:(unsigned long)col;

@end

NS_ASSUME_NONNULL_END
