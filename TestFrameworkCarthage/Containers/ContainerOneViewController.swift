//
//  ContainerOneViewController.swift
//  AppClient
//
//  Created by Jhonatahan Orlando Rivera Vilcapoma on 21/06/21.
//

import UIKit
import sdk_ios_feature_handling

class ContainerOneViewController: UIViewController {
    
    @IBOutlet weak var lblFeatureOne: UILabel!
    @IBOutlet weak var btnFeatureOne: UIButton!
    
    private let ldCliet = Utils.getAppDelegate().ldCliet

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    deinit {
        print("REMOVE CONTAINER ONE")
    }

    func setupView(){
        loadDefaultFeatures()
        registerFeatures()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func loadDefaultFeatures(){
        do{
            try FeatureManager.sharedInstance.loadFeaturesDefault(nameResource: "features", extensionName: "json")
        }catch{
            print(error)
        }
        
    }
    
    func registerFeatures(){
        let arrayFeatures = getFeatures()
        do {
            try FeatureManager.sharedInstance.registerContainer(featureComponent: self, features: arrayFeatures)
        }catch{
            print(error)
        }
    }
    
    
    func getFeatures()->[Feature]{
        let ft1 = Feature(name:FeaturesNames.feat1,featureView:btnFeatureOne)
        let ft2 = Feature(name:FeaturesNames.feat2,featureView:lblFeatureOne)
        ldCliet?.checkFeatureBoolValue(featureKey: FeaturesNames.feat1)
        ldCliet?.checkFeatureStrValue(featureKey: FeaturesNames.feat2, defaultValue: btnFeatureOne.titleLabel?.text ?? "")
       
        let arrayFeatures:[Feature] = [ft1,ft2]
        return arrayFeatures
    }
    
    @IBAction func buttonNext(_ sender: UIButton) {
        routeToControlerTwo()
    }
    
    
    @IBAction func buttonAction(_ sender: UIButton) {
        routeToControlerTwo()
    }
    
    func routeToControlerTwo(){
        guard let controllerTwo = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContainerTwoViewController") as? ContainerTwoViewController else{return}
        self.navigationController?.pushViewController(controllerTwo, animated: true)
    }
}

extension ContainerOneViewController: FeatureListener{
    func onFeatureCustomStateChanged(featureName: String, newStatus: String) {
        switch featureName {
        case FeaturesNames.feat2:
            lblFeatureOne.text = newStatus
        default:
            break
        }
    }
    
    
}
