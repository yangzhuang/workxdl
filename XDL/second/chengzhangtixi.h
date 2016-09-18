//
//  chengzhangtixi.h
//  XDL
//
//  Created by ruiji on 16/8/24.
//  Copyright © 2016年 ruiji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UUChart.h"
#import "urlinfo.h"
#import "MBProgressHUD.h"
#import "ViewController.h"

@interface chengzhangtixi : UIViewController<UITableViewDelegate,UITableViewDataSource,UUChartDataSource,urlinfoDelegate>
{
    UIButton * riqibtn;
    NSMutableArray * btnarr;
    NSMutableArray * btnarr2;
    BOOL kaiguan;
    UITableView * tab;
    NSMutableArray * yufaarr;
    NSMutableArray * danciarr;
    int k;
    int keshi;
    int danci;
    NSMutableArray *ary ;
    NSMutableArray *ary2;
    UILabel * lable;
    NSString * labyufa;
    NSString * labdanci;
    NSString * labkeshi;
    NSString * course;
    NSString * course2;
    NSMutableArray * keshi1;
    NSMutableArray * keshi2;
    MBProgressHUD * HUD;
    UIView * view;
    UILabel * lab2;
    NSMutableArray * shengyukeshi1;
    NSMutableArray * shengyukeshi2;
    NSMutableArray * quanbukeshi1;
    NSMutableArray * quanbukeshi2;
    UILabel * shengyukeshilab;
    UILabel * quanbukeshilab;
    NSDate * nowdate;
    NSArray * riqiarr;
    UIView * imgview;
    NSMutableArray * riliarr;
    
    int  odikeshi;
    int  pindukeshi;
}
@end
