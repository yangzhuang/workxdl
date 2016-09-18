//
//  wodelaoshi.h
//  XDL
//
//  Created by reginet on 16/8/29.
//  Copyright © 2016年 ruiji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "urlinfo.h"
#import "MBProgressHUD.h"

@interface wodelaoshi : UIViewController<urlinfoDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * myname;
    NSMutableArray * touxiangimg;
    NSMutableArray * text;
    MBProgressHUD * HUD;
}
@property(nonatomic,strong)NSString * topname;
@end
