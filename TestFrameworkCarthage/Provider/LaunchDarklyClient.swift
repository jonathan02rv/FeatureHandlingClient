//
//  LaunchDarklyClient.swift
//  TestLauchDarkly
//
//  Created by Jhonatahan Orlando Rivera Vilcapoma on 7/07/21.
//

import Foundation
import LaunchDarkly
import sdk_ios_feature_handling


public class LaunchDarklyClient: FeatureHandleClient{

    override init() {
        super.init()
        setupLaunchDarkly()
    }
    
    func stopObserver(){
        LDClient.get()?.stopObserving(owner: self)
    }
    
    func checkFeatureBoolValue(featureKey:String, defaultValue:Bool = true) {
        guard let ldClient = LDClient.get() else{return}
        let featureFlagValue = ldClient.variation(forKey: featureKey, defaultValue: defaultValue)
        print("\(featureFlagValue)")
        self.featureFlagDidUpdate(featureName: featureKey, newStatus: "\(featureFlagValue)")
    }
    
    func checkFeatureStrValue(featureKey:String, defaultValue:String) {
        guard let ldClient = LDClient.get() else{return}
        let featureFlagValue = ldClient.variation(forKey: featureKey, defaultValue: defaultValue)
        print("\(featureFlagValue)")
        self.featureFlagDidUpdate(featureName: featureKey, newStatus: featureFlagValue)
    }
    
    func getKeys()->[String]{
        let flagKey = FeaturesNames.feat1
        let flagDemo = FeaturesNames.flagDemo
        let flagKey2 = FeaturesNames.feat2
        let flagKey3 = FeaturesNames.feat3
        let flagKey4 = FeaturesNames.feat4
        let flagKey5 = FeaturesNames.feat5
        let flagKey6 = FeaturesNames.feat6
        return [flagKey,flagDemo,flagKey2,flagKey3,flagKey4,flagKey5,flagKey6]
    }
    
    func setupLaunchDarkly(){
        
        guard let ldClient = LDClient.get() else{return}
        let keysList = getKeys()

        ldClient.observe(keys: keysList, owner: self, handler: { [weak self] changedFlags in
            guard let _ = self else{return}
            self?.featureFlagsDidUpdate(changedFlags)
        })
    }
    
    func featureFlagsDidUpdate(_ changedFlags: [LDFlagKey:LDChangedFlag]) {
        guard let ldClient = LDClient.get() else{return}
        var newStatus = ""
        for flag in changedFlags{
            switch flag.key {
            case FeaturesNames.feat1, FeaturesNames.feat3, FeaturesNames.flagDemo:
                let flagBool = ldClient.variation(forKey: flag.key, defaultValue: false)
                newStatus = "\(flagBool)"
                print(newStatus)
            case FeaturesNames.feat2,FeaturesNames.feat4,FeaturesNames.feat5,FeaturesNames.feat6:
                let flagStr = ldClient.variation(forKey: flag.key, defaultValue: "Hola")
                newStatus = "\(flagStr)"
                print(newStatus)
            default:
                break
            }
            self.featureFlagDidUpdate(featureName: flag.key, newStatus: newStatus)
        }
    }
    
    func featureFlagDidUpdate(featureName: String, newStatus: String){
        self.onFeatureClientChanged(featureName: featureName, newStatus: newStatus)
    }
    
}
