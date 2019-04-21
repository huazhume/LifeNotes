//
//  MTNoteViewController.m
//  Momenting
//
//  Created by xiaobai zhang on 2018/8/7.
//  Copyright © 2018年 xiaobai zhang. All rights reserved.
//

#import "MTNoteViewController.h"
#import "MTNoteToolsView.h"
#import "MTNavigationView.h"
#import "MTNoteToolsTextCell.h"
#import "MTNoteToolsImageCell.h"
#import "MTNoteModel.h"
#import "MTActionSheetView.h"
#import "MTMediaFileManager.h"
#import "MTLocalDataManager.h"
#import "MTActionAlertView.h"
#import "UIImage+ImageCompress.h"
#import "MTWeatherAlertView.h"

@interface MTNoteViewController ()
<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,
MTNavigationViewDelegate,
MTNoteToolsViewDelegate,
UIActionSheetDelegate,
UINavigationControllerDelegate,UIImagePickerControllerDelegate,
MTActionSheetViewDelegate,
MTNoteToolsTextCellDelegate,
MTWeatherAlertViewDelegate>

@property (strong, nonatomic) MTNoteToolsView *toolsView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) CGFloat keyboardHeight;

@property (strong, nonatomic) NSMutableArray *datalist;

@property (strong, nonatomic) UIFont *textFont;
@property (copy, nonatomic) NSString *weatherTitle;
@property (strong, nonatomic) NSIndexPath *selectIndexPath;
@property (strong, nonatomic) UIView *tableHeaderView;

@property (strong, nonatomic) MTNoteImageVo *topVO;
@property (strong, nonatomic) UIButton *topButton;


@end

@implementation MTNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerNotification];
    [self initBaseViews];
}

