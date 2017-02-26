//
//  TTPoperCellFrame.m
//  testPopView
//
//  Created by Evan on 2017/2/25.
//  Copyright © 2017年 vanke. All rights reserved.
//

#import "TTPoperCellFrame.h"
#import "NSString+ContentSize.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kTextFont [UIFont systemFontOfSize:14]
#define kLabelWidth (kScreenWidth*0.7 - 10)
#define kLeftPadding 8
#define kToppding 8

@implementation TTPoperCellFrame

- (void)setContentModel:(TTPoperContentModel *)contentModel {
    
    _contentModel = contentModel;
    NSDictionary *contentDict = @{NSFontAttributeName: kTextFont};
    CGSize caculateSzie = CGSizeMake(kLabelWidth, MAXFLOAT);
    NSLog(@"content:%@", _contentModel.content);
    CGSize contentSize = [_contentModel.content textRectWithSize:caculateSzie attributes:contentDict].size;
    
    CGRect contentFrame;
    contentFrame.origin.x = kLeftPadding;
    contentFrame.origin.y = kToppding;
    contentFrame.size.width = kLabelWidth;
    contentFrame.size.height = contentSize.height;
    self.contentF = contentFrame;
    
    _cellHeight = kLeftPadding + contentSize.height + kLeftPadding;

}


+ (NSArray *)poperCellFrame:(NSArray *)contents {

    NSMutableArray *cellFrames = [[NSMutableArray alloc] init];
    for (NSString *str in contents) {
        
        TTPoperCellFrame *popCellFrame = [TTPoperCellFrame new];
        TTPoperContentModel *contentModel = [[TTPoperContentModel alloc] init];
        contentModel.content = str;
        popCellFrame.contentModel = contentModel;
        [cellFrames addObject:popCellFrame];
    }
    return cellFrames;
}

@end
