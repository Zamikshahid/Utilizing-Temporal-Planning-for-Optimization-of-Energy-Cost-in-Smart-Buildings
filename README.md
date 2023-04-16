# Utilizing-Temporal-Planning-for-Optimization-of-Energy-Cost-in-Smart-Buildings

## Introduction:

This project is focused on using Artificial Intelligence (AI) planning to address the building coordination problem, specifically through the concept of Demand-side Management (DSM). DSM involves optimizing energy cost while maintaining occupant comfort and productivity through sequences of actions executed to reduce energy consumption. This project utilizes temporal planning, a subfield of AI planning that deals with problems that require actions to be executed at specific times or for specific durations.

## Project Description:

The project's main objective is to develop a generic day-ahead scheduling plan that can be applied to any commercial building. This plan is created by integrating day-ahead energy prices and building environmental data, including occupancy, outside natural light, current temperature, and operating hours. The Planning Domain Definition Language (PDDL) is used to model the problem and domain, and the temporal planning versions PDDL 2.1 and PDDL 2.2 are used to model the planning problem. These languages are equipped to handle numeric fluent constraints that can change at any future point in time using Timed Initial Fluent (TIF) and Timed Initial Literal (TIL) to change predicate values. The inclusion of durative actions, which represent actions that have a duration or take place over time, allows the plan to effectively optimize energy usage while ensuring the comfort and productivity of the building occupants.

The proposed model utilizes the Partial Order Planning Forwards – TIF (POPF-TIF) planner, which can solve TIFs and TILs, to generate a plan for reducing energy consumption and optimizing energy costs in any commercial building. The entire process is automated, from taking day-ahead prices and environmental data to generating the problem file, which is used to generate a 24-hour day-ahead plan saved in a .plan file.

## Results:

The proposed model achieves an average cost reduction of 41% during weekdays and 45% during weekends while maintaining occupant comfort and safety. The results demonstrate the effectiveness of the temporal planning approach in reducing energy consumption and operational costs. The model can be applied to any commercial building, making it a useful tool for stakeholders to promote sustainability and reduce energy costs.

## Conclusion:

In conclusion, the proposed model utilizing temporal planning provides a potential solution to address the building coordination problem and DSM. The model has been demonstrated to effectively reduce energy consumption and costs while maintaining occupant comfort and productivity. This model can be applied to any commercial building, making it a useful tool for promoting sustainability and reducing energy costs.

## Installation and run:

To get started with this project, first clone the repository onto your local machine using the following command:

git clone: https://github.com/Zamikshahid/Utilizing-Temporal-Planning-for-Optimization-of-Energy-Cost-in-Smart-Buildings.git

This project requires the following software to be installed on your machine:

•	A Linux operating system as the planner runs on Linux

•	Python 3.x

•	The PDDL temporal planner POPF-TIF from https://github.com/popftif/popf-tif

Running the project is straightforward. Simply navigate to the "Code" folder and run the "ProblemFile_Generation.py" file using the following command:
                         
```sh
 python3 ProblemFile_Generation.py
```


This project is fully automated, which means that upon executing the "ProblemFile_Generation.py" file, the script will take required inputs such as occupancy, day-ahead prices, and weather conditions, generate the problem file, and then run this problem file and domain file on the POPF planner. Finally, it will return the day-ahead plan.

