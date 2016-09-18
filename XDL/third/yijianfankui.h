//
//  yijianfankui.h
//  XDL
//
//  Created by reginet on 16/8/29.
//  Copyright © 2016年 ruiji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "urlinfo.h"
#import "MBProgressHUD.h"

@interface yijianfankui : UIViewController<urlinfoDelegate>
{
    MBProgressHUD * HUD;
}
@property(nonatomic,strong)NSString * topname;
@end
