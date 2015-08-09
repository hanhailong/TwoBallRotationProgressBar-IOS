//
//  TwoBallRotationProgressBar.m
//  TwoBallRotationProgressBar
//
//  Created by HailongHan on 15/8/8.
//  Copyright (c) 2015年 hhl. All rights reserved.
//

#define DEFAULT_MAX_RADIUS 10
#define DEFAULT_MIN_RADIUS 5
#define DEFAULT_DISTANCE 15
#define DEFAULT_DURATION 1.2

#import "TwoBallRotationProgressBar.h"

@interface TwoBallRotationProgressBar ()

@property (nonatomic,assign) CGFloat maxRadius;
@property (nonatomic,assign) CGFloat minRadius;
@property (nonatomic,assign) CGFloat duration;
@property (nonatomic,assign) CGFloat distance;

@property (nonatomic,strong) CAShapeLayer *oneLayer;
@property (nonatomic,strong) CAShapeLayer *twoLayer;

@property (nonatomic,assign) Boolean isTwoAbove;

@property (nonatomic,strong) NSTimer *mTimer;

@property (nonatomic,assign) CGPoint centerPoint;

@end

@implementation TwoBallRotationProgressBar


-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        //TODO 初始化
        self.backgroundColor = [UIColor whiteColor];
        
        [self initProgressBar];
    }
    return self;
}

- (CAShapeLayer *)oneLayer{
    if (!_oneLayer) {
        _oneLayer = [CAShapeLayer layer];
        _oneLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _oneLayer.fillColor = [UIColor redColor].CGColor;
        _oneLayer.path = [UIBezierPath bezierPathWithArcCenter:self.centerPoint radius:self.maxRadius startAngle:0 endAngle:M_PI*2 clockwise:YES].CGPath;
    }
    return _oneLayer;
}

- (CAShapeLayer *)twoLayer{
    if (!_twoLayer) {
        _twoLayer = [CAShapeLayer layer];
        _twoLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _twoLayer.anchorPoint = CGPointMake(0.5, 0.5);
        _twoLayer.fillColor = [UIColor greenColor].CGColor;
        _twoLayer.path = [UIBezierPath bezierPathWithArcCenter:self.centerPoint radius:self.minRadius startAngle:0 endAngle:M_PI*2 clockwise:YES].CGPath;
    }
    return _twoLayer;
}

/**
 *  初始化进度条
 */
- (void)initProgressBar{    
    self.isTwoAbove = YES;
    
    self.duration = DEFAULT_DURATION;
    self.maxRadius = DEFAULT_MAX_RADIUS;
    self.minRadius = DEFAULT_MIN_RADIUS;
    self.distance = DEFAULT_DISTANCE;
    
    self.centerPoint = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5);
    
    //添加两个CAShapeLayer
    [self.layer addSublayer:self.oneLayer];
    [self.layer addSublayer:self.twoLayer];
}

#pragma mark - 实现接口
- (void)setBallMaxRadius:(CGFloat)radius{
    self.maxRadius = radius;
    self.oneLayer.path = [UIBezierPath bezierPathWithArcCenter:self.centerPoint radius:self.maxRadius startAngle:0 endAngle:M_PI*2 clockwise:YES].CGPath;
}

- (void)setBallMinRadius:(CGFloat)radius{
    self.minRadius = radius;
    self.twoLayer.path = [UIBezierPath bezierPathWithArcCenter:self.centerPoint radius:self.minRadius startAngle:0 endAngle:M_PI*2 clockwise:YES].CGPath;
}

- (void)setOneBallColor:(UIColor *)oneColor twoBallColor:(UIColor *)twoColor{
    self.oneLayer.fillColor = oneColor.CGColor;
    self.twoLayer.fillColor = twoColor.CGColor;
}

- (void)setAnimatorDuration:(CGFloat)duration{
    self.duration = duration;
}

- (void)setAnimatorDistance:(CGFloat)distance{
    self.distance = distance;
    if (distance > self.bounds.size.width*0.5) {
        self.distance = self.bounds.size.width*0.5;
    }
}

- (void)startAnimator{
    [self startOneBallAnimator];
    [self startTwoBallAnimator];
}

