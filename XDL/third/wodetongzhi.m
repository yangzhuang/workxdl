//
//  wodetongzhi.m
//  XDL
//
//  Created by reginet on 16/8/29.
//  Copyright © 2016年 ruiji. All rights reserved.
//

#import "wodetongzhi.h"

@interface wodetongzhi ()

@end

@implementation wodetongzhi
- (void)viewWillAppear:(BOOL)animated
{
    [self requesturl];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1];
    self.navigationItem.title = self.topname;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    self.navigationController.navigationBar.tintColor =[UIColor whiteColor];
    
    
}
- (void)requesturl
{
    [self showHUD];
    urlinfo * uif = [urlinfo new];
    uif.Delegate = self;
    [uif sendurlinfo:nil andurlstr:@"http://www.feifeifeixiang.com.cn/XDL/user/tongzhi.php" withIdentifier:tongzhi];
}
- (void)urldata:(NSMutableDictionary *)data withIdentifier:(RequestName)name
{
    action = [NSMutableArray new];
    teachername = [NSMutableArray new];
    time = [NSMutableArray new];
    for (NSMutableDictionary * dic in data) {
        [action addObject:[dic objectForKey:@"action"]];
        [teachername addObject:[dic objectForKey:@"name"]];
        [time addObject:[dic objectForKey:@"time"]];
    }
    [self table];
}
- (void)table
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 85, self.view.frame.size.width, self.view.frame.size.height-49-85)];
    tab.delegate = self;
    tab.dataSource = self;
    tab.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tab];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (teachername.count==0)
    {
        return 1;
    }
    else
    {
        return teachername.count;
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
    tv.font = [UIFont systemFontOfSize:15];
    tv.editable = NO;
    tv.layer.cornerRadius = 5;
    tv.layer.borderColor = [UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1].CGColor;
    tv.layer.borderWidth = 1;
    [cell.contentView addSubview:tv];
    
    if (teachername.count==0)
    {
        tv.text = @"无";
    }
    else
    {
        NSString * urlbiaoxian = [teachername objectAtIndex:indexPath.row];
        if ([urlbiaoxian isEqual:[NSNull null]]||[urlbiaoxian isEqualToString:@""]||urlbiaoxian==nil)
        {
            tv.text = @"无";
        }
        else
        {
            tv.text = urlbiaoxian;
        }
        
        UILabel * actionlab = [[UILabel alloc]initWithFrame:CGRectMake(25, 35, tv.frame.size.width-37, tv.frame.size.height-65)];
        actionlab.numberOfLines = 0;
        NSString * actionstr = [action objectAtIndex:indexPath.row];
        if ([actionstr isEqual:[NSNull null]]||[actionstr isEqualToString:@""]||actionstr==nil)
        {
            actionlab.text = @"无";
        }
        else
        {
            actionlab.text = actionstr;
        }
        [tv addSubview:actionlab];
        
        UILabel * timelab = [[UILabel alloc]initWithFrame:CGRectMake(tv.frame.size.width/2.2, 168, tv.frame.size.width/2, 30)];
        timelab.font = [UIFont systemFontOfSize:14];
        NSString * timestr = [time objectAtIndex:indexPath.row];
        
        NSTimeInterval timeaa=[timestr doubleValue];
        NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:timeaa];
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
        
        if ([currentDateStr isEqual:[NSNull null]]||[currentDateStr isEqualToString:@""]||currentDateStr==nil)
        {
            timelab.text = @"无";
        }
        else
        {
            timelab.text = currentDateStr;
        }
        [tv addSubview:timelab];
        
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
