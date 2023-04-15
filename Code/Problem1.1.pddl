;;;:::::::::::::::::::::::::::::::
;                                ;
;         Problem file 1         ;
;      from 00:00 to 15:00       ;
;                                ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
(define (problem scheduling1) (:domain schedule)
(:init
 
;;;_____________________Problem file run for 24Hr (1 day)_________________;;;     
 
(dayStart)       ;; Problem file 1 started from 00:00 to 15:00 of the day
(at 0.1 (not(dayStart)))
(at 14 (dayEnd))    
(= (Hours)15)
(= (time-lapse)1)
 
;;;___________________________Operating Hours Schedule______________________;;;

;; working hours from 08:00 to 20:00

(Not_working-day)
(not(working-day))

(at 8.09 (working-day))
(at 8.09 (not(Not_working-day)))

(at 20 (Not_working-day))
(at 20 (not(working-day)))

 ;;;_____________________________Day Ahead Prices______________________________;;;

;; 2 Low, 1 Nominal, 0 High ;;

(= (Energy_Tariff)2)
;(at 1 (= (Energy_Tariff)2))
;(at 2 (= (Energy_Tariff)2))
;(at 3 (= (Energy_Tariff)2))
;(at 4 (= (Energy_Tariff)2))
;(at 5 (= (Energy_Tariff)2))
;(at 6 (= (Energy_Tariff)1))
;(at 7 (= (Energy_Tariff)0))
(at 8.09 (= (Energy_Tariff)0))
;(at 9 (= (Energy_Tariff)1))
;(at 10 (= (Energy_Tariff)2))
;(at 11 (= (Energy_Tariff)2))
;(at 12 (= (Energy_Tariff)2))

(at 13 (= (Energy_Tariff)2))
;(at 14 (= (Energy_Tariff)2))
;(at 15 (= (Energy_Tariff)2))
;(at 16 (= (Energy_Tariff)1))
(at 17 (= (Energy_Tariff)1))
;(at 18 (= (Energy_Tariff)0))
;(at 19 (= (Energy_Tariff)0))
;(at 20 (= (Energy_Tariff)1))
;(at 21 (= (Energy_Tariff)1))
;(at 22 (= (Energy_Tariff)1))
(at 23 (= (Energy_Tariff)1))
;(at 24 (= (Energy_Tariff)1))

;;;_____________________________Occupancy Schedule_______________________________;;;

(not(Occupied)) 
(NotOccupied)

(at 8.10 (Occupied)) 
;(at 9 (Occupied))
(at 11 (not(Occupied)))
(at 12 (Occupied))
;(at 13 (Occupied))
(at 18 (not(Occupied)))

(at 8.10 (not(NotOccupied)))
;(at 9 (not(NotOccupied)))
(at 11 (NotOccupied))
(at 12 (not(NotOccupied)))
;(at 13 (not(NotOccupied)))
;(at 18 (NotOccupied))
(= (HeavyLightLoads)5)

;;;_________________________________Semaphore_____________________________;;;

(speaking_Lights)
(speaking_Uncontrollable_Loads)
(speaking_Battery)
(speaking_NotWorkingDay)
(speaking_HVAC)
(=(AllUncontrollableLoads)0)

;;;_________________________________________HVAC _______________________________________;;;

(= (TempDecreaseRate)0.5)

(= (HeavyControllableDependentLoad)0)
(= (TempIncreaseRate_HighPrice_Occupied_NotTempRange)0.8)
(= (TempIncreaseRate_HighPrice_NotOccupied)0.5)

(= (BuildingHVAC)3)
(= (TempIncreaseRate_NominalPrice_Occupied_TempRange)0.7)
(= (TempIncreaseRate_NominalPrice_Occupied_NotTempRange)0.9)
(= (TempIncreaseRate_NominalPrice_NotOccupied)0.7)

(= (TempIncreaseRate_LowPrice)0.99)

(= (comfort-max-limit)28)
(= (comfort-min-limt)23)
(= (current-temp)25)

;;;___________________________Lights (Natural Light Schedule______________________________;;;

(= (ControllableDependentLightLoad)0)
(= (NaturalLightLevel)1)  ;; 1 Low
(= (OrdinaryLights)3)
(at 8.09 (= (NaturalLightLevel)0)) ;; 0 High
(at 17 (= (NaturalLightLevel)1)) ;; 1 Low

;;;_________________________________Battery variables_________________________________;;;

(= (BatteryBank)7)
(= (Battery_SOC_Percentage)40) 
(= (Battery_Recharge_Rate)10) 
(=(EnergyBackupCapacity)0)
(= (Battery_Discharge_Rate_NominalPrice)4)  
(= (Battery_Discharge_Rate_HighPrice)7)  

)

(:goal (and

 (done)   

)

)
)
