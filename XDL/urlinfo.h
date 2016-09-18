//
//  urlinfo.h
//  XDL
//
//  Created by reginet on 16/9/1.
//  Copyright © 2016年 ruiji. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum
{
    Login,//登录
    kecheng,//课程
    pindu,//拼读
    Information,//基本信息
    homework,//我的作业
    performance,//我的表现
    teacher,//我的老师
    feedback,//意见反馈
    kechengjs,//课程介绍
    mykecheng,//我的课程
    buykecheng,//购买课程
    fenleikecheng,//分类课程
    tongzhi,//通知
    token,//token
    touxiang,//头像
    shangketime,//上课时间
}RequestName;

@protocol urlinfoDelegate <NSObject>
@required
- (void)urldata:(NSMutableDictionary *)data withIdentifier:(RequestName)name;


@end

@interface urlinfo : NSObject
- (void)sendurlinfo:(NSMutableDictionary *)dic andurlstr:(NSString *)urlstr withIdentifier:(RequestName)name;
@property(nonatomic,strong)id<urlinfoDelegate>Delegate;
@end
