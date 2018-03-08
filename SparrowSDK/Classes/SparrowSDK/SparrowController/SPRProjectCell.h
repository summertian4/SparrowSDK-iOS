//
//  SPRProjectCell.h
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/8.
//

#import <UIKit/UIKit.h>

@class SPRProject;
@interface SPRProjectCell : UITableViewCell

@property (nonatomic, strong) UIView *blockView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;

@property (nonatomic, strong) SPRProject *model;

@end
