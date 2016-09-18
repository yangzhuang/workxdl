//
//  gerenzhongxin.h
//  XDL
//
//  Created by ruiji on 16/8/24.
//  Copyright © 2016年 ruiji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "urlinfo.h"
#import "MBProgressHUD.h"
@interface gerenzhongxin : UIViewController<urlinfoDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UILabel * lable;
    UILabel * zuoyelab;
    UILabel * biaoxianlab;
    UIButton * touxiangbtn;
    UIImage * imm;
    MBProgressHUD * HUD;
}
@end
