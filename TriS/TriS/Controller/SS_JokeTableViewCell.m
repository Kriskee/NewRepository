//
//  SS_JokeTableViewCell.m
//  TriS
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 3Singles. All rights reserved.
//

#import "SS_JokeTableViewCell.h"
#import "SS_JokeModel.h"

@interface SS_JokeTableViewCell ()

// 用于显示笑话的Label
@property (weak, nonatomic) IBOutlet UILabel *SS_JokeLabel;

// 用于显示笑话发布的时间
@property (weak, nonatomic) IBOutlet UILabel *SS_TimeLabel;

// cell的背景图片
//@property (weak, nonatomic) IBOutlet UIImageView *backImage;

@end

@implementation SS_JokeTableViewCell

// 重写setModel方法
- (void)setModel:(SS_JokeModel *)model {
    
    // 笑话内容
    self.SS_JokeLabel.text = model.content;
    
    // 笑话发布时间
    self.SS_TimeLabel.text = model.updatetime;
    
    // 背景图片
//    self.backImage.contentMode = 1;
//    self.backImage.image = [UIImage imageNamed:@"SS_JokeBack.png"];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
