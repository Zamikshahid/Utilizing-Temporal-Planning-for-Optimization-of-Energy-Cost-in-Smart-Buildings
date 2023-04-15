from DayAheadPrices import DayAheadPrice_DataFilteration
import os
import subprocess


def ProblemFile1_Generation (Hourly_Price):
#######################################
##      Hourly prices for 24 hours   ##
##      0 = High price               ##
##      1 = nominal price            ##
##      2 = Low price                ##
#######################################
  pddl_Problem_File = [
";;;:::::::::::::::::::::::::::::::\n",
";                                ;\n",
";         Problem file 1         ;\n",
";      from 00:00 to 15:00       ;\n",             
";                                ;\n",
";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;\n",

" \n",

  "(define (problem scheduling1) (:domain schedule)\n",

  "(:init\n",
" \n",
";;;_____________________Problem file run for 24Hr (1 day)_________________;;;     \n",
 " \n",
"(dayStart)       ;; Problem file 1 started from 00:00 to 15:00 of the day\n",
"(at 0.1 (not(dayStart)))\n",
"(at 14 (dayEnd))    \n",
"(= (Hours)15)\n",
"(= (time-lapse)1)\n",  
    
  " \n",
  ";;;___________________________Operating Hours Schedule______________________;;;\n",
  "\n",
";; working hours from 08:00 to 20:00\n",

  "\n",
  "(Not_working-day)\n",
  "(not(working-day))\n",

  "\n",

  "(at 8.09 (working-day))\n",
  "(at 8.09 (not(Not_working-day)))\n",

  "\n",

  "(at 20 (Not_working-day))\n",
  "(at 20 (not(working-day)))\n",

  "\n",

  " ;;;_____________________________Day Ahead Prices______________________________;;;\n",

  "\n",
  ";; 2 Low, 1 Nominal, 0 High ;;\n",
  
   "\n",
  "(= (Energy_Tariff)"+ str(Hourly_Price[0]) +")\n",
  ";(at 1 (= (Energy_Tariff)" + str(Hourly_Price[1]) + "))\n",
  ";(at 2 (= (Energy_Tariff)" + str(Hourly_Price[2]) + "))\n",
  ";(at 3 (= (Energy_Tariff)" + str(Hourly_Price[3]) + "))\n",
  ";(at 4 (= (Energy_Tariff)" + str(Hourly_Price[4]) + "))\n",
  ";(at 5 (= (Energy_Tariff)" + str(Hourly_Price[5]) + "))\n",
  ";(at 6 (= (Energy_Tariff)" + str(Hourly_Price[6]) + "))\n",
  ";(at 7 (= (Energy_Tariff)" + str(Hourly_Price[7]) + "))\n",
  "(at 8.09 (= (Energy_Tariff)" + str(Hourly_Price[8]) + "))\n",
  ";(at 9 (= (Energy_Tariff)" + str(Hourly_Price[9]) + "))\n",
  ";(at 10 (= (Energy_Tariff)" + str(Hourly_Price[10]) + "))\n",
  ";(at 11 (= (Energy_Tariff)" + str(Hourly_Price[11]) + "))\n",
  ";(at 12 (= (Energy_Tariff)" + str(Hourly_Price[12]) + "))\n",
  
  "\n",
  
  "(at 13 (= (Energy_Tariff)" + str(Hourly_Price[13]) + "))\n",
  ";(at 14 (= (Energy_Tariff)" + str(Hourly_Price[14]) + "))\n",
  ";(at 15 (= (Energy_Tariff)" + str(Hourly_Price[15]) + "))\n",
  ";(at 16 (= (Energy_Tariff)" + str(Hourly_Price[16]) + "))\n",
  "(at 17 (= (Energy_Tariff)" + str(Hourly_Price[17]) + "))\n",
  ";(at 18 (= (Energy_Tariff)" + str(Hourly_Price[18]) + "))\n",
  ";(at 19 (= (Energy_Tariff)" + str(Hourly_Price[19]) + "))\n",
  ";(at 20 (= (Energy_Tariff)" + str(Hourly_Price[20]) + "))\n",
  ";(at 21 (= (Energy_Tariff)" + str(Hourly_Price[21]) + "))\n",
  ";(at 22 (= (Energy_Tariff)" + str(Hourly_Price[22]) + "))\n",
  "(at 23 (= (Energy_Tariff)" + str(Hourly_Price[23]) + "))\n",
  ";(at 24 (= (Energy_Tariff)" + str(Hourly_Price[23]) + "))\n",

  "\n",

  ";;;_____________________________Occupancy Schedule_______________________________;;;\n",

  "\n",

  "(not(Occupied)) \n",
  "(NotOccupied)\n",
 

  "\n",

  "(at 8.10 (Occupied)) \n",
  ";(at 9 (Occupied))\n",
  "(at 11 (not(Occupied)))\n",
  "(at 12 (Occupied))\n",
  ";(at 13 (Occupied))\n",
  "(at 18 (not(Occupied)))\n",

  "\n",

  "(at 8.10 (not(NotOccupied)))\n",
  ";(at 9 (not(NotOccupied)))\n",
  "(at 11 (NotOccupied))\n",
  "(at 12 (not(NotOccupied)))\n",
  ";(at 13 (not(NotOccupied)))\n",
  ";(at 18 (NotOccupied))\n",
  "(= (HeavyLightLoads)5)\n",

  "\n",

  ";;;_________________________________Semaphore_____________________________;;;\n",

  "\n",

  "(speaking_Lights)\n",
  "(speaking_Uncontrollable_Loads)\n",
  "(speaking_Battery)\n",
  "(speaking_NotWorkingDay)\n",
  "(speaking_HVAC)\n",
 "(=(AllUncontrollableLoads)0)\n",
  "\n",

  ";;;_________________________________________HVAC _______________________________________;;;\n",

  "\n",

  "(= (TempDecreaseRate)0.5)\n",

  "\n", 
  "(= (HeavyControllableDependentLoad)0)\n",         
  "(= (TempIncreaseRate_HighPrice_Occupied_NotTempRange)0.8)\n",
  "(= (TempIncreaseRate_HighPrice_NotOccupied)0.5)\n",

  "\n",
  "(= (BuildingHVAC)3)\n",
  "(= (TempIncreaseRate_NominalPrice_Occupied_TempRange)0.7)\n",
  "(= (TempIncreaseRate_NominalPrice_Occupied_NotTempRange)0.9)\n",
  "(= (TempIncreaseRate_NominalPrice_NotOccupied)0.7)\n",

  "\n",

  "(= (TempIncreaseRate_LowPrice)0.99)\n",

  "\n",

  "(= (comfort-max-limit)28)\n",
  "(= (comfort-min-limt)23)\n",
  "(= (current-temp)25)\n",

  "\n",

  ";;;___________________________Lights (Natural Light Schedule______________________________;;;\n",

  "\n",
"(= (ControllableDependentLightLoad)0)\n",
"(= (NaturalLightLevel)1)  ;; 1 Low\n",
"(= (OrdinaryLights)3)\n",
"(at 8.09 (= (NaturalLightLevel)0)) ;; 0 High\n",
"(at 17 (= (NaturalLightLevel)1)) ;; 1 Low\n",

  "\n",

  ";;;_________________________________Battery variables_________________________________;;;\n",

  "\n",
  "(= (BatteryBank)7)\n",
  "(= (Battery_SOC_Percentage)40) \n", 
  "(= (Battery_Recharge_Rate)10) \n",
  "(=(EnergyBackupCapacity)0)\n", 
  "(= (Battery_Discharge_Rate_NominalPrice)4)  \n",
  "(= (Battery_Discharge_Rate_HighPrice)7)  \n",

  "\n",

  ")\n",

  "\n",

  "(:goal (and\n",

  "\n",  
     
  " (done)   \n",

  "\n",

  ")\n",

  "\n",

  ")\n",
  ")\n",

  ]

  # Creating a new file and writing the PDDL structure to it
  with open("Problem1.1.pddl", "w") as file:
    file.writelines(pddl_Problem_File)
  
  print("Problem file 1.1 generated")
