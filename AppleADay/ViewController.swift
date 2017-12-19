//
//  ViewController.swift
//  AppleADay
//
//  Created by Alexander on 29/12/16.
//  Copyright (c) 2016 Zero to Hero. All rights reserved.
// kcal data is from here — http://1trenirovka.com/uprazhneniya/v-domashnih-usloviyah/skolko-kalorij-szhigaetsya-pri-fizicheskih-nagruzkah.html
// useful - https://www.raywenderlich.com/159019/healthkit-tutorial-swift-getting-started

import UIKit
import HealthKit

@available(iOS 10.0, *)
class ViewController: UIViewController, UITextFieldDelegate {
    //MARK: Properties
    
    let healthStore = HKHealthStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        getHealthKitPermission()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions

    @IBAction func setDefaultLabelText(_ sender: UIButton)
    {
        switch sender.currentTitle! {
        case "espresso":
            saveEspresso()
        case "water":
            saveWater()
        case "tea":
            saveTea()
        case "apple":
            saveApple()
        case "granat":
            saveGranat()
        case "multiVitaminMuscleTech":
            saveMultiVitaminMuscleTech()
        case "weiderProtein":
            saveWeiderProtein()

        case "hand-stand":
            saveHandStand()
        case "press":
            savePress()
        case "push-ups":
            savePushUps()
        case "rope-jumping":
            saveRopeJumping()
        case "sex":
            saveSex()
        case "sit-ups":
            saveSitUps()
        case "stairs-climbing":
            saveStairsClimbing()
        case "swimming":
            saveSwimming()

        default:
            savePill() //"Супрадин"
        }
        
        Alert(title: "Success",
              message: "The " + sender.currentTitle! + " was recorded in Apple Health",
              buttonText: "OK");
    }
    
    func getHealthKitPermission() {
        // State the health data type(s) we want to write from HealthKit.
        let healthDataToWrite = Set(arrayLiteral:
            
            HKCategoryType.categoryType(forIdentifier: .sexualActivity)!,

            HKObjectType.workoutType(),
            
            HKObjectType.quantityType(forIdentifier: .flightsClimbed)!,
            HKObjectType.quantityType(forIdentifier: .distanceSwimming)!,
            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,

            HKObjectType.quantityType(forIdentifier: .dietaryFatTotal)!,
            HKObjectType.quantityType(forIdentifier: .dietaryFatSaturated)!,
            HKObjectType.quantityType(forIdentifier: .dietaryFatPolyunsaturated)!,
            HKObjectType.quantityType(forIdentifier: .dietaryFatMonounsaturated)!,
            HKObjectType.quantityType(forIdentifier: .dietaryProtein)!,
            HKObjectType.quantityType(forIdentifier: .dietarySugar)!,
            HKObjectType.quantityType(forIdentifier: .dietaryFiber)!,

            HKObjectType.quantityType(forIdentifier: .dietaryEnergyConsumed)!,
            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKObjectType.quantityType(forIdentifier: .dietarySodium)!,
            HKObjectType.quantityType(forIdentifier: .dietaryPotassium)!,
            HKObjectType.quantityType(forIdentifier: .dietaryCarbohydrates)!,
            HKObjectType.quantityType(forIdentifier: .dietaryFatTotal)!,
            HKObjectType.quantityType(forIdentifier: .dietaryWater)!,
            
            HKObjectType.quantityType(forIdentifier: .dietaryCaffeine)!,
            HKObjectType.quantityType(forIdentifier: .dietaryPhosphorus)!,
            HKObjectType.quantityType(forIdentifier: .dietaryVitaminA)!,
            HKObjectType.quantityType(forIdentifier: .dietaryVitaminB6)!,
            HKObjectType.quantityType(forIdentifier: .dietaryVitaminD)!,
            HKObjectType.quantityType(forIdentifier: .dietaryVitaminE)!,
            HKObjectType.quantityType(forIdentifier: .dietaryVitaminK)!,
            HKObjectType.quantityType(forIdentifier: .dietaryThiamin)!, //b1
            HKObjectType.quantityType(forIdentifier: .dietaryRiboflavin)!, //b2
            HKObjectType.quantityType(forIdentifier: .dietaryNiacin)!,
            HKObjectType.quantityType(forIdentifier: .dietaryPantothenicAcid)!,
            HKObjectType.quantityType(forIdentifier: .dietaryFolate)!,
            HKObjectType.quantityType(forIdentifier: .dietaryVitaminB12)!,
            HKObjectType.quantityType(forIdentifier: .dietaryBiotin)!,
            HKObjectType.quantityType(forIdentifier: .dietaryVitaminC)!,
            HKObjectType.quantityType(forIdentifier: .dietaryCalcium)!,
            HKObjectType.quantityType(forIdentifier: .dietaryMagnesium)!,
            HKObjectType.quantityType(forIdentifier: .dietaryIron)!,
            HKObjectType.quantityType(forIdentifier: .dietaryCopper)!,
            HKObjectType.quantityType(forIdentifier: .dietaryIodine)!,
            HKObjectType.quantityType(forIdentifier: .dietaryZinc)!,
            HKObjectType.quantityType(forIdentifier: .dietaryManganese)!,
            HKObjectType.quantityType(forIdentifier: .dietarySelenium)!,
            HKObjectType.quantityType(forIdentifier: .dietaryMolybdenum)!
        )
        
        // Just in case OneHourWalker makes its way to an iPad...
        if !HKHealthStore.isHealthDataAvailable() {
            print("Can't access HealthKit.")
        }
        
        // Request authorization to read and/or write the specific data.
        healthStore.requestAuthorization(toShare: healthDataToWrite, read: nil) { (success, error) -> Void in
            //print(success);
        }
    }
    
