import requests
from datetime import date
import xml.etree.ElementTree as ET

def GetDayAheadPrices():
    # Get the day ahead prices for the next 24 hours
    
    ###_________________________Variable Declaration__________________________###
    Hour = list()              ## list to store day ahead hours and prices  
    Price = list()
    Data={}                   ## Data contain Day Ahead Prices 

    ###________________________Current Date__________________________###

    today = date.today()     ## Date today
    Date = today.strftime("%Y-%m-%d")
    print("Date Today:",Date, "\n")

    ###_______________Day Ahead Prices REST API Parameters_____________###

    Token = "b03ae798-050a-472c-b66e-f064349b36fd"
    #Timeinterval = "2022-10-13T00:00Z/2022-10-13T20:00Z"   ## YYYY-MM-DDT00:00Z
    Timeinterval= Date+"T00:00Z""/"+Date+"T20:00Z"

    ###______________________GET Day Ahead Prices_________________________###

    api_url = f"https://web-api.tp.entsoe.eu/api?securityToken={Token}&in_Domain=10Y1001A1001A82H&out_Domain=10Y1001A1001A82H&documentType=A44&TimeInterval={Timeinterval}"
    response = requests.get(api_url)
    #print("Response from API in XML format:","\n","\n",response.text,"\n")
    response = ET.fromstring(response.text)

    ###__________________________Data Filteration____________________________###


    for position in response.findall('.//{urn:iec62325.351:tc57wg16:451-3:publicationdocument:7:0}position'):
        Hour.append(position.text)    ## push all the hours into the list   
    
    for value in response.findall('.//{urn:iec62325.351:tc57wg16:451-3:publicationdocument:7:0}price.amount'):
        Price.append(value.text)      ## push all the prices into the list 
    
    del Hour[0:96] 
    del Price[0:96]

    for X in range(len(Hour)):
        Data[Hour[X]]=Price[X]      ## dictionary contain prices against hours
    
    
    ###__________________________Data contain Hourly Day ahead prices in [EUR/MWH]____________________________###    
    #print("Hourly Day Ahead Prices of Germany in [EUR/MWH]","\n",Data,"\n")    
    return Data

def DayAheadPrice_DataFilteration():
    
    i=0
    Hourly_Price =[]
    Data=GetDayAheadPrices()
    Hourly_Prices=list(Data.values())


    Hourly_Prices = list(map(float,Hourly_Prices))
    print(Hourly_Prices)  
    
    max_value = max(Hourly_Prices)
    min_value = min(Hourly_Prices)
    Avg1 = min_value + 25.0
    Avg2 = max_value - 17.0

    print("Max value:", max_value)
    print("Min value:", min_value)

    while i < len(Hourly_Prices):
    # print(Hourly_Prices[i])
        if (Hourly_Prices[i]) <= Avg1:
          Hourly_Price.append(2)    ## 2 is the lowest price
        elif (Hourly_Prices[i]) > Avg1 and (Hourly_Prices[i]) <= Avg2:
          Hourly_Price.append(1)   ## 1 is the Nominal price
        else:
            Hourly_Price.append(0)   ## 0 is the highest price
      
        i = i + 1
    print(Hourly_Price)
    Hourly_Price =[2,2,2,2,2,2,1,0,0,1,2,2,2,2,2,2,1,1,0,0,1,1,1,1,1]
    return Hourly_Price
