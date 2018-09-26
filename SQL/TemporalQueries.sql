SHOW databases;
USE TaxiTest;
SHOW TABLES;

DESCRIBE Address;
SELECT * FROM Address;

DESCRIBE Car;
SELECT * FROM Car;

SELECT * FROM insurance;
SELECT idCar, Lisense, Mark, Model from insurance, car where insurance.idInsurance = car.insurance_idInsurance ;

DESCRIBE Driver;
SELECT * FROM Driver;

SELECT idDriver, idCar, ROUND(RAND() * 1000) as AddressId, ROUND(RAND()) as Available FROM Driver JOIN Car WHERE Driver.isDeleted = 1;
SELECT idDriver, ROUND(RAND() * 1000), ROUND(RAND()) FROM Driver, Car;
DESCRIBE Taxi;
SELECT * FROM Taxi;
SELECT COUNT(*) FROM Taxi;

DESCRIBE Operator; 
SELECT COUNT(*) FROM Operator;

DESCRIBE `Client`;
SELECT * FROM `Client`;

SHOW CREATE TABLE PhoneCall;
DESCRIBE PhoneCall;
SELECT * FROM PhoneCall;
DELETE FROM PhoneCall WHERE idCall > 1000 	;
INSERT INTO PhoneCall (idCall, Operator_idOperator, Client_idClient, Duration) VALUES (1, 49, 1071, 93);

DESCRIBE PaymentService;
SELECT * FROM PaymentService;
INSERT INTO PaymentService (idPaymentService, Name, Address, Site) VALUES (0, 'CashService', 'NoAddress', 'NoSite');

DESCRIBE Payment;
SELECT * FROM Payment;	
DELETE FROM Payment WHERE idPayment > 0;

DESCRIBE Orders;
SELECT * FROM Orders;	
DELETE FROM Orders WHERE idOrder > 0;

SELECT idOrder, Call_idCall, Taxi_idTaxi, Car_idCar StartDatetime, FinishDatetime, Cost, Rate FROM (
	SELECT idOrder, Call_idCall, Taxi_idTaxi, StartDatetime, FinishDatetime, Cost, Rate FROM Order WHERE idOrder IN (
		SELECT idOrder FROM PhoneCall Left JOIN Orders ON PhoneCall.idCall = Orders.Call_idCall WHERE Client_idClient IN (
			SELECT idClient FROM Client WHERE Phone='+7(726)5384089'
		)
	) AND StartDatetime > '2018-01-03 00:00:00' AND FinishDatetime < '2018-05-01 00:00:00'
) AS T2 JOIN Taxi ON T2.Taxi_idTaxi = Taxi.idTaxi;

SELECT idOrder, Call_idCall, Taxi_idTaxi, Car_idCar, Lisense, Model, Mark, StartDatetime, FinishDatetime, Cost, Rate FROM (
	SELECT idOrder, Call_idCall, Taxi_idTaxi, Car_idCar, StartDatetime, FinishDatetime, Cost, Rate FROM (
		SELECT idOrder, Call_idCall, Taxi_idTaxi, StartDatetime, FinishDatetime, Cost, Rate FROM Orders WHERE idOrder IN (
			SELECT idOrder FROM PhoneCall Left JOIN Orders ON PhoneCall.idCall = Orders.Call_idCall WHERE Client_idClient IN (
				SELECT idClient FROM Client WHERE Phone='+7(726)5384089'
			)
		) AND StartDatetime > '2018-01-03 00:00:00' AND FinishDatetime < '2018-05-01 00:00:00'
	) AS T2 JOIN Taxi ON T2.Taxi_idTaxi = Taxi.idTaxi
) AS T3 JOIN Car ON Car.idCar = T3.Car_idCar;
