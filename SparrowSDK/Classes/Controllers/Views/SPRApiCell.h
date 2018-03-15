//
//  SPRApiCell.h
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/15.
//

#import <UIKit/UIKit.h>

@class SPRApi;
@interface SPRApiCell : UITableViewCell
@property (nonatomic, strong) UILabel *methodLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *urlLabel;
@property (nonatomic, strong) UISwitch *mockSwitch;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) SPRApi *model;
@end