- (void)initBaseViews
{
    [self.view addSubview:self.toolsView];
    [self.view addSubview:self.navigationView];
    
    self.tableView.tableHeaderView = self.tableHeaderView;
    
    self.textFont = [UIFont fontWithName:@"PingFangSC-Light" size:14];
    [self.tableView registerNib:[UINib nibWithNibName:@"MTNoteToolsTextCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[MTNoteToolsTextCell getIdentifier]];
    [self.tableView registerNib:[UINib nibWithNibName:@"MTNoteToolsImageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:[MTNoteToolsImageCell getIdentifier]];
//    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
    
    self.navigationView.frame = CGRectMake(0, iPhoneTopMargin, SCREEN_WIDTH, 55);
    self.navigationView.delegate = self;
    self.navigationView.navigationTitle = @"书写生活";
    self.navigationView.rightTitle = @"下一步";
    self.navigationView.backgroundColor = [UIColor whiteColor];
    self.navigationView.leftButton.hidden = NO;
    [self.navigationView.leftButton setImage:[UIImage imageNamed:@"ic_arrow_back_black_24dp"] forState:UIControlStateNormal];
    self.navigationView.titleLabel.textColor = [UIColor colorWithHex:0x333333];
    self.navigationView.titleLabel.font = [UIFont systemFontOfSize:14];
    
    MTNoteToolsTextCell *textCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [textCell becomeKeyboardFirstResponder];
    
    self.weatherTitle = @"A";
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = self.datalist[indexPath.row];
    UITableViewCell *cell = nil;
    if ([model isKindOfClass:[MTNoteTextVo class]]) {
        
        MTNoteToolsTextCell *textCell = [tableView dequeueReusableCellWithIdentifier:[MTNoteToolsTextCell getIdentifier]];
        textCell.font = self.textFont;
        textCell.delegate = self;
        textCell.model = model;
        cell = textCell;
        
    } else {
        MTNoteToolsImageCell *imageCell = [tableView dequeueReusableCellWithIdentifier:[MTNoteToolsImageCell getIdentifier]];
        imageCell.model = model;
        cell = imageCell;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView new];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = self.datalist[indexPath.row];
    if ([model isKindOfClass:[MTNoteTextVo class]]) {
        return [self imageCount] ? [MTNoteToolsTextCell heightForCell] : CGRectGetHeight(self.view.bounds) - 100 - 100;
    } else {
        return [MTNoteToolsImageCell heightForCellWithModel:model];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = [self.datalist objectAtIndex:indexPath.row];
    if ([model isKindOfClass:[MTNoteTextVo class]]) return;
    self.selectIndexPath = indexPath;
    [self.view endEditing:YES];
    MTActionSheetView *sheetView = [MTActionSheetView loadFromNib];
    sheetView.isShowDelete = YES;
    sheetView.frame = [UIScreen mainScreen].bounds;
    sheetView.delegate = self;
    [sheetView show];
}

#pragma mark - MTWeatherAlertViewDelegate
- (void)weatherAlertViewSelectedWithTitle:(NSString *)title
{
    self.weatherTitle = title;
    self.toolsView.weatherTitle = title;
}

#pragma mark - MTNoteToolsTextCellDelegate
- (void)noteCell:(UITableViewCell *)cell textViewWillBeginEditing:(UITextView *)textView;
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self adjustTableViewToFitWithKeyboardHeight:self.keyboardHeight indexPath: indexPath];
}

- (void)noteCell:(UITableViewCell *)cell didChangeText:(NSString *)text
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    id model = self.datalist[indexPath.row];
    if ([model isKindOfClass: [MTNoteTextVo class]]) {
        MTNoteTextVo *textModel = model;
        textModel.text = text;
    }
}

- (void)adjustTableViewToFitWithKeyboardHeight:(CGFloat)keyboardHeight indexPath:(NSIndexPath *)indexPath
{
    if (indexPath == nil || indexPath.row == 0) {
        return;
    }
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
    CGRect rect = [cell.superview convertRect:cell.frame toView:window];
    CGFloat delta = CGRectGetMaxY(rect) - (window.bounds.size.height - keyboardHeight);
    CGPoint offset = self.tableView.contentOffset;
    offset.y += delta;
    if (offset.y < 0) {
        offset.y = 0;
    }
    offset.y = offset.y + 30;
    [self.tableView setContentOffset:offset animated:YES];
}


#pragma mark - MTNoteToolsViewDelegate
- (void)noteToolsFootActionWithFont:(UIFont *)font
{
    self.textFont = font;
    [self.tableView reloadData];
}

- (void)noteToolsActionWithType:(MTNoteToolsViewType)type
{
    
    if (type == MTNoteToolsViewImage) {
        self.selectIndexPath = nil;
        [self.view endEditing:YES];
        MTActionSheetView *sheetView = [MTActionSheetView loadFromNib];
        sheetView.frame = [UIScreen mainScreen].bounds;
        sheetView.delegate = self;
        [sheetView show];
    } else if (type == MTNoteToolsViewAt) {
        [self.view endEditing:YES];
        MTWeatherAlertView *weatherView = [MTWeatherAlertView loadFromNib];
        weatherView.frame = [UIScreen mainScreen].bounds;
        weatherView.delegate = self;
        weatherView.selectTitle = self.weatherTitle;
        [weatherView show];
    }
}

#pragma mark - MTActionSheetViewDelegate
- (void)sheetToolsActionWithType:(MTActionSheetViewType)type
{
    if (self.selectIndexPath == nil || self.selectIndexPath.row == 1000) {
        if (type == MTActionSheetViewOne) {
            [self takePhoto];
        } else if (type == MTActionSheetViewTwo) {
            [self LocalPhoto];
        }
    } else {
        if (self.selectIndexPath.row >= self.datalist.count) return;
        id model = [self.datalist objectAtIndex:self.selectIndexPath.row];
        if ([model isKindOfClass:[MTNoteTextVo class]]) return;
        if (type == MTActionSheetViewOne) {
            [self takePhoto];
        } else if (type == MTActionSheetViewTwo) {
            [self LocalPhoto];
        } else if (type == MTActionSheetViewDelete) {
            //delete
            [self.datalist removeObject:model];
            [self.datalist removeObjectAtIndex:self.selectIndexPath.row];
            [self.tableView reloadData];
        }
    }
}

#pragma mark - photo
- (void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.videoQuality = UIImagePickerControllerQualityTypeIFrame1280x720;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        NSLog(@"无法打开照相机");
    }
}

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if (![type isEqualToString:@"public.image"]) {
        return;
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    NSData *data;
    if (UIImagePNGRepresentation(image) == nil) {
        data = UIImageJPEGRepresentation(image, 1.0);
    } else {
        data = UIImagePNGRepresentation(image);
    }
    
    UIImage *beta_image = [UIImage compressImage:image compressRatio:0.4];
    NSData *beta_data;
    if (UIImagePNGRepresentation(beta_image) == nil) {
        beta_data = UIImageJPEGRepresentation(beta_image, 1.0);
    } else {
        beta_data = UIImagePNGRepresentation(beta_image);
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * path =[[MTMediaFileManager sharedManager] getMediaFilePathWithAndSanBoxType:SANBOX_DOCUMNET_TYPE AndMediaType:FILE_IMAGE_TYPE];
    NSString * beta_path =[[MTMediaFileManager sharedManager] getMediaFilePathWithAndSanBoxType:SANBOX_DOCUMNET_TYPE AndMediaType:FILE_IMAGEBATE_TYPE];
    NSString *fileName = [NSString stringWithFormat:@"%ld.png",(long)[[NSDate date]timeIntervalSince1970]];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",path,fileName];
    NSString *beta_filePath = [NSString stringWithFormat:@"%@/%@",beta_path,fileName];
    [fileManager createFileAtPath:filePath contents:data attributes:nil];
    [fileManager createFileAtPath:beta_filePath contents:beta_data attributes:nil];
    MTNoteImageVo *model = [MTNoteImageVo new];
    model.path = fileName;
    model.width = image.size.width;
    model.height = image.size.height;
    
    if (self.selectIndexPath.row < 1000) {
        if (self.selectIndexPath.row >= self.datalist.count) return;
        [self.datalist replaceObjectAtIndex:self.selectIndexPath.row withObject:model];
        
    } else if (self.selectIndexPath.row == 1000 ) {
        
        self.topVO = model;
        [self.topButton setImage:[UIImage imageWithContentsOfFile:beta_filePath] forState:UIControlStateNormal];
    } else {
        
        [self.datalist addObject:model];
        MTNoteTextVo *textModel = [MTNoteTextVo new];
        [self.datalist addObject:textModel];
    }

    [self.tableView reloadData];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)LocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - keyboard notification
- (void)registerNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChange:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChange:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)keyboardWillChange:(NSNotification *)notification
{
    NSTimeInterval animationDuration;
    NSDictionary *info = [notification userInfo];
    
    [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    CGRect keyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat y = keyboardRect.origin.y;
//    CGSize contentSize = self.tableView.contentSize;
    if (notification.name == UIKeyboardWillHideNotification) {
        y = CGRectGetHeight(self.view.bounds) - 40;
//        contentSize.height -= 2 * keyboardRect.size.height;
        
    } else {
        y = CGRectGetHeight(self.view.bounds) - keyboardRect.size.height - 40;
//        contentSize.height +=  2 * keyboardRect.size.height;
    }
//    self.tableView.contentSize = contentSize;
    self.keyboardHeight = keyboardRect.size.height;
    
    self.toolsView.keyBoardIsVisiable = (notification.name != UIKeyboardWillHideNotification);
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         self.toolsView.frame = CGRectMake(0, y, SCREEN_WIDTH, 40);
                     }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - MTNavigationViewDelegate
- (void)leftAction
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightAction
{
    [self.view endEditing:YES];
    
    if (!self.topVO) {
        [UIView showToastInKeyWindow:@"请选择一张背景图"];
        return;
    }
    [MTActionAlertView alertShowWithMessage:@"确定结束编辑？" leftTitle:@"结束" leftColor:[UIColor colorWithHex:0xCD6256] rightTitle:@"继续" rightColor:[UIColor colorWithHex:0x333333] callBack:^(NSInteger index) {
        if (index == 2){
            return;
        }
        [UIView showToastInKeyWindow:@"发送成功,审核通过后方可查看"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self saveNote];
        });
    }];
}

