//
//  ImageController.h
//  FlySwatter
//
//  Created by Lin Dong on 9/20/14.
//  Copyright (c) 2014 Lin Dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

// IBOutlet is auto generated
@property (weak, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImagePickerController * imagePicker;

@end
