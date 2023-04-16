;;;:::::::::::::::::::::::::::::::
;                                ;
;         Problem file 1         ;
;      from 00:00 to 15:00       ;
;    LOW NATURAL lIGHT LEVEL     ;
;                                ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (problem scheduling1) (:domain schedule)
(:objects       
)

(:init
;;;_____________________Problem file run for 24Hr (1 day)_________________;;;     

(dayStart)                          ;; problem1 started from 00:00 to 15:00 of the day
(at 0.1 (not(dayStart)))
(at 14 (dayEnd))
(= (Hours)15)  
(= (time-lapse)1)  

(=   (duration_Lights)0)
(=   (duration_Uncontrol)0)
(=   (duration_Battery)0)
(=   (duration_HVAC)0)

(= (L)3)
(= (U)5)
(= (B)7)
(= (H)3)
;;;___________________________Operating Hours Schedule______________________;;;

;; working hours from 08:00 to 20:00
(Not_working-day)
(not(working-day))

(at 8.09 (working-day))
(at 8.09 (not(Not_working-day)))

(at 20 (Not_working-day))
(at 20 (not(working-day)))

;;;_____________________________Day Ahead Prices______________________________;;;

(= (Energy_Tariff)2)          ;; Low Energy Price from 00:00 to 08:00
(at 8.09(= (Energy_Tariff)1)) ;; Nominal Energy Price from 00:00 to 14:00
; (at 9 (= (Energy_Tariff)1))
; (at 10 (= (Energy_Tariff)1))
; (at 11 (= (Energy_Tariff)1))
; (at 12 (= (Energy_Tariff)1))
; (at 13 (= (Energy_Tariff)1))
; (at 14 (= (Energy_Tariff)1))
; (at 15 (= (Energy_Tariff)1))
; (at 16 (= (Energy_Tariff)1))
(at 17(= (Energy_Tariff)0))      ;; High Energy Price from 17:00 to 22:00
; (at 18 (= (Energy_Tariff)0))
; (at 19 (= (Energy_Tariff)0))
; (at 20 (= (Energy_Tariff)0))
; (at 21 (= (Energy_Tariff)0))
; (at 22 (= (Energy_Tariff)0))
 (at 23 (= (Energy_Tariff)1))
;(at 24 (= (Energy_Tariff)1))

;;;_____________________________Occupancy Schedule_______________________________;;;

(not(Occupied))     ;;  Not occupied from 00:00 to 08:00 in the morning
(NotOccupied)

(at 8.05 (Occupied))  ;; occupied from working hours from 08:00
;(at 9 (Occupied))
;(at 10 (Occupied))
(at 11 (not(Occupied)))    ;; Lunch break at 11:00 to 12:00
(at 12 (Occupied))         ;; back from Lunch at 12:00
;(at 13 (Occupied))
(at 18 (not(Occupied)))    ;; Leaving at 18:00 


(at 8.10 (not(NotOccupied)))
;(at 9 (not(NotOccupied)))
;(at 10 (not(NotOccupied)))
(at 11 (NotOccupied))
(at 12 (not(NotOccupied)))
;(at 13 (not(NotOccupied)))
(at 18 (NotOccupied))


;;;_________________________________Deadlock prevention_____________________________;;;

(speaking_Lights)
(speaking_Uncontrollable_Loads)
(speaking_Battery)
(speaking_NotWorkingDay)
(speaking_HVAC)

;;;_________________________________________HVAC _______________________________________;;;

(= (TempDecreaseRate)0.5)
            
(= (TempIncreaseRate_HighPrice_Occupied_NotTempRange)0.8)
(= (TempIncreaseRate_HighPrice_NotOccupied)0.5)

(= (TempIncreaseRate_NominalPrice_Occupied_TempRange)0.7)
(= (TempIncreaseRate_NominalPrice_Occupied_NotTempRange)0.9)
(= (TempIncreaseRate_NominalPrice_NotOccupied)0.7)

(= (TempIncreaseRate_LowPrice)0.99)

(= (comfort-max-limit)28)
(= (comfort-min-limt)23)
(= (current-temp)25)


;;;___________________________Lights (Natural Light Schedule______________________________;;;

;; Low Natual Light till 08:00
;; High Natual light from 08:00 to 05:00

(= (NaturalLightLevel)1)  ;; 1 Low
;(at 8.09 (= (NaturalLightLevel)0)) ;; 0 High
;(at 17 (= (NaturalLightLevel)1)) ;; 1 Low

;;;_________________________________Battery variables_________________________________;;;

(= (Battery_SOC_Percentage)40)  
(= (Battery_Recharge_Rate)10)  
(= (Battery_Discharge_Rate_NominalPrice)4)  
(= (Battery_Discharge_Rate_HighPrice)7)  
)

(:goal (and
   (done)
)

)
)