//
//  SinglePcikerViewVC.m
//  01-PickerDemo
//
//  Created by qingyun on 16/3/12.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "SinglePcikerViewVC.h"

@interface SinglePcikerViewVC ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) NSArray *datas;
@end

@implementation SinglePcikerViewVC

-(void)loadDatas{
    _datas = @[@"zhangsan",@"lisi",@"wangwu",@"zhaoliu",@"tianqi",@"songba"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDatas];
    
    //设置pickerView的数据源和代理
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    
    _label.text = _datas[0];
    // Do any additional setup after loading the view.
}

#pragma mark -UIPickerViewDataSource
//component
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
//row
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _datas.count;
}

#pragma mark -UIPickerViewDelegate

//标题
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (row != 0) {
        return _datas[row];
    }
    return nil;
}

//属性标题
-(NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (row == 0) {
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:_datas[0] attributes:@{NSUnderlineStyleAttributeName:@1,NSForegroundColorAttributeName:[UIColor redColor]}];
        return attributedString;
    }
    return nil;
}

//行高
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 60;
}

//已经选中行
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _label.text = _datas[row];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
