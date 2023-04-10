//
//  ZhenwupTaskCell.m
//  GiguoFrameWork
//
//  Created by Admin on 2021/9/29.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "ZhenwupTaskCell.h"
#import "ZhenwupTheme_Utils.h"
#import "UIView+GrossExtension.h"
#import "NSString+GrossExtension.h"
#import "ZhenwupAccount_Server.h"
#define EM_RGBA(r,g,b,a)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
@implementation ZhenwupTaskCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        self.em_bgV = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.em_width - 20,80)];
        self.em_bgV.layer.cornerRadius = 10;
        self.em_bgV.backgroundColor= EM_RGBA(55, 57, 65, 0.8) ;
        [self.contentView addSubview:self.em_bgV];
        
                        
        
        UIFont *contFont = [ZhenwupTheme_Utils em_colors_LargeFont];
        self.em11_taskName = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, self.em_bgV.em_width/2, 20)];
        self.em11_taskName.font = contFont;
        self.em11_taskName.textColor = [ZhenwupTheme_Utils em_colors_GrayColor];
        self.em11_taskName.text = @"";
        self.em11_taskName.textAlignment = NSTextAlignmentLeft;
        self.em11_taskName.numberOfLines = 0;
        [self.em_bgV addSubview:self.em11_taskName];
        
        self.em18_taskDetail = [[UILabel alloc] initWithFrame:CGRectMake(15, self.em11_taskName.em_bottom + 10, self.em_bgV.em_width/2, 18)];
        self.em18_taskDetail.font = [ZhenwupTheme_Utils em_colors_SmallFont];
        self.em18_taskDetail.textColor = [ZhenwupTheme_Utils khxl_SmalltitleColor];
        self.em18_taskDetail.text = @"";
        self.em18_taskDetail.adjustsFontSizeToFitWidth = true;
        self.em18_taskDetail.textAlignment = NSTextAlignmentLeft;
        self.em18_taskDetail.numberOfLines = 0;
        [self.em_bgV addSubview:self.em18_taskDetail];
        
        
        self.em14_taskBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.em14_taskBtn.frame =  CGRectMake(self.em_bgV.em_width - 90, 25, 80, 30);
        self.em14_taskBtn.backgroundColor = [ZhenwupTheme_Utils khxl_SmalltitleColor];
        self.em14_taskBtn.layer.cornerRadius = 15;
        self.em14_taskBtn.titleLabel.font = [ZhenwupTheme_Utils khxl_FontSize13];
        [self.em14_taskBtn setTitle:@"Đến" forState:UIControlStateNormal];
        [self.em14_taskBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [self.em14_taskBtn addTarget:self action:@selector(em14_taskAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.em_bgV addSubview:self.em14_taskBtn];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.em_bgV.frame=CGRectMake(10, 10, self.em_width - 20,80);
    self.em11_taskName.frame = CGRectMake(15, 10, self.em_bgV.em_width/2, 20);
    self.em18_taskDetail.frame  = CGRectMake(15, self.em11_taskName.em_bottom + 10, self.em_bgV.em_width/2, 18);
    self.em14_taskBtn.frame =  CGRectMake(self.em_bgV.em_width - 90, 25, 80, 30);
}


- (void)em14_taskAction:(UIButton *)em14_taskBtn{
    
    NSDictionary *params = @{[NSString stringWithFormat:@"%@",@"game_id"] : EMSDKGlobalInfo.gameInfo.gameID?:@"", [NSString stringWithFormat:@"%@",@"userid"]:[EMSDKGlobalInfo.userInfo.userID hash_md5]?:@"", [NSString stringWithFormat:@"%@",@"token"]: [EMSDKGlobalInfo.userInfo.token hash_base64Encode]?:@""};
    NSString *url = [ZhenwupRemoteData_Server em14_BuildFinalUrl:MYMGUrlConfig.em14_httpsdomain.em14_backupsBaseUrl WithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpAutoLoginPath andParams:params];
    [EMSDKGlobalInfo em14_PresendWithUrlString:url];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
