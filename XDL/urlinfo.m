//
//  urlinfo.m
//  XDL
//
//  Created by reginet on 16/9/1.
//  Copyright © 2016年 ruiji. All rights reserved.
//

#import "urlinfo.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
@implementation urlinfo
- (void)sendurlinfo:(NSMutableDictionary *)dic andurlstr:(NSString *)urlstr withIdentifier:(RequestName)name
{
    // 启动系统风火轮
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //以post的形式提交，POST的参数就是上面的域名，parameters的参数是一个字典类型，将上面的字典作为它的参数
    [manager POST:urlstr parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 隐藏系统风火轮
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        //json解析
        NSMutableDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        [self.Delegate urldata:resultDic withIdentifier:name];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 解析失败隐藏系统风火轮(可以打印error.userInfo查看错误信息)
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    }];

    
}
@end
