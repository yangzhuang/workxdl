//
//  jibenxinxi.h
//  XDL
//
//  Created by reginet on 16/8/29.
//  Copyright © 2016年 ruiji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "urlinfo.h"
#import "MBProgressHUD.h"
@interface jibenxinxi : UIViewController<UITableViewDelegate,UITableViewDataSource,urlinfoDelegate>
{
    NSArray * xinxiarr;
    UITableView * tab;
    MBProgressHUD * HUD;
}
@property(nonatomic,strong)NSString * topname;
@property(nonatomic,strong)NSString * userid;


@end
