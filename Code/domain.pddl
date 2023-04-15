(define (domain schedule)

(:requirements :strips :adl :fluents :durative-actions :timed-initial-literals :typing :conditional-effects :negative-preconditions :duration-inequalities :equality)

(:predicates 
    
    (working-day)
    (not_working-day) 
    (Occupied)
    (NotOccupied)

    ;;;___________________24 Hours of the day_____________________;;;

    (dayEnd)
    (dayStart)
    (done)
    (enable)

    ;;;____________________________Semaphores____________________________;;;

    (speaking_Battery)
    (speaking_NotWorkingDay)
    (speaking_HVAC)
    (speaking_Lights)
    (speaking_Uncontrollable_Loads)

    
    ;;;___________________Uncontrollable Loads_________________________;;;

    (Uncontrollable_LightLoads_ON)
    (Uncontrollable_LightLoads_OFF)

    (Uncontrollable_HeavyLoads_ON)
    (Uncontrollable_HeavyLoads_OFF)

    ;;;___________________Controllable Independent Loads_________________________;;;

    (Controllable_Heavy_IndependentLoad_Dishwasher_ON)
    (Controllable_Heavy_IndependentLoad_Dishwasher_OFF)

    (controllable_light_Independentload_Situatedlights_ON)
    (controllable_light_Independentload_Situatedlights_OFF)
)

(:functions
    (time-lapse)
    (Energy_Tariff)  (u)
  
;;;____________________Battery Numerics__________________;;;

    (Battery_SOC_Percentage)
    (batterybank)
    (Battery_Recharge_Rate) 
    (Battery_Discharge_Rate_HighPrice) 
    (Battery_Discharge_Rate_NominalPrice)
    (EnergyBackupCapacity)

;;;____________________Heavy Controllable Dependent Loads - HVAC Numerics__________________;;;
     
    (HVAC_Intensity)
    (buildinghvac)
    (comfort-max-limit) 
    (comfort-min-limt) 
    (current-temp)
    (HeavyControllableDependentLoad)
    (TempDecreaseRate)
    (heavylightloads)
    (TempIncreaseRate_HighPrice_Occupied_NotTempRange)
    (TempIncreaseRate_HighPrice_NotOccupied)

    (TempIncreaseRate_NominalPrice_Occupied_TempRange)
    (TempIncreaseRate_NominalPrice_Occupied_NotTempRange)
    (TempIncreaseRate_NominalPrice_NotOccupied)
    (TempIncreaseRate_LowPrice)


;;;____________________Light Controllable Dependent Loads - Ordinary Lights Numerics__________________;;;
    
    (NaturalLightLevel)
    (ordinarylights)
    (Reduce_Light_Intensity_Percentage)  
    (ControllableDependentLightLoad)
    (AllUncontrollableLoads)  
    (hours)
)


;;;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::;;;;
;;                                                                                                        ;;
;;                       LIGHT CONTROLLABLE DEPENDENT LOAD EXAMPLE: Ordianry Lights                       ;;
;;                                                                                                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;___________________Ordinary Lights at High Energy Prices_________________________;;;

(:durative-action Ordinary_Lights_HighPrice_Occupied_HighNaturalLight
    :parameters ()
    :duration (= ?duration 2)
    :condition (and 
        (over all (working-day))  ;; working day
        (over all (=(Energy_Tariff) 0)) ;; High Price 
        (over all (=(NaturalLightLevel) 0)) ;; High Natural Light
        (at start  (Occupied))
	    (at start (speaking_Lights))
	    (at start (enable))
	    )
    :effect (and 
            (at start (assign(Reduce_Light_Intensity_Percentage) 70))

            (at end (increase (ControllableDependentLightLoad)time-lapse))
            (at start (not(speaking_Lights)))
            (at end(speaking_Lights))
            )
)
(:durative-action Ordinary_Lights_HighPrice_Occupied_LowNaturalLight
    :parameters ()
    :duration (= ?duration 2)
    :condition (and 
        (over all (working-day))  ;; working day
        (over all (=(Energy_Tariff) 0)) ;; High Price 
        (over all (=(NaturalLightLevel) 1)) ;; Low Natural Light
        (at start   (Occupied))
	    (at start (speaking_Lights))
	    (at start (enable))
	    )
    :effect (and 
            (at start (assign(Reduce_Light_Intensity_Percentage) 15))

            (at end (increase (ControllableDependentLightLoad)time-lapse))
            (at start (not(speaking_Lights)))
            (at end(speaking_Lights))
            )
)
(:durative-action Ordinary_Lights_HighPrice_NotOccupied_HighNaturalLight
    :parameters ()
    :duration (= ?duration 2)
    :condition (and 
        (over all (working-day))
        (over all (=(Energy_Tariff) 0)) ;; High Price 
        (over all (=(NaturalLightLevel) 0)) ;; High Natural Light
        (at start   (NotOccupied))
	    (at start (speaking_Lights))
	    (at start (enable))
	    )
    :effect (and 
            (at start (assign(Reduce_Light_Intensity_Percentage) 100))

            (at end (increase (ControllableDependentLightLoad)time-lapse))
            (at start (not(speaking_Lights)))
            (at end(speaking_Lights))
            )
)
(:durative-action Ordinary_Lights_HighPrice_NotOccupied_LowNaturalLight
    :parameters ()
    :duration (= ?duration 2)
    :condition (and 
        (over all (working-day))
        (over all (=(Energy_Tariff) 0)) ;; High Price 
        (over all (=(NaturalLightLevel) 1)) ;; Low Natural Light
        (at start   (NotOccupied))
	    (at start (speaking_Lights))
	    (at start (enable))
	    )
    :effect (and 
            (at start (assign(Reduce_Light_Intensity_Percentage) 90))

            (at end (increase (ControllableDependentLightLoad)time-lapse))
            (at start (not(speaking_Lights)))
            (at end(speaking_Lights))
            )
)

;;;___________________Lights at Nominal Energy Prices_________________________;;;

(:durative-action Ordinary_Lights_NominalPrice_Occupied_HighNaturalLight
    :parameters ()
    :duration (= ?duration 2)
    :condition (and 
        (over all (working-day))
        (over all (=(Energy_Tariff) 1)) ;; Nominal Price 
        (over all (=(NaturalLightLevel) 0)) ;; High Natural Light
        (at start  (Occupied))
	    (at start (speaking_Lights))
	    (at start (enable))
	    )
    :effect (and 
            (at start (assign(Reduce_Light_Intensity_Percentage) 60)) ;; reduce existing lights load by 60%

            (at end (increase (ControllableDependentLightLoad)time-lapse))
            (at start (not(speaking_Lights)))
            (at end(speaking_Lights))
            )
)
(:durative-action Ordinary_Lights_NominalPrice_Occupied_LowNaturalLight
    :parameters ()
    :duration (= ?duration 2)
    :condition (and 
        (over all (working-day))
        (over all (=(Energy_Tariff) 1)) ;; Nominal Price 
        (over all (=(NaturalLightLevel) 1)) ;; Low Natural Light
        (at start  (Occupied))
	    (at start (speaking_Lights))
	    (at start (enable))
	    )
    :effect (and 
            (at start (assign(Reduce_Light_Intensity_Percentage) 15)) ;; reduce existing lights load by 15%

            (at end (increase (ControllableDependentLightLoad)time-lapse))
            (at start (not(speaking_Lights)))
            (at end(speaking_Lights))
            )
)

(:durative-action Ordinary_Lights_NominalPrice_NotOccupied_HighNaturalLight
    :parameters ()
    :duration (= ?duration 2)
    :condition (and 
        (over all (working-day))
        (over all (=(Energy_Tariff) 1)) ;; Nominal Price 
        (over all (=(NaturalLightLevel) 0)) ;; High Natural Light
        (at start   (NotOccupied))
	    (at start (speaking_Lights))
	    (at start (enable))
	    )
    :effect (and 
            (at start (assign(Reduce_Light_Intensity_Percentage) 100)) ;; Lights are off
            (at end (increase (ControllableDependentLightLoad)time-lapse))
            (at start (not(speaking_Lights)))
            (at end(speaking_Lights))
            )
)
(:durative-action Ordinary_Lights_NominalPrice_NotOccupied_LowNaturalLight
    :parameters ()
    :duration (= ?duration 2)
    :condition (and 
        (over all (working-day))
        (over all (=(Energy_Tariff) 1)) ;; Nominal Price 
        (over all (=(NaturalLightLevel) 1)) ;; Low Natural Light
        (at start   (NotOccupied))
	    (at start (speaking_Lights))
	    (at start (enable))
	    )
    :effect (and 
            (at start (assign(Reduce_Light_Intensity_Percentage) 90))  ;; reduce existing lights load by 90%
            (at end (increase (ControllableDependentLightLoad)time-lapse))
            (at start (not(speaking_Lights)))
            (at end(speaking_Lights))
            )
)

;;;___________________Lights at Low Energy Prices_________________________;;;

(:durative-action Ordinary_Lights_LowPrice_Occupied_HighNaturalLight
    :parameters ()
    :duration (= ?duration 2)
    :condition (and 
        (over all (working-day))
        (over all (=(Energy_Tariff) 2)) ;; Low Price 
        (over all (=(NaturalLightLevel) 0)) ;; High Natural Light
        (at start   (Occupied))   
	    (at start (speaking_Lights))
	    (at start (enable))
	    )
    :effect (and 
            (at start (assign(Reduce_Light_Intensity_Percentage) 50))   ;; reduce existing lights load by 50%


            (at end (increase (ControllableDependentLightLoad)time-lapse))
            (at start (not(speaking_Lights)))
            (at end(speaking_Lights))
            )
)
(:durative-action Ordinary_Lights_LowPrice_Occupied_LowNaturalLight
    :parameters ()
    :duration (= ?duration 2)
    :condition (and 
        (over all (working-day))
        (over all (=(Energy_Tariff) 2)) ;; Low Price 
        (over all (=(NaturalLightLevel) 1)) ;; Low Natural Light
        (at start   (Occupied))
	    (at start (speaking_Lights))
	    (at start (enable))
	    )
    :effect (and 
            (at start (assign(Reduce_Light_Intensity_Percentage) 0)) ;; turn ON lights at maximum demand level

            (at end (increase (ControllableDependentLightLoad)time-lapse))
            (at start (not(speaking_Lights)))
            (at end(speaking_Lights))
            )
)

(:durative-action Ordinary_Lights_LowPrice_NotOccupied_HighNaturalLight
    :parameters ()
    :duration (= ?duration 2)
    :condition (and 
        (over all (working-day))
        (over all (=(Energy_Tariff) 2)) ;; Low Price 
        (over all (=(NaturalLightLevel) 0)) ;; High Natural Light
        (at start  (NotOccupied))
	    (at start (speaking_Lights))
	    (at start (enable))
	    )
    :effect (and 
            (at start (assign(Reduce_Light_Intensity_Percentage) 100)) ;; turn off lights
            (at end (increase (ControllableDependentLightLoad)time-lapse))
            (at start (not(speaking_Lights)))
            (at end(speaking_Lights))
            )
)
(:durative-action Ordinary_Lights_LowPrice_NotOccupied_LowNaturalLight
    :parameters ()
    :duration (= ?duration 2)
    :condition (and 
        (over all (working-day))
        (over all (=(Energy_Tariff) 2)) ;; Low Price 
        (over all (=(NaturalLightLevel) 1)) ;; Low Natural Light
        (at start  (NotOccupied))
	    (at start (speaking_Lights))
	    (at start (enable))
	    )
    :effect (and 
            (at start (assign(Reduce_Light_Intensity_Percentage) 40)) ;; rreduce existing lights load by 40%

            (at end (increase (ControllableDependentLightLoad)time-lapse))
            (at start (not(speaking_Lights)))
            (at end(speaking_Lights))
            )
)

;;;;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;;                                                                      ;;
;;                       LIGHT UNCONTROLLABLE LOAD                      ;;
;;                       HEAVY UNCONTROLLABLE LOAD                      ;;
;;     LIGHT CONTROLLABLE INNDEPENDENT LOAD EXAMPLE Situated Lights     ;;
;;       HEAVY CONTROLLABLE INNDEPENDENT LOAD EXAMPLE Dish Washer       ;;
;;                                                                      ;;                              
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    



;;;___________________High Energy Prices_________________________;;;

(:durative-action HighPrice_Uncontrollable_Loads_Controllable_Independent_Loads
    :parameters ()
    :duration (= ?duration 2)
    :condition (and 
        (over all (working-day))
        (over all (=(Energy_Tariff) 0)) ;; High Price 
	    (at start (speaking_Uncontrollable_Loads))
	    (at start (enable))
	    )
    :effect (and 
            (at start (Uncontrollable_LightLoads_ON))    ;;Uncontrollable_LightLoads (Sckets, Tv): ON Battery
            (at start (not(Uncontrollable_LightLoads_OFF)))

            (at start (Uncontrollable_HeavyLoads_ON))        ;;Uncontrollable_HeavyLoads (Oven, Stove): ON Battery
            (at start (not(Uncontrollable_HeavyLoads_OFF)))
            
            (at start (Controllable_Heavy_IndependentLoad_Dishwasher_OFF))   ;; Dish washer: OFF
            (at start (not(Controllable_Heavy_IndependentLoad_Dishwasher_ON)))
            
            (at start (Controllable_Light_IndependentLoad_SituatedLights_OFF))   ;; Situated Lights: OFF
            (at start (not(Controllable_Light_IndependentLoad_SituatedLights_ON)))


            (at end (increase (AllUncontrollableLoads)time-lapse))
            (at start (not(speaking_Uncontrollable_Loads)))
            (at end(speaking_Uncontrollable_Loads))
            )
)

;;;___________________Nominal Energy Prices_________________________;;;

(:durative-action NominalPrice_Uncontrollable_Loads_Controllable_Independent_Loads
    :parameters ()
    :duration (= ?duration 2)
    :condition (and 
        (over all (working-day))
        (over all (=(Energy_Tariff) 1)) ;; Nominal Price 
	    (at start (speaking_Uncontrollable_Loads))
	    (at start (enable))
	    )
    :effect (and 
            (at start (Uncontrollable_LightLoads_ON))    ;;Uncontrollable_LightLoads (Sckets, Tv): ON 
            (at start (not(Uncontrollable_LightLoads_OFF)))

            (at start (Uncontrollable_HeavyLoads_ON))        ;;Uncontrollable_HeavyLoads (Oven, Stove): ON Battery if >80% SOC
            (at start (not(Uncontrollable_HeavyLoads_OFF)))
            
            (at start (Controllable_Heavy_IndependentLoad_Dishwasher_ON))   ;; Dish washer: ON
            (at start (not(Controllable_Heavy_IndependentLoad_Dishwasher_OFF)))

            (at start (Controllable_Light_IndependentLoad_SituatedLights_ON))   ;; Situated Lights: ON
            (at start (not(Controllable_Light_IndependentLoad_SituatedLights_OFF)))
            

            (at end (increase (AllUncontrollableLoads)time-lapse))
            (at start (not(speaking_Uncontrollable_Loads)))
            (at end(speaking_Uncontrollable_Loads))
            )
)

;;;___________________Low Energy Prices_________________________;;;

(:durative-action LowPrice_Uncontrollable_Loads_Controllable_Independent_Loads
    :parameters ()
    :duration (= ?duration 2)
    :condition (and 
        (over all (working-day))
        (over all (=(Energy_Tariff) 2)) ;; Low Price 
	    (at start (speaking_Uncontrollable_Loads))
	    (at start (enable))
	    )
    :effect (and 
            (at start (Uncontrollable_LightLoads_ON))    ;;Uncontrollable_LightLoads (Sckets, Tv): ON 
            (at start (not(Uncontrollable_LightLoads_OFF)))

            (at start (Uncontrollable_HeavyLoads_ON))        ;;Uncontrollable_HeavyLoads (Oven, Stove): ON 
            (at start (not(Uncontrollable_HeavyLoads_OFF)))
            
            (at start (Controllable_Heavy_IndependentLoad_Dishwasher_ON))   ;; Dish washer: ON
            (at start (not(Controllable_Heavy_IndependentLoad_Dishwasher_OFF)))

            (at start (Controllable_Light_IndependentLoad_SituatedLights_ON))   ;; Situated Lights: ON
            (at start (not(Controllable_Light_IndependentLoad_SituatedLights_OFF)))
            

            (at end (increase (AllUncontrollableLoads)time-lapse))
            (at start (not(speaking_Uncontrollable_Loads)))
            (at end(speaking_Uncontrollable_Loads))
            )
)



;;;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::;;;;
;                                                                                                        ;;
;                              HEAVY CONTROLLABLE DEPENDENT LOAD EXAMPLE: HVAC                           ;;
; NOTE: Assumption is that its Winter season. Room should be warm enough to be in Comfortable Temp Range ;;
;                                                                                                        ;;
;                                                                                                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;___________________HVAC High Energy Prices_________________________;;;

(:durative-action HVAC_HighPrice_Occupied_InTempRange
    :parameters ()
    :duration (= ?duration 2)
    :condition (and 
        (over all (working-day))
        (over all (=(Energy_Tariff) 0)) ;; high price
        (at start (Occupied))
        (at start (speaking_HVAC))
        (over all (>=(current-temp)(comfort-min-limt)));; In Temp Range
	    (over all (<=(current-temp )(comfort-max-limit)))
	    (at start (enable))
	   
	    )
    :effect (and 
            (at start (assign(HVAC_Intensity) 0))
            (at end(decrease (current-temp)(TempDecreaseRate)))

            (at end (increase (HeavyControllableDependentLoad)time-lapse))
            (at start (not(speaking_HVAC)))
            (at end(speaking_HVAC))
            )
)

(:durative-action HVAC_HighPrice_Occupied_NotInTempRange
     :parameters ()
     :duration (= ?duration 2)
     :condition (and 
                (over all (working-day))
                (over all (=(Energy_Tariff) 0)) ;; high price
                (at start (Occupied))
                (over all (<= (current-temp) (comfort-min-limt)));; not In Temp Range
 	        (over all (<=(current-temp)(comfort-max-limit))) 
 	        (at start (speaking_HVAC))
 	        (at start (enable))
 	    )
     :effect (and 
             (at start (assign(HVAC_Intensity) 80))
             (at end(increase (current-temp)(TempIncreaseRate_HighPrice_Occupied_NotTempRange)))

             (at end (increase (HeavyControllableDependentLoad)time-lapse))
              (at start (not(speaking_HVAC)))
            (at end(speaking_HVAC))
             )
)

(:durative-action HVAC_HighPrice_NotOccupied_InTempRange
     :parameters ()
     :duration (= ?duration 2)
     :condition (and 
                (over all (working-day))
                (over all (=(Energy_Tariff) 0)) ;; high price
                (at start (NotOccupied))
                (over all (>=(current-temp)(comfort-min-limt)));; In Temp Range
 	            (over all (<=(current-temp)(comfort-max-limit))) 
 	            (at start (speaking_HVAC))
 	            (at start (enable))
 	        )
     :effect (and 
            (at start (assign(HVAC_Intensity)0))
            (at end(decrease (current-temp)(TempDecreaseRate)))

            (at end (increase (HeavyControllableDependentLoad)time-lapse))
             (at start (not(speaking_HVAC)))
            (at end(speaking_HVAC))
            )
)

(:durative-action HVAC_HighPrice_NotOccupied_NotInTempRange
     :parameters ()
     :duration (= ?duration 2)
     :condition (and 
                (over all (working-day))
                (over all (=(Energy_Tariff) 0)) ;; high price
                (at start (NotOccupied))
                (over all (<= (current-temp) (comfort-min-limt)));; not In Temp Range
 	        (over all (<=(current-temp)(comfort-max-limit))) 
 	        (at start (speaking_HVAC))
 	        (at start (enable))
 	    )
     :effect (and 
            (at start (assign(HVAC_Intensity) 50))
            (at end(increase (current-temp)(TempIncreaseRate_HighPrice_NotOccupied)))

            (at end (increase (HeavyControllableDependentLoad)time-lapse))
             (at start (not(speaking_HVAC)))
            (at end(speaking_HVAC))
            )
)

;;;___________________HVAC Nominal Energy Prices_________________________;;;

(:durative-action HVAC_NominalPrice_Occupied_InTempRange
    :parameters ()
    :duration (= ?duration 2)
    :condition (and 
        (over all (working-day))
        (over all (=(Energy_Tariff) 1)) ;; Nominal price
        (at start (Occupied))
        (over all (>=(current-temp)(comfort-min-limt)));; In Temp Range
	    (over all (<=(current-temp )(comfort-max-limit)))
	    (at start (speaking_HVAC))
	    )
    :effect (and 
            (at start (assign(HVAC_Intensity) 70))
            (at end(increase (current-temp)(TempIncreaseRate_NominalPrice_Occupied_TempRange)))
            (at end (increase (HeavyControllableDependentLoad)time-lapse))
            (at start (not(speaking_HVAC)))
            (at end(speaking_HVAC))
            (at start (enable))
            )
)

(:durative-action HVAC_NominalPrice_Occupied_NotInTempRange
     :parameters ()
     :duration (= ?duration 2)
     :condition (and 
                (over all (working-day))
                (over all (=(Energy_Tariff) 1)) ;; Nominal price
                (at start (Occupied))
                (over all (<= (current-temp) (comfort-min-limt)));; not In Temp Range
 	            (over all (<=(current-temp)(comfort-max-limit))) 
 	            (at start (speaking_HVAC))
 	            (at start (enable))
 	    )
     :effect (and 
            (at start (assign(HVAC_Intensity) 90))
            (at end(increase (current-temp)(TempIncreaseRate_NominalPrice_Occupied_NotTempRange)))
            (at end (increase (HeavyControllableDependentLoad)time-lapse))
            (at start (not(speaking_HVAC)))
            (at end(speaking_HVAC))
             )
)

(:durative-action HVAC_NominalPrice_NotOccupied_InTempRange
     :parameters ()
     :duration (= ?duration 2)
     :condition (and 
                (over all (working-day))
                (over all (=(Energy_Tariff) 1)) ;; Nominal price
                (at start (NotOccupied))
                (over all (>=(current-temp)(comfort-min-limt)));; In Temp Range
 	            (over all (<=(current-temp)(comfort-max-limit))) 
 	            (at start (speaking_HVAC))
 	            (at start (enable))
 	        )
     :effect (and 
            (at start (assign(HVAC_Intensity)0))
            (at end(decrease (current-temp)(TempDecreaseRate)))
            (at end (increase (HeavyControllableDependentLoad)time-lapse))
            (at start (not(speaking_HVAC)))
            (at end(speaking_HVAC))
            )
)

(:durative-action HVAC_NominalPrice_NotOccupied_NotInTempRange
     :parameters ()
     :duration (= ?duration 2)
     :condition (and 
                (over all (working-day))
                (over all (=(Energy_Tariff) 1)) ;; Nominal price
                (at start (NotOccupied))
                (over all (<= (current-temp) (comfort-min-limt)));; not In Temp Range
 	            (over all (<=(current-temp)(comfort-max-limit))) 
 	            (at start (speaking_HVAC))
 	            (at start (enable))
 	    )
     :effect (and 
            (at start (assign(HVAC_Intensity) 70))
            (at end(increase (current-temp)(TempIncreaseRate_NominalPrice_NotOccupied)))
            (at end (increase (HeavyControllableDependentLoad)time-lapse))
            (at start (not(speaking_HVAC)))
            (at end(speaking_HVAC))
            )
)


;;;___________________HVAC Low Energy Prices_________________________;;;

(:durative-action HVAC_LowPrice_Occupied_InTempRange
    :parameters ()
    :duration (= ?duration 2)
    :condition (and 
        (over all (working-day))
        (over all (=(Energy_Tariff) 2)) ;; Low price
        (at start (Occupied))
        (over all (>=(current-temp)(comfort-min-limt)));; In Temp Range
	    (over all (<=(current-temp )(comfort-max-limit)))
	    (at start (speaking_HVAC))
	    (at start (enable))
	    )
    :effect (and 
            (at start (assign(HVAC_Intensity) 100))
            (at end(increase (current-temp)(TempIncreaseRate_LowPrice)))
            (at end (increase (HeavyControllableDependentLoad)time-lapse))
            (at start (not(speaking_HVAC)))
            (at end(speaking_HVAC))
            )
)

(:durative-action Hours_of_the_Day
:parameters()
:duration (<= ?duration(Hours))
:condition(and
   (at start(dayStart)) 
   (at end (dayEnd))
   (over all (>= (current-temp)(comfort-min-limt)))
   (over all (<=(current-temp)(comfort-max-limit))) 
   (over all (>= (Battery_SOC_Percentage)0))
   (over all (<= (Battery_SOC_Percentage)100))
   (at end (and   
        (=(ControllableDependentLightLoad)(OrdinaryLights))  
        (=(AllUncontrollableLoads)(HeavyLightLoads)) ;; uncontrol + out of operating hours
        (=(EnergyBackupCapacity) (BatteryBank))
        (=(HeavyControllableDependentLoad) (BuildingHVAC)) 
   ))
)
:effect(and
(at start (enable))
(at end (not(enable)))
(at end(done)))
)


(:durative-action HVAC_LowPrice_Occupied_NotInTempRange
     :parameters ()
     :duration (= ?duration 2)
     :condition (and 
                (over all (working-day))
                (over all (=(Energy_Tariff) 2)) ;; Low price
                (at start (Occupied))
                (over all (<= (current-temp) (comfort-min-limt)));; not In Temp Range
 	        (over all (<=(current-temp)(comfort-max-limit))) 
 	        (at start (speaking_HVAC))
 	        (at start (enable))
 	    )
     :effect (and 
             (at start (assign(HVAC_Intensity) 100))
             (at end(increase (current-temp) (TempIncreaseRate_LowPrice)))
             (at end (increase (HeavyControllableDependentLoad)time-lapse))
            (at start (not(speaking_HVAC)))
            (at end(speaking_HVAC))
             )
)

(:durative-action HVAC_LowPrice_NotOccupied_InTempRange
     :parameters ()
     :duration (= ?duration 2)
     :condition (and 
                (over all (working-day))
                (over all (=(Energy_Tariff) 2)) ;; Low price
                (at start (NotOccupied))
                (over all (>=(current-temp)(comfort-min-limt)));; In Temp Range
 	            (over all (<=(current-temp)(comfort-max-limit))) 
 	            (at start (speaking_HVAC))
 	            (at start (enable))
 	        )
     :effect (and 
            (at start (assign(HVAC_Intensity)0))
            (at end(decrease (current-temp)(TempDecreaseRate)))
            (at end (increase (HeavyControllableDependentLoad)time-lapse))
            (at start (not(speaking_HVAC)))
            (at end(speaking_HVAC))
            )
)

(:durative-action HVAC_LowPrice_NotOccupied_NotInTempRange
     :parameters ()
     :duration (= ?duration 2)
     :condition (and 
                (over all (working-day))
                (over all (=(Energy_Tariff) 2)) ;; Low price
                (at start (NotOccupied))
                (over all (<= (current-temp) (comfort-min-limt)));; not In Temp Range
 	        (over all (<=(current-temp)(comfort-max-limit))) 
 	        (at start (speaking_HVAC))
 	        (at start (enable))
 	    )
     :effect (and 
            (at start (assign(HVAC_Intensity) 100))
            (at end(increase (current-temp) (TempIncreaseRate_LowPrice)))
            (at end (increase (HeavyControllableDependentLoad)time-lapse))
            (at start (not(speaking_HVAC)))
            (at end(speaking_HVAC))
            )
)

;;;;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::;;;;
;;                                                                                                        ;;
;;                              ELECTRICITY STORAGE SYSTEM EXAMPLE: Battery                               ;;
;;                                                                                                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;___________________Battery Discharge at High Energy Prices_________________________;;;

(:durative-action Battery_DisCharge_HighPrice
    :parameters ()
    :duration (= ?duration 2)
    :condition (and 
        (over all (=(Energy_Tariff) 0))
	    (at start (speaking_Battery))
	    (at start (>(Battery_SOC_Percentage)0))
	    (at start (enable))
	    )
    :effect (and 
            (at end (decrease (Battery_SOC_Percentage)(Battery_Discharge_Rate_HighPrice)))

            (at end (increase (EnergyBackupCapacity)time-lapse))
            (at start (not(speaking_Battery)))
            (at end(speaking_Battery))
            )
)

;;;___________________Battery Discharge at Nominal Energy Prices_________________________;;;

(:durative-action Battery_DisCharge_NominalPrice
    :parameters ()
    :duration (= ?duration 2)
    :condition (and 
        (over all (working-day))
        (over all (=(Energy_Tariff) 1))
	    (at start (speaking_Battery))
	    (at start (>(Battery_SOC_Percentage)0))
	    (at start (enable))
	    )
    :effect (and 
            (at end (decrease (Battery_SOC_Percentage)(Battery_Discharge_Rate_NominalPrice)))

            (at end (increase (EnergyBackupCapacity)time-lapse))
            (at start (not(speaking_Battery)))
            (at end(speaking_Battery))
            )
)

;;;___________________Battery charge at Low Energy Prices_________________________;;;


(:durative-action Battery_Charge_Low_Price
    :parameters ()
    :duration (= ?duration 2)
    :condition (and 
        (over all (=(Energy_Tariff) 2)) ;; Low Price 
	    (at start (speaking_Battery))
	    (at start (<(Battery_SOC_Percentage)100))
	    (at start (enable))
	    )
    :effect (and 
            (at end (increase (Battery_SOC_Percentage)(Battery_Recharge_Rate)))

            (at end (increase (EnergyBackupCapacity)time-lapse))
            (at start (not(speaking_Battery)))
            (at end(speaking_Battery))
            )
)


;;;;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::;;;;
;;                                                                                                        ;;
;;                       Out of Operating Hours / Weekends / Public Holidays                              ;;
;;                                                                                                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;_______________________Out of Operting Hours_________________________;;;

 (:durative-action Out_of_Operating_Hours_all_OFF_LightsReduced
    :parameters ()
    :duration (= ?duration 4)
    :condition (and 
        (over all (Not_working-day))
	    (at start (speaking_NotWorkingDay))
	    (at start (enable))
	    )
    :effect (and 
             (at start (not(working-day))) ;; Not its Out of operation hours
             (at end (not(working-day))) 

             (at start (assign(HVAC_Intensity)0))     ;;HVAC: OFF

             (at start (assign(Reduce_Light_Intensity_Percentage)40))  ;; Reduce Light Intensity
            
             (at start (Uncontrollable_LightLoads_OFF))    ;;Uncontrollable_LightLoads (Sckets, Tv): OFF 
             (at start (not(Uncontrollable_LightLoads_ON)))

             (at start (Uncontrollable_HeavyLoads_OFF))        ;;Uncontrollable_HeavyLoads (Oven, Stove): OFF 
             (at start (not(Uncontrollable_HeavyLoads_ON)))
            
             (at start (Controllable_Heavy_IndependentLoad_Dishwasher_OFF))   ;; Dish washer: OFF
             (at start (not(Controllable_Heavy_IndependentLoad_Dishwasher_ON)))

             (at start (Controllable_Light_IndependentLoad_SituatedLights_OFF))   ;; Situated Lights: OFF
             (at start (not(Controllable_Light_IndependentLoad_SituatedLights_ON)))

            (at start (not(speaking_NotWorkingDay)))
            (at end (increase (AllUncontrollableLoads)time-lapse)) 
            (at end(speaking_NotWorkingDay))
            )
)
)



