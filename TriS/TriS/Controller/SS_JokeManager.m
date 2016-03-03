//
//  SS_JokeManager.m
//  TriS
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 3Singles. All rights reserved.
//

#import "SS_JokeManager.h"
#import "SS_JokeModel.h"

static SS_JokeManager *jokeManager; // 单例声明为静态变量 与程序共存
@interface SS_JokeManager ()

@property (nonatomic, strong) NSMutableArray *SS_JokeModelArray;

@end

@implementation SS_JokeManager

#pragma mark 懒加载
- (NSMutableArray *)SS_JokeModelArray {
    
    if (!_SS_JokeModelArray) {
        
        _SS_JokeModelArray = [NSMutableArray array];
    }
    return _SS_JokeModelArray;
}

#pragma mark 单例返回自身对象
+ (instancetype)ShareInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        jokeManager = [SS_JokeManager new];
    });
    
    return jokeManager;
}

#pragma mark 数据解析
- (void)dataWithJoke:(NSString *)Url didFinish:(void (^)())finish{
    
    // 解析数据
    NSURL *urlX = [NSURL URLWithString:Url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:urlX completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
//        NSLog(@"%ld", dic.count);
        
        NSDictionary *dict = dic[@"result"];
        
        for (NSDictionary *MDic in dict[@"data"]) {
            
            SS_JokeModel *model = [SS_JokeModel new];
            [model setValuesForKeysWithDictionary:MDic];
            NSLog(@"%@      %@", model.content, model.updatetime);
            [self.SS_JokeModelArray addObject:model];
//            NSLog(@"%ld", _SS_JokeModelArray.count);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            finish();
        });
    }];
    
    [task resume];
}

#pragma mark 返回数组中数据的个数
- (NSInteger)numOfDataArray {
    
    return _SS_JokeModelArray.count;
}

#pragma mark 根据传入的下标返回model
- (SS_JokeModel *)modelWithIndex:(NSInteger)index {
    
    return _SS_JokeModelArray[index];
}

#pragma mark 清空数组内所有内容
- (void)removeAllObjectWithArray {
    
    [self.SS_JokeModelArray removeAllObjects];
}

@end
