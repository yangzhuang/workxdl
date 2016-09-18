//
//  ziranpindujieshaoViewController.h
//  XDL
//
//  Created by reginet on 16/9/12.
//  Copyright © 2016年 ruiji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "urlinfo.h"
#import "MBProgressHUD.h"
@interface ziranpindujieshaoViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,urlinfoDelegate>
{
    NSString * danyuanzhuti;
    NSString * yufa;
    NSString * ziranfayin;
    NSString * danciliang;
    NSString * keshishu;
    NSString * kechengjiage;
    NSMutableString * tid;
    NSMutableArray * zongid;
    UIButton * btn;
    MBProgressHUD * HUD;
}
@property(nonatomic,strong)NSString * biaoti;
@property(nonatomic,strong)NSString * kechengid;
@end
