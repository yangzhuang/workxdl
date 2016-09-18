//
//  chengzhangtixi.m
//  XDL
//
//  Created by ruiji on 16/8/24.
//  Copyright © 2016年 ruiji. All rights reserved.
//

#import "chengzhangtixi.h"
#import "UUChart.h"
#import "riliViewController.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface chengzhangtixi ()
{
    UUChart *chartView;
    
    NSMutableArray * danci1;
    NSMutableArray * danci2;
    NSMutableArray * danci3;
    NSMutableArray * danci4;
    NSMutableArray * danci5;
    NSMutableArray * danci6;
    NSMutableArray * danci7;
    NSMutableArray * danci8;
    
    NSMutableArray * yufa1;
    NSMutableArray * yufa2;
    NSMutableArray * yufa3;
    NSMutableArray * yufa4;
    NSMutableArray * yufa5;
    NSMutableArray * yufa6;
    NSMutableArray * yufa7;
    NSMutableArray * yufa8;
     
    
}
@end

@implementation chengzhangtixi
- (void)viewWillAppear:(BOOL)animated
{
    [self resulturl];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    k=1;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1];
    self.navigationItem.title = @"成长体系";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20]}];
    
    //获取当前时间的一周中每一天的日期
    nowdate = [NSDate date];
    
    if (nowdate == nil) {
        nowdate = [NSDate date];
    }
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *second = nil;
    NSDate *third = nil;
    NSDate *four = nil;
    NSDate *five = nil;
    NSDate *six = nil;
    NSDate *seven = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitWeekOfMonth startDate:&beginDate interval:&interval forDate:nowdate];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        second = [beginDate dateByAddingTimeInterval:60*60*24];
        third = [beginDate dateByAddingTimeInterval:2*60*60*24];
        four = [beginDate dateByAddingTimeInterval:3*60*60*24];
        five = [beginDate dateByAddingTimeInterval:4*60*60*24];
        six = [beginDate dateByAddingTimeInterval:5*60*60*24];
        seven = [beginDate dateByAddingTimeInterval:6*60*60*24];
    }else {
        return;
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"MM-dd"];
    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
    NSString *secondString = [myDateFormatter stringFromDate:second];
    NSString *thirdString = [myDateFormatter stringFromDate:third];
    NSString *fourdString = [myDateFormatter stringFromDate:four];
    NSString *fivedString = [myDateFormatter stringFromDate:five];
    NSString *sixdString = [myDateFormatter stringFromDate:six];
    NSString *sevendString = [myDateFormatter stringFromDate:seven];
    
    riqiarr = [NSArray arrayWithObjects:beginString,secondString,thirdString,fourdString,fivedString,sixdString,sevendString, nil];

    
    imgview = [[UIView alloc]initWithFrame:CGRectMake(1, 64, WIDTH-2, HEIGHT/5-2)];
    imgview.layer.borderWidth = 1;
    imgview.layer.borderColor = [UIColor colorWithRed:143/255.0 green:215/255.0 blue:253/255.0 alpha:1].CGColor;
    [self.view addSubview:imgview];
    
    
    NSArray * xingqiarr = [NSArray arrayWithObjects:@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日", nil];
    for (int i=0; i<7; i++)
    {
        
        riqibtn = [UIButton buttonWithType:UIButtonTypeCustom];
        riqibtn.frame =CGRectMake(i*(imgview.frame.size.width/7), 1, imgview.frame.size.width/7, imgview.frame.size.height/4);
        [riqibtn setTitle:[riqiarr objectAtIndex:i] forState:UIControlStateNormal];
        riqibtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        riqibtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [riqibtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [riqibtn addTarget:self action:@selector(rili) forControlEvents:UIControlEventTouchUpInside];
        riqibtn.tag=i+500;
        [riqibtn setEnabled:NO];
        [imgview addSubview:riqibtn];
//        rililab = [[UILabel alloc]initWithFrame:CGRectMake(i*(imgview.frame.size.width/7), 1, imgview.frame.size.width/7, imgview.frame.size.height/4)];
//        rililab.text = [riqiarr objectAtIndex:i];
//        rililab.textAlignment = NSTextAlignmentCenter;
//        rililab.font = [UIFont boldSystemFontOfSize:14];
//        rililab.textColor = [UIColor lightGrayColor];
//        //        riqilab.backgroundColor = [UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1];
//        rililab.tag=i+500;
//        [imgview addSubview:rililab];
        
        
        UILabel * riqilab = [[UILabel alloc]initWithFrame:CGRectMake(i*(imgview.frame.size.width/7), imgview.frame.size.height/4+1, imgview.frame.size.width/7, imgview.frame.size.height/4)];
        riqilab.text = [xingqiarr objectAtIndex:i];
        riqilab.textAlignment = NSTextAlignmentCenter;
        riqilab.font = [UIFont boldSystemFontOfSize:14];
        riqilab.textColor = [UIColor lightGrayColor];
//        riqilab.backgroundColor = [UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1];
        [imgview addSubview:riqilab];
        
        UIView * shuxian = [[UIView alloc]initWithFrame:CGRectMake(i*(imgview.frame.size.width/7), 0, 1, (imgview.frame.size.height/4)*2)];
        shuxian.backgroundColor =[UIColor colorWithRed:143/255.0 green:215/255.0 blue:253/255.0 alpha:1];
        [imgview addSubview:shuxian];
    }
    for (int i=1; i<3; i++)
    {
        UIView * hengxian = [[UIView alloc]initWithFrame:CGRectMake(0, i*imgview.frame.size.height/4, WIDTH, 1)];
        hengxian.backgroundColor =[UIColor colorWithRed:143/255.0 green:215/255.0 blue:253/255.0 alpha:1];
        [imgview addSubview:hengxian];
    }
    
    quanbukeshilab = [[UILabel alloc]initWithFrame:CGRectMake(0, (imgview.frame.size.height/2)+(imgview.frame.size.height/4)/2, imgview.frame.size.width/2, imgview.frame.size.height/4)];
//    quanbukeshilab.backgroundColor = [UIColor redColor];
    quanbukeshilab.textAlignment = NSTextAlignmentCenter;
    quanbukeshilab.font = [UIFont systemFontOfSize:15];
    quanbukeshilab.textColor = [UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1];
    [imgview addSubview:quanbukeshilab];
    
    shengyukeshilab = [[UILabel alloc]initWithFrame:CGRectMake(imgview.frame.size.width/2, (imgview.frame.size.height/2)+(imgview.frame.size.height/4)/2, imgview.frame.size.width/2, imgview.frame.size.height/4)];
//    shengyukeshilab.backgroundColor = [UIColor greenColor];
    shengyukeshilab.textAlignment = NSTextAlignmentCenter;
    shengyukeshilab.font = [UIFont systemFontOfSize:15];
    shengyukeshilab.textColor = [UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1];
    [imgview addSubview:shengyukeshilab];
    
    NSArray * arr = [NSArray arrayWithObjects:@"leftbtn",@"rightbtn",@"语法",@"单词",@"剩余课时", nil];
    for (int i=0; i<3; i++)
    {
        if (i<2)
        {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag=i;
            btn.frame = CGRectMake(i*(WIDTH/2)+12, 70+HEIGHT/5, WIDTH/2.3, HEIGHT/14);
            [btn setImage:[UIImage imageNamed:[arr objectAtIndex:i]] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btn];
            
            view = [[UIView alloc]initWithFrame:CGRectMake(i*(WIDTH/2)+WIDTH/7, HEIGHT/1.35, 40, 15)];
            view.tag= i;
            if (view.tag==0)
            {
                view.backgroundColor = [UUColor colorWithRed:4/255.0 green:111/255.0 blue:183/255.0 alpha:1];
            }
            if (view.tag==1)
            {
                view.backgroundColor = [UUColor colorWithRed:247/255.0 green:181/255.0 blue:43/255.0 alpha:1];
            }
            if (view.tag==2)
            {
                view.backgroundColor = [UUColor redColor];
            }
            [self.view addSubview:view];
            
            UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(view.frame.origin.x+view.frame.size.width+5, HEIGHT/1.39, 100, 40)];
            lab.text =[arr objectAtIndex:i+2];
            lab.font = [UIFont systemFontOfSize:15];
            [self.view addSubview:lab];
        }
        
    }
    
    lable = [[UILabel alloc]initWithFrame:CGRectMake(2, HEIGHT/1.28, WIDTH-4, HEIGHT/9)];
    lable.layer.cornerRadius = 5;
    lable.layer.borderWidth = 1;
    lable.layer.borderColor =[UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1].CGColor;
    lable.text =@"学时到达100学时，学习了xxx语法，xxx单词";
    lable.font = [UIFont boldSystemFontOfSize:14];
    lable.numberOfLines = 0;
    lable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lable];
    
    
    
    
    danciarr = [NSMutableArray new];
    yufaarr = [NSMutableArray new];
    
    
    
    kaiguan = YES;
    
    
    [self timerurl];
}
- (void)rili
{
    
    
//    SZCalendarPicker *calendarPicker = [SZCalendarPicker showOnView:self.view];
//    calendarPicker.today = [NSDate date];
//    calendarPicker.date = calendarPicker.today;
//    calendarPicker.frame = CGRectMake(0, self.view.frame.size.height/5, self.view.frame.size.width, self.view.frame.size.height/1.5);
//    calendarPicker.calendarBlock = ^(NSInteger day, NSInteger month, NSInteger year){
//        
//    };
    riliViewController * rili = [riliViewController new];
    UIBarButtonItem * back = [UIBarButtonItem new];
    back.title = @"";
    self.navigationItem.backBarButtonItem = back;
    [self.navigationController pushViewController:rili animated:YES];
}
- (void)resulturl
{
    
    urlinfo * uif = [urlinfo new];
    uif.Delegate = self;
    [uif sendurlinfo:nil andurlstr:@"http://www.feifeifeixiang.com.cn/XDL/user/odi.php" withIdentifier:fenleikecheng];
}
- (void)timerurl
{
    urlinfo * uif = [urlinfo new];
    uif.Delegate = self;
    [uif sendurlinfo:nil andurlstr:@"http://www.feifeifeixiang.com.cn/XDL/user/time.php" withIdentifier:shangketime];
}
- (void)urldata:(NSMutableDictionary *)data withIdentifier:(RequestName)name
{
    if (name==shangketime)
    {
        riliarr = [NSMutableArray new];
        
        for (NSString * timestr in data) {
            
            NSString * aa = [timestr substringFromIndex:5];

            for (int j=0; j<7; j++)
            {
                UIButton * pdlab = (UIButton *)[self.view viewWithTag:j+500];
                riqibtn = pdlab;
                
                if ([riqibtn.titleLabel.text isEqualToString:aa])
                {
                    riqibtn.backgroundColor = [UIColor colorWithRed:143/255.0 green:215/255.0 blue:253/255.0 alpha:1];
                    [riqibtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    [riqibtn setEnabled:YES];
                }
            }
        }
        
        
    }
    if (name==fenleikecheng)
    {
        NSLog(@"%@",data);
        keshi1 = [NSMutableArray new];
        keshi2 = [NSMutableArray new];
        btnarr = [NSMutableArray new];
        btnarr2 = [NSMutableArray new];
        shengyukeshi1 = [NSMutableArray new];
        shengyukeshi2 = [NSMutableArray new];
        quanbukeshi1 = [NSMutableArray new];
        quanbukeshi2 = [NSMutableArray new];
        
        danci1 = [NSMutableArray new];
        danci2 = [NSMutableArray new];
        danci3 = [NSMutableArray new];
        danci4 = [NSMutableArray new];
        danci5 = [NSMutableArray new];
        danci6 = [NSMutableArray new];
        danci7 = [NSMutableArray new];
        danci8 = [NSMutableArray new];
        
        yufa1 = [NSMutableArray new];
        yufa2 = [NSMutableArray new];
        yufa3 = [NSMutableArray new];
        yufa4 = [NSMutableArray new];
        yufa5 = [NSMutableArray new];
        yufa6 = [NSMutableArray new];
        yufa7 = [NSMutableArray new];
        yufa8 = [NSMutableArray new];
        
        for (NSMutableDictionary * dic in data) {
            NSString * type = [dic objectForKey:@"type"];
            if ([type isEqualToString:@"1"])
            {
                course = [NSString stringWithFormat:@"%@",[dic objectForKey:@"course"]];
                NSString * num = [NSString stringWithFormat:@"%@",[dic objectForKey:@"num"]];
                NSString * class = [NSString stringWithFormat:@"%@",[dic objectForKey:@"class"]];
                int aclass = [class intValue];
                int anum = [num intValue];
                int ashengyukeshi = aclass-anum;
                NSString * shengyukeshi = [NSString stringWithFormat:@"%d",ashengyukeshi];
                NSString * quanbukeshi = [NSString stringWithFormat:@"%d",aclass];
                
                [quanbukeshi1 addObject:quanbukeshi];
                [shengyukeshi1 addObject:shengyukeshi];
                [btnarr addObject:course];
                [keshi1 addObject:num];
                if (k==1)
                {
                    [danci1 addObject:[dic objectForKey:@"danci1"]];
                    [danci2 addObject:[dic objectForKey:@"danci2"]];
                    [danci3 addObject:[dic objectForKey:@"danci3"]];
                    [danci4 addObject:[dic objectForKey:@"danci4"]];
                    [danci5 addObject:[dic objectForKey:@"danci5"]];
                    [danci6 addObject:[dic objectForKey:@"danci6"]];
                    [danci7 addObject:[dic objectForKey:@"danci7"]];
                    [danci8 addObject:[dic objectForKey:@"danci8"]];
                    
                    [yufa1 addObject:[dic objectForKey:@"yufa1"]];
                    [yufa2 addObject:[dic objectForKey:@"yufa2"]];
                    [yufa3 addObject:[dic objectForKey:@"yufa3"]];
                    [yufa4 addObject:[dic objectForKey:@"yufa4"]];
                    [yufa5 addObject:[dic objectForKey:@"yufa5"]];
                    [yufa6 addObject:[dic objectForKey:@"yufa6"]];
                    [yufa7 addObject:[dic objectForKey:@"yufa7"]];
                    [yufa8 addObject:[dic objectForKey:@"yufa8"]];
                }
            }
            if ([type isEqualToString:@"2"])
            {
                course2 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"course"]];
                NSString * num = [NSString stringWithFormat:@"%@",[dic objectForKey:@"num"]];
                NSString * class = [NSString stringWithFormat:@"%@",[dic objectForKey:@"class"]];
                int aclass = [class intValue];
                int anum = [num intValue];
                int ashengyukeshi = aclass-anum;
                NSString * shengyukeshi = [NSString stringWithFormat:@"%d",ashengyukeshi];
                NSString * quanbukeshi = [NSString stringWithFormat:@"%d",aclass];
                
                [quanbukeshi2 addObject:quanbukeshi];
                [shengyukeshi2 addObject:shengyukeshi];
                [btnarr2 addObject:course2];
                [keshi2 addObject:num];
                if (k==2)
                {
                    [danci1 addObject:[dic objectForKey:@"danci1"]];
                    [danci2 addObject:[dic objectForKey:@"danci2"]];
                    [danci3 addObject:[dic objectForKey:@"danci3"]];
                    [danci4 addObject:[dic objectForKey:@"danci4"]];
                    [danci5 addObject:[dic objectForKey:@"danci5"]];
                    [danci6 addObject:[dic objectForKey:@"danci6"]];
                    [danci7 addObject:[dic objectForKey:@"danci7"]];
                    [danci8 addObject:[dic objectForKey:@"danci8"]];
                    
                    [yufa1 addObject:[dic objectForKey:@"yufa1"]];
                    [yufa2 addObject:[dic objectForKey:@"yufa2"]];
                    [yufa3 addObject:[dic objectForKey:@"yufa3"]];
                    [yufa4 addObject:[dic objectForKey:@"yufa4"]];
                    [yufa5 addObject:[dic objectForKey:@"yufa5"]];
                    [yufa6 addObject:[dic objectForKey:@"yufa6"]];
                    [yufa7 addObject:[dic objectForKey:@"yufa7"]];
                    [yufa8 addObject:[dic objectForKey:@"yufa8"]];
                }
            }
        }
        //第一次进入数据
        
        if (keshi1.count!=0)
        {
            odikeshi = [[keshi1 objectAtIndex:0] intValue];
            lab2.text = [shengyukeshi1 objectAtIndex:0];
            NSString * quanbukeshistr = [NSString stringWithFormat:@"全部课时:%@",[quanbukeshi1 objectAtIndex:0]];
            NSString * shengyukeshistr = [NSString stringWithFormat:@"剩余课时:%@",[shengyukeshi1 objectAtIndex:0]];
            quanbukeshilab.text = quanbukeshistr;
            shengyukeshilab.text = shengyukeshistr;
        }
        [self zhexiantu];
    }
    
    
}
- (void)button:(id)sender
{
    
    UIButton * btn = (UIButton *)sender;
    
    if (btn.tag==0)
    {
        if (kaiguan==YES)
        {
            [self table];
            
            tab.frame = CGRectMake(btn.frame.origin.x+15, 69+HEIGHT/5+HEIGHT/14, WIDTH/2.3-30, HEIGHT/4);
            
            if (btnarr.count==0)
            {
                UIAlertController * alc = [UIAlertController alertControllerWithTitle:@"提示" message:@"您没有购买任何ODI课程" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alc addAction:ac];
                [self presentViewController:alc animated:YES completion:nil];
                
                kaiguan = YES;
            }
            else
            {
                kaiguan = NO;
            }
            
            
            k = 1;
            
        }
        else
        {
            [tab removeFromSuperview];
            
            kaiguan = YES;
        }
        
        
    }
    if (btn.tag==1)
    {
        if (kaiguan==YES)
        {
            [self table];
            
            tab.frame = CGRectMake(btn.frame.origin.x+15, 69+HEIGHT/5+HEIGHT/14, WIDTH/2.3-30, HEIGHT/4);
            
            if (btnarr2.count==0)
            {
                UIAlertController * alc = [UIAlertController alertControllerWithTitle:@"提示" message:@"您没有购买任何自然拼读课程" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alc addAction:ac];
                [self presentViewController:alc animated:YES completion:nil];
                
                kaiguan = YES;
            }
            else
            {
                kaiguan = NO;
            }
            k = 2;
        }
        else
        {
            [tab removeFromSuperview];
            
            kaiguan = YES;
        }
        
    }
    
}
- (void)table
{
    tab = [[UITableView alloc]init];
    tab.delegate = self;
    tab.dataSource = self;
    tab.separatorStyle = UITableViewCellSeparatorStyleNone;
    tab.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:tab];
    
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (k==1)
    {
        return btnarr.count;
    }
    else
    {
        return btnarr2.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * yz = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:yz];
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:yz];
    }
    for (UIView * sub in cell.contentView.subviews) {
        [sub removeFromSuperview];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithRed:143/255.0 green:215/255.0 blue:253/255.0 alpha:0.1];
    cell.layer.cornerRadius = 5;
    
    if (k==1)
    {
        cell.textLabel.text = [btnarr objectAtIndex:indexPath.row];
    }
    if (k==2)
    {
        cell.textLabel.text = [btnarr2 objectAtIndex:indexPath.row];
    }
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor =[UIColor colorWithRed:73/255.0 green:172/255.0 blue:223/255.0 alpha:1];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    odikeshi = 0;
    pindukeshi = 0;

    [tab removeFromSuperview];
    kaiguan = YES;
    
    if (k==1)
    {
        NSString * odi = [keshi1 objectAtIndex:indexPath.row];
        odikeshi = [odi intValue];
        lab2.text = [shengyukeshi1 objectAtIndex:indexPath.row];
        NSString * quanbukeshistr = [NSString stringWithFormat:@"全部课时:%@",[quanbukeshi1 objectAtIndex:indexPath.row]];
        NSString * shengyukeshistr = [NSString stringWithFormat:@"剩余课时:%@",[shengyukeshi1 objectAtIndex:indexPath.row]];
        quanbukeshilab.text = quanbukeshistr;
        shengyukeshilab.text = shengyukeshistr;
    }
    if (k==2)
    {
        NSString * pindu = [keshi2 objectAtIndex:indexPath.row];
        pindukeshi = [pindu intValue];
        lab2.text = [shengyukeshi2 objectAtIndex:indexPath.row];
        NSString * quanbukeshistr = [NSString stringWithFormat:@"全部课时:%@",[quanbukeshi2 objectAtIndex:indexPath.row]];
        NSString * shengyukeshistr = [NSString stringWithFormat:@"剩余课时:%@",[shengyukeshi2 objectAtIndex:indexPath.row]];
        quanbukeshilab.text = quanbukeshistr;
        shengyukeshilab.text = shengyukeshistr;
    }
    [self resulturl];
}
- (void)zhexiantu
{
    if (chartView) {
        [chartView removeFromSuperview];
        chartView = nil;
    }
    chartView = [[UUChart alloc]initWithFrame:CGRectMake(10, HEIGHT/2.3, [UIScreen mainScreen].bounds.size.width-20, HEIGHT/3.5) dataSource:self style:UUChartStyleLine];
    
    [chartView showInView:self.view];
    
}
- (NSArray *)getXTitles:(int)num
{
    NSArray * arr = [NSArray arrayWithObjects:@"预热",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8", nil];
    NSMutableArray *xTitles = [NSMutableArray array];
    for (int i=0; i<num; i++) {
        NSString * str = [arr objectAtIndex:i];
        [xTitles addObject:str];
    }
    return xTitles;
}
#pragma mark - @required
//横坐标标题数组
- (NSArray *)chartConfigAxisXLabel:(UUChart *)chart
{
    return [self getXTitles:9];
}
//数值多重数组
- (NSArray *)chartConfigAxisYValue:(UUChart *)chart
{
    ary = [NSMutableArray new];
    ary2 = [NSMutableArray new];
    
    
   
    
    //选择课程后数据
    if ((odikeshi>0&&odikeshi<20)||(pindukeshi>0&&pindukeshi<20))
    {
        [ary removeAllObjects];
        [ary2 removeAllObjects];
        [ary addObject:@"0"];
        [ary2 addObject:@"0"];
        labyufa = @"0";
        labkeshi = @"开始学习";
        labdanci = @"0";
    }
    if ((odikeshi>=20&&odikeshi<40)||(pindukeshi>=20&&pindukeshi<40))
    {
        [ary removeAllObjects];
        [ary addObject:@"0"];
        [ary addObject:@"50"];
        
        [ary2 removeAllObjects];
        [ary2 addObject:@"0"];
        [ary2 addObject:@"35"];
        
        labyufa = @"50";
        labkeshi = @"学习1单元";
        labdanci = @"35";
    }
    if ((odikeshi>=40&&odikeshi<60)||(pindukeshi>=40&&pindukeshi<60))
    {
        [ary removeAllObjects];
        [ary addObject:@"0"];
        [ary addObject:@"50"];
        [ary addObject:@"55"];
        
        [ary2 removeAllObjects];
        [ary2 addObject:@"0"];
        [ary2 addObject:@"35"];
        [ary2 addObject:@"20"];
        
        labyufa = @"55";
        labkeshi = @"学习2单元";
        labdanci = @"20";
    }
    if ((odikeshi>=60&&odikeshi<80)||(pindukeshi>=60&&pindukeshi<80))
    {
        [ary removeAllObjects];
        [ary addObject:@"0"];
        [ary addObject:@"50"];
        [ary addObject:@"55"];
        [ary addObject:@"75"];
        
        [ary2 removeAllObjects];
        [ary2 addObject:@"0"];
        [ary2 addObject:@"35"];
        [ary2 addObject:@"20"];
        [ary2 addObject:@"40"];
        
        labyufa = @"75";
        labkeshi = @"学习3单元";
        labdanci = @"40";
    }
    if ((odikeshi>=80&&odikeshi<104)||(pindukeshi>=80&&pindukeshi<104))
    {
        [ary removeAllObjects];
        [ary addObject:@"0"];
        [ary addObject:@"50"];
        [ary addObject:@"55"];
        [ary addObject:@"75"];
        [ary addObject:@"80"];
        
        [ary2 removeAllObjects];
        [ary2 addObject:@"0"];
        [ary2 addObject:@"35"];
        [ary2 addObject:@"20"];
        [ary2 addObject:@"40"];
        [ary2 addObject:@"67"];
        
        labyufa = @"80";
        labkeshi = @"学习4单元";
        labdanci = @"67";
    }
    if (odikeshi==104||pindukeshi==104)
    {
        [ary removeAllObjects];
        [ary addObject:@"0"];
        [ary addObject:@"50"];
        [ary addObject:@"55"];
        [ary addObject:@"75"];
        [ary addObject:@"80"];
        [ary addObject:@"104"];
        
        [ary2 removeAllObjects];
        [ary2 addObject:@"0"];
        [ary2 addObject:@"35"];
        [ary2 addObject:@"20"];
        [ary2 addObject:@"40"];
        [ary2 addObject:@"67"];
        [ary2 addObject:@"104"];
        
        labyufa = @"104";
        labkeshi = @"学习5单元";
        labdanci = @"104";
    }
    
    
    if (ary2.count==0||ary.count==0||labkeshi==nil)
    {
        if (ary.count==0)
        {
            [ary removeAllObjects];
            [ary addObject:@"0"];
        }
        if (ary2.count==0)
        {
            [ary2 removeAllObjects];
            [ary2 addObject:@"0"];
        }
        if (labkeshi==nil)
        {
            [ary removeAllObjects];
            [ary addObject:@"0"];
            [ary2 removeAllObjects];
            [ary2 addObject:@"0"];
            labyufa = @"0";
            labkeshi = @"开始学习";
            labdanci = @"0";
        }
    }
    NSString * zongstr = [NSString stringWithFormat:@"%@，学习了%@语法，%@单词",labkeshi,labyufa,labdanci];
    lable.text = zongstr;
    return @[ary,ary2];
    
    
    
    
}

#pragma mark - @optional
//颜色数组
- (NSArray *)chartConfigColors:(UUChart *)chart
{
    return @[[UUColor colorWithRed:4/255.0 green:111/255.0 blue:183/255.0 alpha:1],[UUColor colorWithRed:247/255.0 green:181/255.0 blue:43/255.0 alpha:1]];
}
//显示数值范围
- (CGRange)chartRange:(UUChart *)chart
{
    
    return CGRangeMake(140, 0);
    
    
    return CGRangeZero;
}

#pragma mark 折线图专享功能

//标记数值区域
- (CGRange)chartHighlightRangeInLine:(UUChart *)chart
{
    
    //    return CGRangeMake(25, 75);
    
    return CGRangeZero;
}

//判断显示横线条
- (BOOL)chart:(UUChart *)chart showHorizonLineAtIndex:(NSInteger)index
{
    return YES;
}

//判断显示最大最小值
- (BOOL)chart:(UUChart *)chart showMaxMinAtIndex:(NSInteger)index
{
    return  5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)showHUD
{
    HUD = [MBProgressHUD new];
    HUD.labelText = @"请稍后..";
    [HUD show:YES];
    [self.view addSubview:HUD];
    
}
- (void)stopHUD
{
    [HUD removeFromSuperview];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
