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
        let endTime = NSDate()
        let duration = 60 //seconds
        let startTime = endTime.addingTimeInterval(TimeInterval(-duration)) as Date
        
        let quantityType = HKObjectType.quantityType(
            forIdentifier: HKQuantityTypeIdentifier.dietaryCaffeine
        )
        let unit = HKUnit(from: "mg")
        let quantity = HKQuantity(unit: unit, doubleValue: 63.6)
        
        let metadata: [String: String]? = ["Title": "Espresso"]
        
        let coffeineSample = HKQuantitySample(
            type: quantityType!,
            quantity: quantity,
            start: startTime,
            end: endTime as Date,
            metadata: metadata
        )
        
        let waterType = HKObjectType.quantityType(
            forIdentifier: HKQuantityTypeIdentifier.dietaryWater
        )
        let waterUnit = HKUnit(from: "mL")
        let waterQuantity = HKQuantity(unit: waterUnit, doubleValue: 30.0)
        
        let waterSample = HKQuantitySample(
            type: waterType!,
            quantity: waterQuantity,
            start: startTime,
            end: endTime as Date,
            metadata: metadata
        )
        
        let objects : NSSet = NSSet(objects: coffeineSample, waterSample)
        
        let foodType: HKCorrelationType = HKObjectType.correlationType(forIdentifier: .food)!
        let foodMetadata: [String: String]? = [HKMetadataKeyFoodType: "Cup of espresso"]

        let foodCorrelation : HKCorrelation = HKCorrelation(
            type: foodType,
            start: startTime,
            end: endTime as Date,
            objects: objects as! Set<HKSample>,
            metadata: foodMetadata
        )
        
        healthStore.save(foodCorrelation, withCompletion: { (success, error) -> Void in
            if( error != nil ) {
                print(error ?? "error!")
            }
        })

        //let food = HKCategoryType.correlationType(forIdentifier: .food)
        
        

