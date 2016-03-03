//
//  SS_JokeManager.h
//  TriS
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 3Singles. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SS_JokeModel;
@interface SS_JokeManager : NSObject

/**
 * 单例返回自身对象
 */
+ (instancetype)ShareInstance;

/**
 * 解析数据
 */
- (void)dataWithJoke:(NSString *)Url didFinish:(void (^)())finish;

/**
 * 返回数组中数据的个数
 */
- (NSInteger)numOfDataArray;

/**
 * 根据传入的下标返回model
 */
- (SS_JokeModel *)modelWithIndex:(NSInteger)index;

/**
 * 清空数组内所有内容
 */
- (void)removeAllObjectWithArray;

@end