    func Alert(title:String,message:String,buttonText:String) -> Void {
        let alertController = UIAlertController(
            title:title,
            message:message,
            preferredStyle: UIAlertControllerStyle.alert
        )
        alertController.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func saveEspresso() -> Void {
        var samplesList =  [HKQuantityTypeIdentifier: Array<Any>]()
        samplesList[HKQuantityTypeIdentifier.dietaryEnergyConsumed] = [3.0, "kcal"]
        samplesList[HKQuantityTypeIdentifier.dietaryCarbohydrates] = [0.5, "g"]
        samplesList[HKQuantityTypeIdentifier.dietaryPotassium] = [34.5, "mg"]
        samplesList[HKQuantityTypeIdentifier.dietaryMagnesium] = [24.0, "mg"]
        samplesList[HKQuantityTypeIdentifier.dietaryFatTotal] = [0.1, "g"]
        samplesList[HKQuantityTypeIdentifier.dietaryCaffeine] = [63.6, "mg"]
        samplesList[HKQuantityTypeIdentifier.dietarySodium] = [4.2, "mg"]
        samplesList[HKQuantityTypeIdentifier.dietaryWater] = [30.0, "mL"]
        
        saveFoodSample(samplesList, 60, "Espresso")
    }
    
    func saveWater() -> Void {
        var samplesList =  [HKQuantityTypeIdentifier: Array<Any>]()
        samplesList[HKQuantityTypeIdentifier.dietaryWater] = [200.0, "mL"]
        saveFoodSample(samplesList, 60, "200 ml of water")
    }
    
    func saveTea() -> Void {
        var samplesList =  [HKQuantityTypeIdentifier: Array<Any>]()
        samplesList[HKQuantityTypeIdentifier.dietaryWater] = [340.0, " mL"]
        samplesList[HKQuantityTypeIdentifier.dietaryEnergyConsumed] = [3.4, "kcal"]
        samplesList[HKQuantityTypeIdentifier.dietarySodium] = [3.4 * 4, "mg"]
        samplesList[HKQuantityTypeIdentifier.dietaryPotassium] = [3.4 * 18.0, "mg"]
        samplesList[HKQuantityTypeIdentifier.dietaryCarbohydrates] = [3.4 * 0.2, "g"]
        samplesList[HKQuantityTypeIdentifier.dietaryProtein] = [3.4 * 0.1, "g"]
        samplesList[HKQuantityTypeIdentifier.dietaryCaffeine] = [3.4 * 11, "mg"]
        
        saveFoodSample(samplesList, 60, "Tea")
    }
    
    func saveApple() -> Void {
        var samplesList =  [HKQuantityTypeIdentifier: Array<Any>]()
        samplesList[HKQuantityTypeIdentifier.dietaryEnergyConsumed] = [47.0, "kcal"]
        samplesList[HKQuantityTypeIdentifier.dietaryFatTotal] = [0.3, "g"]
        samplesList[HKQuantityTypeIdentifier.dietaryFatSaturated] = [0.1, "g"]
        samplesList[HKQuantityTypeIdentifier.dietaryFatPolyunsaturated] = [0.1, "g"]
        samplesList[HKQuantityTypeIdentifier.dietaryCarbohydrates] = [25.0, "g"]
        samplesList[HKQuantityTypeIdentifier.dietaryFiber] = [4.4, "g"]
        samplesList[HKQuantityTypeIdentifier.dietarySugar] = [19.0, "g"]
        samplesList[HKQuantityTypeIdentifier.dietaryProtein] = [0.5, "g"]
        samplesList[HKQuantityTypeIdentifier.dietarySodium] = [1.8, "mg"] //Na
        samplesList[HKQuantityTypeIdentifier.dietaryPotassium] = [194.7, "mg"] //K
        samplesList[HKQuantityTypeIdentifier.dietaryMagnesium] = [9.1, "mg"] //Mg
        samplesList[HKQuantityTypeIdentifier.dietaryCalcium] = [10.9, "mg"] //Ca
        samplesList[HKQuantityTypeIdentifier.dietaryIron] = [0.2, "mg"] //Fe
        samplesList[HKQuantityTypeIdentifier.dietaryVitaminB6] = [0.1, "mg"] //B6
        samplesList[HKQuantityTypeIdentifier.dietaryVitaminC] = [8.4, "mg"]
        samplesList[HKQuantityTypeIdentifier.dietaryWater] = [156.0, "mL"]
        
        saveFoodSample(samplesList, 60, "Apple")
    }
    
    /* 100 ml of granat joice */
    func saveGranat() -> Void {
        var samplesList =  [HKQuantityTypeIdentifier: Array<Any>]()
        samplesList[HKQuantityTypeIdentifier.dietaryEnergyConsumed] = [56.0, "kcal"]
        samplesList[HKQuantityTypeIdentifier.dietaryFatTotal] = [1.2, "g"]
        samplesList[HKQuantityTypeIdentifier.dietaryFatSaturated] = [0.1, "g"]
        samplesList[HKQuantityTypeIdentifier.dietaryFatPolyunsaturated] = [0.1, "g"]
        samplesList[HKQuantityTypeIdentifier.dietaryFatMonounsaturated] = [0.1, "g"]
        samplesList[HKQuantityTypeIdentifier.dietaryFiber] = [4.0, "g"]
        samplesList[HKQuantityTypeIdentifier.dietarySugar] = [14.0, "g"]
        samplesList[HKQuantityTypeIdentifier.dietaryProtein] = [1.7, "g"]
        samplesList[HKQuantityTypeIdentifier.dietaryCarbohydrates] = [19.0, "g"]
        samplesList[HKQuantityTypeIdentifier.dietarySodium] = [4.0, "mg"] //Na
        samplesList[HKQuantityTypeIdentifier.dietaryPotassium] = [102.0, "mg"] //K
        samplesList[HKQuantityTypeIdentifier.dietaryMagnesium] = [5.0, "mg"] //Mg
        samplesList[HKQuantityTypeIdentifier.dietaryCalcium] = [12.0, "mg"] //Ca
        samplesList[HKQuantityTypeIdentifier.dietaryPhosphorus] = [8.0, "mg"] //P
        samplesList[HKQuantityTypeIdentifier.dietaryIron] = [1.0, "mg"] //Fe
        samplesList[HKQuantityTypeIdentifier.dietaryThiamin] = [0.04, "mg"] //B1
        samplesList[HKQuantityTypeIdentifier.dietaryRiboflavin] = [0.1, "mg"] //B2
        samplesList[HKQuantityTypeIdentifier.dietaryVitaminB6] = [0.4, "mg"] //B6
        samplesList[HKQuantityTypeIdentifier.dietaryVitaminB12] = [0.31, "mg"] //B12
        samplesList[HKQuantityTypeIdentifier.dietaryVitaminC] = [4.0, "mg"]
        samplesList[HKQuantityTypeIdentifier.dietaryNiacin] = [1.5, "mg"]
        samplesList[HKQuantityTypeIdentifier.dietaryWater] = [100.0, "mL"]
        
        saveFoodSample(samplesList, 60, "Granat juice")
        
    }
    
    /* 100 ml of granat joice */
    func saveMultiVitaminMuscleTech() -> Void {
        var samplesList =  [HKQuantityTypeIdentifier: Array<Any>]()
        samplesList[HKQuantityTypeIdentifier.dietaryVitaminA] = [6.0, "mg"]
        samplesList[HKQuantityTypeIdentifier.dietaryVitaminC] = [135.0, "mg"]
        samplesList[HKQuantityTypeIdentifier.dietaryVitaminD] = [10.0, "mcg"]
        samplesList[HKQuantityTypeIdentifier.dietaryVitaminE] = [81.0, "mg"]
        samplesList[HKQuantityTypeIdentifier.dietaryThiamin] = [20.0, "mg"]
        samplesList[HKQuantityTypeIdentifier.dietaryRiboflavin] = [13.5, "mg"]
        samplesList[HKQuantityTypeIdentifier.dietaryNiacin] = [60.0, "mg"]
        samplesList[HKQuantityTypeIdentifier.dietaryVitaminB6] = [10.0, "mg"]
        samplesList[HKQuantityTypeIdentifier.dietaryFolate] = [300.0, "mcg"] //folic acid
        samplesList[HKQuantityTypeIdentifier.dietaryVitaminB12] = [100.0, "mcg"]
        samplesList[HKQuantityTypeIdentifier.dietaryBiotin] = [165.0, "mcg"]
        samplesList[HKQuantityTypeIdentifier.dietaryPantothenicAcid] = [80.0, "mg"]
        samplesList[HKQuantityTypeIdentifier.dietaryCalcium] = [152.0, "mg"] //Ca
        samplesList[HKQuantityTypeIdentifier.dietaryMagnesium] = [145.0, "mg"] //Mg
        samplesList[HKQuantityTypeIdentifier.dietaryZinc] = [9.5, "mg"]
        samplesList[HKQuantityTypeIdentifier.dietaryCopper] = [1.0, "mg"]
        samplesList[HKQuantityTypeIdentifier.dietaryManganese] = [7.0, "mg"]
        samplesList[HKQuantityTypeIdentifier.dietaryMolybdenum] = [10.0, "mcg"]
        samplesList[HKQuantityTypeIdentifier.dietaryPotassium] = [35.0, "mg"]
        
        saveFoodSample(samplesList, 60, "Mutli-vitamins")
    }


    
    func saveWeiderProtein() -> Void {
        var samplesList =  [HKQuantityTypeIdentifier: Array<Any>]()
        samplesList[HKQuantityTypeIdentifier.dietaryEnergyConsumed] = [110.0, "kcal"]
        samplesList[HKQuantityTypeIdentifier.dietaryFatTotal] = [0.5, "g"]
        samplesList[HKQuantityTypeIdentifier.dietaryFatSaturated] = [0.3, "g"]
        samplesList[HKQuantityTypeIdentifier.dietaryCarbohydrates] = [2.3, "g"]
        samplesList[HKQuantityTypeIdentifier.dietarySugar] = [2.0, "g"]
        samplesList[HKQuantityTypeIdentifier.dietaryProtein] = [24.0, "g"]
        samplesList[HKQuantityTypeIdentifier.dietaryVitaminB6] = [0.6, "mg"]
        samplesList[HKQuantityTypeIdentifier.dietaryCalcium] = [400.0, "mg"]
        
        saveFoodSample(samplesList, 60, "Weider protein")

    }
    

    func savePill() -> Void {
        var samplesList =  [HKQuantityTypeIdentifier: Array<Any>]()
        samplesList[HKQuantityTypeIdentifier.dietaryVitaminA] = [800.0, "mcg"]
        samplesList[HKQuantityTypeIdentifier.dietaryVitaminD] = [5.0, "mcg"]
        samplesList[HKQuantityTypeIdentifier.dietaryVitaminE] = [12.0, "mg"]
        samplesList[HKQuantityTypeIdentifier.dietaryVitaminK] = [25.0, "mcg"]
        samplesList[HKQuantityTypeIdentifier.dietaryThiamin] = [3.3, "mg"] //b1
        samplesList[HKQuantityTypeIdentifier.dietaryRiboflavin] = [4.2, "mg"] //b2
        samplesList[HKQuantityTypeIdentifier.dietaryNiacin] = [48.0, "mg"]
        samplesList[HKQuantityTypeIdentifier.dietaryPantothenicAcid] = [18.0, "mg"]
        samplesList[HKQuantityTypeIdentifier.dietaryVitaminB6] = [2.0, "mg"]
        samplesList[HKQuantityTypeIdentifier.dietaryFolate] = [200.0, "mcg"]
        samplesList[HKQuantityTypeIdentifier.dietaryVitaminB12] = [3.0, "mcg"]
        samplesList[HKQuantityTypeIdentifier.dietaryBiotin] = [50.0, "mcg"]
        samplesList[HKQuantityTypeIdentifier.dietaryVitaminC] = [180.0, "mg"]
        samplesList[HKQuantityTypeIdentifier.dietaryCalcium] = [120.0, "mg"]
        samplesList[HKQuantityTypeIdentifier.dietaryMagnesium] = [80.0, "mg"]
        samplesList[HKQuantityTypeIdentifier.dietaryIron] = [14.0, "mg"]
        samplesList[HKQuantityTypeIdentifier.dietaryCopper] = [1.0, "mg"]
        samplesList[HKQuantityTypeIdentifier.dietaryIodine] = [150.0, "mcg"]
        samplesList[HKQuantityTypeIdentifier.dietaryZinc] = [10.0, "mg"]
        samplesList[HKQuantityTypeIdentifier.dietaryManganese] = [2.0, "mg"]
        samplesList[HKQuantityTypeIdentifier.dietarySelenium] = [50.0, "mcg"]
        samplesList[HKQuantityTypeIdentifier.dietaryMolybdenum] = [50.0, "mcg"]
        
        saveFoodSample(samplesList, 60, "Supradin pill")
        
    }
    
    
    func saveHandStand() -> Void {
        let duration = 30 //seconds
        let energyBurned = HKQuantity(unit: HKUnit.kilocalorie(), doubleValue: 10.0) //10 pushups, approx.
        let endTime = NSDate()
        let startTime = endTime.addingTimeInterval(TimeInterval(-duration)) as Date
        let metadata: [String: Bool] = [HKMetadataKeyIndoorWorkout: true]
        let workout = HKWorkout(
            activityType: HKWorkoutActivityType.gymnastics,
            start: startTime,
            end: endTime as Date,
            duration: TimeInterval(duration),
            totalEnergyBurned: energyBurned,
            totalDistance: nil,
            metadata: metadata
        )
        
        healthStore.save(workout) { (success, error) in
            if( error != nil ) {
                print(error ?? "error!")
                return;
            }
            
            var samples: [HKQuantitySample] = []
            
            let energyBurnedType = HKObjectType.quantityType(
                forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned
            )
            let energyBurnedPerIntervalSample = HKQuantitySample(
                type: energyBurnedType!,
                quantity: energyBurned,
                start: startTime,
                end: endTime as Date
            )
            samples.append(energyBurnedPerIntervalSample)
            
            self.healthStore.add(
                samples,
                to: workout) { (success, error) -> Void in
                    if( error != nil ) {
                        print(error ?? "error!")
                        return;
                    }
            }
        }
    }

    func savePress() -> Void {
        let duration = 30 //seconds
        let energyBurned = HKQuantity(unit: HKUnit.kilocalorie(), doubleValue: 0.5 * 10.0) //10 presses = 0.5 minute = 0.5 * 10 kcal/minute
        let endTime = NSDate()
        let startTime = endTime.addingTimeInterval(TimeInterval(-duration)) as Date
        let metadata: [String: Bool] = [HKMetadataKeyIndoorWorkout: true]
        let workout = HKWorkout(
            activityType: HKWorkoutActivityType.coreTraining,
            start: startTime,
            end: endTime as Date,
            duration: TimeInterval(duration),
            totalEnergyBurned: energyBurned,
            totalDistance: nil,
            metadata: metadata
        )
        
        healthStore.save(workout) { (success, error) in
            if( error != nil ) {
                print(error ?? "error!")
                return;
            }
            
            var samples: [HKQuantitySample] = []
            
            let energyBurnedType = HKObjectType.quantityType(
                forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned
            )
            let energyBurnedPerIntervalSample = HKQuantitySample(
                type: energyBurnedType!,
                quantity: energyBurned,
                start: startTime,
                end: endTime as Date
            )
            samples.append(energyBurnedPerIntervalSample)
            
            self.healthStore.add(
                samples,
                to: workout) { (success, error) -> Void in
                    if( error != nil ) {
                        print(error ?? "error!")
                        return;
                    }
            }
        }
    }
    
    func savePushUps() -> Void {
        let duration = 30 //seconds
        let energyBurned = HKQuantity(unit: HKUnit.kilocalorie(), doubleValue: 0.5 * 17.0) //10 pushups = 0.5 mins * 17 kcal/minute
        let endTime = NSDate()
        let startTime = endTime.addingTimeInterval(TimeInterval(-duration)) as Date
        let metadata: [String: Bool] = [HKMetadataKeyIndoorWorkout: true]
        let workout = HKWorkout(
            activityType: HKWorkoutActivityType.coreTraining,
            start: startTime,
            end: endTime as Date,
            duration: TimeInterval(duration),
            totalEnergyBurned: energyBurned,
            totalDistance: nil,
            metadata: metadata
        )
        
        healthStore.save(workout) { (success, error) in
            if( error != nil ) {
                print(error ?? "error!")
                return;
            }
            
            var samples: [HKQuantitySample] = []
            
            let energyBurnedType = HKObjectType.quantityType(
                forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned
            )
            let energyBurnedPerIntervalSample = HKQuantitySample(
                type: energyBurnedType!,
                quantity: energyBurned,
                start: startTime,
                end: endTime as Date
            )
            samples.append(energyBurnedPerIntervalSample)
            
            self.healthStore.add(
                samples,
                to: workout) { (success, error) -> Void in
                    if( error != nil ) {
                        print(error ?? "error!")
                        return;
                    }
            }
        }
    }
    
    func saveRopeJumping() -> Void {
        let energyBurned = HKQuantity(unit: HKUnit.kilocalorie(), doubleValue: 0.85) //100 jumps
        let endTime = NSDate()
        let startTime = endTime.addingTimeInterval(-90) as Date
        let metadata: [String: Bool] = [
            HKMetadataKeyIndoorWorkout: true
        ]
        
        let workout = HKWorkout(
            activityType: HKWorkoutActivityType.jumpRope,
            start: startTime,
            end: endTime as Date,
            duration: 90,
            totalEnergyBurned: energyBurned,
            totalDistance: nil,
            metadata: metadata
        )
        
        healthStore.save(workout) { (success, error) in
            if( error != nil ) {
                print(error ?? "error!")
                return;
            }
            
            var samples: [HKQuantitySample] = []
            
            let energyBurnedType = HKObjectType.quantityType(
                forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned
            )
            let energyBurnedPerIntervalSample = HKQuantitySample(
                type: energyBurnedType!,
                quantity: energyBurned,
                start: startTime,
                end: endTime as Date
            )
            samples.append(energyBurnedPerIntervalSample)
            
            self.healthStore.add(
                samples,
                to: workout) { (success, error) -> Void in
                    if( error != nil ) {
                        print(error ?? "error!")
                        return;
                    }
            }
        }
    }
    
    func saveSex() -> Void {
        let duration = 600 //seconds
        let sexualActivity = HKCategoryType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sexualActivity)
        let metadata: [String: String]? = [HKMetadataKeySexualActivityProtectionUsed: "NO"]

        let endTime = NSDate()
        
        let sexSample = HKCategorySample(
            type: sexualActivity!,
            value: HKCategoryValue.notApplicable.rawValue,
            start: endTime.addingTimeInterval(TimeInterval(-duration)) as Date,
            end: endTime as Date,
            metadata: metadata
        )

        healthStore.save(sexSample, withCompletion: { (success, error) -> Void in
            if( error != nil ) {
                print(error ?? "error!")
            }
        })

        var samplesList =  [HKQuantityTypeIdentifier: Array<Any>]()
        samplesList[HKQuantityTypeIdentifier.activeEnergyBurned] = [42.0, "kcal"]
        saveFoodSample(samplesList, duration, "Sex")

    }
    
