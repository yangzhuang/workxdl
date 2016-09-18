//
//  wodebiaoxian.m
//  XDL
//
//  Created by reginet on 16/8/29.
//  Copyright © 2016年 ruiji. All rights reserved.
//

#import "wodebiaoxian.h"

@interface wodebiaoxian ()

@end

@implementation wodebiaoxian

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1];
    self.navigationItem.title = self.topname;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    self.navigationController.navigationBar.tintColor =[UIColor whiteColor];
    
    [self showHUD];
    
    shijian = [NSMutableArray new];
    kecheng = [NSMutableArray new];
    biaoxian = [NSMutableArray new];
    [self requesturl];
}
- (void)requesturl
{
    urlinfo * uif = [urlinfo new];
    uif.Delegate = self;
    [uif sendurlinfo:nil andurlstr:@"http://www.feifeifeixiang.com.cn/XDL/user/performance.php" withIdentifier:performance];
}
- (void)urldata:(NSMutableDictionary *)data withIdentifier:(RequestName)name
{
    for (NSDictionary * urlarr in data) {
        if (data!=nil)
        {
            [shijian addObject:[urlarr objectForKey:@"time"]];
            [kecheng addObject:[urlarr objectForKey:@"course"]];
            [biaoxian addObject:[urlarr objectForKey:@"action"]];
        }
        
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITableView * tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 85, self.view.frame.size.width, self.view.frame.size.height-49-85)];
    tab.delegate = self;
    tab.dataSource = self;
    tab.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tab];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (biaoxian.count==0)
    {
        return 1;
    }
    else
    {
        return biaoxian.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * yz = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:yz];
    if (cell ==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:yz];
    }
    for (UIView * sub in cell.contentView.subviews) {
        [sub removeFromSuperview];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITextView * tv = [[UITextView alloc]initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-20, 200)];
    if (biaoxian.count==0)
    {
        tv.text = @"无";
    }
    else
    {
        NSString * urlbiaoxian = [biaoxian objectAtIndex:indexPath.row];
        
        if ([urlbiaoxian isEqual:[NSNull null]]||[urlbiaoxian isEqualToString:@""]||urlbiaoxian==nil)
        {
            tv.text = @"无";
        }
        else
        {
            tv.text = urlbiaoxian;
        }
    }
    
    tv.font = [UIFont systemFontOfSize:15];
    tv.editable = NO;
    tv.layer.cornerRadius = 5;
    tv.layer.borderColor = [UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1].CGColor;
    tv.layer.borderWidth = 1;
    [cell.contentView addSubview:tv];
    
    
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(tv.frame.size.width/3, tv.frame.size.height-35, tv.frame.size.width/2, 30)];
    lab.textAlignment = NSTextAlignmentLeft;
    lab.textColor = [UIColor lightGrayColor];
    lab.font = [UIFont boldSystemFontOfSize:15];
    [tv addSubview:lab];
    
    UILabel * lab2 = [[UILabel alloc]initWithFrame:CGRectMake(tv.frame.size.width/1.2, tv.frame.size.height-35, tv.frame.size.width-tv.frame.size.width/3, 30)];
    lab2.textAlignment = NSTextAlignmentLeft;
    lab2.textColor = [UIColor lightGrayColor];
    lab2.font = [UIFont boldSystemFontOfSize:15];
    [tv addSubview:lab2];
    
    if (shijian.count!=0)
    {
        urlshijian = [shijian objectAtIndex:indexPath.row];
        NSTimeInterval timeaa=[urlshijian doubleValue];
        NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:timeaa];
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
        if ([currentDateStr isEqual:[NSNull null]]||[currentDateStr isEqualToString:@""]||currentDateStr==nil)
        {
            currentDateStr = @"无";
        }
        
        lab.text = currentDateStr;
    }
    
    if (kecheng.count!=0)
    {
        urlkecheng = [kecheng objectAtIndex:indexPath.row];
        if ([urlkecheng isEqual:[NSNull null]]||[urlkecheng isEqualToString:@""]||urlkecheng==nil)
        {
            urlkecheng = @"无";
        }
        
        lab2.text = urlkecheng;
    }
    
    [self stopHUD];
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 220;
}
- (void)showHUD
{
    HUD = [MBProgressHUD new];
    HUD.labelText = @"请稍后..";
    [HUD show:YES];
    [self.view addSubview:HUD];
    
}
- (void)stopHUD
{
    [HUD removeFromSuperview];
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
