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
@synthesize signatureModal_View,captureSign_Button;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    
    signatureModal_View = [[SignatureModalView alloc]initWithFrame:CGRectMake(0,10,self.view.frame.size.width,300)];
    [self.view addSubview:signatureModal_View];
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:SIGN_PATH];
    NSMutableArray *signPathArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [signatureModal_View setPathArray:signPathArray];
    [signatureModal_View setNeedsDisplay];
    
    captureSign_Button = [[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2)-100, self.view.frame.size.height-100, 200,80)];
    [captureSign_Button setTitle:@"Save Sign" forState:UIControlStateNormal];
    [captureSign_Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:captureSign_Button];
    [captureSign_Button addTarget:self action:@selector(captureSignButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)captureSignButtonAction{
    [signatureModal_View captureSign];
    UIImage *captureImage = [signatureModal_View signImage];
    NSData *pngData = UIImagePNGRepresentation(captureImage);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"image.png"];
    NSLog(@"path is %@ and image size is %f ,%f",filePath,captureImage.size.width,captureImage.size.height);
    //Add the file name
    [pngData writeToFile:filePath atomically:YES];
    [signatureModal_View erase];
    UIStoryboard *myStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    DisplaySignViewController *catogery = [myStoryBoard instantiateViewControllerWithIdentifier:@"displaySign"];
    catogery.cropped_Image = captureImage;
    [self.navigationController pushViewController:catogery animated:NO];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
