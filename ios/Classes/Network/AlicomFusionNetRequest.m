
#import "AlicomFusionNetRequest.h"
#import <CommonCrypto/CommonHMAC.h>

#pragma mark - SmsPopRequest

@implementation AlicomFusionNetRequest
- (instancetype)init {
    if (self = [super init]) {
        self.format = @"JSON";
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
        formatter.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];//零区时间
        [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"]];
    }
    return self;
}
#pragma mark - utils
- (NSMutableDictionary *)toDictionary {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [self setObjToDict:dictionary val:self.format key:@"Format"];
    [self setObjToDict:dictionary val:self.action key:@"Action"];
    return dictionary;
}
- (NSString *)buildRequestString {
    
    NSDictionary *parameters = [self toDictionary];
    if (!parameters || parameters.count == 0) {
        return nil;
    }
    NSMutableString *canonicalizedQuery = [[NSMutableString alloc] init];
    NSComparator comparator = ^(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    };
    NSArray *sortedKeys = [[parameters allKeys] sortedArrayUsingComparator:comparator];
    [sortedKeys enumerateObjectsUsingBlock:^(id  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString * separator = (idx == 0) ? @"" : @"&";
        NSString *encodeKey = [self percentEncode:key];
        NSString *encodeValue = [self percentEncode:[parameters objectForKey:key]];
        [canonicalizedQuery appendFormat:@"%@%@=%@", separator, encodeKey, encodeValue];
    }];
    
    return [canonicalizedQuery copy];
}
- (BOOL)setObjToDict:(NSMutableDictionary *)dict val:(id)val key:(id<NSCopying>)key {
    if (val == nil) {
        return NO;
    }
    [dict setObject:val forKey:key];
    return YES;
}

- (NSString *)percentEncode:(NSString *)value {
    if (![value isKindOfClass:[NSString class]]) {
        return value;
    }
    static NSMutableCharacterSet *allowedCharacters = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        allowedCharacters = [[NSMutableCharacterSet alloc] init];
        [allowedCharacters formUnionWithCharacterSet:[NSCharacterSet letterCharacterSet]];
        [allowedCharacters formUnionWithCharacterSet:[NSCharacterSet decimalDigitCharacterSet]];
        [allowedCharacters addCharactersInString:@"-_.~"];
    });
    return [value stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
}

- (NSString *)hmacSha1ToBase64StringWithText:(NSString *)text key:(NSString *)key {
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [text cStringUsingEncoding:NSUTF8StringEncoding];
    if ((cKey==NULL) || (cData==NULL)) {
        return nil;
    }
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    return [HMAC base64EncodedStringWithOptions:0];
}
@end

#pragma mark - SmsPopGetTokenRequest

@implementation AlicomFusionNetGetTokenRequest
- (instancetype)init {
    if (self = [super init]) {
        self.platform = @"iOS";
        self.bundleId = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
    }
    return self;
}
- (NSMutableDictionary *)toDictionary {
    NSMutableDictionary *dictionary = [super toDictionary];
    [self setObjToDict:dictionary val:self.schemeCode key:@"SchemeCode"];
    [self setObjToDict:dictionary val:self.bundleId key:@"BundleId"];
    [self setObjToDict:dictionary val:self.platform key:@"Platform"];
    [self setObjToDict:dictionary val:self.durationSeconds key:@"DurationSeconds"];
    return dictionary;
}

@end


#pragma mark - SmsPopVerifyTokenRequest
@implementation AlicomFusionNetVerifyTokenRequest
- (instancetype)init {
    if (self = [super init]) {

    }
    return self;
}
- (NSMutableDictionary *)toDictionary {
    NSMutableDictionary *dictionary = [super toDictionary];
    [self setObjToDict:dictionary val:self.schemeCode key:@"SchemeCode"];
    [self setObjToDict:dictionary val:self.verifyToken key:@"VerifyToken"];
    return dictionary;
}
@end
