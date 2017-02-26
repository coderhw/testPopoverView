//
//  TTPoperCell.m
//  testPopView
//
//  Created by Evan on 2017/2/25.
//  Copyright © 2017年 vanke. All rights reserved.
//

#import "TTPoperCell.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kTextFont [UIFont systemFontOfSize:14]


@interface TTPoperCell ()

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation TTPoperCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    self.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.contentLabel];
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.contentView addSubview:self.contentLabel];
}


- (UILabel *)contentLabel {
    
    if(_contentLabel == nil){
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = kTextFont;
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
    
}

- (void)setCellFrame:(TTPoperCellFrame *)cellFrame {
    
    _cellFrame = cellFrame;
    [self settingData];
    [self settingFrame];
    
}


- (void)settingData {
    
    TTPoperContentModel *contentModel = self.cellFrame.contentModel;
    self.contentLabel.text = contentModel.content;
}

- (void)settingFrame {
    
    self.contentLabel.frame = _cellFrame.contentF;
    
}



@end
