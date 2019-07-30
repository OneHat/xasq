//
//  InviteUserViewController.m
//  xasq
//
//  Created by dssj on 2019/7/30.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "InviteUserViewController.h"
#import <Contacts/Contacts.h>
#import <MessageUI/MessageUI.h>

@interface InviteUserViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *contacts;

@end

@implementation InviteUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"邀请好友";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //是否有权限
    CNAuthorizationStatus authorizationStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (authorizationStatus == CNAuthorizationStatusNotDetermined) {
        //首次访问
        CNContactStore *contactStore = [[CNContactStore alloc] init];
        [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (granted) {
                    self.contacts = [self fetchContactWithContactStore:contactStore];
                    [self showTableview];
                } else {
                    [self showTipLabel];
                }
               
            });
        }];
        
    } else if (authorizationStatus == CNAuthorizationStatusDenied || authorizationStatus == CNAuthorizationStatusRestricted) {
        //拒绝访问
        [self showTipLabel];
        
    } else if (authorizationStatus == CNAuthorizationStatusAuthorized){
        //用户同意访问
        CNContactStore *contactStore = [[CNContactStore alloc] init];
        _contacts = [self fetchContactWithContactStore:contactStore];
        [self showTableview];
    }
    
}

- (void)showTableview {
    CGRect rect = CGRectMake(0, NavHeight, ScreenWidth, ScreenHeight - NavHeight - BottomHeight);
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

///拒绝访问提示信息
- (void)showTipLabel {
    
}

#pragma mark-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contactCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"contactCell"];
        cell.accessoryType =  UITableViewCellAccessoryDetailButton;
    }
    
    NSDictionary *contact = _contacts[indexPath.row];
    cell.textLabel.text = contact[@"name"];
    cell.detailTextLabel.text = contact[@"phoneNumber"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc] init];
    if ([MFMessageComposeViewController canSendText]) {
        messageVC.body = @"sdf";
        messageVC.recipients = @[];//接收人
        [self presentViewController:messageVC animated:YES completion:^{
            
        }];
    }
}

#pragma mark-
// 访问通讯录
- (NSArray *)fetchContactWithContactStore:(CNContactStore *)contactStore {
    
    NSError *error = nil;
    
    NSPredicate *predicate = [CNContact predicateForContactsInContainerWithIdentifier:contactStore.defaultContainerIdentifier];
    
    // 创建数组，必须遵守 CNKeyDescriptor 协议，放入相应的字符串常量来获取对应的联系人信息
    NSArray *keysToFetch = @[CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey];
    
    // 获取通讯录数组
    NSArray<CNContact*> *arr = [contactStore unifiedContactsMatchingPredicate:predicate keysToFetch:keysToFetch error:&error];
    
    if (!error) {
        
        NSMutableArray *contacts = [NSMutableArray array];
        for (int i = 0; i < arr.count; i++) {
            
            CNContact *contact = arr[i];
            NSString *givenName = contact.givenName;
            NSString *familyName = contact.familyName;
            
            CNLabeledValue *value = contact.phoneNumbers.lastObject;
            CNPhoneNumber *number = value.value;
            NSString *phoneNumber = number.stringValue;
            
            [contacts addObject:@{@"name":[givenName stringByAppendingString:familyName], @"phoneNumber":phoneNumber}];
        }
        
        return [NSArray arrayWithArray:contacts];
        
    } else {
        return nil;
    }
    
}

@end
