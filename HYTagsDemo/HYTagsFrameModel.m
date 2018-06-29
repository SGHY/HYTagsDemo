//
//  HYTagsFrameModel.m
//  HYTagsDemo
//
//  Created by leve on 2018/5/3.
//  Copyright © 2018年 leve. All rights reserved.
//

#import "HYTagsFrameModel.h"

@implementation HYTagsFrameModel
- (instancetype)initWithTagsAlignment:(HYTagsAlignmentType)tagsAlignment
{
    self = [super init];
    if (self) {
        _tagsFrames = [NSMutableArray array];
        _tagsMargin = 10;
        _tagsLineSpacing = 6;
        _tagsMinPadding = 6;
        _singleTagHeight = 28;
        _tagsAlignment = tagsAlignment;
    }
    return self;
}
- (void)getTagsFrame
{
    [_tagsFrames removeAllObjects];
    /*思想：
     *计算多个标签的位置
     *标签根据文字自适应宽度
     *每行标签左右对齐，那么每行超过的宽度平均分配给每个标签
     *每一行标签居中显示，那么首尾标签行间距增加 超过的宽度/2
     */
    CGFloat btnX = _tagsMargin;//记录当前标签的x坐标
    CGFloat btnW = 0;//记录当前标签的宽度
    
    CGFloat nextWidth = 0;  // 下一个标签的宽度
    CGFloat moreWidth = 0;  // 每一行多出来的宽度
    
    /**
     *  每一行的最后一个tag的索引的数组和每一行多出来的宽度的数组
     */
    NSMutableArray *lastIndexs = [NSMutableArray array];
    NSMutableArray *moreWidths = [NSMutableArray array];
    
    for (NSInteger i=0; i<_tagsArray.count; i++) {
        
        //计算当前标签的宽度
        btnW = [self sizeWithText:_tagsArray[i] font:TagsTitleFont].width + _tagsMinPadding * 2;
        
        if (i < _tagsArray.count-1) {
            //计算下一个标签的宽度
            nextWidth = [self sizeWithText:_tagsArray[i+1] font:TagsTitleFont].width + _tagsMinPadding * 2;
        }
        //计算下一个标签的x坐标
        CGFloat nextBtnX = btnX + btnW + _tagsMargin;
        // 超出了要换行或最后一个标签换行
        if ((nextBtnX + nextWidth) > (WIDTH - _tagsMargin) || i == _tagsArray.count -1) {
            // 计算超过的宽度
            moreWidth = WIDTH - nextBtnX;
            
            [lastIndexs addObject:[NSNumber numberWithInteger:i]];
            [moreWidths addObject:[NSNumber numberWithFloat:moreWidth]];
            
            btnX = _tagsMargin;
        }else{
            btnX += (btnW + _tagsMargin);
        }
    }
    
    NSInteger location = 0;  // 截取的位置
    NSInteger length = 0;    // 截取的长度 每行多少个标签
    CGFloat moreMargin = 0;    // 首尾多出来的平均间距
    
    CGFloat tagW = 0;//记录标签的宽度
    CGFloat tagH = _singleTagHeight;//每个标签的高度
    
    for (NSInteger i=0; i<lastIndexs.count; i++) {
        
        NSInteger lastIndex = [lastIndexs[i] integerValue];
        if (i == 0) {
            length = lastIndex + 1;
        }else{
            length = [lastIndexs[i] integerValue]-[lastIndexs[i-1] integerValue];
        }
        
        // 从数组中截取每一行的数组
        NSArray *newArr = [_tagsArray subarrayWithRange:NSMakeRange(location, length)];
        location = lastIndex + 1;
        
        switch (_tagsAlignment) {
            case HYTagsAlignmentLeft:
            {
                //每一行标签左对齐
                CGFloat tagX = _tagsMargin;//标签x坐标
                CGFloat tagY = _tagsLineSpacing + (_tagsLineSpacing + tagH) * i;//标签y坐标
                
                for (NSInteger j=0; j<newArr.count; j++) {
                    
                    tagW = [self sizeWithText:newArr[j] font:TagsTitleFont].width + _tagsMinPadding * 2;
                    
                    CGRect btnF = CGRectMake(tagX, tagY, tagW, tagH);
                    
                    [_tagsFrames addObject:NSStringFromCGRect(btnF)];
                    
                    tagX += tagW+_tagsMargin;
                }
            }
                break;
            case HYTagsAlignmentCenter:
            {
                //每一行标签居中显示 首尾标签行间距增加moreMargin
                moreMargin = [moreWidths[i] floatValue]/2;
                
                CGFloat tagX = _tagsMargin + moreMargin;//标签x坐标
                CGFloat tagY = _tagsLineSpacing + (_tagsLineSpacing + tagH) * i;//标签y坐标
                
                for (NSInteger j=0; j<newArr.count; j++) {
                    
                    tagW = [self sizeWithText:newArr[j] font:TagsTitleFont].width + _tagsMinPadding * 2;
                    
                    CGRect btnF = CGRectMake(tagX, tagY, tagW, tagH);
                    
                    [_tagsFrames addObject:NSStringFromCGRect(btnF)];
                    
                    tagX += tagW+_tagsMargin;
                }
            }
                break;
            case HYTagsAlignmentJustified:
            {
                //每行超过的宽度平均分配给每个标签 每个标签增加averageW
                CGFloat averageW = [moreWidths[i] floatValue]/newArr.count;
                
                CGFloat tagX = _tagsMargin;
                CGFloat tagY = _tagsLineSpacing + (_tagsLineSpacing + tagH) * i;
                
                for (NSInteger j=0; j<newArr.count; j++) {
                    
                    tagW = [self sizeWithText:newArr[j] font:TagsTitleFont].width + _tagsMinPadding * 2 + averageW;
                    
                    CGRect btnF = CGRectMake(tagX, tagY, tagW, tagH);
                    
                    [_tagsFrames addObject:NSStringFromCGRect(btnF)];
                    
                    tagX += (tagW+_tagsMargin);
                }
            }
                break;
            default:
                break;
        }
    }
    
    _tagsHeight = (tagH + _tagsLineSpacing) * lastIndexs.count + _tagsLineSpacing;
}

/**
 *  单行文本数据获取宽高
 *
 *  @param text 文本
 *  @param font 字体
 *
 *  @return 宽高
 */
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text sizeWithAttributes:attrs];
}
@end
