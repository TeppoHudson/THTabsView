//
//  THTabsView.h
//  Publishzer
//
//  Created by Teppo Hudson on 16/07/15.
//  Copyright (c) 2015 Teppo Hudson. All rights reserved.
//

#import <UIKit/UIKit.h>
@class THTabsView;

@protocol THtabsViewDelegate
- (void)tabsView:(THTabsView *)tabsView tabDidChange:(int)selectedIndex;
@end

@interface THTabsView : UIView

@property (assign) id <THtabsViewDelegate> delegate;

@property (nonatomic, strong)UIScrollView *scrollview;

@property (nonatomic, strong) CALayer *tabBottom;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic) int  selectedIndex;
@property (nonatomic) BOOL hasMiddleBorder;

@property (nonatomic) int numberOfTabs;
@property (nonatomic, strong) NSArray *labelTexts;

- (void)setTabText:(NSString *)text;
- (void)setTintColor:(UIColor *)tintColor;

@end
