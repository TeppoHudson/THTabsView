//
//  CosmTabsView.m
//  CosmEthics
//
//  Created by Teppo Hudson on 16/07/15.
//  Copyright (c) 2015 CosmEthics. All rights reserved.
//

#import "THTabsView.h"

@implementation THTabsView

- (void)baseInit {
    _delegate = nil;
    _selectedIndex = 0;
    _tintColor = [UIColor blackColor];
}
- (id)initWithFrame:(CGRect)frame
{
self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self baseInit];
    }
    self.scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    [self.scrollview addGestureRecognizer:singleTap];
    self.scrollview.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollview];
    self.tabBottom = [CALayer layer];
    self.tabBottom.frame = CGRectMake(self.frame.size.width/2*self.selectedIndex, self.frame.size.height-3.0f, self.frame.size.width/2, 3.0f);
    [self.scrollview.layer addSublayer:self.tabBottom];
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    for (int i = 0; i<self.numberOfTabs;i++){
        UILabel *tabLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2*i, 0, self.frame.size.width/2, self.frame.size.height)];
        tabLabel.tag = i;
        tabLabel.text = self.labelTexts[i];
        tabLabel.textAlignment = NSTextAlignmentCenter;
        tabLabel.textColor = self.tintColor;
//        tabLabel.font = [UIFont fontWithName:@"Ubuntu" size:14];
        [self.scrollview addSubview:tabLabel];
        
        if (self.hasMiddleBorder == YES){
            if (i<(self.numberOfTabs-1)){
                CALayer *sideBorder = [CALayer layer];
                sideBorder.frame = CGRectMake(self.frame.size.width/2*(i+1), 5, 1, 34);
                sideBorder.backgroundColor =  self.tintColor.CGColor;
                [self.scrollview.layer addSublayer:sideBorder];
            
            }
        }
    }
    self.scrollview.contentSize =  CGSizeMake(self.frame.size.width/2*self.numberOfTabs, self.frame.size.height);
    self.tabBottom.backgroundColor = self.tintColor.CGColor;
}

- (void)refresh {
    [UIView animateWithDuration:1 animations:^{
        self.tabBottom.frame = CGRectMake(self.frame.size.width/2*self.selectedIndex, self.frame.size.height-3.0f, self.frame.size.width/2, 3.0f);
    }];
}

- (void)setTabText:(NSString *)text {
    //todo
}

- (void)setTintColor:(UIColor *)tintColor {
    // todo
}

- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{
    CGPoint touchLocation=[gesture locationInView:self.scrollview];

    if (self.userInteractionEnabled == NO) return;
    
    int touchIndex = 0;
    for(int i = (int)self.labelTexts.count - 1; i >= 0; i--) {
        UILabel *selectedLabel = (UILabel *)[self viewWithTag:i];
        if (touchLocation.x > selectedLabel.frame.origin.x) {
            touchIndex = i;
            break;
        }
    }
    
    self.selectedIndex = touchIndex;
    
    [self refresh];
    [self.delegate tabsView:self tabDidChange:self.selectedIndex];

}

@end
