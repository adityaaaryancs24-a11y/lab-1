CREATE DATABASE supp;
USE supp;

CREATE TABLE Supplier (
  sid INT PRIMARY KEY,
  sname VARCHAR(50),
  city VARCHAR(50)
);

CREATE TABLE Parts (
  pid INT PRIMARY KEY,
  pname VARCHAR(50),
  color VARCHAR(20)
);

CREATE TABLE Catalog (
  sid INT,
  pid INT,
  cost DECIMAL(10,2),
  PRIMARY KEY (sid, pid),
  FOREIGN KEY (sid) REFERENCES Supplier(sid),
  FOREIGN KEY (pid) REFERENCES Parts(pid)
);

INSERT INTO Supplier VALUES
(10001,'Acme Widget','Bangalore'),
(10002,'Johns','Kolkata'),
(10003,'Vimal','Mumbai'),
(10004,'Reliance','Delhi'),
(10005,'Mahindra','Mumbai');

INSERT INTO Parts VALUES
(20001,'Book','Red'),
(20002,'Pen','Red'),
(20003,'Pencil','Green'),
(20004,'Mobile','Green'),
(20005,'Charger','Black');

DELETE FROM Catalog;

INSERT INTO Catalog VALUES
(10001,20001,10),(10001,20002,10),(10001,20003,30),(10001,20004,10),(10001,20005,10),
(10002,20001,10),(10002,20002,20),
(10003,20003,30),
(10004,20003,40);

-- Queries
SELECT DISTINCT pname 
FROM Parts 
WHERE pid IN (SELECT pid FROM Catalog);

SELECT sname 
FROM Supplier s
WHERE NOT EXISTS (
  SELECT pid FROM Parts 
  WHERE pid NOT IN (SELECT pid FROM Catalog WHERE sid = s.sid)
);

SELECT sname 
FROM Supplier s
WHERE NOT EXISTS (
  SELECT pid FROM Parts 
  WHERE color='Red' 
  AND pid NOT IN (SELECT pid FROM Catalog WHERE sid = s.sid)
);

SELECT pname 
FROM Parts 
WHERE pid IN (
  SELECT pid FROM Catalog 
  WHERE sid = (SELECT sid FROM Supplier WHERE sname='Acme Widget')
)
AND pid NOT IN (
  SELECT pid FROM Catalog 
  WHERE sid != (SELECT sid FROM Supplier WHERE sname='Acme Widget')
);

SELECT DISTINCT c.sid 
FROM Catalog c
JOIN (
  SELECT pid, AVG(cost) AS avg_cost 
  FROM Catalog GROUP BY pid
) avg_table ON c.pid = avg_table.pid
WHERE c.cost > avg_table.avg_cost;

SELECT p.pname, p.pid, s.sname 
FROM Parts p
JOIN Catalog c ON p.pid=c.pid
JOIN Supplier s ON c.sid=s.sid
WHERE (p.pid, c.cost) IN (
  SELECT pid, MAX(cost) FROM Catalog GROUP BY pid
);
	