//
//  course.h
//  XDL
//
//  Created by ruiji on 16/8/24.
//  Copyright © 2016年 ruiji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "urlinfo.h"
#import "MBProgressHUD.h"
#import "ziranpindujieshaoViewController.h"

@interface course : UIViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,urlinfoDelegate>
{
    MBProgressHUD * HUD;
}
@end
