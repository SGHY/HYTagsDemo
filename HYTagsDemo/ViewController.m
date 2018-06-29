//
//  ViewController.m
//  HYTagsDemo
//
//  Created by leve on 2018/5/3.
//  Copyright © 2018年 leve. All rights reserved.
//

#import "ViewController.h"
#import "HYTagsView.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btns;
@property (strong, nonatomic) HYTagsView *tagsView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    HYTagsFrameModel *model = [[HYTagsFrameModel alloc] initWithTagsAlignment:HYTagsAlignmentLeft];
    model.tagsArray = @[@"全部",@"钢琴",@"吉他",@"电吉他",@"小提琴",@"架子鼓",@"口琴",@"贝斯",@"卡祖笛",@"古筝",@"翻弹",@"音乐",@"指弹",@"千本樱",@"民乐",@"初音MIKU",@"ANIMENZ",@"PENBEAT",@"木吉他",@"二胡",@"COVER",@"交响",@"权御天下",@"普通DISCO",@"OP",@"ILEM",@"原创",@"作业用BGM",@"串烧",@"东方",@"合奏",@"燃向",@"触手",@"试奏",@"ACG指弹",@"武士桑",@"触手猴",@"BGM",@"LAUNCHPAD",@"吐槽",@"东方",@"FATE",@"多素材",@"新人向",@"丧心病狂",@"童年",@"数学",@"物理",@"英语",@"化学",@"地理",@"历史",@"生物",@"全部",@"国人女声",@"中文翻唱",@"英文翻唱",@"古风",@"粤语",@"原创曲",@"K",@"轻音少女",@"误解向",@"我们仍未知道那天所看见的花的名字",@"华语",@"黑岩射手",@"空之境界"];
    HYTagsView *tagsView = [[HYTagsView alloc] initWithFrame:CGRectMake(0, 100, WIDTH, 0)];
    tagsView.tagsFrameModel = model;
    [tagsView reloadData];
    [self.view addSubview:tagsView];
    self.tagsView = tagsView;
}
- (IBAction)btnClick:(id)sender {
    for (UIButton *btn in _btns) {
        btn.backgroundColor = [UIColor clearColor];
    }
    UIButton *btn = (UIButton *)sender;
    btn.backgroundColor = [UIColor redColor];
    
    if ([btn.currentTitle isEqualToString:@"左对齐"]) {
        if (self.tagsView.tagsFrameModel.tagsAlignment == HYTagsAlignmentLeft) {
            return;
        }
        self.tagsView.tagsFrameModel.tagsAlignment = HYTagsAlignmentLeft;
        [self.tagsView reloadData];
    }else if ([btn.currentTitle isEqualToString:@"左右对齐"]) {
        if (self.tagsView.tagsFrameModel.tagsAlignment == HYTagsAlignmentJustified) {
            return;
        }
        self.tagsView.tagsFrameModel.tagsAlignment = HYTagsAlignmentJustified;
        [self.tagsView reloadData];
    }else if ([btn.currentTitle isEqualToString:@"居中"]) {
        if (self.tagsView.tagsFrameModel.tagsAlignment == HYTagsAlignmentCenter) {
            return;
        }
        self.tagsView.tagsFrameModel.tagsAlignment = HYTagsAlignmentCenter;
        [self.tagsView reloadData];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
