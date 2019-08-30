//
//  ContactsViewController.m
//  xasq
//
//  Created by dssj on 2019/7/30.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "ContactsViewController.h"
#import "ContactViewCell.h"
#import "UIViewController+ActionSheet.h"
#import <Contacts/Contacts.h>

@interface ContactsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *tipLabels;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableDictionary *contactInfo;
@property (nonatomic, strong) NSMutableArray *titles;

@end

@implementation ContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通讯录好友";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tipLabels.hidden = YES;
    
    //是否有权限
    CNAuthorizationStatus authorizationStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (authorizationStatus == CNAuthorizationStatusNotDetermined) {
        //首次访问
        CNContactStore *contactStore = [[CNContactStore alloc] init];
        [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
            if (granted) {
                [self handleContacts:[self fetchContactWithContactStore:contactStore]];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showTableview];
                });
                
            } else {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showDeniedAlert];
                });
            }
            
        }];
        
    } else if (authorizationStatus == CNAuthorizationStatusAuthorized){
        //用户同意访问
        CNContactStore *contactStore = [[CNContactStore alloc] init];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self handleContacts:[self fetchContactWithContactStore:contactStore]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showTableview];
            });
            
        });
    } else if (authorizationStatus == CNAuthorizationStatusDenied || authorizationStatus == CNAuthorizationStatusRestricted) {
        //拒绝访问，这种情况已经在外面处理，这里不考虑
    }
    
    
//    [[NetworkManager sharedManager] getRequest:UserInviteAddresslist parameters:nil success:^(NSDictionary * _Nonnull data) {
//
//    } failure:^(NSError * _Nonnull error) {
//
//    }];
}

///处理拿到的数据
- (void)handleContacts:(NSArray *)originalArray {
    
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    NSMutableArray *titles = [NSMutableArray array];
    
    for (NSDictionary *info in originalArray) {
        NSString *firstPinYin = [info[@"pinyin"] substringToIndex:1];
        
        if (result[firstPinYin]) {
            NSMutableArray *arr = result[firstPinYin];
            [arr addObject:info];
            
        } else {
            NSMutableArray *arr = [NSMutableArray array];
            [arr addObject:info];
            [result setObject:arr forKey:firstPinYin];
            
            [titles addObject:firstPinYin];
        }
        
    }
    
    [titles sortUsingComparator:^NSComparisonResult(NSString *obj1, NSString * obj2) {
        return [obj1 compare:obj2];
    }];
    
    _titles = titles;
    _contactInfo = result;
}

- (NSString *)pinyin:(NSString *)ori {
    //耗时，必须异步操作
    NSMutableString *pinyin = [ori mutableCopy];
    
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripDiacritics, NO);
    
    return [[pinyin stringByReplacingOccurrencesOfString:@" " withString:@""] uppercaseString];
}

- (void)showTableview {
    
    CGRect rect = CGRectMake(0, 0, ScreenWidth, ScreenHeight - NavHeight - BottomHeight);
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"ContactViewCell" bundle:nil] forCellReuseIdentifier:@"ContactViewCell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 68;
    [self.view addSubview:_tableView];
}

///拒绝访问提示信息
- (void)showDeniedAlert {
    
    [self alertWithTitle:@"提示" message:@"无法获取通讯录，请到\"设置->隐私\"中打开通讯录权限" items:@[@"取消",@"确认"] action:^(NSInteger index) {
        
        if (index == 0) {
            [self dismissViewControllerAnimated:NO completion:^{
               [self.navigationController popViewControllerAnimated:YES];
            }];
            
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
        }
    }];
}

#pragma mark-
- ( NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _titles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *contacts = self.contactInfo[_titles[section]];
    
    return contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *contacts = self.contactInfo[_titles[indexPath.section ]];
    NSDictionary *contact = contacts[indexPath.row];
    
    NSString *name = contact[@"name"];
    
    cell.nameLabel.text = name;
    cell.mobileLabel.text = contact[@"phoneNumber"];
    cell.shortLabel.text = [name substringFromIndex:name.length - 1];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _titles[section];
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
            NSString *name = [NSString stringWithFormat:@"%@%@",familyName,givenName];
            
            CNLabeledValue *value = contact.phoneNumbers.lastObject;
            CNPhoneNumber *number = value.value;
            NSString *phoneNumber = number.stringValue;
            
            NSString *pinyin = [self pinyin:name];
            
            if (name.length > 0 && phoneNumber.length > 0) {
                [contacts addObject:@{@"name":name, @"phoneNumber":phoneNumber,@"pinyin":pinyin}];
            }
            
        }
        
        return [NSArray arrayWithArray:contacts];
        
    } else {
        return nil;
    }
    
}

@end
