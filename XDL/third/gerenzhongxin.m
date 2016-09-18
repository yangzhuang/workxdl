//
//  gerenzhongxin.m
//  XDL
//
//  Created by ruiji on 16/8/24.
//  Copyright © 2016年 ruiji. All rights reserved.
//

#import "gerenzhongxin.h"
#import "jibenxinxi.h"
#import "wodezuoye.h"
#import "wodebiaoxian.h"
#import "wodelaoshi.h"
#import "wodetongzhi.h"
#import "yijianfankui.h"
#import "ViewController.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface gerenzhongxin ()

@end

@implementation gerenzhongxin
- (void)viewWillAppear:(BOOL)animated
{
    [self requesturl];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1];
    self.navigationItem.title = @"个人中心";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    
    UIImageView * imgview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gerenzhongxinbeijing"]];
    imgview.frame = CGRectMake(0, 64, WIDTH, HEIGHT/5);
    imgview.userInteractionEnabled = YES;
    [self.view addSubview:imgview];
    
    
    
    UIImageView * touxiangimg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gerenzhongxintouxiang"]];
    touxiangimg.frame = CGRectMake(WIDTH/2-WIDTH/6.5, 64+HEIGHT/5-WIDTH/9, 2*(WIDTH/2-(WIDTH/2-WIDTH/6.5)), 2*(WIDTH/2-(WIDTH/2-WIDTH/6.5)));
    touxiangimg.userInteractionEnabled = YES;
    [self.view addSubview:touxiangimg];
    
    
    NSData * imgdata =[[ViewController defaultvc]userimg];
    touxiangbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    touxiangbtn.frame = CGRectMake(5, 5, touxiangimg.frame.size.width-10, touxiangimg.frame.size.height-10);
    [touxiangbtn setImage:[UIImage imageWithData:imgdata] forState:UIControlStateNormal];
    touxiangbtn.layer.cornerRadius =(touxiangimg.frame.size.width-10)/2;
    touxiangbtn.layer.masksToBounds = YES;
    [touxiangbtn addTarget:self action:@selector(huantouxiang) forControlEvents:UIControlEventTouchUpInside];
    [touxiangimg addSubview:touxiangbtn];
    
    UIButton * rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbtn setImage:[UIImage imageNamed:@"tuichudenglu"] forState:UIControlStateNormal];
    rightbtn.frame = CGRectMake(0, 0, 55, 21);
    [rightbtn addTarget:self action:@selector(gerenzhongxin:) forControlEvents:UIControlEventTouchUpInside];
    rightbtn.tag = 1111;
    UIBarButtonItem * right = [UIBarButtonItem new];
    right.customView = rightbtn;
    self.navigationItem.rightBarButtonItem = right;
    
    NSArray * arr = [NSArray arrayWithObjects:@"yijianfankui",@"wodetongzhi",@"wodelaoshi",@"wodebiaoxian",@"wodezuoye",@"jibenxinxi", nil];
    
    for (int i=0; i<6; i++)
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:[arr objectAtIndex:i]] forState:UIControlStateNormal];
        btn.frame = CGRectMake(WIDTH/8, HEIGHT-49-(HEIGHT/13.5)-(HEIGHT/13.5-2)*i, WIDTH-(WIDTH/8)*2, HEIGHT/13.5);
        btn.tag=i+7000;
        [btn addTarget:self action:@selector(gerenzhongxin:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        if (btn.tag==7001)
        {
                lable = [[UILabel alloc]initWithFrame:CGRectMake(btn.frame.size.width/1.6, btn.frame.size.height/4.5, 15, 15)];
                lable.layer.cornerRadius = lable.bounds.size.width/2;
                lable.layer.masksToBounds = YES;
                lable.textAlignment = NSTextAlignmentCenter;
                lable.textColor = [UIColor whiteColor];
                lable.font = [UIFont boldSystemFontOfSize:13];
                [btn addSubview:lable];
        }
        if (btn.tag==7003)
        {
            biaoxianlab = [[UILabel alloc]initWithFrame:CGRectMake(btn.frame.size.width/1.6, btn.frame.size.height/4.5, 15, 15)];
            biaoxianlab.layer.cornerRadius = biaoxianlab.bounds.size.width/2;
            biaoxianlab.layer.masksToBounds = YES;
            biaoxianlab.textAlignment = NSTextAlignmentCenter;
            biaoxianlab.textColor = [UIColor whiteColor];
            biaoxianlab.font = [UIFont boldSystemFontOfSize:13];
            [btn addSubview:biaoxianlab];
        }
        if (btn.tag==7004)
        {
            zuoyelab = [[UILabel alloc]initWithFrame:CGRectMake(btn.frame.size.width/1.6, btn.frame.size.height/4.5, 15, 15)];
            zuoyelab.layer.cornerRadius = zuoyelab.bounds.size.width/2;
            zuoyelab.layer.masksToBounds = YES;
            zuoyelab.textAlignment = NSTextAlignmentCenter;
            zuoyelab.textColor = [UIColor whiteColor];
            zuoyelab.font = [UIFont boldSystemFontOfSize:13];
            [btn addSubview:zuoyelab];
        }
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requesturl) name:@"laitongzhi" object:nil];
}
- (void)huantouxiang
{
    // 1.判断相册是否可以打开
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    // 2. 创建图片选择控制器
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    /**
     typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) {
     UIImagePickerControllerSourceTypePhotoLibrary, // 相册
     UIImagePickerControllerSourceTypeCamera, // 用相机拍摄获取
     UIImagePickerControllerSourceTypeSavedPhotosAlbum // 相簿
     }
     */
    // 3. 设置打开照片相册类型(显示所有相簿)
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // 照相机
//     ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    // 4.设置代理
    ipc.delegate = self;
    // 5.modal出这个控制器
    [self presentViewController:ipc animated:YES completion:nil];
}
// 获取图片后的操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    // 销毁控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 设置图片
    imm = info[UIImagePickerControllerOriginalImage];
    
    
    
    //UIImage图片转成Base64字符串：
