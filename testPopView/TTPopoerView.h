//
//  TTPopoerView.h
//  testPopView
//
//  Created by Evan on 2017/2/25.
//  Copyright © 2017年 vanke. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TTPopoerIndexBlock)(NSInteger);
@interface TTPopoerView : UIView

@property (nonatomic, copy) TTPopoerIndexBlock popIndexBlock;

+ (instancetype)popoverView;

/*! @brief 指向指定的点来显示弹窗
 *  @param toPoint 箭头指向的点(这个点的坐标需按照keyWindow的坐标为参照)
 *  @param popIndexBlock 动作对象集合
 */
- (void)showToPoint:(CGPoint)toPoint withIndexBlock:(TTPopoerIndexBlock)popIndexBlock;

@end
