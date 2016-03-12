//
//  SoltPickerVC.m
//  01-PickerDemo
//
//  Created by qingyun on 16/3/12.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "SoltPickerVC.h"

#import <AVFoundation/AVFoundation.h>

@interface SoltPickerVC ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, strong) NSArray *imageNames;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic) NSInteger hardLevel;          //难易程度

@property (nonatomic, strong) AVAudioPlayer *player;        //声音播放器
@end

@implementation SoltPickerVC

//开始游戏
- (IBAction)start:(UIButton *)sender {
    _label.text = nil;
    //声明胜利状态
    BOOL isWin = NO;
    //连续相同的个数
    int numOfSame = 1;
    //保存上一列中选中的行
    int lastRow = 1;
    
    for (int i = 0; i < 5; i++) {
        //创建一个随机数
        int seletedRowNum = arc4random() % _imageNames.count;
        if (i == 0) {
            lastRow = seletedRowNum;
            numOfSame = 1;
        }else{
            if (lastRow == seletedRowNum) {
                numOfSame++;
            }else{
                numOfSame = 1;
            }
            lastRow = seletedRowNum;
        }
        //滚动pickerView
        [_pickerView selectRow:seletedRowNum inComponent:i animated:YES];
        if (numOfSame >= _hardLevel) {
            isWin = YES;
        }
    }
    //滚轮的声音
    NSString *wheelPath = [[NSBundle mainBundle] pathForResource:@"crunch" ofType:@"wav"];
    [self playSound:wheelPath];
    
    if (isWin) {
        _label.text = @"win!!!";
        //胜利的号角
        NSString *winPath = [[NSBundle mainBundle] pathForResource:@"win" ofType:@"wav"];
        [self playSound:winPath];
    }
    
}

-(void)playSound:(NSString *)path{
    NSError *error = nil;
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:&error];
    //分配播放需要的资源,并且将其加入到内部的播放队列
    [_player prepareToPlay];
    [_player play];
}

-(void)loadImageNames{
    _imageNames = @[@"apple",@"bar",@"cherry",@"crown",@"lemon",@"seven"];
}

//更改游戏难易程度
- (IBAction)changeHardlevel:(UISegmentedControl *)sender {
    _hardLevel = _segmentedControl.selectedSegmentIndex + 2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadImageNames];
    //设置pickerView的数据源和代理
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    //设置游戏的默认难易程度
    _hardLevel = _segmentedControl.selectedSegmentIndex + 2;
    
    [self start:nil];
    // Do any additional setup after loading the view.
}

#pragma mark  -UIPickerViewDataSource
//列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 5;
}
//列中行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _imageNames.count;
}

#pragma mark  -UIPickerViewDelegate
//每行中的视图
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_imageNames[row]]];
    return imageView;
}
//设置行高
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 80;
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
