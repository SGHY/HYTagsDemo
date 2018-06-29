//
//  HYTagsFrameModel.h
//  HYTagsDemo
//
//  Created by leve on 2018/5/3.
//  Copyright © 2018年 leve. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#define TagsTitleFont [UIFont systemFontOfSize:14]

typedef NS_ENUM(NSUInteger,HYTagsAlignmentType) {
    HYTagsAlignmentLeft,//左对齐
    HYTagsAlignmentCenter,//居中对齐
    HYTagsAlignmentJustified,//左右对齐
};
@interface HYTagsFrameModel : NSObject
- (instancetype)initWithTagsAlignment:(HYTagsAlignmentType)tagsAlignment;
/** 给所有标签分配好约束 */
- (void)getTagsFrame;
/** 标签排列方式 */
@property (assign, nonatomic) HYTagsAlignmentType tagsAlignment;
/** 标签名字数组 */
@property (nonatomic, strong) NSArray *tagsArray;
/** 标签frame数组 */
@property (nonatomic, strong) NSMutableArray *tagsFrames;
/** 全部标签的高度 */
@property (nonatomic, assign) CGFloat tagsHeight;
/** 标签间距 default is 10*/
@property (nonatomic, assign) CGFloat tagsMargin;
/** 标签行间距 default is 6*/
@property (nonatomic, assign) CGFloat tagsLineSpacing;
/** 标签最小内边距 default is 6*/
@property (nonatomic, assign) CGFloat tagsMinPadding;
/** 单个标签的高度 default is 28*/
@property (nonatomic, assign) CGFloat singleTagHeight;
@end
