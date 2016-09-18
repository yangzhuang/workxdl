//
//  jibenxinxi.m
//  XDL
//
//  Created by reginet on 16/8/29.
//  Copyright © 2016年 ruiji. All rights reserved.
//

#import "jibenxinxi.h"
#import "ViewController.h"
@interface jibenxinxi ()

@end

@implementation jibenxinxi

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1];
    self.navigationItem.title = self.topname;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    self.navigationController.navigationBar.tintColor =[UIColor whiteColor];
    
    
    
    self.userid =[[ViewController defaultvc]userid];
    
    [self requesturl];
}
- (void)requesturl
{
    NSString * str = @"http://www.feifeifeixiang.com.cn/XDL/user/basic.php";
    
    urlinfo * uif = [urlinfo new];
    [uif sendurlinfo:nil andurlstr:str withIdentifier:Information];
    uif.Delegate = self;
    [self showHUD];
}
- (void)urldata:(NSMutableDictionary *)data withIdentifier:(RequestName)name
{
    NSString * myname = [data objectForKey:@"name"];
    NSString * english = [data objectForKey:@"english"];
    NSString * birthday = [data objectForKey:@"birthday"];
    NSString * insurance = [data objectForKey:@"insurance"];
    xinxiarr = [NSArray arrayWithObjects:myname,english,birthday,insurance, nil];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 75, self.view.frame.size.width, 175)];
    tab.delegate = self;
    tab.dataSource = self;
    tab.scrollEnabled = NO;
    [self.view addSubview:tab];
    
    //补全table下划线
    [tab setSeparatorInset:UIEdgeInsetsZero];
    [tab setLayoutMargins:UIEdgeInsetsZero];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * yz = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:yz];
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:yz];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray * arr = [NSArray arrayWithObjects:@"姓名",@"英文名",@"出生日期",@"保险单号",@"王伟",@"David",@"2002年4月2日",@"02115487551", nil];
    cell.textLabel.text = [arr objectAtIndex:indexPath.row];
    
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-150, cell.contentView.frame.size.height/2-15, 140, 30)];
    NSString * xinxi = [xinxiarr objectAtIndex:indexPath.row];

    if ([xinxi isEqual:[NSNull null]]||[xinxi isEqualToString:@""]||xinxi==nil)
    {
        lab.text = @"无";
    }
    else
    {
        lab.text = xinxi;
    }
    
    lab.textColor = [UIColor lightGrayColor];
    lab.textAlignment = NSTextAlignmentRight;
    [cell addSubview:lab];
    [self stopHUD];
    return cell;
}
//下划线对齐
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [cell setSeparatorInset:UIEdgeInsetsZero];
    
    [cell setLayoutMargins:UIEdgeInsetsZero];
    
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
