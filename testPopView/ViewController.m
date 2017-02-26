//
//  ViewController.m
//  testPopView
//
//  Created by Evan on 2017/2/23.
//  Copyright © 2017年 vanke. All rights reserved.
//

#import "ViewController.h"
#import "TTPopoerView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)popAction:(UIButton *)sender {
    
    TTPopoerView *popoverView = [TTPopoerView popoverView];
    [popoverView showToPoint:CGPointMake(sender.frame.origin.x, CGRectGetMaxY(sender.bounds))
              withIndexBlock:^(NSInteger index) {
        
                  NSLog(@"indexPath:%ld", (long)index);
    }];
}

@end
