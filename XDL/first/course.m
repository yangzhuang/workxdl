//
//  course.m
//  XDL
//
//  Created by ruiji on 16/8/24.
//  Copyright © 2016年 ruiji. All rights reserved.
//

#import "course.h"
#import "coursecell.h"
#import "coursemodel.h"
#import "kechengjieshao.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface course ()
{
    UIView  * hengxianview;
    UIButton * btn;
    UIScrollView * scv;
    int k;
    NSMutableArray * sour;
    NSMutableArray * srou;
    NSMutableArray * bt;
    UITableView * tab;
    UITableView * righttab;
    NSMutableArray * kechengid;
    NSMutableArray * pinduid;
}
@end

@implementation course

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1];
    self.navigationItem.title = @"课程";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    
    UIView * topview = [[UIView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT/11)];
    topview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topview];
    
    NSArray * toparr = [NSArray arrayWithObjects:@"ODI课程",@"自然拼读", nil];
    for (int i=0; i<2; i++)
    {
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*(WIDTH/2), 0, WIDTH/2, HEIGHT/11);
        [btn setTitle:[toparr objectAtIndex:i] forState:UIControlStateNormal];
        btn.tag = 100+i;
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(gundong:) forControlEvents:UIControlEventTouchUpInside];
        [topview addSubview:btn];
    }
    hengxianview = [[ UIView alloc]initWithFrame:CGRectMake(0, topview.frame.size.height-2, WIDTH/2, 2)];
    hengxianview.backgroundColor = [UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1];
    [topview addSubview:hengxianview];
    
    UIView * xview = [[UIView alloc]initWithFrame:CGRectMake(WIDTH/2-1, 12, 2, HEIGHT/11-24)];
    xview.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    [topview addSubview:xview];
    
    UIImageView * imgview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1200.jpg"]];
    imgview.frame = CGRectMake(0, 64+HEIGHT/11, WIDTH, HEIGHT/5);
    [self.view addSubview:imgview];
    
    scv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, HEIGHT/11+64+HEIGHT/5, WIDTH, HEIGHT/1.85)];
//    scv.backgroundColor = [UIColor greenColor];
    scv.pagingEnabled = YES;
    scv.bounces = NO;
    scv.contentSize = CGSizeMake(WIDTH*2, 0);
    scv.delegate = self;
    [self.view addSubview:scv];
    
    
    

    if (scv.contentOffset.x==0)
    {
        UIButton * lable = (UIButton *)[self.view viewWithTag:100];
        btn = lable;
        [btn setTitleColor:[UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1] forState:UIControlStateNormal];
        
        k = 1;
        
    }
    
    sour = [NSMutableArray new];
    srou = [NSMutableArray new];
    bt = [NSMutableArray new];
    kechengid = [NSMutableArray new];
    pinduid = [NSMutableArray new];

    
    
    [self requesturlkecheng];
    [self requesturlpindu];
    
    

}
- (void)requesturlkecheng
{
    [self showHUD];
    urlinfo * uif = [urlinfo new];
    uif.Delegate = self;
    [uif sendurlinfo:nil andurlstr:@"http://www.feifeifeixiang.com.cn/XDL/user/course.php" withIdentifier:kecheng];
}
- (void)requesturlpindu
{
    urlinfo * uif = [urlinfo new];
    uif.Delegate = self;
    [uif sendurlinfo:nil andurlstr:@"http://www.feifeifeixiang.com.cn/XDL/user/course.php?type=ziran" withIdentifier:pindu];
}
- (void)urldata:(NSMutableDictionary *)data withIdentifier:(RequestName)name
{
    if (name==kecheng)
    {
        for (NSMutableDictionary * dic in data) {
            
            NSString * pinjie = [NSString stringWithFormat:@"http://www.feifeifeixiang.com.cn/XDL/uploadimg/%@",[dic objectForKey:@"img"]];
            NSURL * urll = [NSURL URLWithString:pinjie];
            NSData * ddd = [NSData dataWithContentsOfURL:urll];
            NSString * course = [NSString stringWithFormat:@"%@",[dic objectForKey:@"course"]];
            NSString * text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"text"]];
            
            coursemodel * model = [coursemodel new];
            model.img = ddd;
            model.biaoti = course;
            model.neirong = text;
            [sour addObject:model];
            
            [kechengid addObject:[dic objectForKey:@"id"]];
        }
    }
    if (name==pindu)
    {
        for (NSMutableDictionary * dic in data) {
            
            NSString * pinjie = [NSString stringWithFormat:@"http://www.feifeifeixiang.com.cn/XDL/uploadimg/%@",[dic objectForKey:@"img"]];
            NSURL * urll = [NSURL URLWithString:pinjie];
            NSData * ddd = [NSData dataWithContentsOfURL:urll];
            NSString * course = [NSString stringWithFormat:@"%@",[dic objectForKey:@"course"]];
            NSString * text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"text"]];
            
            coursemodel * model = [coursemodel new];
            model.img = ddd;
            model.biaoti = course;
            model.neirong = text;
            [srou addObject:model];
            
            [pinduid addObject:[dic objectForKey:@"id"]];
        }
    }
    
    
    
    
    
    [self table];
    [self righttable];
    
    //补全table下划线
