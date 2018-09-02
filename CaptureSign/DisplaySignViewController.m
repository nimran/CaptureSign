//
//  DisplaySignViewController.m
//  CaptureSign
//
//  Created by ArunMak on 31/08/18.
//  Copyright © 2018 ArunMak. All rights reserved.
//

#import "DisplaySignViewController.h"

@interface DisplaySignViewController ()

@end

@implementation DisplaySignViewController
@synthesize cropped_Image;
- (void)viewDidLoad {
    [super viewDidLoad];
    sign_ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:sign_ImageView];
    sign_ImageView.image = cropped_Image;
    [sign_ImageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
