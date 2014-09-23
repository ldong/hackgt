//
//  ViewController.h
//  FlySwatter
//
//  Created by Lin Dong on 9/20/14.
//  Copyright (c) 2014 Lin Dong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TesseractOCR/TesseractOCR.h>
#import <EventKit/EventKit.h>
#import <Social/Social.h>


@interface CameraController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, TesseractDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *infoData;
@property (weak, nonatomic) IBOutlet UIButton *accept;
@property (weak, nonatomic) IBOutlet UIButton *twitterButton;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;
@property (weak, nonatomic) IBOutlet UIButton *spin;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (weak, nonatomic) IBOutlet UIButton *captureButton;
@property (strong, nonatomic) UIImagePickerController * imagePicker;
@property (weak, nonatomic) EKEventStore *store;

- (IBAction)pickImage:(id)sender;
- (IBAction)cancelImage:(id)sender;
- (IBAction)addToCalendar:(id)sender;
//- (UIImage *)convertImageToGrayScale:(UIImage *)image;
- (IBAction)shareWithTwitter:(id)sender;
- (IBAction)shareWithFacebook:(id)sender;
+ (BOOL)uploadImage:(UIImage *)image withName:(NSString *)fileName toURL:(NSURL *)url;
@end

