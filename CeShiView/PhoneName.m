//
//  PhoneName.m
//  CeShiView
//
//  Created by 刘军 on 13-7-19.
//  Copyright (c) 2013年 刘军. All rights reserved.
//

#import "PhoneName.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

#define _NULL_(_ptr_) (_ptr_) == nil || (NSNull*)(_ptr_) == [NSNull null]

@implementation PhoneName
#pragma mark 获取通讯录



// 获取通讯录方法 测试可用
+ (NSMutableArray *) getAllContacts
{
    CFErrorRef error;
    //取得本地通信录名柄
	ABAddressBookRef tmpAddressBook = ABAddressBookCreateWithOptions(NULL, &error);
	//取得本地所有联系人记录
	NSArray* tmpPeoples = (NSArray*)CFBridgingRelease(ABAddressBookCopyArrayOfAllPeople(tmpAddressBook));
    ABAddressBookRequestAccessWithCompletion(tmpAddressBook, ^(bool granted, CFErrorRef error){
        if (granted)
        {
            NSLog(@"granted");
        }
        else
        {
            NSLog(@"%@", error);
            CFRelease(error);
        }
    
    });
    NSMutableArray * a = [[NSMutableArray alloc] initWithCapacity:0];
	for(id tmpPerson in tmpPeoples)
	{
		//获取的联系人单一属性:First name
		NSString* tmpFirstName = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonFirstNameProperty);
        if ([tmpFirstName isEqualToString:@"(null)"] || _NULL_(tmpFirstName))
            tmpFirstName = @"";
		//获取的联系人单一属性:Last name
		NSString* tmpLastName = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonLastNameProperty);
		ABMultiValueRef tmpPhones = ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonPhoneProperty);
		for(NSInteger j = 0; j < ABMultiValueGetCount(tmpPhones); j++)
		{
            NSMutableString *phonelist = [[NSMutableString alloc]init];

			NSString* tmpPhoneIndex = (__bridge NSString*)ABMultiValueCopyValueAtIndex(tmpPhones, j);
         //   [phonelist appendString:[NSString stringWithFormat:@"%@|%@%@, ",tmpPhoneIndex,tmpLastName,tmpFirstName]];
            [phonelist appendString:[NSString stringWithFormat:@"%@%@:%@ ",tmpLastName,tmpFirstName,tmpPhoneIndex]];
            
            [a addObject:phonelist];
            phonelist = nil;
		}
		CFRelease(tmpPhones);
	}
	//释放内存
	CFRelease(tmpAddressBook);
    return a;
}













//此方法没有测试过 如果要用自己调试
#pragma mark - 获取用户adressbook
+ (NSString *)getPhonelist
{
    CFErrorRef error;

	NSString *strPhonelist = @"";
	ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
	CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(addressBook);
    
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error){
        if (granted)
        {
            NSLog(@"granted");
        }
        else
        {
            NSLog(@"%@", error);
            CFRelease(error);
        }
        
    });
	for (int i = 0; i < CFArrayGetCount(results); i++)
	{
		ABRecordRef person = CFArrayGetValueAtIndex(results, i);
        //		NSString *firstName = (NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
        
		NSString *firstName = (NSString *)CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
        
        if (_NULL_(firstName) || [firstName isEqualToString:@"(null)"])
		{
			firstName = @"";
		}
		NSString *lastName = (NSString *)CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
        //        NSString *lastName = (NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
		if (_NULL_(lastName) || [lastName isEqualToString:@"(null)"])
		{
			lastName = @"";
		}
		NSString *fullName = [NSString stringWithFormat:@"%@%@", lastName, firstName];
		
		ABMultiValueRef phone = (ABMultiValueRef *)ABRecordCopyValue(person, kABPersonPhoneProperty);
		for (int j = 0; j < ABMultiValueGetCount(phone); j++)
		{
            
            NSString *strPhone = [(NSString *)CFBridgingRelease(ABMultiValueCopyValueAtIndex(phone, j)) stringByReplacingOccurrencesOfString:@"-" withString:@""];
            
            //			NSString *strPhone = [(NSString *)ABMultiValueCopyValueAtIndex(phone, j) stringByReplacingOccurrencesOfString:@"-" withString:@""];
            
			strPhonelist = [strPhonelist stringByAppendingFormat:@"%@|%@", strPhone, fullName];
			
			if (j != ABMultiValueGetCount(phone) - 1)
			{
				strPhonelist = [strPhonelist stringByAppendingFormat:@"%@", @","];
			}
		}
		
		if (i != CFArrayGetCount(results) - 1)
		{
			strPhonelist = [strPhonelist stringByAppendingFormat:@"%@", @","];
		}
	}
	
	return strPhonelist;
}



@end
