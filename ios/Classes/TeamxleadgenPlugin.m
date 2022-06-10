#import "TeamxleadgenPlugin.h"
#if __has_include(<teamxleadgen/teamxleadgen-Swift.h>)
#import <teamxleadgen/teamxleadgen-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "teamxleadgen-Swift.h"
#endif

@implementation TeamxleadgenPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTeamxleadgenPlugin registerWithRegistrar:registrar];
}
@end
