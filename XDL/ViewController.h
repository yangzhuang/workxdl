//
//  ViewController.h
//  XDL
//
//  Created by ruiji on 16/8/24.
//  Copyright © 2016年 ruiji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "urlinfo.h"
#import "MBProgressHUD.h"
@interface ViewController : UIViewController<urlinfoDelegate>
+(id)defaultvc;

@property(nonatomic,strong)NSData * userimg;
@property(nonatomic,strong)NSString * userid;
@property(nonatomic,strong)NSString * tongzhi;
@property(nonatomic,strong)NSString * myname;
@end

