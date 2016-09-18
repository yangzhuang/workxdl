//
//  ViewController.m
//  XDL
//
//  Created by ruiji on 16/8/24.
//  Copyright © 2016年 ruiji. All rights reserved.
//

#import "ViewController.h"
#import "tabbar.h"
#import "AppDelegate.h"

@interface ViewController ()
{
    UIImageView * tfimg;
    UITextField * tf1;
    UITextField * tf2;
    MBProgressHUD * HUD;
    
}
@end

@implementation ViewController
static ViewController * vc = nil;

+(id)defaultvc
{
    if (vc==nil)
    {
        vc = [ViewController new];
    }
    return vc;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    if (vc==nil)
    {
        vc = [super allocWithZone:zone];
    }
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView * imgview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"denglubeijing"]];
    imgview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    imgview.userInteractionEnabled = YES;
    [self.view addSubview:imgview];
    
    UIImageView * logoimg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"denglulogo"]];
    logoimg.frame = CGRectMake(self.view.frame.size.width/3.5, self.view.frame.size.height/8,self.view.frame.size.width-self.view.frame.size.width/3.5*2, self.view.frame.size.height/4.8);
    [imgview addSubview:logoimg];
    
    NSArray * arr = [NSArray arrayWithObjects:@"zhanghao.png",@"mima.png", nil];
    
    for (int i=0; i<3; i++)
    {
        tfimg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"denglutf"]];
        tfimg.userInteractionEnabled = YES;
        tfimg.frame = CGRectMake(20,i*(imgview.frame.size.height/8.5)+imgview.frame.size.height/2.5,imgview.frame.size.width-40,imgview.frame.size.height/11);
        [imgview addSubview:tfimg];
        
        if (i<2)
        {
            UIImageView * tbimg = [[UIImageView alloc]initWithFrame:CGRectMake(tfimg.bounds.origin.x+20, tfimg.frame.size.height/2-(tfimg.frame.size.width/11)/2, tfimg.frame.size.width/11, tfimg.frame.size.width/11)];
            tbimg.image = [UIImage imageNamed:[arr objectAtIndex:i]];
            [tfimg addSubview:tbimg];
            
            UITextField * tt = [[UITextField alloc]initWithFrame:CGRectMake((tfimg.bounds.origin.x+20)+tfimg.frame.size.width/8, tfimg.frame.size.height/2-(tfimg.frame.size.width/11)/2, tfimg.frame.size.width/1.5, tfimg.frame.size.width/11)];
            tt.tag=i+1000;
            if (tt.tag==1001)
            {
                tt.secureTextEntry = YES;
            }
            if (tt.tag==1000)
            {
                [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
                NSString * userphone = [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
                if (userphone!=nil)
                {
                    tt.text = userphone;
                }

                
            }
            [tfimg addSubview:tt];
            
        }
        
        if (i==2)
        {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(20, 2*(imgview.frame.size.height/8.5)+imgview.frame.size.height/2.5,imgview.frame.size.width-40,imgview.frame.size.height/11);
            [btn setBackgroundImage:[UIImage imageNamed:@"denglubtn"] forState:UIControlStateNormal];
            [btn setTitle:@"登录" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
            [btn addTarget:self action:@selector(denglu) forControlEvents:UIControlEventTouchUpInside];
            [imgview addSubview:btn];
        }
    }
    
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/1.13, 300, 30)];
    lab.text = @"技术支持.秦皇岛锐基网络工程有限公司";
    lab.font = [UIFont boldSystemFontOfSize:14];
    lab.textColor = [UIColor whiteColor];
    lab.textAlignment = NSTextAlignmentCenter;
    [imgview addSubview:lab];
}
- (void)denglu
{
    UITextField * user = (UITextField *)[self.view viewWithTag:1000];
    UITextField * pass = (UITextField *)[self.view viewWithTag:1001];
    
    NSMutableString * phone =[NSMutableString stringWithFormat:@"%@",user.text];
    NSMutableString * pwd =[NSMutableString stringWithFormat:@"%@",pass.text];
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:@"phone"];
    
    
    NSMutableDictionary * dldic = [NSMutableDictionary dictionary];
    [dldic setObject:phone forKey:@"phone"];
    [dldic setObject:pwd forKey:@"pwd"];
    
    urlinfo * uif = [urlinfo new];
    uif.Delegate = self;
    [uif sendurlinfo:dldic andurlstr:@"http://www.feifeifeixiang.com.cn/XDL/user/user.php" withIdentifier:Login];
    [self showHUD];
}
- (void)tokenid:(NSMutableDictionary *)dic
{
    urlinfo * uif = [urlinfo new];
    uif.Delegate = self;
    [uif sendurlinfo:dic andurlstr:@"http://www.feifeifeixiang.com.cn/XDL/user/phone.php" withIdentifier:token];
}
- (void)urldata:(NSMutableDictionary *)data withIdentifier:(RequestName)name
{
    if (name==Login)
    {
        for (NSMutableDictionary * dic in data) {
            NSString * imgstr = [dic objectForKey:@"img"];
            self.userid = [dic objectForKey:@"uid"];
            self.tongzhi = [dic objectForKey:@"num"];
            self.myname = [dic objectForKey:@"name"];
            NSString * user =[NSString stringWithFormat:@"http://www.feifeifeixiang.com.cn/XDL/uploadimg/%@",imgstr];
            NSData * imgdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:user]];
            self.userimg = imgdata;
        }
        if (data==nil)
        {
            [self stopHUD];
            UIAlertController * alc = [UIAlertController alertControllerWithTitle:@"提示" message:@"账号或密码错误!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alc addAction:cancel];
            [self presentViewController:alc animated:YES completion:nil];
        }
        else
        {
            [self stopHUD];
            tabbar * tb = [tabbar new];
            [self presentViewController:tb animated:YES completion:nil];
            
            NSData * tokendata = [[AppDelegate tokenid]token];
            if (tokendata!=nil)
            {
                NSMutableDictionary * tokendic = [NSMutableDictionary dictionary];
                [tokendic setObject:self.userid forKey:@"id"];
                [tokendic setObject:tokendata forKey:@"token"];
                [self tokenid:tokendic];
            }
            
            
        }
    }
    

}
- (void)showHUD
{
    HUD = [MBProgressHUD new];
    HUD.labelText = @"正在登录..";
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

@end
