//
//  wodetongzhi.h
//  XDL
//
//  Created by reginet on 16/8/29.
//  Copyright © 2016年 ruiji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "urlinfo.h"
#import "MBProgressHUD.h"

@interface wodetongzhi : UIViewController<urlinfoDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * teachername;
    NSMutableArray * time;
    NSMutableArray * action;
    MBProgressHUD * HUD;
    UITableView * tab;
}
@property(nonatomic,strong)NSString * topname;
@end
