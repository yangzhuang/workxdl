//
//  kechengjieshao.m
//  XDL
//
//  Created by ruiji on 16/8/25.
//  Copyright © 2016年 ruiji. All rights reserved.
//

#import "kechengjieshao.h"
#import "ViewController.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface kechengjieshao ()

@end

@implementation kechengjieshao

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = self.biaoti;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    
    [self showHUD];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"goumaibtn"] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    btn.frame = CGRectMake(0, HEIGHT/1.2, WIDTH, HEIGHT/14);
    [btn addTarget:self action:@selector(buy) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    zongid = [NSMutableArray new];
    
    [self requesturl];
    
}
- (void)requesturl
{
    urlinfo * uif = [urlinfo new];
    uif.Delegate = self;
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:self.kechengid forKey:@"id"];
    
    [uif sendurlinfo:dic andurlstr:@"http://www.feifeifeixiang.com.cn/XDL/user/aclass.php" withIdentifier:kechengjs];
}
- (void)mykecheng
{
    urlinfo * uif = [urlinfo new];
    uif.Delegate = self;
    
    [uif sendurlinfo:nil andurlstr:@"http://www.feifeifeixiang.com.cn/XDL/user/class.php" withIdentifier:mykecheng];
}
- (void)urldata:(NSMutableDictionary *)data withIdentifier:(RequestName)name
{
    if (name==kechengjs)
    {
        danyuanzhuti = [NSString stringWithFormat:@"%@",[data objectForKey:@"theme"]];
        yufa = [NSString stringWithFormat:@"%@",[data objectForKey:@"sentence"]];
        ziranfayin = [NSString stringWithFormat:@"%@",[data objectForKey:@"pronunciation"]];
        danciliang = [NSString stringWithFormat:@"%@",[data objectForKey:@"number"]];
        keshishu = [NSString stringWithFormat:@"%@",[data objectForKey:@"class"]];
        kechengjiage = [NSString stringWithFormat:@"%@",[data objectForKey:@"price"]];
        tid = [NSMutableString stringWithFormat:@"%@",[data objectForKey:@"tid"]];
        [self mykecheng];
    }
    if (name==mykecheng)
    {
        for (NSMutableDictionary * dic in data) {
            NSString * myid = [dic objectForKey:@"id"];
            [zongid addObject:myid];
        }
    }
    
    if ([zongid containsObject:self.kechengid])
    {
        [btn setTitle:@"已购买" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setEnabled:NO];
    }
    else
    {
        [btn setTitle:@"立即购买" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setEnabled:YES];
    }
    
    [self table];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}
- (void)buy
{
    UIAlertController * alc = [UIAlertController alertControllerWithTitle:@"课程购买" message:@"请致电新大陆学校:0335-8069840" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    
    [alc addAction:act];
    
    [self presentViewController:alc animated:YES completion:nil];
}
- (void)table
{
    UITableView * tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 74, WIDTH, HEIGHT/1.5)];
    tab.delegate = self;
    tab.dataSource = self;
    tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    tab.scrollEnabled = NO;
    tab.layer.cornerRadius = 5;
    tab.layer.borderWidth = 1;
    tab.layer.borderColor = [UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1].CGColor;
    [self.view addSubview:tab];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * table = @"cell";
    UITableViewCell * yz = [tableView dequeueReusableCellWithIdentifier:table];
    if (yz==nil)
    {
        yz = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:table];
    }
    for (UIView * sub in yz.contentView.subviews) {
        [sub removeFromSuperview];
    }
    yz.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    UIView * hengxiangview = [[UIView alloc]init];
    if (indexPath.row==0)
    {
        
        hengxiangview.frame = CGRectMake(0, HEIGHT/13-1, WIDTH, 1);
    }
    else
    {
        
        hengxiangview.frame = CGRectMake(0, HEIGHT/10-1, WIDTH, 1);
    }
    

    hengxiangview.backgroundColor = [UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1];
   
    [yz.contentView addSubview:hengxiangview];
    if (indexPath.row==0)
    {
        
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-100, HEIGHT/13/2-15, 200, 30)];
        lab.text = @"课程介绍";
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = [UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1];
        lab.font = [UIFont boldSystemFontOfSize:20];
        [yz.contentView addSubview:lab];
    }
    if (indexPath.row>0)
    {
        UIView * shuxianview = [[UIView alloc]initWithFrame:CGRectMake(100, 0, 1, HEIGHT/10)];
        shuxianview.backgroundColor =[UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1];
        [yz.contentView addSubview:shuxianview];
        
        NSArray * arr = [NSArray arrayWithObjects:@"单元主题",@"语法／句型",@"自然发音",@"单词量",@"课时数",@"课程价格",danyuanzhuti,yufa,ziranfayin,danciliang,keshishu,kechengjiage, nil];
       
        UILabel * leftlab = [[UILabel alloc]initWithFrame:CGRectMake(0, HEIGHT/10/2-15, 100, 30)];
        leftlab.text = [arr objectAtIndex:indexPath.row-1];
        leftlab.textAlignment = NSTextAlignmentCenter;
        leftlab.font = [UIFont systemFontOfSize:18];
        [yz.contentView addSubview:leftlab];
        
        UILabel * rightlab = [[UILabel alloc]initWithFrame:CGRectMake(110, 5, WIDTH/1.6, HEIGHT/10-10)];
        rightlab.text = [arr objectAtIndex:indexPath.row+5];
        rightlab.textColor = [UIColor grayColor];
        rightlab.font = [UIFont systemFontOfSize:14];
        rightlab.numberOfLines = 0;
        [yz.contentView addSubview:rightlab];
    }
    
    [self stopHUD];
    return yz;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        return HEIGHT/13;
    }
    else
    {
        return HEIGHT/10;
    }
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
