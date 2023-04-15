;;;:::::::::::::::::::::::::::::::
;                                ;
;         Problem file 2         ;
;      from 14:00 to 24:00       ;
;                                ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
(define (problem scheduling2) (:domain schedule)
(:init
 
;;;_____________________Problem file run for 24Hr (1 day)_________________;;;     
 
(at 13.9 (dayStart))       ;; Problem file 2 started from 14:00 to 24:00 of the day
(at 0.1 (not(dayStart)))
(= (HeavyLightLoads)3)
(at 24 (dayEnd))    
(= (Hours)13)       ;; In problem file 2, day is 10 hours so it ended at 24:00
(= (time-lapse)1)
 
 

;;;___________________________Operating Hours Schedule______________________;;;

;; working hours from 08:00 to 20:00
;; as this problem file starting from time 14:00
;; so working hours on problem file 2 is from 14:00 to 24:00

(Not_working-day)
(not(working-day))

(at 14.0 (working-day))
(at 14.0 (not(Not_working-day)))

(at 20.0 (Not_working-day))
(at 20.0 (not(working-day)))

 ;;;_____________________________Day Ahead Prices______________________________;;;

;; 2 Low, 1 Nominal, 0 High ;;

(= (Energy_Tariff)2)
;(at 13 (= (Energy_Tariff)2))
(at 14.0 (= (Energy_Tariff)2))
;(at 15 (= (Energy_Tariff)2))
;(at 16 (= (Energy_Tariff)1))
;(at 17 (= (Energy_Tariff)1))
;(at 18 (= (Energy_Tariff)0))
;(at 19 (= (Energy_Tariff)0))
(at 20 (= (Energy_Tariff)1))
;(at 21 (= (Energy_Tariff)1))
;(at 22 (= (Energy_Tariff)1))
(at 23 (= (Energy_Tariff)1))
;(at 24 (= (Energy_Tariff)1))

;;;_____________________________Occupancy Schedule_______________________________;;;

(not(Occupied)) 
(NotOccupied)

;(at 8.05 (Occupied)) 
;(at 9 (Occupied))
;(at 11 (not(Occupied)))
;(at 12 (Occupied))
;(at 13 (Occupied))
(at 14.0 (Occupied))
(at 18 (not(Occupied)))

;(at 8.05 (not(NotOccupied)))
;(at 9 (not(NotOccupied)))
;(at 11 (NotOccupied))
;(at 12 (not(NotOccupied)))
;(at 13 (not(NotOccupied)))
(at 14.0 (not(NotOccupied)))
(at 18 (NotOccupied))

;;;_________________________________Semaphore_____________________________;;;

(speaking_Lights)
(speaking_Uncontrollable_Loads)
(speaking_Battery)
(speaking_NotWorkingDay)
(speaking_HVAC)
(=(AllUncontrollableLoads)0)

;;;_________________________________________HVAC _______________________________________;;;

(= (TempDecreaseRate)0.5)

(= (TempIncreaseRate_HighPrice_Occupied_NotTempRange)0.8)
(= (TempIncreaseRate_HighPrice_NotOccupied)0.5)
(= (HeavyControllableDependentLoad)0)

(= (TempIncreaseRate_NominalPrice_Occupied_TempRange)0.7)
(= (TempIncreaseRate_NominalPrice_Occupied_NotTempRange)0.9)
(= (TempIncreaseRate_NominalPrice_NotOccupied)0.7)
(= (BuildingHVAC)2)

(= (TempIncreaseRate_LowPrice)0.99)

(= (comfort-max-limit)28)
(= (comfort-min-limt)23)
(= (current-temp)25)

;;;___________________________Lights (Natural Light Schedule______________________________;;;

(= (OrdinaryLights)2)
(= (NaturalLightLevel)0)  ;; 1 Low
(= (ControllableDependentLightLoad)0)
(at 14.0 (= (NaturalLightLevel)0)) ;; 0 High
(at 17 (= (NaturalLightLevel)1)) ;; 1 Low

;;;_________________________________Battery variables_________________________________;;;

(= (BatteryBank)3)
(= (Battery_SOC_Percentage)40) 
(= (EnergyBackupCapacity)0)
(= (Battery_Recharge_Rate)10)  
(= (Battery_Discharge_Rate_NominalPrice)4)  
(= (Battery_Discharge_Rate_HighPrice)7)  

)

(:goal (and

 (done)   

)

)
)
