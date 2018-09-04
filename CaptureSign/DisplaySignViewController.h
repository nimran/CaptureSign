//
//  DisplaySignViewController.h
//  CaptureSign
//
//  Created by ArunMak on 31/08/18.
//  Copyright © 2018 ArunMak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignatureModalView.h"

@protocol recieveSignDelegate <NSObject>
-(void)recieveSign:(NSData *)data withImage:(UIImage*)image;

@end





@interface DisplaySignViewController : UIViewController{
    UIImageView *sign_ImageView;
    UIButton *captureSign_Button,*close_Button;
}
@property(nonatomic,weak)id <recieveSignDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *dialog_View;
@property(strong,nonatomic)SignatureModalView *signatureModal_View;

@end
