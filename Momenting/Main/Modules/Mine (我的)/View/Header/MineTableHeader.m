/**
 * 我的头视图
 * @author xiaobai zhang 2018-12-16 创建文件
 */

#import "MineTableHeader.h"
#import "MINE_EVENT_MANAGER.h"
#import "PhoneController.h"
#import "MTUserInfoDefault.h"
#import "MTMeModel.h"

#pragma mark - 声明
@interface MineTableHeader()

@property (weak, nonatomic) IBOutlet UIButton *punchBtn;    // 打卡
@property (weak, nonatomic) IBOutlet UIImageView *icon;     // 头像
@property (weak, nonatomic) IBOutlet UILabel *nameLab;      // 姓名
@property (weak, nonatomic) IBOutlet UIView *infoView;      // 个人信息
@property (weak, nonatomic) IBOutlet UIView *punchView;
@property (weak, nonatomic) IBOutlet UIView *dayView;
@property (weak, nonatomic) IBOutlet UIView *numberView;
@property (weak, nonatomic) IBOutlet UILabel *punchLab;
@property (weak, nonatomic) IBOutlet UILabel *dayLab;
@property (weak, nonatomic) IBOutlet UILabel *numberLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconConstraintW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *punchConstraintW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infoConstraintT;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *numberConstraintT;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *punchConstraintT;

@end


#pragma mark - 实现
@implementation MineTableHeader


- (void)initUI {
    [self setBackgroundColor:kColor_Main_Color];
    [self createLabel:self];
    [self.infoView setClipsToBounds:false];
    [self.infoView setBackgroundColor:[UIColor clearColor]];
    [self.nameLab setFont:[UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight]];
    [self.nameLab setTextColor:kColor_Text_Black];
    [self.punchBtn.layer setCornerRadius:self.punchBtn.height / 2];
    [self.punchBtn.layer setMasksToBounds:YES];
    [self.punchBtn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(10)]];
    [self.punchBtn setTitleColor:kColor_Text_Black forState:UIControlStateNormal];
    [self.punchBtn setTitleColor:kColor_Text_Black forState:UIControlStateHighlighted];
    
    [self.infoConstraintT setConstant:StatusBarHeight + countcoordinatesX(40)];
    [self.numberConstraintT setConstant:countcoordinatesX(-10)];
    [self.punchConstraintW setConstant:countcoordinatesX(70)];
    [self.punchConstraintT setConstant:StatusBarHeight + countcoordinatesX(5)];
    [self.iconConstraintW setConstant:countcoordinatesX(70)];
    
    [self.icon.layer setCornerRadius:countcoordinatesX(70) / 2];
    [self.icon.layer setMasksToBounds:true];
    
    
}
- (void)createLabel:(UIView *)view {
    for (UIView *subview in view.subviews) {
        [self createLabel:subview];
        if ([subview isKindOfClass:[UILabel class]]) {
            if (subview.tag == 10) {
                UILabel *lab = (UILabel *)subview;
                lab.font = [UIFont systemFontOfSize:AdjustFont(14) weight:UIFontWeightLight];
                lab.textColor = kColor_Text_Black;
            }
            else if (subview.tag == 11) {
                UILabel *lab = (UILabel *)subview;
                lab.font = [UIFont systemFontOfSize:AdjustFont(10) weight:UIFontWeightLight];
                lab.textColor = kColor_Text_Black;
            }
        }
    }
}


#pragma mark - set

- (void)setPunch:(BOOL)punch {
    _punch = punch;
    // 打卡
    if (punch == true) {
        [_punchBtn setTitle:@"已打卡" forState:UIControlStateNormal];
        [_punchBtn setTitle:@"已打卡" forState:UIControlStateHighlighted];
        
        [_punchBtn setImage:nil forState:UIControlStateNormal];
        [_punchBtn setImage:nil forState:UIControlStateHighlighted];
    }
    // 未打卡
    else {
        [_punchBtn setTitle:@"打卡" forState:UIControlStateNormal];
        [_punchBtn setTitle:@"打卡" forState:UIControlStateHighlighted];
        
        [_punchBtn setImage:[UIImage imageNamed:@"mine_siginin"] forState:UIControlStateNormal];
        [_punchBtn setImage:[UIImage imageNamed:@"mine_siginin"] forState:UIControlStateHighlighted];
    }
}


#pragma mark - 点击
// 打卡
- (IBAction)punchClick:(UIButton *)sender {
    
}

- (void)refresh
{
    MTMeModel *meModel = [MTUserInfoDefault getUserDefaultMeModel];
    if (meModel.name.length && meModel.image.length) {
        self.icon.image = [UIImage imageNamed:meModel.image];
        self.nameLab.text = meModel.name;
    }
}

- (IBAction)loginButtonClicked:(id)sender {
    
    NSLog(@"_________________%@",[MTHelp currentNavigation]);
    MTHelp.currentNavigation.hidesBottomBarWhenPushed = YES;PhoneController *phone = [PhoneController new];
    phone.hidesBottomBarWhenPushed = YES;
    [[MTHelp currentNavigation] pushViewController:phone animated:YES];
}

@end
