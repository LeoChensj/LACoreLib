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
#import "Foundation+LACoreLib.h"


static const NSString *kLARegionDataKeyName         = @"name";
static const NSString *kLARegionDataKeyChildList    = @"childList";


@interface LAPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>

//View
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIPickerView *pickerView;

//data
@property (nonatomic, strong) NSArray *regionData;
@property (nonatomic, assign) NSUInteger regionIndex1;
@property (nonatomic, assign) NSUInteger regionIndex2;
@property (nonatomic, assign) NSUInteger regionIndex3;

@end


@implementation LAPickerView

- (instancetype)initWithType:(LAPickerViewType)type
{
    if (self = [super initWithFrame:CGRectMake(0, 0, LA_SCREEN_WIDTH, LA_SCREEN_HEIGHT)])
    {
        self.type = type;
        
        self.contentHeight = 280;
        
        
        [self getDataSource];
        
        
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LA_SCREEN_WIDTH, LA_SCREEN_HEIGHT)];
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _maskView.alpha = 0;
        [self addSubview:_maskView];
        UITapGestureRecognizer *tapMask = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenInWindow)];
        [_maskView addGestureRecognizer:tapMask];
        
        
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, LA_SCREEN_HEIGHT, LA_SCREEN_WIDTH, self.contentHeight)];
        _contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_contentView];
        
        
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, LA_SCREEN_WIDTH, self.contentHeight - 40)];
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        [_contentView addSubview:_pickerView];
        
        
        
        _btnConfirm = [[UIButton alloc] initWithFrame:CGRectMake(_pickerView.la_right - 80, 0, 80, 40)];
        [_btnConfirm setTitle:@"确定"
                     forState:UIControlStateNormal];
        [_btnConfirm setTitleColor:[UIColor la_colorWithCSS:@"#328BEF"]
                          forState:UIControlStateNormal];
        _btnConfirm.titleLabel.font = [UIFont systemFontOfSize:16];
        [_contentView addSubview:_btnConfirm];
        [_btnConfirm addTarget:self
                        action:@selector(onConfirm)
              forControlEvents:UIControlEventTouchUpInside];
        
        
        [self setupDefaultProperty];
    }
    
    return self;
}

- (void)getDataSource
{
    //地区选择数据源
    if (self.type == LAPickerViewTypeRegion)
    {
        NSString *regionPath = [[NSBundle mainBundle] pathForResource:@"LARegion"
                                                               ofType:@"json"];
        NSData *regionData = [NSData dataWithContentsOfFile:regionPath];
        self.regionData = [NSJSONSerialization JSONObjectWithData:regionData
                                                          options:NSJSONReadingAllowFragments
                                                            error:nil];
    }
}

- (void)setupDefaultProperty
{
    self.textColor = [UIColor blackColor];
    self.textFont = [UIFont systemFontOfSize:15];
    
    if (self.type == LAPickerViewTypeNormal)
    {
        self.selectNormalIndex = nil;
    }
    else if (self.type == LAPickerViewTypeDate)
    {
        self.minDate = [NSDate la_dateWithYear:1
                                         month:1
                                           day:1];
        self.maxDate = [NSDate la_dateWithYear:3000
                                         month:1
                                           day:1];
        self.selectDate = [NSDate date];
    }
    else if (self.type == LAPickerViewTypeTime)
    {
        self.selectHour = 0;
        self.selectMinute = 0;
    }
    else if (self.type == LAPickerViewTypeRegion)
    {
        self.selectProvince = @"北京";
        self.selectCity = @"北京";
        self.selectArea = @"东城区";
    }
}


- (void)showInWindow
{
    self.hidden = NO;
    [LA_KeyWindow addSubview:self];
    
    [self.pickerView reloadAllComponents];
    
    [UIView animateWithDuration:0.15 animations:^{
        
        self.maskView.alpha = 1;
        self.contentView.la_y = LA_SCREEN_HEIGHT - self.contentHeight;
        
    }];
}

