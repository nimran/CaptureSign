//
//  DisplaySignViewController.m
//  CaptureSign
//
//  Created by ArunMak on 31/08/18.
//  Copyright © 2018 ArunMak. All rights reserved.
//

#import "DisplaySignViewController.h"
#define SIGN_PATH  @"sign_path"
@interface DisplaySignViewController ()

@end

@implementation DisplaySignViewController
@synthesize signatureModal_View,dialog_View,delegate;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self popUpView];
    // Do any additional setup after loading the view.
}

-(void)popUpView{
        signatureModal_View = [[SignatureModalView alloc]initWithFrame:CGRectMake(0,0,dialog_View.frame.size.width,dialog_View.frame.size.height-100)];
        [signatureModal_View setBackgroundColor:[UIColor whiteColor]];
        [dialog_View addSubview:signatureModal_View];
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:SIGN_PATH];
        NSMutableArray *signPathArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [signatureModal_View setPathArray:signPathArray];
        [signatureModal_View setNeedsDisplay];
    
        captureSign_Button = [[UIButton alloc]initWithFrame:CGRectMake(10,dialog_View.frame.size.height-90,(dialog_View.frame.size.width/2)-20,80)];
        [captureSign_Button setTitle:@"Save Sign" forState:UIControlStateNormal];
        [captureSign_Button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [dialog_View addSubview:captureSign_Button];
        [captureSign_Button addTarget:self action:@selector(captureSignButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
        close_Button = [[UIButton alloc]initWithFrame:CGRectMake(captureSign_Button.frame.size.width+captureSign_Button.frame.origin.x+10,captureSign_Button.frame.origin.y,captureSign_Button.frame.size.width,captureSign_Button.frame.size.height)];
        [close_Button setTitle:@"Close" forState:UIControlStateNormal];
        [close_Button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [dialog_View addSubview:close_Button];
        [close_Button addTarget:self action:@selector(closeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}
-(void)closeButtonAction{
    [signatureModal_View erase];
    [dialog_View removeFromSuperview];
    dialog_View = nil;
    [signatureModal_View removeFromSuperview];
    signatureModal_View = nil;
    [self dismissViewControllerAnimated:YES completion:nil];

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
    [self.delegate recieveSign:pngData withImage:captureImage];
    [signatureModal_View erase];
    [self dismissViewControllerAnimated:YES completion:nil];


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
