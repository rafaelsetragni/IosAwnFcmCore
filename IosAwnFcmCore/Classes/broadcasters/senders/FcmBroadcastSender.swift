//
//  FcmBroadcastSender.swift
//  awesome_notifications
//
//  Created by CardaDev on 03/05/22.
//

import Foundation
import IosAwnCore

public class FcmBroadcastSender {
    static let TAG:String = "FcmBroadcastSender"
    
    // **************************** SINGLETON PATTERN *************************************
    
    static var instance:FcmBroadcastSender?
    public static var shared:FcmBroadcastSender {
        get {
            FcmBroadcastSender.instance =
                FcmBroadcastSender.instance ?? FcmBroadcastSender()
            return FcmBroadcastSender.instance!
        }
    }
    private init(){}
    
    // **************************** SINGLETON PATTERN *************************************
    

    public func SendBroadcastNewFcmToken(token:String) {
        AwesomeFcmEventsReceiver
                .shared
                .addNewFcmTokenEvent(withToken: token)
    }

    public func SendBroadcastSilentData(
        silentData: SilentDataModel,
        completionHandler: @escaping (Bool, Error?) -> Void
    ) throws -> Bool {
        if SwiftUtils.isRunningOnExtension() {
            completionHandler(false, nil)
            return false
        } else {
            let silentRequest:FcmSilentDataRequest =
                FcmSilentDataRequest(
                    silentData: silentData,
                    handler: completionHandler)
            
            return try FcmBackgroundService
                    .shared
                    .enqueue(silentRequest: silentRequest)
        }
    }
}