- (void)hiddenInWindow
{
    [UIView animateWithDuration:0.15 animations:^{
        
        self.maskView.alpha = 0;
        self.contentView.la_y = LA_SCREEN_HEIGHT;
        
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

- (void)setDataArrayNormal:(NSArray<NSArray<NSString *> *> *)dataArrayNormal
{
    _dataArrayNormal = dataArrayNormal;
    
    if (self.type == LAPickerViewTypeNormal)
    {
        [self.pickerView reloadAllComponents];
        
        self.selectNormalIndex = (NSArray <NSNumber *>*)[dataArrayNormal la_mapArrayWithBlock:^id(NSUInteger idx, NSArray<NSString *> *obj) {
            
            return @0;
            
        }];
    }
}

- (void)setSelectNormalIndex:(NSArray<NSNumber *> *)selectNormalIndex
{
    _selectNormalIndex = selectNormalIndex;
    
    if (self.type == LAPickerViewTypeNormal)
    {
        for (NSUInteger i = 0; i < self.pickerView.numberOfComponents; i++)
        {
            NSUInteger row = 0;
            if (selectNormalIndex[i].integerValue <= 0)
            {
                row = 0;
            }
            else if (selectNormalIndex[i].integerValue > 0 &&
                selectNormalIndex[i].integerValue < [self.pickerView numberOfRowsInComponent:i])
            {
                row = selectNormalIndex[i].integerValue;
            }
            else
            {
                row = [self.pickerView numberOfRowsInComponent:i] - 1;
            }
            
            [self.pickerView selectRow:row
                           inComponent:i
                              animated:NO];
        }
    }
}

- (void)setSelectDate:(NSDate *)selectDate
{
    if ([selectDate la_isLessDate:self.minDate])
    {
        _selectDate = self.minDate;
    }
    else if ([selectDate la_isGreaterDate:self.maxDate])
    {
        _selectDate = self.maxDate;
    }
    else
    {
        _selectDate = selectDate;
    }
    
    
    if (self.type == LAPickerViewTypeDate)
    {
        [self.pickerView selectRow:(_selectDate.la_year - 1)
                       inComponent:0
                          animated:NO];
        [self.pickerView selectRow:(_selectDate.la_month - 1)
                       inComponent:1
                          animated:NO];
        [self.pickerView selectRow:(_selectDate.la_day - 1)
                       inComponent:2
                          animated:NO];
    }
}

- (void)setSelectHour:(NSUInteger)selectHour
{
    if (selectHour > 24)
    {
        _selectHour = 24;
    }
    else
    {
        _selectHour = selectHour;
    }
    
    if (self.type == LAPickerViewTypeTime)
    {
        [self.pickerView selectRow:_selectHour
                       inComponent:0
                          animated:NO];
    }
}

- (void)setSelectMinute:(NSUInteger)selectMinute
{
    if (selectMinute > 60)
    {
        _selectMinute = 60;
    }
    else
    {
        _selectMinute = selectMinute;
    }
    
    if (self.type == LAPickerViewTypeTime)
    {
        [self.pickerView selectRow:_selectMinute
                       inComponent:1
                          animated:NO];
    }
}

- (void)setSelectProvince:(NSString *)selectProvince
{
    _selectProvince = selectProvince;
    
    if (self.type == LAPickerViewTypeRegion)
    {
        for (NSUInteger i = 0; i < self.regionData.count; i++)
        {
            NSDictionary *dict = [self.regionData la_objectAtIndex:i];
            NSString *name = [dict la_stringForKey:kLARegionDataKeyName
                                      defaultValue:@""];
            if ([name isEqualToString:selectProvince])
            {
                self.regionIndex1 = i;
                
                [self.pickerView selectRow:self.regionIndex1
                               inComponent:0
                                  animated:NO];
                
                
                [self.pickerView reloadComponent:1];
                [self.pickerView selectRow:0
                               inComponent:1
                                  animated:YES];
                
                [self.pickerView reloadComponent:2];
                [self.pickerView selectRow:0
                               inComponent:2
                                  animated:YES];
                
                break;
            }
        }
    }
}

- (void)setSelectCity:(NSString *)selectCity
{
    _selectCity = selectCity;
    
    if (self.type == LAPickerViewTypeRegion)
    {
        NSDictionary *provinceDict = [self.regionData la_objectAtIndex:self.regionIndex1];
        NSArray *cityList = [provinceDict la_arrayForKey:kLARegionDataKeyChildList
                                            defaultValue:@[]];
        for (NSUInteger i = 0; i < cityList.count; i++)
        {
            NSDictionary *cityDict = [cityList la_objectAtIndex:i];
            NSString *cityName = [cityDict la_stringForKey:kLARegionDataKeyName
                                              defaultValue:@""];
            if ([cityName isEqualToString:selectCity])
            {
                self.regionIndex2 = i;
                
                [self.pickerView selectRow:self.regionIndex2
                               inComponent:1
                                  animated:NO];
                
                [self.pickerView reloadComponent:2];
                [self.pickerView selectRow:0
                               inComponent:2
                                  animated:YES];
                
                break;
            }
        }
    }
}

- (void)setSelectArea:(NSString *)selectArea
{
    _selectArea = selectArea;
    
    if (self.type == LAPickerViewTypeRegion)
    {
        NSDictionary *provinceDict = [self.regionData la_objectAtIndex:self.regionIndex1];
        NSArray *cityList = [provinceDict la_arrayForKey:kLARegionDataKeyChildList
                                            defaultValue:@[]];
        NSDictionary *cityDict = [cityList la_objectAtIndex:self.regionIndex2];
        NSArray *areaList = [cityDict la_arrayForKey:kLARegionDataKeyChildList
                                        defaultValue:@[]];
        for (NSUInteger i = 0; i < areaList.count; i++)
        {
            NSString *areaName = [areaList la_objectAtIndex:i];
            if ([areaName isEqualToString:selectArea])
            {
                self.regionIndex3 = i;
                
                [self.pickerView selectRow:self.regionIndex3
                               inComponent:2
                                  animated:NO];
                
                break;
            }
        }
        
    }
}





#pragma mark - Method
- (void)onConfirm
{
    switch (self.type)
    {
        case LAPickerViewTypeNormal:
        {
            self.blockNormalConfirm ?
            self.blockNormalConfirm(self.selectNormalIndex) :
            nil;
            
            break;
        }
        case LAPickerViewTypeDate:
        {
            self.blockDateConfirm ?
            self.blockDateConfirm(self.selectDate) :
            nil;
            
            break;
        }
        case LAPickerViewTypeTime:
        {
            self.blockTimeConfirm ?
            self.blockTimeConfirm(self.selectHour, self.selectMinute) :
            nil;
            
            break;
        }
        case LAPickerViewTypeRegion:
        {
            self.blockRegionConfirm ?
            self.blockRegionConfirm(self.selectProvince, self.selectCity, self.selectArea) :
            nil;
            
            break;
        }
            
        default:
            break;
    }
    
    [self hiddenInWindow];
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
            return 2;
            
            break;
        }
        case LAPickerViewTypeRegion:
        {
            return 3;
            
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
            if (component == 0)
            {
                return 3000;
            }
            else if (component == 1)
            {
                return 12;
            }
            else if (component == 2)
            {
                return 31;
            }
            
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
            
            return 0;
            
            break;
        }
        case LAPickerViewTypeRegion:
        {
            if (component == 0)
            {
                return self.regionData.count;
            }
            else if(component == 1)
            {
                NSDictionary *provinceDict = [self.regionData la_objectAtIndex:self.regionIndex1];
                NSArray *cityList = [provinceDict la_arrayForKey:kLARegionDataKeyChildList
                                                    defaultValue:@[]];
                return cityList.count;
            }
            else if (component == 2)
            {
                NSDictionary *provinceDict = [self.regionData la_objectAtIndex:self.regionIndex1];
                NSArray *cityList = [provinceDict la_arrayForKey:kLARegionDataKeyChildList
                                                    defaultValue:@[]];
                NSDictionary *cityDict = [cityList la_objectAtIndex:self.regionIndex2];
                NSArray *areaList = [cityDict la_arrayForKey:kLARegionDataKeyChildList
                                                defaultValue:@[]];
                return areaList.count;
            }
            
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
            if (component == 0)
            {
                label.text = $(@"%li", row + 1);
                
                if ([self isYearValidWithRow:row])
                {
                    label.textColor = self.textColor;
                }
                else
                {
                    label.textColor = [UIColor lightGrayColor];
                }
                
            }
            else if (component == 1)
            {
                label.text = $(@"%li", row + 1);
                
                if ([self isMonthValidWithRow:row])
                {
                    label.textColor = self.textColor;
                }
                else
                {
                    label.textColor = [UIColor lightGrayColor];
                }
            }
            else if (component == 2)
            {
                label.text = $(@"%li", row + 1);
                
                if ([self isDayValidWithRow:row])
                {
                    label.textColor = self.textColor;
                }
                else
                {
                    label.textColor = [UIColor lightGrayColor];
                }
            }
            
            break;
        }
        case LAPickerViewTypeTime:
        {
            label.text = $(@"%02li", row);
            
            break;
        }
        case LAPickerViewTypeRegion:
        {
            if (component == 0)
            {
                NSDictionary *provinceDict = [self.regionData la_objectAtIndex:row];
                NSString *provinceName = [provinceDict la_stringForKey:kLARegionDataKeyName
                                                          defaultValue:@""];
                label.text = provinceName;
            }
            else if (component == 1)
            {
                NSDictionary *provinceDict = [self.regionData la_objectAtIndex:self.regionIndex1];
                NSArray *cityList = [provinceDict la_arrayForKey:kLARegionDataKeyChildList
                                                    defaultValue:@[]];
                NSDictionary *cityDict = [cityList la_objectAtIndex:row];
                NSString *cityName = [cityDict la_stringForKey:kLARegionDataKeyName
                                                  defaultValue:@""];
                label.text = cityName;
            }
            else if (component == 2)
            {
                NSDictionary *provinceDict = [self.regionData la_objectAtIndex:self.regionIndex1];
                NSArray *cityList = [provinceDict la_arrayForKey:kLARegionDataKeyChildList
                                                    defaultValue:@[]];
                NSDictionary *cityDict = [cityList la_objectAtIndex:self.regionIndex2];
                NSArray *areaList = [cityDict la_arrayForKey:kLARegionDataKeyChildList
                                                defaultValue:@[]];
                NSString *areaName = [areaList la_stringAtIndex:row
                                                   defaultValue:@""];
                label.text = areaName;
            }
            
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
            for (NSUInteger i = 0; i < pickerView.numberOfComponents; i++)
            {
                if (component == i)
                {
                    self.selectNormalIndex = [self.selectNormalIndex la_mapArrayWithBlock:^id(NSUInteger idx, NSNumber *obj) {
                        
                        if (idx == i)
                        {
                            return [NSNumber numberWithInteger:row];
                        }
                        
                        return obj;
                        
                    }];
                }
            }
            
            break;
        }
        case LAPickerViewTypeDate:
        {
            if (component == 0)
            {
                self.selectDate = [self validDateWithYear:row + 1
                                                    month:self.selectDate.la_month
                                                      day:self.selectDate.la_day];
                
                [pickerView reloadComponent:1];
                [pickerView reloadComponent:2];
                
                if ([pickerView numberOfRowsInComponent:0] != self.selectDate.la_year - 1)
                {
                    [pickerView selectRow:self.selectDate.la_year - 1
                              inComponent:0
                                 animated:YES];
                }
                
                if ([pickerView numberOfRowsInComponent:1] != self.selectDate.la_month - 1)
                {
                    [pickerView selectRow:self.selectDate.la_month - 1
                              inComponent:1
                                 animated:YES];
                }
                
                if ([pickerView numberOfRowsInComponent:2] != self.selectDate.la_day - 1)
                {
                    [pickerView selectRow:self.selectDate.la_day - 1
                              inComponent:2
                                 animated:YES];
                }
                
            }
            else if (component == 1)
            {
                self.selectDate = [self validDateWithYear:self.selectDate.la_year
                                                    month:row + 1
                                                      day:self.selectDate.la_day];
                
                [pickerView reloadComponent:2];
                
                if ([pickerView numberOfRowsInComponent:1] != self.selectDate.la_month - 1)
                {
                    [pickerView selectRow:self.selectDate.la_month - 1
                              inComponent:1
                                 animated:YES];
                }
                
                if ([pickerView numberOfRowsInComponent:2] != self.selectDate.la_day - 1)
                {
                    [pickerView selectRow:self.selectDate.la_day - 1
                              inComponent:2
                                 animated:YES];
                }
            }
            else if (component == 2)
            {
                self.selectDate = [self validDateWithYear:self.selectDate.la_year
                                                    month:self.selectDate.la_month
                                                      day:row + 1];
                
                if ([pickerView numberOfRowsInComponent:2] != self.selectDate.la_day - 1)
                {
                    [pickerView selectRow:self.selectDate.la_day - 1
                              inComponent:2
                                 animated:YES];
                }
            }
            
            break;
        }
        case LAPickerViewTypeTime:
        {
            if (component == 0)
            {
                self.selectHour = row;
            }
            else if (component == 1)
            {
                self.selectMinute = row;
            }
            
            break;
        }
        case LAPickerViewTypeRegion:
        {
            if (component == 0)
            {
                self.regionIndex1 = row;
                
                NSDictionary *provinceDict = [self.regionData la_objectAtIndex:self.regionIndex1];
                self.selectProvince = [provinceDict la_stringForKey:kLARegionDataKeyName
                                                       defaultValue:@""];
                NSArray *cityList = [provinceDict la_arrayForKey:kLARegionDataKeyChildList
                                                    defaultValue:@[]];
                NSDictionary *cityDict = [cityList la_objectAtIndex:0];
                self.selectCity = [cityDict la_stringForKey:kLARegionDataKeyName
                                               defaultValue:@""];
                NSArray *areaList = [cityDict la_arrayForKey:kLARegionDataKeyChildList
                                                defaultValue:@[]];
                self.selectArea = [areaList la_objectAtIndex:0];
                
                [pickerView reloadComponent:1];
                [pickerView selectRow:0
                          inComponent:1
                             animated:YES];
                
                [pickerView reloadComponent:2];
                [pickerView selectRow:0
                          inComponent:2
                             animated:YES];
            }
            else if (component == 1)
            {
                self.regionIndex2 = row;
                
                NSDictionary *provinceDict = [self.regionData la_objectAtIndex:self.regionIndex1];
                NSArray *cityList = [provinceDict la_arrayForKey:kLARegionDataKeyChildList
                                                    defaultValue:@[]];
                NSDictionary *cityDict = [cityList la_objectAtIndex:self.regionIndex2];
                self.selectCity = [cityDict la_stringForKey:kLARegionDataKeyName
                                               defaultValue:@""];
                NSArray *areaList = [cityDict la_arrayForKey:kLARegionDataKeyChildList
                                                defaultValue:@[]];
                self.selectArea = [areaList la_objectAtIndex:0];
                
                
                [pickerView reloadComponent:2];
                [pickerView selectRow:0
                          inComponent:2
                             animated:YES];
            }
            else if (component == 2)
            {
                self.regionIndex3 = row;
                
                NSDictionary *provinceDict = [self.regionData la_objectAtIndex:self.regionIndex1];
                NSArray *cityList = [provinceDict la_arrayForKey:kLARegionDataKeyChildList
                                                    defaultValue:@[]];
                NSDictionary *cityDict = [cityList la_objectAtIndex:self.regionIndex2];
                NSArray *areaList = [cityDict la_arrayForKey:kLARegionDataKeyChildList
                                                defaultValue:@[]];
                self.selectArea = [areaList la_objectAtIndex:self.regionIndex3];
            }
            
            break;
        }
            
        default:
            break;
    }
}







#pragma mark - Help
- (NSUInteger)getYearCount
{
    if (self.minDate &&
        self.maxDate &&
        [self.minDate la_isLessOrEqualToDate:self.maxDate])
    {
        NSUInteger yearCount = self.maxDate.la_year - self.minDate.la_year + 1;
        
        return yearCount;
    }
    
    return 0;
}

- (NSUInteger)getDayCountWithYear:(NSUInteger)year
                            month:(NSUInteger)month
{
    NSDate *date = [NSDate la_dateWithYear:year
                                     month:month
                                       day:1];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay
                                   inUnit:NSCalendarUnitMonth
                                  forDate:date];
    NSUInteger numberOfDaysInMonth = range.length;
    
    return numberOfDaysInMonth;
}