- (void)saveNote
{
    __block MTNoteModel *noteModel = [MTNoteModel new];
    noteModel.noteId = [NSString stringWithFormat:@"%ld",(long)[[NSDate date]timeIntervalSince1970]];
    __block BOOL isTextFind = 0;
    __block BOOL isImageFind = 0;
    [self.datalist enumerateObjectsUsingBlock:^(id  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([model isKindOfClass:[MTNoteTextVo class]]) {
            MTNoteTextVo *vo = (MTNoteTextVo *)model;
            if (vo.text.length > 0 && !isTextFind) {
                isTextFind = YES;
                noteModel.text = vo.text;
                vo.fontName = self.textFont.fontName;
                vo.fontSize = self.textFont.pointSize;
            }
            vo.noteId = noteModel.noteId;
        } else if ([model isKindOfClass:[MTNoteImageVo class]]) {
            MTNoteImageVo *vo = (MTNoteImageVo *)model;
            if (vo.path.length > 0 && !isImageFind) {
                isImageFind = YES;
                noteModel.imagePath = vo.path;
                noteModel.width = vo.width;
                noteModel.height = vo.height;
            }
            vo.noteId = noteModel.noteId;
        }
    }];
    
    if (self.topVO) {
        noteModel.imagePath = self.topVO.path;
        noteModel.width = self.topVO.width;
        noteModel.height = self.topVO.height;
        self.topVO.noteId = noteModel.noteId;
        [self.datalist insertObject:self.topVO atIndex:0];
    }
    
    noteModel.weather = self.weatherTitle;
    [[MTLocalDataManager shareInstance] insertDatas:@[noteModel] withType:MTCoreDataContentTypeNoteSelf];
    [[MTLocalDataManager shareInstance] insertDatas:self.datalist withType:MTCoreDataContentTypeNoteContent];
    [self leftAction];
}

