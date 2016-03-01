//
//  LCKFirstViewController.m
//  TriS
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 3Singles. All rights reserved.
//

#import "LCKFirstViewController.h"

@interface LCKFirstViewController ()
// 背景图片
@property (weak, nonatomic) IBOutlet UIImageView *backImage;

@end

@implementation LCKFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

#pragma mark - 界面即将加载时调用
- (void)viewWillAppear:(BOOL)animated{
    // 添加背景图片
    self.backImage.image = [UIImage imageNamed:@"back_5"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
