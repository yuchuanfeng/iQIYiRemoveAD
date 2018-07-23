# iQIYiRemoveAD
爱奇艺除开屏广告、视频广告

版本：v9.7.0

```
%hook AdsProxy
+ (id)GetAdExtraInfoWithAdId_oc:(unsigned int)arg1{return nil;}    // IMP=0x00000001020d3ba8
+ (id)GetExportLog_oc{return nil;}    // IMP=0x00000001020d3c68
+ (id)GetSdkVersion_oc{return nil;}
+ (unsigned int)InitCupidEpisode_oc:(id)arg1{return 0;}   // IMP=0x00000001020d389c
+ (void)OnAdEventWithAdId_oc:(unsigned int)arg1 event:(int)arg2{}    // IMP=0x00000001020d3a28
+ (void)OnAdEventWithAdId_oc:(unsigned int)arg1 event:(int)arg2 properties:(id)arg3{}    // IMP=0x00000001020d3a3c
+ (void)OnCreativeEventWithAdId_oc:(unsigned int)arg1 event:(int)arg2 index:(int)arg3 url:(id)arg4{}    // IMP=0x00000001020d3b94
+ (void)OnVVEventWithVVId_oc:(unsigned int)arg1 event:(int)arg2{}    // IMP=0x00000001020d3c04
+ (void)RegisterJsonDelegateWithVVId_oc:(unsigned int)arg1 slotType:(int)arg2 delegate:(id)arg3{}    // IMP=0x00000001020d39d8
+ (void)RegisterObjectAppDelegateWithVVId_oc:(unsigned int)arg1 slotType:(int)arg2 delegate:(id)arg3{}    // IMP=0x00000001020d3a00
+ (void)SetMemberStatus_oc:(id)arg1{}    // IMP=0x00000001020d3940
+ (void)SetSdkStatus_oc:(id)arg1{}    // IMP=0x00000001020d3c18
+ (void)ShutDownCupidEpisode_oc:(unsigned int)arg1{}    // IMP=0x00000001020d3c40
+ (void)UpdateAdProgress:(unsigned int)arg1 progress:(unsigned int)arg2{}    // IMP=0x00000001020d3b80
+ (void)onPlayCardShow:(unsigned int)arg1 event:(int)arg2{}
%end

%hook AdsClient
- (id)initWithUserId:(id)arg1 appVersion:(id)arg2 cupidUserId:(id)arg3 mobileKey:(id)arg4{
    return nil;
}
%end
```
