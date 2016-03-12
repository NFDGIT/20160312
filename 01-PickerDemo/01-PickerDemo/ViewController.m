//
//  ViewController.m
//  01-PickerDemo
//
//  Created by qingyun on 16/3/12.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //当前时间
    NSDate *currentDate = [NSDate date];
    _datePicker.minimumDate = currentDate;
    
    NSDate *maxDate = [currentDate dateByAddingTimeInterval:3 * 24 * 60 *60];
    _datePicker.maximumDate =maxDate;
    
    NSLog(@"%@",currentDate);
    
    //获取当前时区
    NSTimeZone *zone = [NSTimeZone localTimeZone];
    //世界标准时间距当前时区的时间间隔
    NSInteger interval = [zone secondsFromGMTForDate:currentDate];
    //转化成当前时区的时间
    NSDate  *localDate = [currentDate dateByAddingTimeInterval:interval];
    NSLog(@"%@",localDate);
    
    //添加事件(valuechanged)
    [_datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)datePickerValueChanged:(UIDatePicker *)datePicker{
    NSLog(@"date:%@",[datePicker.date descriptionWithLocale:datePicker.locale]);
}

- (IBAction)selectedDate:(UIButton *)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您选择的时间:" message:[_datePicker.date descriptionWithLocale:_datePicker.locale] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:action1];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
