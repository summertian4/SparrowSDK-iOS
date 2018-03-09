//
//  SPRProjectCell.m
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/8.
//

#import "SPRProjectCell.h"
#import <Masonry/Masonry.h>
#import "SPRProject.h"

@implementation SPRProjectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self blockView];
    }
    return self;
}

- (void)setModel:(SPRProject *)model {
    _model = model;
    self.titleLabel.text = model.name;
    self.descriptionLabel.text = model.note;
}

- (UIView *)blockView {
    if (_blockView == nil) {
        _blockView = [[UIView alloc] init];
        _blockView.backgroundColor = [UIColor whiteColor];
        _blockView.layer.borderColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1].CGColor;
        _blockView.layer.borderWidth = 1;
        _blockView.layer.cornerRadius = 5;
        _blockView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        _blockView.layer.shadowOpacity = 0.95f;
        _blockView.layer.shadowOffset = CGSizeMake(1,1);

        [_blockView addSubview:[self titleLabel]];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_blockView).offset(8);
            make.left.equalTo(_blockView).offset(15);
        }];

        [_blockView addSubview:[self descriptionLabel]];
        [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
            make.left.equalTo(self.titleLabel);
        }];

        [self addSubview:_blockView];
        [_blockView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.top.equalTo(self).offset(5);
            make.right.equalTo(self).offset(-10);
            make.bottom.equalTo(self).offset(-5);
        }];
    }
    return _blockView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor colorWithRed:54/256.0 green:54/256.0 blue:54/256.0 alpha:1];
        _titleLabel.text = @"标题";
    }
    return _titleLabel;
}

- (UILabel *)descriptionLabel {
    if (_descriptionLabel == nil) {
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.font = [UIFont systemFontOfSize:13];
        _descriptionLabel.textColor = [UIColor lightGrayColor];
        _descriptionLabel.text = @"描述";
    }
    return _descriptionLabel;
}

@end
