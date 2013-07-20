//
//  RootViewController.m
//  CeShiView
//
//  Created by 刘军 on 13-7-16.
//  Copyright (c) 2013年 刘军. All rights reserved.
//

#import "RootViewController.h"

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

#import "PhoneName.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    UIView * v1 = [[UIView alloc] initWithFrame:self.view.bounds];
    v1.backgroundColor = [UIColor clearColor];
    [self.view addSubview:v1];
    
    
    UIView * v = [[UIView alloc] initWithFrame:self.view.bounds];
    v.backgroundColor = [UIColor blackColor];
    v.alpha = 0.7;
    [v1 addSubview:v];
    
    
    UIButton * b = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    b.frame = CGRectMake(100, 200, 60, 30);
    [b setTitle:@"aaa" forState:UIControlStateNormal];
    [v1 addSubview:b];
    
    
    //获取通讯录
    NSMutableArray * s = [PhoneName getAllContacts];
    NSLog(@"ss  %d",s.count);
    if (s.count != 0) {
        
        NSString * ss = [s objectAtIndex:1];
        NSLog(@"name is %@",ss);
        
        
        
    }
    

    
      
    
}
//-(void)phoneCall
//{
//    CFErrorRef error;
//    ABAddressBookRef result = ABAddressBookCreateWithOptions(NULL, &error);
//    if (!result)
//    {
//        NSLog(@"get addressBook failed:%@", error);
//        CFRelease(error);
//    }
//    else
//    {
//        //        if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined)
//        //        {
//        ABAddressBookRequestAccessWithCompletion(result, ^(bool granted, CFErrorRef error) {
//            if (granted)
//            {
//                NSLog(@"granted");
//            }
//            else
//            {
//                NSLog(@"%@", error);
//                CFRelease(error);
//            }
//        });
//        //        }
//    }
//
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
