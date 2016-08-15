//
//  SearchResultTableViewCell.m
//  GaoDe-da0hang
//
//  Created by xiacheng on 16/4/20.
//  Copyright © 2016年 xiacheng. All rights reserved.
//

#import "SearchResultTableViewCell.h"

@interface SearchResultTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@end

static NSString *device;
@implementation SearchResultTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    if (kScreenWidth == 320) {
        self.nameLabel.font = [UIFont systemFontOfSize:17];
        self.areaLabel.font = [UIFont systemFontOfSize:15];
    }else if(kScreenWidth == 375){
        self.nameLabel.font = [UIFont systemFontOfSize:18];
        self.areaLabel.font = [UIFont systemFontOfSize:16];
    }else {
        self.nameLabel.font = [UIFont systemFontOfSize:19];
        self.areaLabel.font = [UIFont systemFontOfSize:17];
    }
    // Initialization code
}

- (void)setTip:(AMapTip *)tip
{
    if (_tip != tip) {
        _tip = tip;
        self.nameLabel.text = tip.name;
        self.areaLabel.text = tip.district;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