//    NSData *data = UIImageJPEGRepresentation(imm, 1.0f);
    
//    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString * imgstr = [self imageBase64WithDataURL:imm];
    [self touxiangimg:imgstr];

}
- (NSString *)imageBase64WithDataURL:(UIImage *)image
{
    NSData *imageData = nil;
    NSString *mimeType = nil;
    
    //图片要压缩的比例，此处100根据需求，自行设置
    CGFloat x = 100 / image.size.height;
    if (x > 1)
    {
        x = 1.0;
    }
    imageData = UIImageJPEGRepresentation(image, x);
    mimeType = @"image/jpeg";
    return [NSString stringWithFormat:@"data:%@;base64,%@", mimeType,
            [imageData base64EncodedStringWithOptions: 0]];
}
- (void)touxiangimg:(NSString * )base
{
    NSString * str = @"http://www.feifeifeixiang.com.cn/XDL/user/sethead.php";
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:base forKey:@"img"];
    urlinfo * uif = [urlinfo new];
    [uif sendurlinfo:dic andurlstr:str withIdentifier:touxiang];
    uif.Delegate = self;
    [self showHUD];
}
- (void)requesturl
{
    NSString * str = @"http://www.feifeifeixiang.com.cn/XDL/user/basic.php";
    
    urlinfo * uif = [urlinfo new];
    [uif sendurlinfo:nil andurlstr:str withIdentifier:Information];
    uif.Delegate = self;
}
- (void)urldata:(NSMutableDictionary *)data withIdentifier:(RequestName)name
{
    if (name==Information)
    {
        NSString * tongzhi = [NSString stringWithFormat:@"%@",[data objectForKey:@"num"]];
        NSString * biaoxianstr = [NSString stringWithFormat:@"%@",[data objectForKey:@"biaoxiannum"]];
        NSString * zuoyestr = [NSString stringWithFormat:@"%@",[data objectForKey:@"zuoyenum"]];
        
        if ([tongzhi isEqualToString:@"0"]||tongzhi==nil)
        {
            lable.backgroundColor = [UIColor clearColor];
            lable.text = nil;
        }
        else
        {
            lable.text = tongzhi;
            lable.backgroundColor = [UIColor redColor];
        }
        if ([biaoxianstr isEqualToString:@"0"]||biaoxianstr==nil)
        {
            biaoxianlab.backgroundColor = [UIColor clearColor];
            biaoxianlab.text = nil;
        }
        else
        {
            biaoxianlab.text = biaoxianstr;
            biaoxianlab.backgroundColor = [UIColor redColor];
        }
        if ([zuoyestr isEqualToString:@"0"]||zuoyestr==nil)
        {
            zuoyelab.backgroundColor = [UIColor clearColor];
            zuoyelab.text = nil;
        }
        else
        {
            zuoyelab.text = zuoyestr;
            zuoyelab.backgroundColor = [UIColor redColor];
        }
        
        
    }
    if (name==touxiang)
    {
        [self stopHUD];
        NSString * result = [data objectForKey:@"last"];
        if ([result isEqual:@"1"])
        {
            [touxiangbtn setImage:imm forState:UIControlStateNormal];
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {   // 判断是否是IOS8
                UIAlertController * alc = [UIAlertController alertControllerWithTitle:@"提示" message:@"上传头像成功" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [alc addAction:cancel];
                [self presentViewController:alc animated:YES completion:nil];
            }
            
        }
        else
        {
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {   // 判断是否是IOS8
                UIAlertController * alc = [UIAlertController alertControllerWithTitle:@"提示" message:@"上传头像失败" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [alc addAction:cancel];
                [self presentViewController:alc animated:YES completion:nil];
            }
            
        }
        
    }
    
}
- (void)gerenzhongxin:(id)sender
{
    NSArray * arr = [NSArray arrayWithObjects:@"意见反馈",@"我的通知",@"我的老师",@"我的表现",@"我的作业",@"基本信息", nil];
    jibenxinxi * jbxx = [jibenxinxi new];
    wodezuoye * wdzy = [wodezuoye new];
    wodebiaoxian * wdbx = [wodebiaoxian new];
    wodelaoshi * wdls = [wodelaoshi new];
    wodetongzhi * wdtz = [wodetongzhi new];
    yijianfankui * yjfk = [yijianfankui new];
    
    UIBarButtonItem * back = [UIBarButtonItem new];
    back.title = @"";
    self.navigationItem.backBarButtonItem = back;
    
    UIButton * btn = (UIButton *)sender;
    if (btn.tag==7000)
    {
        yjfk.topname = [arr objectAtIndex:btn.tag-7000];
        [self.navigationController pushViewController:yjfk animated:YES];
    }
    if (btn.tag==7001)
    {
        wdtz.topname = [arr objectAtIndex:btn.tag-7000];
        [self.navigationController pushViewController:wdtz animated:YES];
    }
    if (btn.tag==7002)
    {
        wdls.topname = [arr objectAtIndex:btn.tag-7000];
        [self.navigationController pushViewController:wdls animated:YES];
    }
    if (btn.tag==7003)
    {
        wdbx.topname = [arr objectAtIndex:btn.tag-7000];
        [self.navigationController pushViewController:wdbx animated:YES];
    }
    if (btn.tag==7004)
    {
        wdzy.topname = [arr objectAtIndex:btn.tag-7000];
        [self.navigationController pushViewController:wdzy animated:YES];
    }
    if (btn.tag==7005)
    {
        jbxx.topname = [arr objectAtIndex:btn.tag-7000];
        [self.navigationController pushViewController:jbxx animated:YES];
    }
    
    if (btn.tag==1111)
    {
        UIAlertController * alc = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否退出当前账号？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }];
        UIAlertAction * acc = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alc addAction:acc];
        [alc addAction:ac];
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
