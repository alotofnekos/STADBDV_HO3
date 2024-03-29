CREATE TABLE Accounts(id INT AUTO_INCREMENT PRIMARY KEY, amount INT);

INSERT INTO Accounts (amount) VALUES (100);
INSERT INTO Accounts (amount) VALUES (200);

SET autocommit = OFF;

-- Isolation levels
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;



-- Update after every pass 
UPDATE Accounts SET amount = 200 WHERE id=2;
Commit;
#dirty read
-- Transaction 1
  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
START TRANSACTION;
UPDATE Accounts SET amount = '300' WHERE id=2;
DO SLEEP(10); -- Delay 
COMMIT;

-- Transaction 2
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SELECT * FROM Accounts WHERE id=2;
