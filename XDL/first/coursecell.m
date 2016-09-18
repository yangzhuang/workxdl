//
//  coursecell.m
//  XDL
//
//  Created by ruiji on 16/8/24.
//  Copyright © 2016年 ruiji. All rights reserved.
//

#import "coursecell.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation coursecell
- (void)course:(coursemodel *)course
{
    for (UIView * sub in self.contentView.subviews) {
        [sub removeFromSuperview];
    }
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 10, WIDTH, HEIGHT/4.45-10)];
    view.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view];
    
    
    
    UIImageView * imgview = [[UIImageView alloc]init];
    imgview.image = [UIImage imageWithData:course.img];
    imgview.frame = CGRectMake(10, 5, view.frame.size.width/3.55, view.frame.size.height-10);
    [view addSubview:imgview];
    
    UILabel * biaotilab = [[UILabel alloc]initWithFrame:CGRectMake(view.frame.size.width/3, 2, 200, 30)];
    biaotilab.text = course.biaoti;
    biaotilab.textColor = [UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1];
    biaotilab.font = [UIFont boldSystemFontOfSize:20];
    [view addSubview:biaotilab];
    
    UILabel * neironglab = [[UILabel alloc]initWithFrame:CGRectMake(view.frame.size.width/3.1, 30, view.frame.size.width/1.5, view.frame.size.height-30)];
    neironglab.numberOfLines = 0;
    neironglab.text = course.neirong;
    neironglab.textColor = [UIColor grayColor];
    neironglab.font = [UIFont systemFontOfSize:12];
    [view addSubview:neironglab];
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
