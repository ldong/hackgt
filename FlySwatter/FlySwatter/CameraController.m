//
//  ViewController.m
//  FlySwatter
//
//  Created by Lin Dong on 9/20/14.
//  Copyright (c) 2014 Lin Dong. All rights reserved.
//

#import "CameraController.h"
#import "UIImage+Filters.h"

@interface CameraController ()

@end

@implementation CameraController
//@synthesize imagePicker, infoData, accept, captureButton, cancelButton, imageView;
@synthesize imagePicker, infoData, accept, captureButton, cancelButton, imageView, facebookButton, twitterButton, store, spin;

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  accept.hidden = true;
  infoData.hidden = true;
  cancelButton.hidden = true;
  facebookButton.hidden = true;
  twitterButton.hidden = true;
  spin.hidden = true;
  
  [captureButton setImage:[UIImage imageWithContentsOfFile:@"./icons/camera.png"] forState: UIControlStateNormal];
  [cancelButton setImage:[UIImage imageWithContentsOfFile:@"./icons/error.png"] forState: UIControlStateNormal];
  [facebookButton setImage:[UIImage imageWithContentsOfFile:@"./icons/facebook.png"] forState: UIControlStateNormal];
  [twitterButton setImage:[UIImage imageWithContentsOfFile:@"./icons/twitter.png"] forState: UIControlStateNormal];
  [accept setImage:[UIImage imageWithContentsOfFile:@"icons/check.png"] forState: UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


- (IBAction)pickImage:(id)sender {
  imagePicker = [[UIImagePickerController alloc]init];
  
  //Set the delegate
  imagePicker.delegate = self;
  
  //  if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
  //    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
  //  }else{
  imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
  //  }
  
  [self presentModalViewController:imagePicker animated:YES];
}

- (IBAction)cancelImage:(id)sender {
  accept.hidden = true;
  cancelButton.hidden = true;
  infoData.hidden = true;
  captureButton.hidden = false;
  facebookButton.hidden = true;
  twitterButton.hidden = true;
  spin.hidden = true;
}

- (IBAction)addToCalendar:(id)sender {
  NSLog(@"?addToCalendar?");
//  UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Waiting"
//                                                  message: @"Syncing with iCloud"
//                                                 delegate: nil cancelButtonTitle:@"OK"
//                                        otherButtonTitles:nil];
//  [alert show];

  EKEventStore *eventStore = [[EKEventStore alloc] init];
  if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
    // iOS 6 and later
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
      if (granted) {
        // code here for when the user allows your app to access the calendar
        [self addEventToCalendar:@" "];
        NSLog(@"permittion √");
      } else {
        // code here for when the user does NOT allow your app to access the calendar
        NSLog(@"no permittion");
      }
    }];
  } else {
    // code here for iOS < 6.0
    //        [self addEventToCalendar:@" "];
    NSLog(@"iOS < 6.0");
  }
  spin.hidden = true;
  //    [self addEventToCalendar:@" "];
}

- (void) addEventToCalendar: (NSString*) text {
  EKEventStore *eventStore=[[EKEventStore alloc] init];
  
  [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error)
   {
     if (granted)
     {
       EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
       NSString * NoteDetails =@"This will be the details of the event";
       
       NSDate *startDate = [NSDate date];
       
       //Create the end date components
       NSDateComponents *tomorrowDateComponents = [[NSDateComponents alloc] init];
       tomorrowDateComponents.day = 1;
       
       NSDate *endDate = [[NSCalendar currentCalendar] dateByAddingComponents:tomorrowDateComponents
                                                                       toDate:startDate
                                                                      options:0];
       
       event.title =@"Event title";
       event.startDate=startDate;
       //             event.endDate=endDate;
       event.endDate = [event.startDate dateByAddingTimeInterval:60*60];
       event.notes = @"the details of the event, any notes will will be here";
       event.allDay=NO;
       
       [event setCalendar:[eventStore defaultCalendarForNewEvents]];
       
       NSError *err;
       [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
       
       if(!error){
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Hi there"
                                                         message: @"Your event has been added"
                                                        delegate: nil cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
        [alert show];
        
       }
     }
     else
     {
       NSLog(@"NoPermission to access the calendar");
     }
     
   }];
  
  
  NSLog(@"Check your calendar");
}