//    [tab setSeparatorInset:UIEdgeInsetsZero];
//    [tab setLayoutMargins:UIEdgeInsetsZero];
//    
//    [righttab setSeparatorInset:UIEdgeInsetsZero];
//    [righttab setLayoutMargins:UIEdgeInsetsZero];
}
- (void)table
{
    tab = [[UITableView alloc]init];
    tab.delegate = self;
    tab.dataSource = self;
    tab.frame = CGRectMake(0, 0, WIDTH, HEIGHT-scv.frame.origin.y-49);
    tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    tab.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    [scv addSubview:tab];
}
- (void)righttable
{
    righttab = [[UITableView alloc]init];
    righttab.delegate = self;
    righttab.dataSource = self;
    //    tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    righttab.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    
    righttab.frame = CGRectMake(WIDTH, 0, WIDTH, HEIGHT-scv.frame.origin.y-49);
    
    righttab.separatorStyle = UITableViewCellSeparatorStyleNone;
    [scv addSubview:righttab];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:tab])
    {
        return sour.count;
    }
    else
    {
        return srou.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * left = @"cell";
    static NSString * right = @"cell";
    
    if ([tableView isEqual:tab])
    {
        coursecell * yz = [tableView dequeueReusableCellWithIdentifier:left];
            if (yz==nil)
            {
                yz = [[coursecell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:left];
            }
            yz.selectionStyle = UITableViewCellSelectionStyleNone;
            yz.backgroundColor = [UIColor clearColor];
        
        coursemodel * model = [sour objectAtIndex:indexPath.row];
        yz.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
        [yz course:model];
        [self stopHUD];
        return yz;
    }
    if ([tableView isEqual:righttab])
    {
        coursecell * yz = [tableView dequeueReusableCellWithIdentifier:right];
        if (yz==nil)
        {
            yz = [[coursecell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:right];
        }
        yz.selectionStyle = UITableViewCellSelectionStyleNone;
        yz.backgroundColor = [UIColor clearColor];
        
        coursemodel * model = [srou objectAtIndex:indexPath.row];
        [yz course:model];
        
        yz.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
        [self stopHUD];
        return yz;
    }
    
    return nil;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT/4.45;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    kechengjieshao * kcjs = [kechengjieshao new];
    ziranpindujieshaoViewController * ziranpindu = [ziranpindujieshaoViewController new];
    UIBarButtonItem * back = [UIBarButtonItem new];
    back.title = @"";
    self.navigationItem.backBarButtonItem = back;
    
    if ([tableView isEqual:tab])
    {
        coursemodel * model = [sour objectAtIndex:indexPath.row];
        kcjs.biaoti = model.biaoti;
        kcjs.kechengid = [kechengid objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:kcjs animated:YES];
    }
    if ([tableView isEqual:righttab])
    {
        coursemodel * model = [srou objectAtIndex:indexPath.row];
        ziranpindu.biaoti = model.biaoti;
        ziranpindu.kechengid = [pinduid objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:ziranpindu animated:YES];
    }
    
    
    
    
}
//下划线对齐
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    [cell setSeparatorInset:UIEdgeInsetsZero];
//    
//    [cell setLayoutMargins:UIEdgeInsetsZero];
//    
//}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[UITableView class]]) {
        
    }
    else
    {
        if (scrollView.contentOffset.x==0)
        {
            
            
            [UIView animateWithDuration:0.25 animations:^{
                CGRect rect = hengxianview.frame;
                rect.origin.x = 0;
                hengxianview.frame = rect;
            }];
            UIButton * lable = (UIButton *)[self.view viewWithTag:100];
            btn = lable;
            [btn setTitleColor:[UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1] forState:UIControlStateNormal];
            
            UIButton * lable2 = (UIButton *)[self.view viewWithTag:101];
            btn = lable2;
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            

            
        }
        if (scrollView.contentOffset.x==WIDTH)
        {
            
            
            [UIView animateWithDuration:0.25 animations:^{
                CGRect rect = hengxianview.frame;
                rect.origin.x = WIDTH/2;
                hengxianview.frame = rect;
            }];
            UIButton * lable = (UIButton *)[self.view viewWithTag:101];
            btn = lable;
            [btn setTitleColor:[UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1] forState:UIControlStateNormal];
            
            UIButton * lable2 = (UIButton *)[self.view viewWithTag:100];
            btn = lable2;
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            

        }

    }
    [tab reloadData];
}
- (void)gundong:(id)sender
{
    UIButton * button = (UIButton *)sender;
    if (button.tag==100)
    {
        
        
        [UIView animateWithDuration:0.25 animations:^{
            scv.contentOffset = CGPointMake(0, 0);
            [UIView animateWithDuration:0.25 animations:^{
                CGRect rect = hengxianview.frame;
                rect.origin.x = 0;
                hengxianview.frame = rect;
            }];
            
        }];
        UIButton * lable = (UIButton *)[self.view viewWithTag:100];
        btn = lable;
        [btn setTitleColor:[UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1] forState:UIControlStateNormal];
        
        UIButton * lable2 = (UIButton *)[self.view viewWithTag:101];
        btn = lable2;
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        

    }
    if (button.tag==101)
    {
        
        
        
        [UIView animateWithDuration:0.25 animations:^{
            scv.contentOffset = CGPointMake(WIDTH, 0);
            [UIView animateWithDuration:0.25 animations:^{
                CGRect rect = hengxianview.frame;
                rect.origin.x = WIDTH/2;
                hengxianview.frame = rect;
            }];
            
        }];
        UIButton * lable = (UIButton *)[self.view viewWithTag:101];
        btn = lable;
        [btn setTitleColor:[UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1] forState:UIControlStateNormal];
        
        UIButton * lable2 = (UIButton *)[self.view viewWithTag:100];
        btn = lable2;
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        

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
