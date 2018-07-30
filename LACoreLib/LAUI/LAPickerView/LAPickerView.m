//
//  LAPickerView.m
//  LACoreLibDemo
//
//  Created by Leo.Chen on 2018/7/27.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "LAPickerView.h"
#import "LAUIDefines.h"
#import "UIKit+LACoreLib.h"
#import "LABaseDefines.h"


@interface LAPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>

//View
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIPickerView *pickerView;

//data



@end


@implementation LAPickerView

- (instancetype)initWithType:(LAPickerViewType)type
{
    if (self = [super initWithFrame:CGRectMake(0, 0, LA_SCREEN_WIDTH, LA_SCREEN_HEIGHT)])
    {
        self.type = type;
        
        self.contentHeight = 260;
        
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LA_SCREEN_WIDTH, LA_SCREEN_HEIGHT)];
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _maskView.alpha = 0;
        [self addSubview:_maskView];
        UITapGestureRecognizer *tapMask = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenInWindow)];
        [_maskView addGestureRecognizer:tapMask];
        
        
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, LA_SCREEN_HEIGHT, LA_SCREEN_WIDTH, self.contentHeight)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        [self addSubview:_pickerView];
        
        
        _btnConfirm = [[UIButton alloc] initWithFrame:CGRectMake(_pickerView.la_right - 60, 0, 60, 40)];
        [_btnConfirm setTitle:@"确定"
                     forState:UIControlStateNormal];
        [_btnConfirm setTitleColor:[UIColor la_colorWithCSS:@"#328BEF"]
                          forState:UIControlStateNormal];
        _btnConfirm.titleLabel.font = [UIFont systemFontOfSize:14];
        [_pickerView addSubview:_btnConfirm];
    }
    
    return self;
}

- (void)showInWindow
{
    self.hidden = NO;
    [LA_KeyWindow addSubview:self];
    
    [self.pickerView reloadAllComponents];
    
    [UIView animateWithDuration:0.15 animations:^{
        
        self.maskView.alpha = 1;
        self.pickerView.la_y = LA_SCREEN_HEIGHT - self.contentHeight;
        
    }];
}

- (void)hiddenInWindow
{
    [UIView animateWithDuration:0.15 animations:^{
        
        self.maskView.alpha = 0;
        self.pickerView.la_y = LA_SCREEN_HEIGHT;
        
    } completion:^(BOOL finished) {
        
        self.hidden = YES;
        [self removeFromSuperview];
        
    }];
}





#pragma mark - Set
- (void)setContentHeight:(CGFloat)contentHeight
{
    _contentHeight = contentHeight;
    
    _pickerView.la_height = contentHeight;
}





#pragma mark - Method
- (void)onConfirm
{
    
}




#pragma mark - UIPickerViewDataSource UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    switch (self.type)
    {
        case LAPickerViewTypeNormal:
        {
            return self.dataArrayNormal.count;
            
            break;
        }
        case LAPickerViewTypeDate:
        {
            return 3;
            
            break;
        }
        case LAPickerViewTypeTime:
        {
            return 3;
            
            break;
        }
        case LAPickerViewTypeRegion:
        {
            break;
        }
            
        default:
            break;
    }
    
    return 0;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (self.type)
    {
        case LAPickerViewTypeNormal:
        {
            return self.dataArrayNormal[component].count;
            
            break;
        }
        case LAPickerViewTypeDate:
        {
            break;
        }
        case LAPickerViewTypeTime:
        {
            if (component == 0)
            {
                return 24;
            }
            else if (component == 1)
            {
                return 60;
            }
            
            return 60;
            
            break;
        }
        case LAPickerViewTypeRegion:
        {
            break;
        }
            
        default:
            break;
    }
    
    return 0;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    LA_AS(view, UILabel, label);
    
    if (!label)
    {
        label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = self.textColor;
        label.font = self.textFont;
    }
    
    switch (self.type)
    {
        case LAPickerViewTypeNormal:
        {
            label.text = self.dataArrayNormal[component][row];
            break;
        }
        case LAPickerViewTypeDate:
        {
            break;
        }
        case LAPickerViewTypeTime:
        {
            label.text = [NSString stringWithFormat:@"%02li", row];
            
            break;
        }
        case LAPickerViewTypeRegion:
        {
            break;
        }
            
        default:
            break;
    }
    
    return label;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (self.type)
    {
        case LAPickerViewTypeNormal:
        {
            break;
        }
        case LAPickerViewTypeDate:
        {
            break;
        }
        case LAPickerViewTypeTime:
        {
            break;
        }
        case LAPickerViewTypeRegion:
        {
            break;
        }
            
        default:
            break;
    }
}


//- (void)dealloc
//{
//    NSLog(@"dealloc-LAPickerView");
//}


@end
