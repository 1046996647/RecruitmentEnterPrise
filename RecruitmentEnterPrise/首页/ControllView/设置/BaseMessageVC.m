//
//  BaseMessageVC.m
//  RecruitmentEnterPrise
//
//  Created by ZhangWeiLiang on 2017/10/20.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "BaseMessageVC.h"
#import "EditHeadImgVC.h"
#import "UIImage+UIImageExt.h"

#import "AddContactCell.h"

@interface BaseMessageVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) NSArray *dataArr;
@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIButton *userBtn;

@property (nonatomic,strong) NSArray *selectArr;
@property (nonatomic,strong) NSArray *selectJobArr;

@end

@implementation BaseMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 选择项数据
    NSArray *selectArr = [InfoCache unarchiveObjectWithFile:SelectItem];;
    self.selectArr = selectArr;
    
    NSArray *selectJobArr = [InfoCache unarchiveObjectWithFile:SelectItemJob];;
    self.selectJobArr = selectJobArr;
    
    [self get_company_info];
}

- (void)get_company_info
{
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Get_company_info dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        PersonModel *model = [PersonModel yy_modelWithJSON:responseObject[@"data"]];
        self.model = model;
        
        self.dataArr = @[@{@"title":@"招聘负责人",@"placeTitle":@"请填写招聘负责人",@"text":model.name,@"key":@"contactName"},
                         @{@"title":@"法人代表（选填）",@"placeTitle":@"请填写法人代表",@"text":model.lawer,@"key":@"lawer"},
                         @{@"title":@"联系电话",@"placeTitle":@"请填写联系电话",@"text":model.tele,@"key":@"tele"},
                         @{@"title":@"传真号码（选填）",@"placeTitle":@"请填写传真号码",@"text":model.fax,@"key":@"fax"},
                         @{@"title":@"公司地址",@"placeTitle":@"请填写公司地址",@"text":model.address,@"key":@"address"},
                         @{@"title":@"公司网站（选填）",@"placeTitle":@"请填写公司网站",@"text":model.web,@"key":@"web"},
                         @{@"title":@"所属行业",@"placeTitle":@"请选择所属行业",@"text":model.cateName,@"key":@"cateName"},
                         @{@"title":@"公司性质",@"placeTitle":@"请选择公司性质",@"text":model.type,@"key":@"type"}
                         
                         ];
        
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dic in self.dataArr) {
            
            AddContactModel *model = [AddContactModel yy_modelWithJSON:dic];
            [arrM addObject:model];
            
        }
        
        self.dataArr = arrM;
        
        _tableView = [UITableView tableViewWithframe:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        //    _tableView.backgroundColor = [UIColor redColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        // 头视图
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        
        UIButton *userBtn = [UIButton buttonWithframe:CGRectMake((kScreenWidth-75)/2, 28, 75, 75) text:@"" font:SystemFont(16) textColor:@"#FFFFFF" backgroundColor:@"" normal:@"Rectangle 14" selected:nil];
        userBtn.layer.cornerRadius = 10;
        userBtn.layer.masksToBounds = YES;
        [headerView addSubview:userBtn];
        [userBtn addTarget:self action:@selector(editImgAction) forControlEvents:UIControlEventTouchUpInside];
        self.userBtn = userBtn;
        [self.userBtn sd_setImageWithURL:[NSURL URLWithString:self.model.logo] forState:UIControlStateNormal];
        
        
        UIImageView *edtImg = [UIImageView imgViewWithframe:CGRectMake(userBtn.width-15, userBtn.height-15, 15, 15) icon:@"41"];
        [userBtn addSubview:edtImg];
        
        
        UILabel *nameLab = [UILabel labelWithframe:CGRectMake(22, userBtn.bottom+44, 58, 17) text:@"公司名称" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:@"#666666"];
        [headerView addSubview:nameLab];
        
        // 杭州晖鸿科技有限公司
        UILabel *nameLab1 = [UILabel labelWithframe:CGRectMake(kScreenWidth-200-22, nameLab.top, 200, 17) text:@"" font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentRight textColor:@"#666666"];
        [headerView addSubview:nameLab1];
        nameLab1.text = self.model.title;
        
        headerView.height = nameLab.bottom;
        _tableView.tableHeaderView = headerView;
        
        
        // 尾视图
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 46+40+46)];
        
        UIButton *releseBtn = [UIButton buttonWithframe:CGRectMake(25, 46, kScreenWidth-50, 40) text:@"提交修改内容" font:SystemFont(16) textColor:@"#FFFFFF" backgroundColor:@"#D0021B" normal:@"" selected:nil];
        releseBtn.layer.cornerRadius = 7;
        releseBtn.layer.masksToBounds = YES;
        [footerView addSubview:releseBtn];
        [releseBtn addTarget:self action:@selector(upAction) forControlEvents:UIControlEventTouchUpInside];

        
        _tableView.tableFooterView = footerView;// 请保存完善的信息
        
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)upAction
{
    [self.view endEditing:YES];
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    
    for (AddContactModel *model in self.dataArr) {
        
        if (!([model.title isEqualToString:@"法人代表（选填）"]||
              [model.title isEqualToString:@"传真号码（选填）"]||
              [model.title isEqualToString:@"公司网站（选填）"])) {
            
            if (model.text.length == 0) {
                [self.view makeToast:@"您还有必填项未填写"];
                return;
            }
        }
        
        [paramDic  setValue:model.text forKey:model.key];
        
    }
    
    NSLog(@"%@",paramDic);
    
    [AFNetworking_RequestData requestMethodPOSTUrl:Update_company_info dic:paramDic showHUD:YES response:NO Succed:^(id responseObject) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)editImgAction
{
    EditHeadImgVC *vc  = [[EditHeadImgVC alloc] init];
    vc.modalPresentationStyle=UIModalPresentationOverCurrentContext;
    //淡出淡入
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //  self.definesPresentationContext = YES; //不盖住整个屏幕
    vc.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
    [self presentViewController:vc animated:YES completion:nil];
    vc.clickBlock = ^(NSInteger indexRow) {
        
        if (indexRow == 0) {
            
            // 创建相册控制器
            UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
            
            // 设置代理对象
            pickerController.delegate = self;
            // 设置选择后的图片可以被编辑
            //            pickerController.allowsEditing=YES;
            
            // 判断当前设备是否有摄像头
            if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear] || [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
                
                // 设置类型
                pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                
            }
            
            // 跳转到相册页面
            [self presentViewController:pickerController animated:YES completion:nil];
        }
        else {
            // 创建相册控制器
            UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
            
            // 设置代理对象
            pickerController.delegate = self;
            // 设置选择后的图片可以被编辑
            //            pickerController.allowsEditing=YES;
            // 设置类型
            pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            // 设置为静态图像类型
            pickerController.mediaTypes = @[@"public.image"];
            // 跳转到相册页面
            [self presentViewController:pickerController animated:YES completion:nil];
        }
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //    return [self.dataArr count];
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArr count];
    //    return 2;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 86;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[AddContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    AddContactModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    cell.selectArr = _selectArr;
    cell.selectJobArr = _selectJobArr;
    return cell;
}

#pragma mark - UIImagePickerControllerDelegate

//选取后调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"info:%@",info[UIImagePickerControllerOriginalImage]);
    UIImage *img = info[UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //通过判断picker的sourceType，如果是拍照则保存到相册去
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
    
    NSMutableDictionary  *paramDic=[[NSMutableDictionary  alloc]initWithCapacity:0];
    NSData *data = [UIImage imageOrientation:img];
    
    [AFNetworking_RequestData uploadImageUrl:Upload_company_logo dic:paramDic data:data Succed:^(id responseObject) {
        
        [self.userBtn sd_setImageWithURL:[NSURL URLWithString:responseObject[@"img"]] forState:UIControlStateNormal];
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

//取消后调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//此方法就在UIImageWriteToSavedPhotosAlbum的上方
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSLog(@"已保存");
}

@end