/*
        let foodSample = HKCorrelationType(
            type: food!,
            start: endTime.addingTimeInterval(-600) as Date,
            end: endTime as Date,
            metadata: metadata
        )

        healthStore.save(foodSample) { (success, error) in
            if( error != nil ) {
                print(error ?? "error!")
                return;
            }
            
            var samples: [HKQuantitySample] = []
            
        }

        let sexSample = HKCategorySample(
            type: sexualActivity!,
            value: HKCategoryValue.notApplicable.rawValue,
            start: endTime.addingTimeInterval(-600) as Date,
            end: endTime as Date,
            metadata: metadata
        )
        
        healthStore.save(food, withCompletion: { (success, error) -> Void in
            if( error != nil ) {
                print(error ?? "error!")
            }
        })

        let list = [
            [HKQuantityTypeIdentifier.dietaryFatTotal, 0.1, "g"],
            [HKQuantityTypeIdentifier.dietarySodium, 4.2, "mg"],
            [HKQuantityTypeIdentifier.dietaryPotassium, 34.5, "mg"],
            [HKQuantityTypeIdentifier.dietaryCarbohydrates, 0.5, "g"],
            [HKQuantityTypeIdentifier.dietaryCaffeine, 63.6, "mg"],
            [HKQuantityTypeIdentifier.dietaryMagnesium, 24.0, "mg"],
            [HKQuantityTypeIdentifier.dietaryWater, 30.0, "mL"]
        ]
        processData(list, "espresso")
        */
    }
    
    func saveWater() -> Void {
        let list = [
            [HKQuantityTypeIdentifier.dietaryWater, 200.0, "mL"]
        ]
        processData(list, "200 ml glass of water")
    }
    
    func saveTea() -> Void {
        let list = [
            [HKQuantityTypeIdentifier.dietaryWater, 340.0, "mL"],
            [HKQuantityTypeIdentifier.dietaryEnergyConsumed, 3.4, "kcal"],
            [HKQuantityTypeIdentifier.dietarySodium, 3.4 * 4.0, "mg"],
            [HKQuantityTypeIdentifier.dietaryPotassium, 3.4 * 18.0, "mg"],
            [HKQuantityTypeIdentifier.dietaryCarbohydrates, 3.4 * 0.2, "g"],
            [HKQuantityTypeIdentifier.dietaryProtein, 3.4 * 0.1, "g"],
            [HKQuantityTypeIdentifier.dietaryCaffeine, 3.4 * 11.0, "mg"]
        ]
        processData(list, "Mug of tea")
    }
    
    func saveApple() -> Void {
        let list = [
            [HKQuantityTypeIdentifier.dietaryEnergyConsumed, 47.0, "kcal"],
            [HKQuantityTypeIdentifier.dietaryFatTotal, 0.3, "g"],
            [HKQuantityTypeIdentifier.dietaryFatSaturated, 0.1, "g"],
            [HKQuantityTypeIdentifier.dietaryFatPolyunsaturated, 0.1, "g"],
            
            [HKQuantityTypeIdentifier.dietaryCarbohydrates, 25.0, "g"],
            [HKQuantityTypeIdentifier.dietaryFiber, 4.4, "g"],
            [HKQuantityTypeIdentifier.dietarySugar, 19.0, "g"],
            [HKQuantityTypeIdentifier.dietaryProtein, 0.5, "g"]
        ]
        
        let list2 = [
            
            [HKQuantityTypeIdentifier.dietarySodium, 1.8, "mg"], //Na
            [HKQuantityTypeIdentifier.dietaryPotassium, 194.7, "mg"], //K
            [HKQuantityTypeIdentifier.dietaryMagnesium, 9.1, "mg"], //Mg
            [HKQuantityTypeIdentifier.dietaryCalcium, 10.9, "mg"], //Ca
            [HKQuantityTypeIdentifier.dietaryIron, 0.2, "mg"], //Fe
            
            [HKQuantityTypeIdentifier.dietaryVitaminB6, 0.1, "mg"], //B6
            [HKQuantityTypeIdentifier.dietaryVitaminC, 8.4, "mg"],
            
            [HKQuantityTypeIdentifier.dietaryWater, 156.0, "mL"]        ]
        
        processData(list, "An apple")
        processData(list2, "An apple")

    }
    
    /* 100 ml of granat joice */
    func saveGranat() -> Void {
        let list = [
            [HKQuantityTypeIdentifier.dietaryEnergyConsumed, 56.0, "kcal"],
            [HKQuantityTypeIdentifier.dietaryFatTotal, 1.2, "g"],
            [HKQuantityTypeIdentifier.dietaryFatSaturated, 0.1, "g"],
            [HKQuantityTypeIdentifier.dietaryFatPolyunsaturated, 0.1, "g"],
            [HKQuantityTypeIdentifier.dietaryFatMonounsaturated, 0.1, "g"],
            
            [HKQuantityTypeIdentifier.dietaryFiber, 4.0, "g"],
            [HKQuantityTypeIdentifier.dietarySugar, 14.0, "g"],
            [HKQuantityTypeIdentifier.dietaryProtein, 1.7, "g"],
            [HKQuantityTypeIdentifier.dietaryCarbohydrates, 19.0, "g"]
        ]
        
        let list2 = [
            [HKQuantityTypeIdentifier.dietarySodium, 4.0, "mg"], //Na
            [HKQuantityTypeIdentifier.dietaryPotassium, 102.0, "mg"], //K
            [HKQuantityTypeIdentifier.dietaryMagnesium, 5.0, "mg"], //Mg
            [HKQuantityTypeIdentifier.dietaryCalcium, 12.0, "mg"], //Ca
            [HKQuantityTypeIdentifier.dietaryPhosphorus, 8.0, "mg"], //P
            [HKQuantityTypeIdentifier.dietaryIron, 1.0, "mg"], //Fe
            
            [HKQuantityTypeIdentifier.dietaryThiamin, 0.04, "mg"], //B1
            [HKQuantityTypeIdentifier.dietaryRiboflavin, 0.1, "mg"], //B2
            [HKQuantityTypeIdentifier.dietaryVitaminB6, 0.4, "mg"], //B6
            [HKQuantityTypeIdentifier.dietaryVitaminB12, 0.31, "mg"], //B12
            [HKQuantityTypeIdentifier.dietaryVitaminC, 4.0, "mg"],
            [HKQuantityTypeIdentifier.dietaryNiacin, 1.5, "mg"],
            
            [HKQuantityTypeIdentifier.dietaryWater, 100.0, "mL"]
            
        ]
        processData(list, "Granat")
        processData(list2, "Granat")
        
    }
    
    /* 100 ml of granat joice */
    func saveMultiVitaminMuscleTech() -> Void {
        let list = [
            [HKQuantityTypeIdentifier.dietaryVitaminA, 6.0, "mg"],
            [HKQuantityTypeIdentifier.dietaryVitaminC, 135.0, "mg"],
            [HKQuantityTypeIdentifier.dietaryVitaminD, 10.0, "mcg"],
            [HKQuantityTypeIdentifier.dietaryVitaminE, 81.0, "mg"],
            [HKQuantityTypeIdentifier.dietaryThiamin, 20.0, "mg"],
            [HKQuantityTypeIdentifier.dietaryRiboflavin, 13.5, "mg"],
            [HKQuantityTypeIdentifier.dietaryNiacin, 60.0, "mg"],
            [HKQuantityTypeIdentifier.dietaryVitaminB6, 10.0, "mg"],
            [HKQuantityTypeIdentifier.dietaryFolate, 300.0, "mcg"], //folic acid
            [HKQuantityTypeIdentifier.dietaryVitaminB12, 100.0, "mcg"],
            [HKQuantityTypeIdentifier.dietaryBiotin, 165.0, "mcg"],
            [HKQuantityTypeIdentifier.dietaryPantothenicAcid, 80.0, "mg"]
        ]
        let list2 = [
            [HKQuantityTypeIdentifier.dietaryCalcium, 152.0, "mg"], //Ca
            [HKQuantityTypeIdentifier.dietaryMagnesium, 145.0, "mg"], //Mg
            [HKQuantityTypeIdentifier.dietaryZinc, 9.5, "mg"],
            [HKQuantityTypeIdentifier.dietaryCopper, 1.0, "mg"],
            [HKQuantityTypeIdentifier.dietaryManganese, 7.0, "mg"],
            [HKQuantityTypeIdentifier.dietaryMolybdenum, 10.0, "mcg"],
            [HKQuantityTypeIdentifier.dietaryPotassium, 35.0, "mg"]
        ]
        processData(list, "Mutli-vitamins")
        processData(list2, "Mutli-vitamins")
    }


    
    func saveWeiderProtein() -> Void {
        let list = [
            [HKQuantityTypeIdentifier.dietaryEnergyConsumed, 110.0, "kcal"],
            [HKQuantityTypeIdentifier.dietaryFatTotal, 0.5, "g"],
            [HKQuantityTypeIdentifier.dietaryFatSaturated, 0.3, "g"],
            [HKQuantityTypeIdentifier.dietaryCarbohydrates, 2.3, "g"],
            [HKQuantityTypeIdentifier.dietarySugar, 2.0, "g"],
            [HKQuantityTypeIdentifier.dietaryProtein, 24.0, "g"],
            [HKQuantityTypeIdentifier.dietaryVitaminB6, 0.6, "mg"],
            [HKQuantityTypeIdentifier.dietaryCalcium, 400.0, "mg"]
        ]
        processData(list, "Weider protein")
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
        let sexualActivity = HKCategoryType.categoryType(forIdentifier: HKCategoryTypeIdentifier.sexualActivity)
        let metadata: [String: String]? = [HKMetadataKeySexualActivityProtectionUsed: "NO"]

        let endTime = NSDate()
        
        let sexSample = HKCategorySample(
            type: sexualActivity!,
            value: HKCategoryValue.notApplicable.rawValue,
            start: endTime.addingTimeInterval(-600) as Date,
            end: endTime as Date,
            metadata: metadata
        )

        healthStore.save(sexSample, withCompletion: { (success, error) -> Void in
            if( error != nil ) {
                print(error ?? "error!")
            }
        })

        let list = [
            [HKQuantityTypeIdentifier.activeEnergyBurned, 42.0, "kcal"], //252 kcal/hour
            ]
        processData(list, "Sex")
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


    func savePill() -> Void {
        let list = [
            [HKQuantityTypeIdentifier.dietaryVitaminA, 800.0, "mcg"],
            [HKQuantityTypeIdentifier.dietaryVitaminD, 5.0, "mcg"],
            [HKQuantityTypeIdentifier.dietaryVitaminE, 12.0, "mg"],
            [HKQuantityTypeIdentifier.dietaryVitaminK, 25.0, "mcg"],
            [HKQuantityTypeIdentifier.dietaryThiamin, 3.3, "mg"], //b1
            [HKQuantityTypeIdentifier.dietaryRiboflavin, 4.2, "mg"], //b2
            [HKQuantityTypeIdentifier.dietaryNiacin, 48.0, "mg"],
            [HKQuantityTypeIdentifier.dietaryPantothenicAcid, 18.0, "mg"],
            [HKQuantityTypeIdentifier.dietaryVitaminB6, 2.0, "mg"],
            [HKQuantityTypeIdentifier.dietaryFolate, 200.0, "mcg"]
        ]
        
        let list2 = [
            [HKQuantityTypeIdentifier.dietaryVitaminB12, 3.0, "mcg"],
            [HKQuantityTypeIdentifier.dietaryBiotin, 50.0, "mcg"],
            [HKQuantityTypeIdentifier.dietaryVitaminC, 180.0, "mg"],
            [HKQuantityTypeIdentifier.dietaryCalcium, 120.0, "mg"],
            [HKQuantityTypeIdentifier.dietaryMagnesium, 80.0, "mg"],
            [HKQuantityTypeIdentifier.dietaryIron, 14.0, "mg"],
            [HKQuantityTypeIdentifier.dietaryCopper, 1.0, "mg"],
            [HKQuantityTypeIdentifier.dietaryIodine, 150.0, "mcg"],
            [HKQuantityTypeIdentifier.dietaryZinc, 10.0, "mg"],
            [HKQuantityTypeIdentifier.dietaryManganese, 2.0, "mg"],
            [HKQuantityTypeIdentifier.dietarySelenium, 50.0, "mcg"],
            [HKQuantityTypeIdentifier.dietaryMolybdenum, 50.0, "mcg"]
        ]
        
        processData(list, "Supradin pill")
        processData(list2, "Supradin pill")
        
    }
    
    
    func processData(_ list: [[Any]], _ title: String) {
        for item in list {
            guard let quantityType = HKObjectType.quantityType(forIdentifier: item[0] as! HKQuantityTypeIdentifier) else {
                continue
            }
            let unit = HKUnit(from: item[2] as! String)
            let quantity = HKQuantity(unit: unit, doubleValue: item[1] as! Double)

            let metadata: [String: String]? = ["Title": title]

            let quantitySample = HKQuantitySample(
                type: quantityType,
                quantity: quantity,
                start: NSDate() as Date,
                end: NSDate() as Date,
                metadata: metadata
            )
            healthStore.save(quantitySample, withCompletion: { (success, error) -> Void in
                if( error != nil ) {
                    print(error ?? "error!")
                }
            })
        }
    }



}

