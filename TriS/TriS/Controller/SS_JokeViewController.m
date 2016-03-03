//
//  SS_JokeViewController.m
//  TriS
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 3Singles. All rights reserved.
//

#import "SS_JokeViewController.h"
#import "SS_JokeManager.h"
#import "SS_JokeModel.h"
#import "SS_JokeTableViewCell.h"
#import "MJRefresh.h"

static NSString *reuseIdenti = @"SS_JokeCell";
@interface SS_JokeViewController ()<UITableViewDataSource, UITableViewDelegate>

// TableView
@property (weak, nonatomic) IBOutlet UITableView *Joke_TableView;

// 刷新数据拼接url
@property (nonatomic, assign) NSInteger numOfUrl;

@end

@implementation SS_JokeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化为1
    _numOfUrl = 1;
    
    // 设置自动为滚动视图添加高度关闭
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 指定代理
    self.Joke_TableView.delegate = self;
    self.Joke_TableView.dataSource = self;
    
    // 注册cell
    [self.Joke_TableView registerNib:[UINib nibWithNibName:@"SS_JokeTableViewCell" bundle:nil] forCellReuseIdentifier:reuseIdenti];
    
    // 加载数据
    [[SS_JokeManager ShareInstance] dataWithJoke:@"http://japi.juhe.cn/joke/content/text.from?key=e4a3efd3c47bdf3aabf1fbd4309fd136&page=1&pagesize=10" didFinish:^{
        
        [self.Joke_TableView reloadData];
    }];
    
    self.Joke_TableView.separatorColor = [UIColor colorWithWhite:1.000 alpha:0.000];
    
    // cell自适应
    self.Joke_TableView.rowHeight = UITableViewAutomaticDimension;
    self.Joke_TableView.estimatedRowHeight = 10;
    
    // 设置滑动条为不显示
    self.Joke_TableView.showsVerticalScrollIndicator = NO;
    
    // 下拉刷新
    [self setUpRefresh];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 刷新
- (void)setUpRefresh {
    
    // 添加下拉刷新控件
    UIRefreshControl *downRefresh = [[UIRefreshControl alloc] init];
    [downRefresh addTarget:self action:@selector(refreshAction:) forControlEvents:UIControlEventValueChanged];
    
    [self.Joke_TableView addSubview:downRefresh];
    
    // 进入刷新状态(不会触发UIControlEventValueChanged事件)
    [downRefresh beginRefreshing];
    
    // 加载数据
    [self refreshAction:downRefresh];
    
    // 添加上拉刷新控件
    [self.Joke_TableView addFooterWithTarget:self action:@selector(footRefreshAction)];
    
}

#pragma mark 下拉刷新时进行的操作
- (void)refreshAction:(UIRefreshControl *)refresControl {
    
    // 清空数据
    [[SS_JokeManager ShareInstance] removeAllObjectWithArray];
    
    // 重新加载数据并刷新数据
    [[SS_JokeManager ShareInstance] dataWithJoke:@"http://japi.juhe.cn/joke/content/text.from?key=e4a3efd3c47bdf3aabf1fbd4309fd136&page=1&pagesize=10" didFinish:^{
        
        [self.Joke_TableView reloadData];
    }];
    
    // 关闭UIRefreshControl
    [refresControl endRefreshing];
}

#pragma mark 上拉时
- (void)footRefreshAction {
    
    _numOfUrl++;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [[SS_JokeManager ShareInstance] dataWithJoke:[NSString stringWithFormat:@"http://japi.juhe.cn/joke/content/text.from?key=e4a3efd3c47bdf3aabf1fbd4309fd136&page=%ld&pagesize=10", _numOfUrl] didFinish:^{
            
            [self.Joke_TableView reloadData];
        }];
        // 关闭刷新动画
        [self.Joke_TableView footerEndRefreshing];
    });
}

#pragma mark - 代理方法<UITableViewDataSource, UITableViewDelegate>

#pragma mark 返回cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[SS_JokeManager ShareInstance] numOfDataArray];
}

#pragma mark 返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SS_JokeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SS_JokeCell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = [[SS_JokeManager ShareInstance] modelWithIndex:indexPath.row];
    
    return cell;
}

#pragma mark 页面即将消失的时候
- (void)viewWillDisappear:(BOOL)animated {
    
    [[SS_JokeManager ShareInstance] removeAllObjectWithArray];
}

//#pragma mark 返回cell高度
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return 200;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