- (BOOL)isYearValidWithRow:(NSUInteger)row
{
    return (row + 1) >= self.minDate.la_year &&
           (row + 1) <= self.maxDate.la_year;
}

- (BOOL)isMonthValidWithRow:(NSUInteger)row
{
    NSDate *dateMin = [NSDate la_dateWithYear:self.selectDate.la_year
                                        month:row + 1
                                          day:self.minDate.la_day];
    NSDate *dateMax = [NSDate la_dateWithYear:self.selectDate.la_year
                                        month:row + 1
                                          day:self.maxDate.la_day];
    
    return [dateMin la_isGreaterOrEqualToDate:self.minDate] &&
           [dateMax la_isLessOrEqualToDate:self.maxDate];
}

- (BOOL)isDayValidWithRow:(NSUInteger)row
{
    NSDate *date = [NSDate la_dateWithYear:self.selectDate.la_year
                                     month:self.selectDate.la_month
                                       day:row + 1];
    NSUInteger dayCount = [self getDayCountWithYear:self.selectDate.la_year
                                              month:self.selectDate.la_month];
    
    return [date la_isGreaterOrEqualToDate:self.minDate] &&
           [date la_isLessOrEqualToDate:self.maxDate] &&
           row + 1 <= dayCount;
}

- (NSDate *)validDateWithYear:(NSUInteger)year
                        month:(NSUInteger)month
                          day:(NSUInteger)day
{
    NSUInteger dayCount = [self getDayCountWithYear:year
                                              month:month];
    
    NSUInteger validDay = day <= dayCount ? day : dayCount;
    
    NSDate *date = [NSDate la_dateWithYear:year
                                     month:month
                                       day:validDay];
    
    if ([date la_isLessDate:self.minDate])
    {
        date = self.minDate;
    }
    else if ([date la_isGreaterDate:self.maxDate])
    {
        date = self.maxDate;
    }
    
    return date;
}



//- (void)dealloc
//{
//    LALog(@"dealloc-LAPickerView");
//}


@end
