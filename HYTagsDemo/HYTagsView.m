//
//  HYTagsView.m
//  HYTagsDemo
//
//  Created by leve on 2018/5/3.
//  Copyright © 2018年 leve. All rights reserved.
//

#import "HYTagsView.h"

@implementation HYTagsView
- (void)reloadData
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagsFrameModel getTagsFrame];
    self.frame = CGRectMake(0, self.frame.origin.y, WIDTH, self.tagsFrameModel.tagsHeight);
    for (NSInteger i=0; i<self.tagsFrameModel.tagsArray.count; i++) {
        UIButton *tagsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [tagsBtn setTitle:self.tagsFrameModel.tagsArray[i] forState:UIControlStateNormal];
        [tagsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        tagsBtn.titleLabel.font = TagsTitleFont;
        [tagsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        tagsBtn.backgroundColor = [UIColor colorWithRed:148/255.0 green:174/255.0 blue:1.0 alpha:1];
        tagsBtn.layer.cornerRadius = 4;
        tagsBtn.layer.masksToBounds = YES;
        
        tagsBtn.frame = CGRectFromString(self.tagsFrameModel.tagsFrames[i]);
        
        [self addSubview:tagsBtn];
    }
}
@end
