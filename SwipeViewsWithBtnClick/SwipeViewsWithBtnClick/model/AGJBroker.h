//
//  AGJBroker.h
//  Angejia
//
//  Created by wysasun on 15/1/12.
//  Copyright (c) 2015年 Plan B Inc. All rights reserved.
//

#import "BIFModel.h"

@interface AGJBroker : BIFModel


@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *name;
CREATE_STRING_PROPERTY(phone)
CREATE_STRING_PROPERTY(photoUrl)
CREATE_STRING_PROPERTY(imgUrl)
CREATE_STRING_PROPERTY(visitCount)
CREATE_STRING_PROPERTY(reviewCount)
CREATE_STRING_PROPERTY(assignedPhone)//集团号
CREATE_STRING_PROPERTY(avatar)
CREATE_STRING_PROPERTY(stars)
CREATE_STRING_PROPERTY(star)
CREATE_STRING_PROPERTY(isCc)
CREATE_STRING_PROPERTY(privateInventoryCount)
CREATE_STRING_PROPERTY(content)//地图欢迎页中，content为经纪人的活动

//payload 3.0+3.1
CREATE_STRING_PROPERTY(inventoryCount)//推荐房源数
CREATE_STRING_PROPERTY(userId);
CREATE_STRING_PROPERTY(birthPlaceName)//出生地
CREATE_STRING_PROPERTY(age)
CREATE_STRING_PROPERTY(serviceYear)
CREATE_STRING_PROPERTY(identityCardNumber)//认证号码
CREATE_STRING_PROPERTY(workExperience)
CREATE_STRING_PROPERTY(weiliaoReplyRatio)//微聊回复率，百分比
CREATE_STRING_PROPERTY(weiliaoReplyTime)//微聊回复时间，单位：分钟
CREATE_STRING_PROPERTY(visitReviewCount)
CREATE_STRING_PROPERTY(companyName)//公司名
CREATE_STRING_PROPERTY(flashTwUrl) //跳转tw的闪购列表
CREATE_STRING_PROPERTY(flashTwTitle)
CREATE_STRING_PROPERTY(visitReviewGoodCount) //好评数
CREATE_STRING_PROPERTY(visitReviewBadCount)//差评数
CREATE_STRING_PROPERTY(reviewVisitRate) //好评率
CREATE_STRING_PROPERTY(isGoldMedal)//是否是金牌顾问 0表示不是，1表示是
CREATE_STRING_PROPERTY(continueGoldWeek)//连续多少周获得金牌顾问
CREATE_STRING_PROPERTY(serviceSellerCount)
CREATE_STRING_PROPERTY(goodReviewCountRate)
CREATE_STRING_PROPERTY(goodReviewCount)
CREATE_STRING_PROPERTY(surroundingArea) // 熟悉商圈


/**
 *总服务房东数
 */
CREATE_STRING_PROPERTY(surveyCount)

/**
 *  经纪人状态
 *
 *  @param status 1.待入职 2.在职 3.取消入职 4.离职
 *
 */
CREATE_STRING_PROPERTY(status)

/**
 *  历史评价等级
 */
CREATE_STRING_PROPERTY(level)
CREATE_STRING_PROPERTY(evaluationScore)

CREATE_STRING_PROPERTY(wechatName)
CREATE_STRING_PROPERTY(dealCount)
CREATE_STRING_PROPERTY(viewCount)
CREATE_STRING_PROPERTY(commissionCount)
CREATE_STRING_PROPERTY(review_count)//用户评论数
CREATE_STRING_PROPERTY(describe)//选房单的描述，如：“收到您的选房单，正在定制选房单”

CREATE_STRING_PROPERTY(findInventoryTime) // 用户特征：找房时间


@end
