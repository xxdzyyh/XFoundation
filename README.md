# XFoundation

想要快速上线产品，就技术实现角度来讲，就是要将能提前做的事情的都做了，XFFoundation就是一个用来实现快速上线产品的框架。

### 使用shell生成模板

使用项目中的的xftemplate.sh脚本，可以创建相应的文件。

```
$ sh xftemplate.sh User
$ ls User

User.h
User.m
UserCell.h   
UserCell.m
UserCell.xib 
UserVC.h
UserVC.m
UserListVC.h
UserListVC.m 
UserDetailVC.h      
UserDetailVC.m
```
文件的头文件导入，常见的方法都已准备就绪。

```
//
// UserListVC.m
// XNOnline
//
// Created by xiaoniu on 2019/01/23.
// Copyright © 2019 xiaoniu88. All rights reserved.
//
#import "UserListVC.h"

#import "User.h"
#import "UserCell.h"
#import "RequestResult.h"
#import "UserDetailVC.h"
#import <YYModel/YYModel.h>
#import <SVProgressHUD/SVProgressHUD.h>

//typedef NS_ENUM(NSUInteger,UserCellType) {
//    UserCellTypeOne,
//    UserCellCount
//};

@interface UserListVC ()

@end

@implementation UserListVC

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self sendDefaultRequest];
}

#pragma mark - Request

- (NSString *)defaultPath {
	return @"";
}

- (void)sendDefaultRequest {
    XFRequest *request = [[XFRequest alloc] initWithPath:[self defaultPath] finish:^(XFRequest *request, id result) {
        if (self.page == [self startPage]) {
            [self.refreshHeader endRefreshing];
        } else {
            [self.refreshFooter endRefreshing];
        }
		
		RequestResult *res = [RequestResult yy_modelWithJSON:result];
        
        if (res.code == 200) {
            NSArray *array = [NSArray yy_modelArrayWithClass:[self modelClass] json:res.data];
            
            if (self.page == [self startPage]) {
                self.dataSource = [array mutableCopy];
            } else {
                [self.dataSource addObjectsFromArray:array];
            }
        } else {
        	Toast(res.msg);
        }
    }];
    
    [self.mainQueue push:request];
}

#pragma mark - <XFCellDelegate>

- (Class)modelClass {
	return [User class];
}

- (Class)cellClass {
    return [UserCell class];
}

//- (Class)cellClassForIndexPath:(NSIndexPath *)indexPath {
//  	return [UserCell class];
//}


#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id obj = self.dataSource[indexPath.row];
//    
//    UIViewController *vc = [UserDetailVC new];
//    [self.navigationController pushViewController:vc animated:YES];
}

@end

```

你需要做的就是实现 defaultPath 返回你自己的请求地址，同时在sendDefaultRequest方法中添加请求参数。








