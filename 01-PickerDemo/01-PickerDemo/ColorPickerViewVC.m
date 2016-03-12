//
//  ColorPickerViewVC.m
//  01-PickerDemo
//
//  Created by qingyun on 16/3/12.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ColorPickerViewVC.h"

#define RGBMaxNum   255
#define StepValue   5
#define RowNum      RGBMaxNum / StepValue + 1

@interface ColorPickerViewVC ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIView *colorView;

@property (nonatomic) CGFloat redColorNum;
@property (nonatomic) CGFloat greenColorNum;
@property (nonatomic) CGFloat blueColorNum;

@end

@implementation ColorPickerViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSInteger redSelectedNum = arc4random() % RowNum;
    [self selectedPickerView:_pickerView forRow:redSelectedNum inComponent:RGBComponentTypeRed];
    
    NSInteger greenSelectedNum = arc4random() % RowNum;
    [self selectedPickerView:_pickerView forRow:greenSelectedNum inComponent:RGBComponentTypeGreen];
    
    NSInteger blueSelectedNum = arc4random() % RowNum;
    [self selectedPickerView:_pickerView forRow:blueSelectedNum inComponent:RGBComponentTypeBlue];
    
    // Do any additional setup after loading the view.
}

-(void)selectedPickerView:(UIPickerView *)pickerView forRow:(NSInteger)row inComponent:(NSInteger)component{
    [_pickerView selectRow:row inComponent:component animated:YES];
    [self pickerView:pickerView didSelectRow:row inComponent:component];
}

#pragma mark  - UIPickerViewDataSource

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return RowNum;
}

#pragma mark  - UIPickerViewDelegate

-(NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    CGFloat redNum = 0;
    CGFloat greenNum = 0;
    CGFloat blueNum = 0;
    
    switch (component) {
        case  RGBComponentTypeRed:
            redNum = row * StepValue / 255.0;
            break;
        case RGBComponentTypeGreen:
            greenNum = row * StepValue / 255.0;
            break;
        case RGBComponentTypeBlue:
            blueNum = row * StepValue / 255.0;
            break;
            
        default:
            break;
    }
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld",row * StepValue] attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:redNum green:greenNum blue:blueNum alpha:1.0]}];
    return attributedString;
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    CGFloat value = row * StepValue / 255.0;
    switch (component) {
        case RGBComponentTypeRed:
            _redColorNum = value;
            break;
        case RGBComponentTypeGreen:
            _greenColorNum = value;
            break;
        case RGBComponentTypeBlue:
            _blueColorNum = value;
            break;
            
        default:
            break;
    }
    
    _colorView.backgroundColor = [UIColor colorWithRed:_redColorNum green:_greenColorNum blue:_blueColorNum alpha:1.0];
}

@end