    func saveSitUps() -> Void {
        let duration = 30 //seconds
        let energyBurned = HKQuantity(unit: HKUnit.kilocalorie(), doubleValue: 10 * 0.5) //10 sit-ups
        let endTime = NSDate()
        let startTime = endTime.addingTimeInterval(TimeInterval(-duration)) as Date
        let metadata: [String: Bool] = [HKMetadataKeyIndoorWorkout: true]
        let workout = HKWorkout(
            activityType: HKWorkoutActivityType.functionalStrengthTraining,
            start: startTime,
            end: endTime as Date,
            duration: TimeInterval(duration),
            totalEnergyBurned: energyBurned,
            totalDistance: nil,
            metadata: metadata
        )
        
        healthStore.save(workout) { (success, error) in
            if( error != nil ) {
                print(error ?? "error!")
                return;
            }
            
            var samples: [HKQuantitySample] = []
            
            let energyBurnedType = HKObjectType.quantityType(
                forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned
            )
            let energyBurnedPerIntervalSample = HKQuantitySample(
                type: energyBurnedType!,
                quantity: energyBurned,
                start: startTime,
                end: endTime as Date
            )
            samples.append(energyBurnedPerIntervalSample)
            
            self.healthStore.add(
                samples,
                to: workout) { (success, error) -> Void in
                    if( error != nil ) {
                        print(error ?? "error!")
                        return;
                    }
            }
        }
    }
    

