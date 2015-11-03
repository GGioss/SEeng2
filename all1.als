 abstract sig Person{
}

sig License{
}

sig TaxiID{
}

some sig Passenger extends Person{
}

some sig Driver extends Person{
license: one License,
drives: lone Taxi
}

some sig Taxi{
id: one TaxiID
}

sig Request{
reqfor: some Ride,
from: one Passenger
}

sig Ride{
origin: one Request,
client: one Passenger,
driver: one Driver,
start: one Location,
end: one Location,
}

sig Location{
inarea: one Area
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
//we assume no drivers can be in two different taxis at once
(no d1, d2 : Driver, t1, t2 : Taxi | d1=d2 and t1!= t2 and d1.drives=t1 and d2.drives=t2)
}

fact noTwoDriversInTaxi{
//two drivers can't drive the same taxi
(no d1, d2: Driver, t1, t2: Taxi | d1!=d2 and t1=t2 and d1.drives=t1 and d2.drives=t2)
}

fact noLocationInTwoAreas{
//No Location must be in two different areas
(no l1,l2: Location, a1, a2: Area | l1.inarea=a1 and l2.inarea=a2  and a1!=a2 and l1=l2)
}

fact noClosedPathRides{
//Rides start and end in different places
(no l1,l2: Location, r: Ride | r.start=l1 and r.start=l2 and l1=l2)
}


pred show{}

run show for 10
