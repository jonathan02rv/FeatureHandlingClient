//
//  ContainerThreeViewController.swift
//  AppClient
//
//  Created by Jhonatahan Orlando Rivera Vilcapoma on 30/06/21.
//

import UIKit
import sdk_ios_feature_handling

class ContainerThreeViewController: UIViewController {
    
    @IBOutlet weak var txtFeatureOne: UITextField!
    @IBOutlet weak var btnFeatureThree: UIButton!
    
    private let ldCliet = Utils.getAppDelegate().ldCliet
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    deinit {
        print("REMOVE CONTAINER THREE")
    }
    
    func setupView(){
        registerFeatures()
    }
    
    
    @IBAction func actionButon(_ sender: UIButton){
    }
    
    @IBAction func routeToPrevius(_ sender: UIButton){
        removeFeaturesReferences()
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension ContainerThreeViewController{
    func registerFeatures(){
        let arrayFeatures = getFeatures()
        do {
            try FeatureManager.sharedInstance.registerContainer(featureComponent: self, features: arrayFeatures)
        }catch{
            print(error)
        }
    }
    
    func getFeatures()->[Feature]{
        let ft5 = Feature(name:FeaturesNames.feat5,featureView:txtFeatureOne)
        let ft6 = Feature(name:FeaturesNames.feat6,featureView:btnFeatureThree)
        ldCliet?.checkFeatureStrValue(featureKey: FeaturesNames.feat5, defaultValue: "")
        ldCliet?.checkFeatureStrValue(featureKey: FeaturesNames.feat6, defaultValue: "enable")
        
        let arrayFeatures:[Feature] = [ft5,ft6]
        return arrayFeatures
    }
    
    func removeFeaturesReferences(){
        FeatureManager.sharedInstance.disposeComponent(featureContainer: self)
    }
}

extension ContainerThreeViewController: FeatureListener{
    func onFeatureCustomStateChanged(featureName: String, newStatus: String) {
        //Impplement Custom feature state change
        switch featureName {
        case FeaturesNames.feat5:
            txtFeatureOne.placeholder = newStatus
        case FeaturesNames.feat6:
            btnFeatureThree.backgroundColor = UIColor(hex: newStatus)
        default:
            break
        }
    }
}
