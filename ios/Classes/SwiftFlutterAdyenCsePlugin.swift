import Flutter
import Adyen
import UIKit

public class SwiftFlutterAdyenCsePlugin: NSObject, FlutterPlugin {
    var publicKey: String?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_adyen_cse", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterAdyenCsePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch (call.method) {
        case "initAdyenCse":
            initAdyenCse(call: call, result: result)
            break;
        case "encryptCard":
            encryptCard(call: call, result: result)
            break;
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func initAdyenCse(call: FlutterMethodCall, result: FlutterResult) {
        let arguments = call.arguments as! Dictionary<String, Any>
        let publicKey = arguments["publicKey"] as! String
        self.publicKey = publicKey
        
        result("Adyen client side encryption initialized")
    }
    
    private func encryptCard(call: FlutterMethodCall, result: FlutterResult)  {
        
        if (self.publicKey == nil) {
            result(FlutterError(code: "E001", message: "Adyen CSE public key not configured!", details: nil))
            return
        }
        
        let arguments = call.arguments as! Dictionary<String, Any>
        let cardNumber = arguments["cardNumber"] as! String
        let securityCode = arguments["securityCode"] as! String
        let expiryMonth = arguments["expiryMonth"] as! String
        let expiryYear = arguments["expiryYear"] as! String
        
        let unencryptedCard = Card(number: cardNumber, securityCode: securityCode, expiryMonth: expiryMonth, expiryYear: expiryYear)
        var resultData = NSMutableDictionary()
        var data: String? = nil
        
        do {
            let encryptedCard = try CardEncryptor.encrypt(card: unencryptedCard, with: self.publicKey!)
            
            resultData = [
                "encryptedNumber":encryptedCard.number!,
                "encryptedExpiryMonth":encryptedCard.expiryMonth!,
                "encryptedExpiryYear":encryptedCard.expiryYear!,
                "encryptedSecurityCode":encryptedCard.securityCode!,
            ]
            
        } catch let encryptedCardError {
            debugPrint(encryptedCardError)
        }
        
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: resultData, options: .prettyPrinted)
            data = String(data: jsonData, encoding: .utf8)
        }catch let jsonError{
            debugPrint(jsonError)
        }
        
        result(data)
    }
}
