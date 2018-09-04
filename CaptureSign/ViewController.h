//
//  ViewController.h
//  CaptureSign
//
//  Created by ArunMak on 31/08/18.
//  Copyright © 2018 ArunMak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisplaySignViewController.h"


@interface ViewController : UIViewController<recieveSignDelegate>{
      UIView *popUp_View;
    
}
@property (weak, nonatomic) IBOutlet UIImageView *digitalSign_ImageView;


@end

