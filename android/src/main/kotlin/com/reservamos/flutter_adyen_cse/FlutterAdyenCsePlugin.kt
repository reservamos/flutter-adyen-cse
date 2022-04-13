package com.reservamos.flutter_adyen_cse

import androidx.annotation.NonNull
import com.adyen.checkout.core.api.Environment;
import com.adyen.checkout.cse.CardEncrypter;
import com.adyen.checkout.cse.EncryptedCard;
import com.adyen.checkout.cse.UnencryptedCard;
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import org.json.JSONObject


/** FlutterAdyenCsePlugin */
class FlutterAdyenCsePlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel
  private var publicKey: String? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_adyen_cse")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: MethodChannel.Result) {
    when (call.method) {
      "initAdyenCse" -> initAdyenCse(call, result)
      "encryptCard" -> encryptCard(call, result)
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun initAdyenCse(call: MethodCall, result: MethodChannel.Result) {
    this.publicKey = call.argument("publicKey")
    result.success("Adyen client side encryption initialized")
  }

  private fun encryptCard(call: MethodCall, result: MethodChannel.Result) {

    if (this.publicKey == null) {
      result.error("E001", "Adyen CSE public key not configured!", null)
      return
    }

    val cardNumber: String? = call.argument("cardNumber")
    val expiryMonth: String? = call.argument("expiryMonth")
    val expiryYear: String? = call.argument("expiryYear")
    val securityCode: String? = call.argument("securityCode")

    val unencryptedCard: UnencryptedCard = UnencryptedCard.Builder()
            .setNumber(cardNumber!!)
            .setExpiryMonth(expiryMonth!!)
            .setExpiryYear(expiryYear!!)
            .setCvc(securityCode!!)
            .build()

    val encryptedCard: EncryptedCard = CardEncrypter.encryptFields(unencryptedCard, this.publicKey!!)

    val resultData = JSONObject()
    resultData.put("encryptedNumber", encryptedCard.encryptedCardNumber)
    resultData.put("encryptedExpiryMonth", encryptedCard.encryptedExpiryMonth)
    resultData.put("encryptedExpiryYear", encryptedCard.encryptedExpiryYear)
    resultData.put("encryptedSecurityCode", encryptedCard.encryptedSecurityCode)
    result.success(resultData.toString())
  }
}
