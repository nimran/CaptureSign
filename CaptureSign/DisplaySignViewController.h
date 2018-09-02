//
//  DisplaySignViewController.h
//  CaptureSign
//
//  Created by ArunMak on 31/08/18.
//  Copyright © 2018 ArunMak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisplaySignViewController : UIViewController{
    UIImageView *sign_ImageView;
}
@property(strong,nonatomic )UIImage *cropped_Image;
@end
