//
//  yijianfankui.m
//  XDL
//
//  Created by reginet on 16/8/29.
//  Copyright © 2016年 ruiji. All rights reserved.
//

#import "yijianfankui.h"

@interface yijianfankui ()

@end

@implementation yijianfankui

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1];
    self.navigationItem.title = self.topname;
    self.navigationController.navigationBar.tintColor =[UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UITextView * tv = [[UITextView alloc]initWithFrame:CGRectMake(10, 75, self.view.frame.size.width-20, 200)];
    tv.font = [UIFont systemFontOfSize:15];
    tv.layer.borderColor = [UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1].CGColor;
    tv.layer.borderWidth = 1;
    tv.tag=100;
    [self.view addSubview:tv];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(0, self.view.frame.size.height-119, self.view.frame.size.width, 50);
    [btn addTarget:self action:@selector(tijiao) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)tijiao
{
    [self showHUD];
    UITextView * tv = (UITextView *)[self.view viewWithTag:100];
    NSMutableString * str = [NSMutableString stringWithFormat:@"%@",tv.text];
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:str forKey:@"feedback"];
    
    urlinfo * uif = [urlinfo new];
    uif.Delegate = self;
    [uif sendurlinfo:dic andurlstr:@"http://www.feifeifeixiang.com.cn/XDL/user/feedback.php" withIdentifier:feedback];
}
- (void)urldata:(NSMutableDictionary *)data withIdentifier:(RequestName)name
{
    NSString * jieguo =[data objectForKey:@"last"];
    [self stopHUD];
    
    if ([jieguo isEqualToString:@"1"])
    {
        UIAlertController * alc = [UIAlertController alertControllerWithTitle:@"提示" message:@"提交成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alc addAction:cancel];
        [self presentViewController:alc animated:YES completion:nil];
        
    }
    else
    {
        UIAlertController * alc = [UIAlertController alertControllerWithTitle:@"提示" message:@"提交失败" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alc addAction:cancel];
        [self presentViewController:alc animated:YES completion:nil];
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