    func saveStairsClimbing() -> Void {
        let energyBurned = HKQuantity(unit: HKUnit.kilocalorie(), doubleValue: 0.883)
        let distance = HKQuantity(unit: HKUnit.meter(), doubleValue: 7.0)
        let endTime = NSDate()
        let startTime = endTime.addingTimeInterval(-30) as Date
        var metadata: [String: Any] = [HKMetadataKeyIndoorWorkout: true]

        if #available(iOS 11.2, *) {
            let elevation = HKQuantity(unit: HKUnit.meter(), doubleValue: 3.0)
            metadata[HKMetadataKeyElevationAscended] = elevation
        }
        let workout = HKWorkout(
            activityType: HKWorkoutActivityType.stairs,
            start: startTime,
            end: endTime as Date,
            duration: 30,
            totalEnergyBurned: energyBurned,
            totalDistance: distance,
            metadata: metadata
        )
        
        healthStore.save(workout) { (success, error) in
            if( error != nil ) {
                print(error ?? "error!")
                return;
            }
            
            var samples: [HKQuantitySample] = []
            
            let distanceType = HKObjectType.quantityType(
                forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning
            )
            let distancePerIntervalSample = HKQuantitySample(
                type: distanceType!,
                quantity: distance,
                start: startTime,
                end: endTime as Date
            )
            samples.append(distancePerIntervalSample)
            
            let energyBurnedType = HKObjectType.quantityType(
                forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned
            )
            let energyBurnedPerIntervalSample = HKQuantitySample(
                type: energyBurnedType!,
                quantity: energyBurned,
                start: startTime,
                end: endTime as Date
            )
            samples.append(energyBurnedPerIntervalSample)
            
            let flightsType = HKObjectType.quantityType(
                forIdentifier: HKQuantityTypeIdentifier.flightsClimbed
            )
            let oneFloorUp = HKQuantitySample(
                type: flightsType!,
                quantity: HKQuantity(unit: HKUnit.count(), doubleValue: 1.0),
                start: startTime,
                end: endTime as Date
            )
            samples.append(oneFloorUp)
            
            self.healthStore.add(
                samples,
                to: workout) { (success, error) -> Void in
                    if( error != nil ) {
                        print(error ?? "error!")
                        return;
                    }
            }
        }
    }
    
    @available(iOS 10.0, *)
    func saveSwimming() -> Void {
        let energyBurned = HKQuantity(unit: HKUnit.kilocalorie(), doubleValue: 80.0) //I spend 8-10 min for 250 metres approx.
        let distance = HKQuantity(unit: HKUnit.meter(), doubleValue: 250.0)
        let endTime = NSDate()
        let startTime = endTime.addingTimeInterval(-600) as Date
        
        let metadata: [String: Bool] = [
            HKMetadataKeyIndoorWorkout: true,
            HKMetadataKeyCoachedWorkout: false
        ]
        
        let workout = HKWorkout(
            activityType: HKWorkoutActivityType.swimming,
            start: startTime,
            end: endTime as Date,
            duration: 600,
            totalEnergyBurned: energyBurned,
            totalDistance: distance,
            metadata: metadata
        )
        
        let healthStore = HKHealthStore()
        
        healthStore.save(workout) { (success, error) in
            if( error != nil ) {
                print(error ?? "error!")
                return;
            }
            
            // Add optional, detailed information for each time interval
            var samples: [HKQuantitySample] = []
            
            let distanceType = HKObjectType.quantityType(
                forIdentifier: HKQuantityTypeIdentifier.distanceSwimming
            )
            
            let distancePerIntervalSample = HKQuantitySample(
                type: distanceType!,
                quantity: distance,
                start: startTime,
                end: endTime as Date
            )
            
            samples.append(distancePerIntervalSample)
            
            let energyBurnedType = HKObjectType.quantityType(
                forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned
            )
            
            let energyBurnedPerIntervalSample = HKQuantitySample(
                type: energyBurnedType!,
                quantity: energyBurned,
                start: startTime,
                end: endTime as Date
            )
            
            samples.append(energyBurnedPerIntervalSample)
            
            healthStore.add(
                samples,
                to: workout) { (success, error) -> Void in
                    if( error != nil ) {
                        print(error ?? "error!")
                        return;
                    }
            }
            
        }
    }

  
    func buildSamplesList(_ list: [HKQuantityTypeIdentifier: Array<Any>], _ title: String, _ start: NSDate, _ end: NSDate) -> [HKSample] {
        var samplesArray = [HKSample]()
        for (identifier, item) in list {
            guard let quantityType = HKObjectType.quantityType(forIdentifier: identifier) else {
                continue
            }
            let unit = HKUnit(from: item[1] as! String)
            let quantity = HKQuantity(unit: unit, doubleValue: item[0] as! Double)
            
            let metadata: [String: String]? = ["Title": title]
            
            let sample = HKQuantitySample(
                type: quantityType,
                quantity: quantity,
                start: start as Date,
                end: end as Date,
                metadata: metadata
            )
            
            samplesArray.append(sample);
        }
        return samplesArray
    }
    
    func saveFoodSample(_ samplesList: [HKQuantityTypeIdentifier: Array<Any>], _ durationInSeconds: Int, _ title: String) {
        let endTime = NSDate()
        let startTime = endTime.addingTimeInterval(TimeInterval(-durationInSeconds))
        
        let samples = buildSamplesList(samplesList, title, startTime, endTime)
        
        let foodType: HKCorrelationType = HKObjectType.correlationType(forIdentifier: .food)!
        let foodMetadata: [String: String]? = [HKMetadataKeyFoodType: title]
        
        let foodCorrelation : HKCorrelation = HKCorrelation(
            type: foodType,
            start: startTime as Date,
            end: endTime as Date,
            objects: NSSet(array: samples) as! Set<HKSample>,
            metadata: foodMetadata
        )
        
        healthStore.save(foodCorrelation, withCompletion: { (success, error) -> Void in
            if( error != nil ) {
                print(error ?? "error!")
            }
        })
    }
    
    func processData(_ list: [HKQuantityTypeIdentifier: Array<Any>], _ title: String) {
        let samplesArray = buildSamplesList(list, title, NSDate(), NSDate())
        
        for sample in samplesArray {
            healthStore.save(sample, withCompletion: { (success, error) -> Void in
                if( error != nil ) {
                    print(error ?? "error!")
                }
            })
        }
    }
}

