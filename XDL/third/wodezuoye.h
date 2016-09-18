//
//  wodezuoye.h
//  XDL
//
//  Created by reginet on 16/8/29.
//  Copyright © 2016年 ruiji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "urlinfo.h"
#import "MBProgressHUD.h"

@interface wodezuoye : UIViewController<UITableViewDelegate,UITableViewDataSource,urlinfoDelegate>
{
    NSMutableArray * urlarr;
    MBProgressHUD * HUD;
}
@property(nonatomic,strong)NSString * topname;
@end
