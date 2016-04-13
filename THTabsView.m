//
//  CosmTabsView.m
//  CosmEthics
//
//  Created by Teppo Hudson on 16/07/15.
//  Copyright (c) 2015 CosmEthics. All rights reserved.
//

#import "CosmTabsView.h"
#import "CosmColor.h"

@implementation CosmTabsView

- (void)baseInit {
    _delegate = nil;
    _selectedIndex = 0;
    _useCircle = NO;
    _useLine = NO;
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
    
    // bottomline init
    self.tabBottom = [CALayer layer];
    self.tabBottom.frame = CGRectMake(self.frame.size.width/3*self.selectedIndex, self.frame.size.height-2.0f, self.frame.size.width/self.numberOfTabs, 2.0f);
    [self.scrollview.layer addSublayer:self.tabBottom];
    [self.tabBottom setHidden:YES];
    
    // circle init
    [self.scrollview.layer addSublayer:self.tabBottom];
    self.circleContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/3, self.frame.size.height)];
    self.tabCircleBorderWidth = 2;
    self.tabCircle = [CAShapeLayer layer];
    [self.tabCircle setBounds:CGRectMake(self.circleContainer.frame.size.width/3*self.selectedIndex, 0, 20,
                                      20)];
    [self.tabCircle setPosition:CGPointMake(self.circleContainer.frame.size.width/3+self.circleContainer.frame.size.width/6-(self.tabCircleBorderWidth*2+1), self.circleContainer.frame.size.height/2-(self.tabCircleBorderWidth*2+1))];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:
                          CGRectMake(0.0f, 0.0f, self.circleContainer.frame.size.height-self.tabCircleBorderWidth, self.circleContainer.frame.size.height-self.tabCircleBorderWidth)];
    [self.tabCircle setPath:[path CGPath]];
    [self.tabCircle setLineWidth:self.tabCircleBorderWidth];
    [self.tabCircle setFillColor:[[UIColor clearColor] CGColor]];
    
    [self.circleContainer.layer addSublayer: self.tabCircle];
    [self.scrollview addSubview:self.circleContainer];
    [self.tabCircle setHidden:YES];
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if (self.useLine){
        [self.tabBottom setHidden:NO];
        self.tabBottom.frame = CGRectMake(self.frame.size.width/self.numberOfTabs*self.selectedIndex, self.frame.size.height-2.0f, self.frame.size.width/self.numberOfTabs, 2.0f);
    }
    if (self.useCircle){
        [self.tabCircle setHidden:NO];
        self.circleContainer.frame = CGRectMake(0, 0, self.frame.size.width/3, self.frame.size.height);
    }
    
    for (int i = 0; i<self.numberOfTabs;i++){
        if ([self.labelTexts[i] isKindOfClass:[UIImage class]]){
            UIImage *tabImage = self.labelTexts[i];
            UIImageView *tabImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/self.numberOfTabs*i, 4, self.frame.size.width/self.numberOfTabs, self.frame.size.height-8)];
            tabImageView.tag = i;
            tabImageView.image = tabImage;
            tabImageView.contentMode = UIViewContentModeScaleAspectFit;
            [self.scrollview addSubview:tabImageView];
        } else {
            
            UILabel *tabLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2*i, 0, self.frame.size.width/self.numberOfTabs, self.frame.size.height)];
            tabLabel.tag = i;
            tabLabel.text = self.labelTexts[i];
            tabLabel.textAlignment = NSTextAlignmentCenter;
            tabLabel.textColor = COSMpurple;
            tabLabel.font = [UIFont fontWithName:@"Ubuntu" size:14];
            [self.scrollview addSubview:tabLabel];
        }
        if (self.hasMiddleBorder == YES){
            if (i<(self.numberOfTabs-1)){
                CALayer *sideBorder = [CALayer layer];
                sideBorder.frame = CGRectMake(self.frame.size.width/2*(i+1), 5, 1, 34);
                sideBorder.backgroundColor =  [UIColor colorWithRed:92.0/255.0 green:100.0/255.0 blue:68.0/255.0 alpha:0.15f].CGColor;
                [self.scrollview.layer addSublayer:sideBorder];
            
            }
        }
    }
    self.scrollview.contentSize =  CGSizeMake(self.frame.size.width/2*self.numberOfTabs, self.frame.size.height);
    [self.tabCircle setStrokeColor:[[UIColor colorWithRed:104/255 green:164/255 blue:255/255 alpha:1] CGColor]];
    self.tabBottom.backgroundColor = COSMpurple.CGColor;
}

- (void)refresh {
    if (self.useLine){
        self.tabBottom.frame = CGRectMake(self.frame.size.width/self.numberOfTabs*self.selectedIndex, self.frame.size.height-2.0f, self.frame.size.width/self.numberOfTabs, 2.0f);
    }
    if (self.useCircle){
        [UIView animateWithDuration:0.2 animations:^{
            self.circleContainer.alpha = 0;
        } completion:^(BOOL finished) {
            self.circleContainer.frame = CGRectMake(self.frame.size.width/self.numberOfTabs*self.selectedIndex, 0, self.frame.size.width/3, self.frame.size.height);
            [UIView animateWithDuration:0.2 animations:^{
                self.circleContainer.alpha = 1;
            }];
        }];
    }
    
}

- (void)setTabText:(NSString *)text {
    // coming soon...
}

- (void)setTintColor:(UIColor *)tintColor {
    // coming soon...    
}

- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{
    CGPoint touchLocation=[gesture locationInView:self.scrollview];

    if (self.userInteractionEnabled == NO) return;
    
    int touchIndex = 0;
    for(int i = (int)self.labelTexts.count - 1; i >= 0; i--) {
        if ([self.labelTexts[i] isKindOfClass:[UIImage class]]){
            UIImageView *selectedImageView = (UIImageView *)[self viewWithTag:i];
            selectedImageView.backgroundColor = [UIColor clearColor];
            if (touchLocation.x > selectedImageView.frame.origin.x) {
                touchIndex = i;
                break;
            }
        } else {
            UILabel *selectedLabel = (UILabel *)[self viewWithTag:i];
            if (touchLocation.x > selectedLabel.frame.origin.x) {
                touchIndex = i;
                break;
            }
        }
    }
    
    self.selectedIndex = touchIndex;
    
    [self refresh];
    [self.delegate tabsView:self tabDidChange:self.selectedIndex];

}

@end
