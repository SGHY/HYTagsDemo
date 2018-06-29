//
//  HYTagsView.h
//  HYTagsDemo
//
//  Created by leve on 2018/5/3.
//  Copyright © 2018年 leve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYTagsFrameModel.h"

@interface HYTagsView : UIView
@property (nonatomic, strong) HYTagsFrameModel *tagsFrameModel;
/** 重新刷新数据*/
- (void)reloadData;
@end