- (IBAction)shareWithTwitter:(id)sender {
  if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
  {
    SLComposeViewController *tweetSheet = [SLComposeViewController
                                           composeViewControllerForServiceType:SLServiceTypeTwitter];
    [tweetSheet setInitialText:infoData.text];
    
    [self presentViewController:tweetSheet animated:YES completion:nil];
  } else {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
    { SLComposeViewController *tweetSheet = [SLComposeViewController
                                             composeViewControllerForServiceType:SLServiceTypeTwitter];
      [tweetSheet setInitialText:infoData.text];
      
      [self presentViewController:tweetSheet animated:YES completion:nil];
      
      
      //inform the user that no account is configured with alarm view.
    }
    
  }
}

- (IBAction)shareWithFacebook:(id)sender {
  if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
  {
    NSLog(@"HI FB");
    SLComposeViewController*fvc = [SLComposeViewController
                                   composeViewControllerForServiceType:SLServiceTypeFacebook];
    [fvc setInitialText:infoData.text];
    [fvc addImage:[UIImage imageNamed:@"hackGT rocks"]];
    [self presentViewController:fvc animated:YES completion:nil];
  } else {
    NSLog(@"No FB");
    SLComposeViewController * fbSheetOBJ = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [fbSheetOBJ setInitialText:@"Post from my iOS"];
    [fbSheetOBJ addURL:[NSURL URLWithString:@"http://hackgt.com"]];
    [fbSheetOBJ addImage:[UIImage imageNamed:@"klaus.png"]];
    
    [self presentViewController:fbSheetOBJ animated:YES completion:Nil];
  }
}
- (UIImage *)scaleAndRotateImage:(UIImage *)image {
  int kMaxResolution = 1024; // Or whatever
  
  CGImageRef imgRef = image.CGImage;
  
  CGFloat width = CGImageGetWidth(imgRef);
  CGFloat height = CGImageGetHeight(imgRef);
  
  
  CGAffineTransform transform = CGAffineTransformIdentity;
  CGRect bounds = CGRectMake(0, 0, width, height);
  if (width > kMaxResolution || height > kMaxResolution) {
    CGFloat ratio = width/height;
    if (ratio > 1) {
      bounds.size.width = kMaxResolution;
      bounds.size.height = roundf(bounds.size.width / ratio);
    }
    else {
      bounds.size.height = kMaxResolution;
      bounds.size.width = roundf(bounds.size.height * ratio);
    }
  }
  
  CGFloat scaleRatio = bounds.size.width / width;
  CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
  CGFloat boundHeight;
  UIImageOrientation orient = image.imageOrientation;
  switch(orient) {
      
    case UIImageOrientationUp: //EXIF = 1
      transform = CGAffineTransformIdentity;
      break;
      
    case UIImageOrientationUpMirrored: //EXIF = 2
      transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
      transform = CGAffineTransformScale(transform, -1.0, 1.0);
      break;
      
    case UIImageOrientationDown: //EXIF = 3
      transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
      transform = CGAffineTransformRotate(transform, M_PI);
      break;
      
    case UIImageOrientationDownMirrored: //EXIF = 4
      transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
      transform = CGAffineTransformScale(transform, 1.0, -1.0);
      break;
      
    case UIImageOrientationLeftMirrored: //EXIF = 5
      boundHeight = bounds.size.height;
      bounds.size.height = bounds.size.width;
      bounds.size.width = boundHeight;
      transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
      transform = CGAffineTransformScale(transform, -1.0, 1.0);
      transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
      break;
      
    case UIImageOrientationLeft: //EXIF = 6
      boundHeight = bounds.size.height;
      bounds.size.height = bounds.size.width;
      bounds.size.width = boundHeight;
      transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
      transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
      break;
      
    case UIImageOrientationRightMirrored: //EXIF = 7
      boundHeight = bounds.size.height;
      bounds.size.height = bounds.size.width;
      bounds.size.width = boundHeight;
      transform = CGAffineTransformMakeScale(-1.0, 1.0);
      transform = CGAffineTransformRotate(transform, M_PI / 2.0);
      break;
      
    case UIImageOrientationRight: //EXIF = 8
      boundHeight = bounds.size.height;
      bounds.size.height = bounds.size.width;
      bounds.size.width = boundHeight;
      transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
      transform = CGAffineTransformRotate(transform, M_PI / 2.0);
      break;
      
    default:
      [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
      
  }
  
  UIGraphicsBeginImageContext(bounds.size);
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
    CGContextScaleCTM(context, -scaleRatio, scaleRatio);
    CGContextTranslateCTM(context, -height, 0);
  }
  else {
    CGContextScaleCTM(context, scaleRatio, -scaleRatio);
    CGContextTranslateCTM(context, 0, -height);
  }
  
  CGContextConcatCTM(context, transform);
  
  CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
  UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return imageCopy;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
  //  CIImage *ciImage = image.CIImage;
  //  CIFilter *filter = [CIFilter filterWithName:@"CINoiseReduction"];
  //  [filter setDefaults];
  //  [filter setValue:ciImage forKey:kCIInputImageKey];
  //  CIImage *displayImage = filter.outputImage;
  //  UIImage *finalImage = [UIImage imageWithCIImage:displayImage];
  //  image = finalImage;
  //
  //  filter = [CIFilter filterWithName:@"CIMaximumComponent"];
  //  [filter setDefaults];
  //  [filter setValue:ciImage forKey:kCIInputImageKey];
  //  displayImage = filter.outputImage;
  //  finalImage = [UIImage imageWithCIImage:displayImage];
  //  image = finalImage;
  
  // Load image from library
  UIImage* myImage = [info objectForKey:UIImagePickerControllerOriginalImage];
  CIImage *afterMono, *afterBlur;
  UIImage *fixedImage = [self scaleAndRotateImage:myImage];
  CIImage *inputImage = [[CIImage alloc] initWithImage:fixedImage];

//  CIImage *inputImage = [[CIImage alloc] initWithCGImage:myImage.CGImage];
//  CIContext *context = [CIContext contextWithOptions:nil];
//  CIFilter *random = [CIFilter filterWithName:@"CIRandomGenerator"];
//  //UIImage *randomFilter = [UIImage imageWithCIImage:random.outputImage];
//  
//  CIImage* result = random.outputImage;
//  CGImageRef cgiimage = [context createCGImage:result fromRect:[result extent]];
//  
//  //assume beginImage is CIImage you want to tint
//  CIImage* outputImage = nil;
//  
//  //create some blue
//  CIFilter* blueGenerator = [CIFilter filterWithName:@"CIConstantColorGenerator"];
//  CIColor* blue = [CIColor colorWithString:@"0.1 0.5 0.8 1.0"];
//  [blueGenerator setValue:blue forKey:@"inputColor"];
//  CIImage* blueImage = [blueGenerator valueForKey:@"outputImage"];
//  
//  //apply a multiply filter
//  CIFilter* filterm = [CIFilter filterWithName:@"CIMultiplyCompositing"];
//  [filterm setValue:blueImage forKey:@"inputImage"];
//  [filterm setValue:inputImage forKey:@"inputBackgroundImage"];
//  outputImage = [filterm valueForKey:@"outputImage"];
//  
//  UIImage *resultUIImage = [UIImage imageWithCIImage:outputImage];
//  
//  imageView.image = resultUIImage;
//  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//    UIImageWriteToSavedPhotosAlbum(resultUIImage, nil, nil, nil);
//  });x
  
//  CIFilter *monoEffectFilter = [CIFilter filterWithName:@"CIPhotoEffectMono"];
//  [monoEffectFilter setDefaults];
//  [monoEffectFilter setValue:inputImage forKey:kCIInputImageKey];
//  afterMono = monoEffectFilter.outputImage;

  
//  CIFilter *gaussianBlur = [CIFilter filterWithName:@"CIGaussianBlur"];
//  [gaussianBlur setDefaults];
//  [gaussianBlur setValue: afterMono forKey:kCIInputImageKey];
//  [gaussianBlur setValue: @500.0f forKey:kCIInputRadiusKey];
////  afterBlur = gaussianBlur.outputImage;
//
//  UIImage *resultUIImage = [UIImage imageWithCIImage: afterMono];
//  imageView.image = resultUIImage;
//  UIImageWriteToSavedPhotosAlbum(resultUIImage, nil, nil, nil);
  
  Tesseract* tesseract = [[Tesseract alloc] initWithDataPath:@"tessdata" language:@"eng"];
  [tesseract setImage:myImage];
  [tesseract recognize];
  
  NSLog(@"%@", [tesseract recognizedText]);
  
  NSLog(@"Parsed text: %@", [tesseract recognizedText]);
  
  [self dismissModalViewControllerAnimated:YES];
  infoData.text = [tesseract recognizedText];
  captureButton.hidden = true;
  accept.hidden = false;
  infoData.hidden = false;
  cancelButton.hidden = false;
  facebookButton.hidden = false;
  twitterButton.hidden = false;
  
  //  UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
  [self dismissModalViewControllerAnimated:YES];
}
@end