- (void)startOneBallAnimator{
    //第一个小球位移动画
    CAKeyframeAnimation *oneFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, self.centerPoint.x, self.centerPoint.y);
    CGPathAddLineToPoint(path, NULL, self.centerPoint.x+self.distance, self.centerPoint.y);
    CGPathAddLineToPoint(path, NULL, self.centerPoint.x, self.centerPoint.y);
    CGPathAddLineToPoint(path, NULL, self.centerPoint.x-self.distance, self.centerPoint.y);
    CGPathAddLineToPoint(path, NULL, self.centerPoint.x, self.centerPoint.y);
    [oneFrameAnimation setPath:path];
    
    //第一个小球缩放动画
    CABasicAnimation *oneScaleAnimation1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    oneScaleAnimation1.fromValue = [NSNumber numberWithFloat:1.0];
    oneScaleAnimation1.toValue = [NSNumber numberWithFloat:0.5];
    oneScaleAnimation1.duration = self.duration*0.5;
    
    CABasicAnimation *oneScaleAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    oneScaleAnimation2.fromValue = [NSNumber numberWithFloat:0.5];
    oneScaleAnimation2.toValue = [NSNumber numberWithFloat:1.0];
    oneScaleAnimation2.beginTime = self.duration*0.5;
    oneScaleAnimation2.duration = self.duration*0.5;
    
    //第一个小球透明动画
    CABasicAnimation *oneOpacityAnimation1 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    oneOpacityAnimation1.fromValue = [NSNumber numberWithFloat:1.0];
    oneOpacityAnimation1.toValue = [NSNumber numberWithFloat:0.5];
    oneOpacityAnimation1.duration = self.duration*0.5;
    
    CABasicAnimation *oneOpacityAnimation2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    oneOpacityAnimation2.fromValue = [NSNumber numberWithFloat:0.5];
    oneOpacityAnimation2.toValue = [NSNumber numberWithFloat:1.0];
    oneOpacityAnimation2.beginTime = self.duration*0.5;
    oneOpacityAnimation2.duration = self.duration*0.5;
    
    
    CAAnimationGroup *oneScaleGroup = [CAAnimationGroup animation];
    [oneScaleGroup setAnimations:@[oneScaleAnimation1,oneScaleAnimation2,oneOpacityAnimation1,oneOpacityAnimation2]];
    
    //组合动画
    CAAnimationGroup *oneGroup = [CAAnimationGroup animation];
    [oneGroup setAnimations:@[oneFrameAnimation,oneScaleGroup]];
    oneGroup.duration = self.duration;
    oneGroup.repeatCount = HUGE;
    oneGroup.delegate = self;
    [self.oneLayer addAnimation:oneGroup forKey:@"oneGroup"];
}

- (void)startTwoBallAnimator{
    //第二个小球位移动画
    CAKeyframeAnimation *twoFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, self.centerPoint.x, self.centerPoint.y);
    CGPathAddLineToPoint(path, NULL, self.centerPoint.x-self.distance, self.centerPoint.y);
    CGPathAddLineToPoint(path, NULL, self.centerPoint.x, self.centerPoint.y);
    CGPathAddLineToPoint(path, NULL, self.centerPoint.x+self.distance, self.centerPoint.y);
    CGPathAddLineToPoint(path, NULL, self.centerPoint.x, self.centerPoint.y);
    [twoFrameAnimation setPath:path];
    
    //第二个小球缩放动画
    CABasicAnimation *twoScaleAnimation1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    twoScaleAnimation1.fromValue = [NSNumber numberWithFloat:1.0];
    twoScaleAnimation1.toValue = [NSNumber numberWithFloat:2.0];
    twoScaleAnimation1.duration = self.duration*0.5;
    
    CABasicAnimation *twoScaleAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    twoScaleAnimation2.fromValue = [NSNumber numberWithFloat:2.0];
    twoScaleAnimation2.toValue = [NSNumber numberWithFloat:1.0];
    twoScaleAnimation2.beginTime = self.duration*0.5;
    twoScaleAnimation2.duration = self.duration*0.5;
    
    //第二个小球透明动画
    CABasicAnimation *twoOpacityAnimation1 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    twoOpacityAnimation1.fromValue = [NSNumber numberWithFloat:0.5];
    twoOpacityAnimation1.toValue = [NSNumber numberWithFloat:1.0];
    twoOpacityAnimation1.duration = self.duration*0.5;
    
    CABasicAnimation *twoOpacityAnimation2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    twoOpacityAnimation2.fromValue = [NSNumber numberWithFloat:1.0];
    twoOpacityAnimation2.toValue = [NSNumber numberWithFloat:0.5];
    twoOpacityAnimation2.beginTime = self.duration*0.5;
    twoOpacityAnimation2.duration = self.duration*0.5;
    
    CAAnimationGroup *oneScaleGroup = [CAAnimationGroup animation];
    [oneScaleGroup setAnimations:@[twoScaleAnimation1,twoScaleAnimation2,twoOpacityAnimation1,twoOpacityAnimation2]];
    
    //组合动画
    CAAnimationGroup *twoGroup = [CAAnimationGroup animation];
    [twoGroup setAnimations:@[twoFrameAnimation,oneScaleGroup]];
    twoGroup.duration = self.duration;
    twoGroup.repeatCount = HUGE;
    [self.twoLayer addAnimation:twoGroup forKey:@"twoGroup"];
}

- (void)stopAnimator{
    //TODO
}

- (void)animationDidStart:(CAAnimation *)anim{
    [self performSelector:@selector(startNSTimer) withObject:self afterDelay:self.duration*0.25];
}

- (void)startNSTimer{
    //添加定时器
    self.mTimer = [NSTimer scheduledTimerWithTimeInterval:self.duration*0.5 target:self selector:@selector(animationUpdateListener) userInfo:nil repeats:YES];

}

- (void)animationUpdateListener{
    if (self.isTwoAbove) {
        [self.layer insertSublayer:self.twoLayer below:self.oneLayer];
    }else{
        [self.layer insertSublayer:self.oneLayer below:self.twoLayer];
    }
    _isTwoAbove = !_isTwoAbove;
}

@end
