//
//  ViewController.m
//  CaptureSign
//
//  Created by ArunMak on 31/08/18.
//  Copyright © 2018 ArunMak. All rights reserved.
//

#import "ViewController.h"
#import "DisplaySignViewController.h"
#import <QuartzCore/QuartzCore.h>

#define SIGN_PATH  @"sign_path"


@interface ViewController ()

@end

@implementation ViewController
@synthesize digitalSign_ImageView;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    NSLog(@"test controller");
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DisplaySignViewController *newVC = segue.destinationViewController;
    newVC.delegate = self;
    [ViewController setPresentationStyleForSelfController:self presentingController:newVC];
}

+ (void)setPresentationStyleForSelfController:(UIViewController *)selfController presentingController:(UIViewController *)presentingController
{
    if ([NSProcessInfo instancesRespondToSelector:@selector(isOperatingSystemAtLeastVersion:)])
    {
        //iOS 8.0 and above
        presentingController.providesPresentationContextTransitionStyle = YES;
        presentingController.definesPresentationContext = YES;
        
        [presentingController setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    }
    else
    {
        [selfController setModalPresentationStyle:UIModalPresentationCurrentContext];
        [selfController.navigationController setModalPresentationStyle:UIModalPresentationCurrentContext];
    }
}
-(void)recieveSign:(NSData *)data withImage:(UIImage*)image{
    //here you reviece the image and data
    [digitalSign_ImageView setImage:image];
    [digitalSign_ImageView setContentMode:UIViewContentModeScaleAspectFit];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
