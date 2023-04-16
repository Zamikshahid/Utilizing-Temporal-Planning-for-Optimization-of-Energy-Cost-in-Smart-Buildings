(define (problem weekend_scheduling) (:domain schedule)
(:objects       
)

(:init
;;;_____________________Problem file run for 24Hr (1 day)_________________;;;     

(= (time-lapse)1)  
(=   (timePeriod_Uncontrol)0)
(=   (timePeriod_Battery)0)

;;;___________________________Operating Hours Schedule______________________;;;

(Not_working-day)
(not(working-day))

;;;_____________________________Day Ahead Prices______________________________;;;
(= (Energy_Tariff)0)
(at 1 (= (Energy_Tariff)2))
(at 9 (= (Energy_Tariff)1))
(at 16 (= (Energy_Tariff)0))
(at 23 (= (Energy_Tariff)1))

;;;_________________________________Deadlock prevention_____________________________;;;
(speaking_Battery)
(speaking_NotWorkingDay)

;;;_________________________________Battery variables_________________________________;;;

(= (Battery_SOC_Percentage)30)  
(= (Battery_Recharge_Rate)8)  
(= (Battery_Discharge_Rate_NominalPrice)4)  
(= (Battery_Discharge_Rate_HighPrice)7)  
)

(:goal (and 
  (=(timePeriod_Uncontrol) 12)    
  (=(timePeriod_Battery) 13)
)

)
)