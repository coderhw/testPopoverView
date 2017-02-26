//
//  TTPopoerView.m
//  testPopView
//
//  Created by Evan on 2017/2/25.
//  Copyright © 2017年 vanke. All rights reserved.
//

#import "TTPopoerView.h"
#import "TTPoperCellFrame.h"
#import "TTPoperCell.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kWidth  kScreenWidth*0.7
#define kHeight kScreenHeight/3
@interface TTPopoerView ()<UITableViewDelegate, UITableViewDataSource>

#pragma mark - UI

@property (nonatomic, strong) UIWindow      *keyWindow; //current window
@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) UIView        *shadeView; ///shade view
@property (nonatomic, weak) CAShapeLayer    *borderLayer; ///< 边框Layer
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture; ///< 点击背景阴影的手势
@property (nonatomic, assign) CGFloat viewHeight; //
#pragma mark - Data
@property (nonatomic, strong) NSArray *dataSources;

@end

@implementation TTPopoerView

+ (instancetype)popoverView {

    return [[self alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];

}

#pragma mark - Lift Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame])) return nil;
    [self initialize];
    [self configData];

    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self configData];
    [self initialize];

}


#pragma mark - Init
- (void)initialize {
    
    [self addSubview:self.tableView];
}

- (void)configData {
    
    NSArray *contents = @[@"中华人民共和国成立后，曾先后兼任中央人民政府主席暨人民",
                          @"中华人民共和国成立后，曾先后兼任中央人民政府主席暨人民革命军事委员会主",
                          @"中华人民共和国成立后，曾先后兼任中央人民政府主席暨人民革命军事委员会主席、中华人民共和",
                          @"中华人民共和国成立后，曾先后兼任中央人民政府主席暨人民革命军事委员会主席、中华人民共和国主席暨国防委员会主席中华人民共和国成立后，曾先后兼任中央人民政府主席暨人民革命军事委员会主席、中华人民共和国主席暨国防委员会主席"];
    _dataSources = [TTPoperCellFrame poperCellFrame:contents];
}


#pragma mark - Get & Set Method
- (UITableView *)tableView {
    
    if(_tableView == nil){
        _tableView = [[UITableView alloc]
                      initWithFrame:CGRectMake(0, 0,
                                               CGRectGetWidth(self.bounds),
                                               CGRectGetHeight(self.bounds))
                      style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (UIView *)shadeView {
    
    if(_shadeView == nil){
        _shadeView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _shadeView.backgroundColor = [UIColor blackColor];
        _shadeView.alpha = 0.5;
        _shadeView.userInteractionEnabled = YES;
        
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        [_shadeView addGestureRecognizer:_tapGesture];
        
    }
    

    return _shadeView;
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cellIdentifier";
    TTPoperCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        
        cell = [[TTPoperCell alloc]
                                 initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    TTPoperCellFrame *cellFrameModel = [_dataSources objectAtIndex:indexPath.row];
    cell.cellFrame = cellFrameModel;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TTPoperCellFrame *cellFrameModel = [_dataSources objectAtIndex:indexPath.row];
    CGFloat height = cellFrameModel.cellHeight;
    _viewHeight += height;
    return  height;
}

- (void)showToPoint:(CGPoint)toPoint withIndexBlock:(TTPopoerIndexBlock)popIndexBlock {
    
    CGPoint point = CGPointMake(toPoint.x - kWidth, toPoint.y);
    self.backgroundColor = [UIColor whiteColor];
    _tableView.backgroundColor = [UIColor clearColor];

    self.layer.borderWidth = 1;
    self.layer.borderColor = _tableView.separatorColor.CGColor;
    self.layer.cornerRadius = 5.0f;
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
    
    [_tableView reloadData];

    [self addSubview:self.tableView];
    self.frame = CGRectMake(point.x, point.y, kWidth, _viewHeight);
    
    CGRect tableViewF = _tableView.frame;
    tableViewF.size.height = _viewHeight;
    self.tableView.frame = tableViewF;
    
    
    CGRect oldFrame = self.frame;
    self.layer.anchorPoint = CGPointMake(1, 0);
    self.frame = oldFrame;
    self.transform = CGAffineTransformMakeScale(0.01f, 0.01f);
    [UIView animateWithDuration:0.25f animations:^{
        self.transform = CGAffineTransformIdentity;
    }];
    
    self.popIndexBlock = popIndexBlock;
    [[[UIApplication sharedApplication].keyWindow.subviews objectAtIndex:0] addSubview:self.shadeView];
    [[[UIApplication sharedApplication].keyWindow.subviews objectAtIndex:0] addSubview:self];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(self.popIndexBlock){
        self.popIndexBlock(indexPath.row);
    }
    [self tapGesture:nil];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - Private
- (void)tapGesture:(UITapGestureRecognizer *)tap {
    [self removeFromSuperview];
    [self.shadeView removeFromSuperview];
}


@end
