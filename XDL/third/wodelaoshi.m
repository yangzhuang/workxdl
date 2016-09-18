//
//  wodelaoshi.m
//  XDL
//
//  Created by reginet on 16/8/29.
//  Copyright © 2016年 ruiji. All rights reserved.
//

#import "wodelaoshi.h"

@interface wodelaoshi ()

@end

@implementation wodelaoshi

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1];
    self.navigationItem.title = self.topname;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    self.navigationController.navigationBar.tintColor =[UIColor whiteColor];
    
    [self showHUD];
    
    touxiangimg = [NSMutableArray new];
    text = [NSMutableArray new];
    myname = [NSMutableArray new];
    
    [self requesturl];
}
- (void)requesturl
{
    urlinfo * uif = [urlinfo new];
    uif.Delegate = self;
    [uif sendurlinfo:nil andurlstr:@"http://www.feifeifeixiang.com.cn/XDL/user/teacher.php" withIdentifier:teacher];
}
- (void)urldata:(NSMutableDictionary *)data withIdentifier:(RequestName)name
{
    for (NSDictionary * dic in data) {
        [myname addObject:[dic objectForKey:@"name"]];
        NSString * pinjie = [NSString stringWithFormat:@"http://www.feifeifeixiang.com.cn/XDL/uploadimg/%@",[dic objectForKey:@"img"]];
        NSURL * urll = [NSURL URLWithString:pinjie];
        NSData * ddd = [NSData dataWithContentsOfURL:urll];
        if (ddd!=nil)
        {
            [touxiangimg addObject:ddd];
        }
        
        [text addObject:[dic objectForKey:@"text"]];
    }
    
    
        

    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITableView * tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height-49-85)];
    tab.delegate = self;
    tab.dataSource = self;
    tab.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tab];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (myname.count==0)
    {
        return 1;
    }
    else
    {
        return myname.count;
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
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, 100)];
    view.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:view];
    
    
    UIImageView * img = [[UIImageView alloc]init];
    img.frame = CGRectMake(20, -30, 85, 85);
    img.layer.cornerRadius = img.frame.size.width/2;
    img.layer.masksToBounds = YES;
    if (touxiangimg.count!=0)
    {
        
        
            img.image = [UIImage imageWithData:[touxiangimg objectAtIndex:indexPath.row]];
        
    }
    [view addSubview:img];
    
    UILabel * lab = [[UILabel alloc]init];
    if (myname.count!=0)
    {
        NSString * namestr = [myname objectAtIndex:indexPath.row];
        CGSize size = [namestr sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:lab.font,NSFontAttributeName, nil]];
        lab.frame = CGRectMake(125/2-size.width/2, 90, size.width, 30);
        if ([namestr isEqual:[NSNull null]]||[namestr isEqualToString:@""])
        {
            lab.text = @"无";
        }
        else
        {
            lab.text = namestr;
        }
    }
    
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1];
    lab.font = [UIFont boldSystemFontOfSize:15];
    [cell.contentView addSubview:lab];
    
    UILabel * lab2 = [[UILabel alloc]initWithFrame:CGRectMake(img.frame.origin.x+img.frame.size.width+10, 5, self.view.frame.size.width-(img.frame.origin.x+img.frame.size.width+20), view.frame.size.height-10)];
    if (text.count!=0)
    {
        NSString * textstr = [text objectAtIndex:indexPath.row];
        
        if ([textstr isEqual:[NSNull null]]||[textstr isEqualToString:@""])
        {
            lab2.text = @"无";
        }
        else
        {
            lab2.text = textstr;
        }
    }
    else
    {
        lab2.text = @"无";
    }
    
    lab2.textColor = [UIColor grayColor];
    lab2.font = [UIFont boldSystemFontOfSize:14];
    lab2.numberOfLines = 0;
    [view addSubview:lab2];
    
    [self stopHUD];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
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
