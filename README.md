# TwoBallRotationProgressBar-IOS
IOS版本的两个小球绕中心旋转的进度条，可设置颜色、小球半径、旋转半径和动画时间等等

#效果图
![效果图](https://github.com/hanhailong/TwoBallRotationProgressBar-IOS/blob/master/screenshot/ballrotation_ios.gif)

#Requirements
1. ARC
2. IOS7+
3. Xcode6+

#How to use
##like this:
`TwoBallRotationProgressBar *progressBar2 = [[TwoBallRotationProgressBar alloc] initWithFrame:CGRectMake(0, screen_height/5, screen_width, screen_height/5)];
    [self.view addSubview:progressBar2];
    
    [progressBar2 setOneBallColor:[UIColor greenColor] twoBallColor:[UIColor yellowColor]];
    //设置俩小球最大半径6
    [progressBar2 setBallMaxRadius:8];
    //设置俩小球最小半径3
    [progressBar2 setBallMinRadius:4];
    //设置动画时间1.5秒
    [progressBar2 setAnimatorDuration:1.5];
    [progressBar2 setAnimatorDistance:30];
    
    [progressBar2 startAnimator];`

#License

Copyright 2015 hanhailong

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