#pragma mark - getter
- (MTNoteToolsView *)toolsView
{
    if (!_toolsView) {
        _toolsView = [MTNoteToolsView loadFromNib];
        _toolsView.frame = CGRectMake(0, self.view.bounds.size.height - 40, self.view.bounds.size.width, 40);
        _toolsView.delegate = self;
    }
    return _toolsView;
}

- (NSMutableArray *)datalist
{
    if (!_datalist) {
        _datalist = [NSMutableArray array];
        MTNoteTextVo *textModel = [[MTNoteTextVo alloc] init];
        [_datalist addObject:textModel];
    }
    return _datalist;
}

- (NSInteger)imageCount
{
    __block NSInteger sum = 0;
    [self.datalist enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[MTNoteImageVo class]]) {
            sum ++;
        }
    }];
    return sum;
}

- (UIView *)tableHeaderView
{
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"UADefaultPlaceholder"] forState:UIControlStateNormal];
        button.frame = CGRectMake(8, 8, SCREEN_WIDTH - 16, 200 -16);
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        [_tableHeaderView addSubview:button];
        self.topButton = button;
        [button addTarget:self action:@selector(addNote) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tableHeaderView;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addNote
{
    self.selectIndexPath = [NSIndexPath indexPathForRow:1000 inSection:0];
    [self.view endEditing:YES];
    MTActionSheetView *sheetView = [MTActionSheetView loadFromNib];
    sheetView.frame = [UIScreen mainScreen].bounds;
    sheetView.delegate = self;
    [sheetView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
