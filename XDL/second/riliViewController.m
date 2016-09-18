//
//  riliViewController.m
//  XDL
//
//  Created by reginet on 16/9/13.
//  Copyright © 2016年 ruiji. All rights reserved.
//

#import "riliViewController.h"
#import "YQCalendarView.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface riliViewController ()

@end

@implementation riliViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1];
    self.navigationItem.title = @"上课日期";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    
    [self timerurl];

}
- (void)timerurl
{
    urlinfo * uif = [urlinfo new];
    uif.Delegate = self;
    [uif sendurlinfo:nil andurlstr:@"http://www.feifeifeixiang.com.cn/XDL/user/time.php" withIdentifier:shangketime];
}
- (void)urldata:(NSMutableDictionary *)data withIdentifier:(RequestName)name
{
    YQCalendarView *view = [[YQCalendarView alloc]initWithFrame:CGRectMake(20,
                                                                           100,
                                                                           self.view.frame.size.width-40,
                                                                           300)];
    
    for (NSString * time in data) {
        [view.selectedArray addObject:time];
    }
    
   
    [self.view addSubview:view];
    
    //设置选中的日期，格式 yyyy-MM-dd (数组)
//    view.selectedArray = @[@"2016-08-23",
//                           @"2016-08-21",
//                           @"2016-08-20",
//                           @"2016-08-15",
//                           @"2016-08-12",
//                           @"2016-08-05",
//                           @"2016-07-26",
//                           @"2016-07-29",
//                           @"2016-09-14",
//                           @"2016-09-20",
//                           @"2016-09-23",
//                           ];
    
    //单独添加选中个某一天
    [view AddToChooseOneDay:@"2016-8-10"];
    view.dayFont           = [UIFont systemFontOfSize:14];
    
    //--------------------------------------------------自定义显示
    /*
     
     //整体背景色
     view.backgroundColor   = [UIColor blueColor];
     //选中的日期的背景颜色
     view.selectedBackColor = [UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1];
     //选中的日期下方的图标
     view.selectedIcon      = [UIImage imageNamed:@""];
     //下一页按钮的图标
     view.nextBTNIcon       = [UIImage imageNamed:@""];
     //前一页按钮的图标
     view.preBTNIcon        = [UIImage imageNamed:@""];
     //上方日期标题的字体
     view.titleFont         = [UIFont systemFontOfSize:17];
     //上方日期标题的颜色
     view.titleColor        = [UIColor blackColor];
     //下方日历的每一天的字体
     view.dayFont           = [UIFont systemFontOfSize:17];
     //下方日历的每一天的字体颜色
     view.dayColor          = [UIColor blackColor];
     
     */

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
