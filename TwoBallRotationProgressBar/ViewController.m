//
//  ViewController.m
//  TwoBallRotationProgressBar
//
//  Created by HailongHan on 15/8/8.
//  Copyright (c) 2015年 hhl. All rights reserved.
//
#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import "TwoBallRotationProgressBar.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpViews];
}

- (void)setUpViews{
#pragma mark - 蓝色小球
    TwoBallRotationProgressBar *progressBar1 = [[TwoBallRotationProgressBar alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height/5)];
    [self.view addSubview:progressBar1];
    
    [progressBar1 setOneBallColor:[UIColor blueColor] twoBallColor:[UIColor blackColor]];
    //设置俩小球最大半径6
    [progressBar1 setBallMaxRadius:6];
    //设置俩小球最小半径3
    [progressBar1 setBallMinRadius:3];
    //设置动画时间1.5秒
    [progressBar1 setAnimatorDuration:1.5];
    
    [progressBar1 startAnimator];
    
#pragma mark - 红黄小球
    TwoBallRotationProgressBar *progressBar2 = [[TwoBallRotationProgressBar alloc] initWithFrame:CGRectMake(0, screen_height/5, screen_width, screen_height/5)];
    [self.view addSubview:progressBar2];
    
    [progressBar2 setOneBallColor:[UIColor greenColor] twoBallColor:[UIColor yellowColor]];
    //设置俩小球最大半径6
    [progressBar2 setBallMaxRadius:8];
    //设置俩小球最小半径3
    [progressBar2 setBallMinRadius:4];
    //设置动画时间1.5秒
    [progressBar2 setAnimatorDuration:1.5];
    [progressBar2 setAnimatorDistance:30];
    
    [progressBar2 startAnimator];
    
#pragma mark - 红蓝小球
    TwoBallRotationProgressBar *progressBar3 = [[TwoBallRotationProgressBar alloc] initWithFrame:CGRectMake(0, screen_height/5*2, screen_width, screen_height/5)];
    [self.view addSubview:progressBar3];
    
    [progressBar3 setOneBallColor:[UIColor redColor] twoBallColor:[UIColor blueColor]];
    //设置俩小球最大半径6
    [progressBar3 setBallMaxRadius:10];
    //设置俩小球最小半径3
    [progressBar3 setBallMinRadius:5];
    //设置动画时间1.5秒
    [progressBar3 setAnimatorDuration:1.5];
    [progressBar3 setAnimatorDistance:40];
    
    [progressBar3 startAnimator];
    
#pragma mark - 橙绿小球
    TwoBallRotationProgressBar *progressBar4 = [[TwoBallRotationProgressBar alloc] initWithFrame:CGRectMake(0, screen_height/5*3, screen_width, screen_height/5)];
    [self.view addSubview:progressBar4];
    
    [progressBar4 setOneBallColor:[UIColor orangeColor] twoBallColor:[UIColor greenColor]];
    //设置俩小球最大半径6
    [progressBar4 setBallMaxRadius:12];
    //设置俩小球最小半径3
    [progressBar4 setBallMinRadius:6];
    //设置动画时间1.5秒
    [progressBar4 setAnimatorDuration:1.5];
    [progressBar4 setAnimatorDistance:50];
    
    [progressBar4 startAnimator];
    
#pragma mark - 蓝灰小球
    TwoBallRotationProgressBar *progressBar5 = [[TwoBallRotationProgressBar alloc] initWithFrame:CGRectMake(0, screen_height/5*4, screen_width, screen_height/5)];
    [self.view addSubview:progressBar5];
    
    [progressBar5 setOneBallColor:[UIColor blueColor] twoBallColor:[UIColor grayColor]];
    //设置俩小球最大半径6
    [progressBar5 setBallMaxRadius:14];
    //设置俩小球最小半径3
    [progressBar5 setBallMinRadius:7];
    //设置动画时间1.5秒
    [progressBar5 setAnimatorDuration:1.5];
    [progressBar5 setAnimatorDistance:60];
    
    [progressBar5 startAnimator];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
