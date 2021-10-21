//
//  ContainerTwoViewController.swift
//  AppClient
//
//  Created by Jhonatahan Orlando Rivera Vilcapoma on 25/06/21.
//

import UIKit
import sdk_ios_feature_handling

class ContainerTwoViewController: UIViewController {
    
    @IBOutlet weak var viewFeatureOne: UIView!
    @IBOutlet weak var btnFeatureTwo: UIButton!
    
    private let ldCliet = Utils.getAppDelegate().ldCliet

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    deinit {
        print("REMOVE CONTAINER TWO")
    }
    
    func setupView(){
        registerFeatures()
    }
    
    @IBAction func buttonActionTwo(_ sender: UIButton) {
        routeToControlerThree()
    }
    
    @IBAction func routeToPrevius(){
        removeFeaturesReferences()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func routeToNext(){
        routeToControlerThree()
    }
    
    
    
    func routeToControlerThree(){
        guard let controllerTwo = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContainerThreeViewController") as? ContainerThreeViewController else{return}
        self.navigationController?.pushViewController(controllerTwo, animated: true)
    }
}

extension ContainerTwoViewController{
    func registerFeatures(){
        let arrayFeatures = getFeatures()
        do {
            try FeatureManager.sharedInstance.registerContainer(featureComponent: self, features: arrayFeatures)
        }catch{
            print(error)
        }
    }
    
    func getFeatures()->[Feature]{
        let ft3 = Feature(name:FeaturesNames.feat3,featureView:btnFeatureTwo)
        let ft4 = Feature(name:FeaturesNames.feat4,featureView:viewFeatureOne)
        ldCliet?.checkFeatureBoolValue(featureKey: FeaturesNames.feat3)
        ldCliet?.checkFeatureStrValue(featureKey: FeaturesNames.feat4, defaultValue: "enable")
        
        let arrayFeatures:[Feature] = [ft3,ft4]
        return arrayFeatures
    }
    
    func removeFeaturesReferences(){
        FeatureManager.sharedInstance.disposeComponent(featureContainer: self)
    }
}


extension ContainerTwoViewController: FeatureListener{
    func onFeatureCustomStateChanged(featureName: String, newStatus: String) {
        //Impplement Custom feature state change
    }
    
    
}
