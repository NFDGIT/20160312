//
//  DependetionPickerVC.m
//  01-PickerDemo
//
//  Created by qingyun on 16/3/12.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "DependetionPickerVC.h"

@interface DependetionPickerVC ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic, strong) NSDictionary *dict;
@property (nonatomic, strong) NSArray *keys;
@property (nonatomic, strong) NSArray *values;
@end

@implementation DependetionPickerVC

-(void)loadDictFromFile{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"statedictionary" ofType:@"plist"];
    _dict = [NSDictionary dictionaryWithContentsOfFile:path];
    //取出左边对应的数据
    _keys = [_dict.allKeys sortedArrayUsingSelector:@selector(compare:)];
    //取出右边默认的数据
    _values = _dict[_keys.firstObject];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDictFromFile];
    //设置pickerView的数据源和代理
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    // Do any additional setup after loading the view.
}
- (IBAction)selectedBtnClick:(UIButton *)sender {
    //左列选中的行
    NSInteger leftRow = [_pickerView selectedRowInComponent:0];
    //右列选中行
    NSInteger rightRow = [_pickerView selectedRowInComponent:1];
    
    NSString *leftString = _keys[leftRow];
    NSString *rightString = _values[rightRow];
    NSString *message = [NSString stringWithFormat:@"%@中的%@",leftString,rightString];
    UIAlertController *alertController  = [UIAlertController alertControllerWithTitle:@"您选中的是:" message:message preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - UIPickerViewDateSource
//列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
//每列中行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return _keys.count;
    }
    return _values.count;
}

#pragma mark -UIPickerViewDelegate

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return _keys[row];
    }
    
    return _values[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        NSString *key = _keys[row];
        _values = _dict[key];
        //刷新右边列
        [pickerView reloadComponent:1];
        //强制选中右边列中第0行
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
}

@end
