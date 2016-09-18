//
//  wodezuoye.m
//  XDL
//
//  Created by reginet on 16/8/29.
//  Copyright © 2016年 ruiji. All rights reserved.
//

#import "wodezuoye.h"

@interface wodezuoye ()

@end

@implementation wodezuoye

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1];
    self.navigationItem.title = self.topname;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    self.navigationController.navigationBar.tintColor =[UIColor whiteColor];
    
    [self showHUD];
    
    urlarr = [NSMutableArray new];
    [self requesturl];
}
- (void)requesturl
{
    NSString *  str = @"http://www.feifeifeixiang.com.cn/XDL/user/task.php";
    urlinfo * uif = [urlinfo new];
    uif.Delegate = self;
    [uif sendurlinfo:nil andurlstr:str withIdentifier:homework];
    
}
- (void)urldata:(NSMutableDictionary *)data withIdentifier:(RequestName)name
{
    for (NSArray * shujuarr in data) {
        if (data!=nil)
        {
            [urlarr addObject:shujuarr];
        }
        
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITableView * tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 85, self.view.frame.size.width, self.view.frame.size.height-49-85)];
    tab.delegate = self;
    tab.dataSource = self;
    tab.backgroundColor = [UIColor clearColor];
    tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tab];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (urlarr.count==0)
    {
        return 1;
    }
    else
    {
        return urlarr.count;
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    NSArray * arr = [NSArray arrayWithObjects:@"zuoye1",@"zuoye2",@"zuoye3", nil];
    
    UIImageView * imgview = [[UIImageView alloc]init];
    if (indexPath.row%3==0)
    {
        imgview.image = [UIImage imageNamed:[arr objectAtIndex:0]];
    }
    if (indexPath.row%3==1)
    {
        imgview.image = [UIImage imageNamed:[arr objectAtIndex:1]];
    }
    if (indexPath.row%3==2)
    {
        imgview.image = [UIImage imageNamed:[arr objectAtIndex:2]];
    }
    
    imgview.frame = CGRectMake(15, 0, self.view.frame.size.width-30, 160);
    [cell addSubview:imgview];
    
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(30, imgview.frame.size.height/5.5, imgview.frame.size.width-50, imgview.frame.size.height/1.5)];
    if (urlarr.count!=0)
    {
        NSString * urlstr = [urlarr objectAtIndex:indexPath.row];
        if ([urlstr isEqual:[NSNull null]]||[urlstr isEqualToString:@""]||urlstr==nil)
        {
            urlstr = @"无";
        }
        lab.text = urlstr;
    }
    else
    {
        lab.text = @"无";
    }
    
    lab.backgroundColor = [UIColor clearColor];
    lab.numberOfLines = 0;
    [imgview addSubview:lab];
    
    [self stopHUD];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
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
