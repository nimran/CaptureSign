//
//  ViewController.h
//  CaptureSign
//
//  Created by ArunMak on 31/08/18.
//  Copyright © 2018 ArunMak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignatureModalView.h"
@interface ViewController : UIViewController{
    
}
@property(strong,nonatomic)SignatureModalView *signatureModal_View;
@property(strong,nonatomic)UIButton *captureSign_Button;

@end

