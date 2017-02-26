//
//  TTPoperCellFrame.h
//  testPopView
//
//  Created by Evan on 2017/2/25.
//  Copyright © 2017年 vanke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TTPoperContentModel.h"

@interface TTPoperCellFrame : NSObject

@property (nonatomic, assign) CGRect contentF;
@property (nonatomic, strong) TTPoperContentModel *contentModel;

@property (nonatomic, assign, readonly) CGFloat cellHeight;


+ (NSArray *)poperCellFrame:(NSArray *)contents;

@end
