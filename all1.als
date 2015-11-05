abstract sig Person{
}


sig Passenger extends Person{
}

sig Driver extends Person{
license: one Int,
drives: lone Taxi
}{license>0}

sig Taxi{
id: one Int
}{id>0}

sig Request{
madeby: one Person,
madefor: one Ride
}

sig lat{}

sig long{}

sig Ride{
client: one Passenger,
driver: one Driver,
start: one Location,
end: one Location,
}

sig Location{
inarea: one Area,
lat: one lat,
long: one long
}

sig Area{
}

fact NoSameLicenseDrivers{
//no drivers with same license
(no d1,d2 : Driver | d1.license=d2.license and d1!=d2)
}

fact NoSameIDTaxis{
//no taxis with same ID
(no t1,t2 : Taxi | t1.id=t2.id and t1!=t2)
}

fact NoDriverInTwoTaxis{
//No drivers can be in two different taxis at once
(no d1, d2 : Driver, t1, t2 : Taxi | d1=d2 and t1!= t2 and d1.drives=t1 and d2.drives=t2)
}

fact noTwoDriversInTaxi{
//Two drivers can't drive the same taxi
(no d1, d2: Driver, t1, t2: Taxi | d1!=d2 and t1=t2 and d1.drives=t1 and d2.drives=t2)
}

fact noLocationInTwoAreas{
//No location must be in two different areas
(no l1,l2: Location, a1, a2: Area | l1.inarea=a1 and l2.inarea=a2  and a1!=a2 and l1=l2)
}

fact noClosedPathRides{
//Rides start and end in different places
 (no l1,l2: Location, r: Ride | r.start=l1 and r.end=l2 and l1=l2)
}

fact NoDiffLocationsSameCoords{
//Locations that are different must have different coordinates
(no l1,l2: Location | l1!=l2 and l1.lat=l2.lat and l1.long =l2.long)
}


assert allLocationsInAreas{
(all l: Location | #l.inarea=1)
}
check allLocationsInAreas


pred show{
}

pred showMultiRidesForAPassenger{
#Passenger = 1
#Ride >1
}

pred showMultiplePassengers{
#Passenger>1
}


run show for 8 
run showMultiRidesForAPassenger for 5
run showMultiplePassengers for 4 
