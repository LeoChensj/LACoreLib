//
//  LABannerView.m
//  LACoreLib
//
//  Created by Leo.Chen on 2018/7/25.
//  Copyright © 2018年 Leo.Chen. All rights reserved.
//

#import "LABannerView.h"
#import "LABannerViewCell.h"
#import "LAUIDefines.h"


@interface LABannerView () <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

//View
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSTimer *timer;

//data
@property (nonatomic, assign) NSUInteger factor;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, strong) UIImage *placeholderImage;

@property (nonatomic, assign) NSUInteger rowOfIndexPath;

@end


@implementation LABannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.itemSize = frame.size;
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.itemSize = frame.size;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [self addSubview:_collectionView];
        
        [_collectionView registerClass:[LABannerViewCell class] forCellWithReuseIdentifier:@"LABannerViewCell"];
        
        
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, frame.size.height - 20, frame.size.width, 20)];
        [self addSubview:_pageControl];
        
        
        
        
        self.isShowPageControl = YES;
        self.pageControlNormalColor = [UIColor lightGrayColor];
        self.pageControlSelectColor = [UIColor whiteColor];
        self.isAutoPlay = YES;
        self.playInterval = 5;
        self.isCircular = YES;
    }
    
    return self;
}




#pragma mark - Set
- (void)setIsShowPageControl:(BOOL)isShowPageControl
{
    _isShowPageControl = isShowPageControl;
    
    _pageControl.hidden = !isShowPageControl;
}

- (void)setPageControlNormalColor:(UIColor *)pageControlNormalColor
{
    _pageControlNormalColor = pageControlNormalColor;
    
    _pageControl.pageIndicatorTintColor = pageControlNormalColor;
}

- (void)setPageControlSelectColor:(UIColor *)pageControlSelectColor
{
    _pageControlSelectColor = pageControlSelectColor;
    
    _pageControl.currentPageIndicatorTintColor = pageControlSelectColor;
}

- (void)setIsCircular:(BOOL)isCircular
{
    _isCircular = isCircular;
    
    self.factor = isCircular ? 100 : 1;
}




- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    
    [self.collectionView reloadData];
    
    
    //初始化index、collectionView显示位置
    if (self.factor != 1)
    {
        _rowOfIndexPath = self.factor * 0.5 * dataArray.count;
        self.collectionView.contentOffset = CGPointMake(self.itemSize.width * _rowOfIndexPath, 0);
    }
    
    
    //配置pageControl
    if (self.isShowPageControl)
    {
        _pageControl.numberOfPages = dataArray.count;
    }
    
    
    //开启定时器
    [self startTimer];
}

- (void)setRowOfIndexPath:(NSUInteger)rowOfIndexPath
{
    _rowOfIndexPath = rowOfIndexPath;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowOfIndexPath
                                                inSection:0];
    [self.collectionView selectItemAtIndexPath:indexPath
                                      animated:YES
                                scrollPosition:UICollectionViewScrollPositionLeft];
}




#pragma mark - Read
- (NSUInteger)index
{
    if (self.dataArray.count == 0)
    {
        return 0;
    }
    else
    {
        return _rowOfIndexPath % self.dataArray.count;
    }
}




#pragma mark - Timer
- (void)releaseTimer
{
    if (_timer)
    {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)startTimer
{
    [self releaseTimer];
    if (self.isAutoPlay)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:self.playInterval
                                                  target:self
                                                selector:@selector(onTimer)
                                                userInfo:nil
                                                 repeats:YES];
    }
}



#pragma mark - UICollectionViewDataSource UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count * self.factor;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"LABannerViewCell";
    LABannerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    
    NSUInteger index = (indexPath.row % self.dataArray.count);
    id data = [self.dataArray objectAtIndex:index];
    if ([data isKindOfClass:[UIImage class]])
    {
        cell.image = data;
    }
    else if ([data isKindOfClass:[NSString class]])
    {
        cell.placeholderImage = self.placeholderImage;
        cell.urlImage = data;
    }
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger index = indexPath.row % self.dataArray.count;
    
    self.blockTap ? self.blockTap(index) : nil;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //手动拖拽开始时调用
    [self releaseTimer];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //手动拖拽停止时调用
    _rowOfIndexPath = scrollView.contentOffset.x / self.itemSize.width;
    
    if (self.isCircular)
    {
        if (_rowOfIndexPath == 0)
        {
            _rowOfIndexPath = self.factor * 0.5 * self.dataArray.count;
            self.collectionView.contentOffset = CGPointMake(self.itemSize.width * _rowOfIndexPath, 0);
        }
        else if (_rowOfIndexPath == (self.factor * self.dataArray.count - 1))
        {
            _rowOfIndexPath = self.factor * 0.5 * self.dataArray.count + self.dataArray.count - 1;
            self.collectionView.contentOffset = CGPointMake(self.itemSize.width * _rowOfIndexPath, 0);
        }
    }
    
    
    NSUInteger index = _rowOfIndexPath % self.dataArray.count;
    _pageControl.currentPage = index;
    
    [self startTimer];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //定时器滑动停止时调用
    if (self.isAutoPlay)
    {
        NSUInteger index = _rowOfIndexPath % self.dataArray.count;
        _pageControl.currentPage = index;
    }
}




#pragma mark - Help
- (void)onTimer
{
    if (self.isAutoPlay)
    {
        if (self.isCircular)
        {
            if (_rowOfIndexPath == self.dataArray.count * self.factor)
            {
                _rowOfIndexPath = self.factor * 0.5 * self.dataArray.count + self.dataArray.count - 1;
                self.collectionView.contentOffset = CGPointMake(self.itemSize.width * _rowOfIndexPath, 0);
            }
            
            self.rowOfIndexPath += 1;
        }
        else
        {
            self.rowOfIndexPath = (self.rowOfIndexPath + 1) % self.dataArray.count;
        }
    }
}

@end
