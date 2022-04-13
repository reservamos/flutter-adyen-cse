#import "FlutterAdyenCsePlugin.h"
#if __has_include(<flutter_adyen_cse/flutter_adyen_cse-Swift.h>)
#import <flutter_adyen_cse/flutter_adyen_cse-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_adyen_cse-Swift.h"
#endif

@implementation FlutterAdyenCsePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterAdyenCsePlugin registerWithRegistrar:registrar];
}
@end