def ProblemFile2_Generation (Hourly_Price):
#######################################
##      Hourly prices for 24 hours   ##
##      0 = High price               ##
##      1 = nominal price            ##
##      2 = Low price                ##
#######################################
  pddl_Problem_File = [
";;;:::::::::::::::::::::::::::::::\n",
";                                ;\n",
";         Problem file 2         ;\n",
";      from 14:00 to 24:00       ;\n",             
";                                ;\n",
";;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;\n",

" \n",

  "(define (problem scheduling2) (:domain schedule)\n",

  "(:init\n",
" \n",
";;;_____________________Problem file run for 24Hr (1 day)_________________;;;     \n",
 " \n",
"(at 13.9 (dayStart))       ;; Problem file 2 started from 14:00 to 24:00 of the day\n",
"(at 0.1 (not(dayStart)))\n",
"(= (HeavyLightLoads)3)\n",
"(at 24 (dayEnd))    \n",
"(= (Hours)13)       ;; In problem file 2, day is 10 hours so it ended at 24:00\n",
"(= (time-lapse)1)\n",  
    
  " \n",
 
  
  
 
  
  " \n",



  "\n",
  ";;;___________________________Operating Hours Schedule______________________;;;\n",
  "\n",
";; working hours from 08:00 to 20:00\n",
";; as this problem file starting from time 14:00\n",
";; so working hours on problem file 2 is from 14:00 to 24:00\n",

  "\n",
  "(Not_working-day)\n",
  "(not(working-day))\n",

  "\n",

  "(at 14.0 (working-day))\n",
  "(at 14.0 (not(Not_working-day)))\n",

  "\n",

  "(at 20.0 (Not_working-day))\n",
  "(at 20.0 (not(working-day)))\n",

  "\n",

  " ;;;_____________________________Day Ahead Prices______________________________;;;\n",

  "\n",
  ";; 2 Low, 1 Nominal, 0 High ;;\n",
  
  "\n",
    "(= (Energy_Tariff)"+ str(Hourly_Price[12]) +")\n",
  ";(at 13 (= (Energy_Tariff)" + str(Hourly_Price[13]) + "))\n",
  "(at 14.0 (= (Energy_Tariff)" + str(Hourly_Price[14]) + "))\n",
  ";(at 15 (= (Energy_Tariff)" + str(Hourly_Price[15]) + "))\n",
  ";(at 16 (= (Energy_Tariff)" + str(Hourly_Price[16]) + "))\n",
  ";(at 17 (= (Energy_Tariff)" + str(Hourly_Price[17]) + "))\n",
  ";(at 18 (= (Energy_Tariff)" + str(Hourly_Price[18]) + "))\n",
  ";(at 19 (= (Energy_Tariff)" + str(Hourly_Price[19]) + "))\n",
  "(at 20 (= (Energy_Tariff)" + str(Hourly_Price[20]) + "))\n",
  ";(at 21 (= (Energy_Tariff)" + str(Hourly_Price[21]) + "))\n",
  ";(at 22 (= (Energy_Tariff)" + str(Hourly_Price[22]) + "))\n",
  "(at 23 (= (Energy_Tariff)" + str(Hourly_Price[23]) + "))\n",
  ";(at 24 (= (Energy_Tariff)" + str(Hourly_Price[23]) + "))\n",

  "\n",

  ";;;_____________________________Occupancy Schedule_______________________________;;;\n",

  "\n",

  "(not(Occupied)) \n",
  "(NotOccupied)\n",

  "\n",

  ";(at 8.05 (Occupied)) \n",
  ";(at 9 (Occupied))\n",
  ";(at 11 (not(Occupied)))\n",
  ";(at 12 (Occupied))\n",
  ";(at 13 (Occupied))\n",
  "(at 14.0 (Occupied))\n",
  "(at 18 (not(Occupied)))\n",

  "\n",

  ";(at 8.05 (not(NotOccupied)))\n",
  ";(at 9 (not(NotOccupied)))\n",
  ";(at 11 (NotOccupied))\n",
  ";(at 12 (not(NotOccupied)))\n",
  ";(at 13 (not(NotOccupied)))\n",
  "(at 14.0 (not(NotOccupied)))\n",
  "(at 18 (NotOccupied))\n",

  "\n",

  ";;;_________________________________Semaphore_____________________________;;;\n",

  "\n",

  "(speaking_Lights)\n",
  "(speaking_Uncontrollable_Loads)\n",
  "(speaking_Battery)\n",
  "(speaking_NotWorkingDay)\n",
  "(speaking_HVAC)\n",
  "(=(AllUncontrollableLoads)0)\n",
  "\n",



  

  ";;;_________________________________________HVAC _______________________________________;;;\n",

  "\n",

  "(= (TempDecreaseRate)0.5)\n",

  "\n", 
           
  "(= (TempIncreaseRate_HighPrice_Occupied_NotTempRange)0.8)\n",
  "(= (TempIncreaseRate_HighPrice_NotOccupied)0.5)\n",
  "(= (HeavyControllableDependentLoad)0)\n",
  "\n",

  "(= (TempIncreaseRate_NominalPrice_Occupied_TempRange)0.7)\n",
  "(= (TempIncreaseRate_NominalPrice_Occupied_NotTempRange)0.9)\n",
  "(= (TempIncreaseRate_NominalPrice_NotOccupied)0.7)\n",
  "(= (BuildingHVAC)2)\n",
  "\n",

  "(= (TempIncreaseRate_LowPrice)0.99)\n",

  "\n",

  "(= (comfort-max-limit)28)\n",
  "(= (comfort-min-limt)23)\n",
  "(= (current-temp)25)\n",

  "\n",

  ";;;___________________________Lights (Natural Light Schedule______________________________;;;\n",

  "\n",
"(= (OrdinaryLights)2)\n",
"(= (NaturalLightLevel)0)  ;; 1 Low\n",
"(= (ControllableDependentLightLoad)0)\n",
"(at 14.0 (= (NaturalLightLevel)0)) ;; 0 High\n",
"(at 17 (= (NaturalLightLevel)1)) ;; 1 Low\n",

  "\n",

  ";;;_________________________________Battery variables_________________________________;;;\n",

  "\n",
  "(= (BatteryBank)3)\n",
  "(= (Battery_SOC_Percentage)40) \n", 
  "(= (EnergyBackupCapacity)0)\n",
  "(= (Battery_Recharge_Rate)10)  \n",
  "(= (Battery_Discharge_Rate_NominalPrice)4)  \n",
  "(= (Battery_Discharge_Rate_HighPrice)7)  \n",

  "\n",

  ")\n",

  "\n",

  "(:goal (and\n",

  "\n",  
     
  " (done)   \n",

  "\n",

  ")\n",

  "\n",

  ")\n",
  ")\n",

  ]

  # Creating a new file and writing the PDDL structure to it
  with open("Problem1.2.pddl", "w") as file:
    file.writelines(pddl_Problem_File)
  
  print("Problem file 1.2 generated")


#############################################################################################################
# Occupied = input("Is Building Occupied? (yes/no)")
# InTempRangeRange = input("Is Building Temperaure within Comfortable Range? (yes/no)")
# HighNaturalLight = input("Is there High Natural Light outside? (yes/no)")

Hourly_Price= DayAheadPrice_DataFilteration()
ProblemFile1_Generation(Hourly_Price)
ProblemFile2_Generation(Hourly_Price)

print("Now Generating a plan using Planner POPF-TIF")
print("Please Wait...")

ProblemFIle1 = "./popf3-clp domain.pddl Problem1.1.pddl" 
ProblemFIle2 = "./popf3-clp domain.pddl Problem1.2.pddl" 

Plan1 = "Day_Ahead_Plan1.1.plan" 
Plan2 = "Day_Ahead_Plan1.2.plan" 

terminal = "gnome-terminal" 

with open(Plan1, "w") as f:
  subprocess.call(f"{ProblemFIle1} > {Plan1 }", shell=True)
  
print("Generating...")
  
with open(Plan2, "w") as f:
  subprocess.call(f"{ProblemFIle2} > {Plan2 }", shell=True)

print(" Day Ahead Plan file Generated")
