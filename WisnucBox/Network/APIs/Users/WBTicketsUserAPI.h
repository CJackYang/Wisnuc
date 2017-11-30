//
//  WBTicketsUserAPI.h
//  WisnucBox
//
//  Created by wisnuc-imac on 2017/11/30.
//  Copyright © 2017年 JackYang. All rights reserved.
//

#import "JYBaseRequest.h"

@interface WBTicketsUserAPI : JYBaseRequest
@property (nonatomic) NSString *ticketId;
@property (nonatomic) NSString *token;

+ (instancetype)apiWithTicketId:(NSString *)ticketId WithToken:(NSString *)token;
@end
