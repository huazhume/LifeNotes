/**
 * 登录
 * @author xiaobai zhang 2018-12-17 创建文件
 */


#import "LoginController.h"
#import "RE1Controller.h"
#import "PhoneController.h"
#import "BaseViewController+Extension.h"
#import "LOGIN_NOTIFICATION.h"


#pragma mark - 声明
@interface LoginController()

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIImageView *nameIcn;
@property (weak, nonatomic) IBOutlet UIButton *wxLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *moreBtnConstraintB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wxConstraintH;

@end


#pragma mark - 实现
@implementation LoginController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.wxLoginBtn.layer setCornerRadius:3];
    [self.wxLoginBtn.layer setMasksToBounds:YES];
    [self.wxLoginBtn setTitleColor:kColor_Text_Black forState:UIControlStateNormal];
    [self.wxLoginBtn setTitleColor:kColor_Text_Black forState:UIControlStateHighlighted];
    [self.wxLoginBtn setBackgroundImage:[UIColor createImageWithColor:kColor_Main_Color] forState:UIControlStateNormal];
    [self.wxLoginBtn setBackgroundImage:[UIColor createImageWithColor:kColor_Main_Dark_Color] forState:UIControlStateHighlighted];
    [self.wxLoginBtn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(14)]];
    [self.moreBtn.titleLabel setFont:[UIFont systemFontOfSize:AdjustFont(12)]];
    [self.moreBtn setTitleColor:kColor_Text_Gary forState:UIControlStateNormal];
    [self.moreBtn setTitleColor:kColor_Text_Gary forState:UIControlStateHighlighted];
    
    [self.moreBtnConstraintB setConstant:countcoordinatesX(20) + SafeAreaBottomHeight];
    [self.wxConstraintH setConstant:countcoordinatesX(45)];
    
    [self rac_notification_register];
}

// 监听通知
- (void)rac_notification_register {
    
    
    
}

#pragma mark - 点击
// 关闭
- (IBAction)closeBtnClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
// 微信
- (IBAction)wxBtnClick:(UIButton *)sender {
    [self startQQLogin:^{
        [self.navigationController dismissViewControllerAnimated:true completion:nil];
    }];
    
//    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:nil completion:^(id result, NSError *error) {
//        if (error) {
//            [self showTextHUD:@"登录失败" delay:1.5f];
//        } else {
//            UMSocialUserInfoResponse *resp = result;
//            [self getQQLoginRequest:resp];
//        }
//    }];
}
// 更多登录方式
- (IBAction)moreBtnClick:(UIButton *)sender {
   
}


@end
