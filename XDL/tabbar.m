//
//  tabbar.m
//  XDL
//
//  Created by ruiji on 16/8/24.
//  Copyright © 2016年 ruiji. All rights reserved.
//

#import "tabbar.h"
#import "course.h"
#import "chengzhangtixi.h"
#import "gerenzhongxin.h"


@interface tabbar ()
{
    UIView * view;
    UIButton * btn;
    UIButton * tabbarbtn;
}
@end

@implementation tabbar

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray * arr = [NSArray arrayWithObjects:@"first",@"second",@"third", nil];
    for (int i=0; i<3; i++)
    {
        view = [[UIView alloc]initWithFrame:CGRectMake(i*(self.view.frame.size.width/3), self.view.frame.size.height-49, self.view.frame.size.width/3, 49)];
        view.tag = i+1000;
        view.backgroundColor = [UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1];
        [self.view addSubview:view];
        
        tabbarbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        tabbarbtn.frame = CGRectMake(0,0,view.frame.size.width,view.frame.size.height);
//        tabbarbtn.backgroundColor = [UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1];
        tabbarbtn.tag = i;
        [tabbarbtn addTarget:self action:@selector(tabbarbtn:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:tabbarbtn];
        
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag=i;
        btn.frame = CGRectMake(tabbarbtn.frame.size.width/2-17, tabbarbtn.frame.size.height/2-15, 35, 29);
        [btn setImage:[UIImage imageNamed:[arr objectAtIndex:i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(tabbarbtn:) forControlEvents:UIControlEventTouchUpInside];
        [tabbarbtn addSubview:btn];
    }
    
    
    
    course * first = [course new];
    chengzhangtixi * cztx = [chengzhangtixi new];
    gerenzhongxin * grzx = [gerenzhongxin new];
    
    UINavigationController * nav1 = [[UINavigationController alloc]initWithRootViewController:first];
    UINavigationController * nav2 = [[UINavigationController alloc]initWithRootViewController:cztx];
    UINavigationController * nav3 = [[UINavigationController alloc]initWithRootViewController:grzx];
    
    [self setViewControllers:@[nav1,nav2,nav3] animated:YES];
    
    if (self.selectedIndex==0)
    {
        UIView * vv = (UIView *)[self.view viewWithTag:1000];
        view = vv;
        view.backgroundColor = [UIColor colorWithRed:143/255.0 green:215/255.0 blue:253/255.0 alpha:1];
    }
    
}
- (void)tabbarbtn:(id)sender
{
    UIButton * btnn = (UIButton *)sender;
    self.selectedIndex = btnn.tag;
    
    for (int i=0; i<3; i++)
    {
        if (btnn.tag==i)
        {
            UIView * lable = (UIView *)[self.view viewWithTag:i+1000];
            view = lable;
            view.backgroundColor = [UIColor colorWithRed:143/255.0 green:215/255.0 blue:253/255.0 alpha:1];

        }
        else
        {
            UIView * lable = (UIView *)[self.view viewWithTag:i+1000];
            view = lable;
            view.backgroundColor = [UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1];

        }
    }
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
