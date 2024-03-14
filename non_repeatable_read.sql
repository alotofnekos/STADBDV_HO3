-- Do transaction 1 in one connection then do transaction 2 in another connection; To simulate multiple transactions

-- CREATE TABLE Accounts(id INT AUTO_INCREMENT PRIMARY KEY, amount INT) ENGINE = INNODB;

-- Sample data
-- INSERT INTO Accounts (amount) VALUES (100);
-- INSERT INTO Accounts (amount) VALUES (200);

SET autocommit = OFF;

-- Isolation levels; Change isolation level to check multiple cases
-- SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
-- SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
-- SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
-- SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- Update after every pass 
UPDATE Accounts SET amount = 200 WHERE id = 2;
COMMIT;

-- Transaction 1
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
START TRANSACTION;
SELECT * FROM Accounts WHERE id = 2;
DO SLEEP(10); -- Delay 
SELECT * FROM Accounts WHERE id = 2; -- Non-Repeatable Read
COMMIT;

-- Transaction 2
START TRANSACTION;
COMMIT;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
START TRANSACTION;
UPDATE Accounts SET amount = '300' WHERE id = 2;
DO SLEEP(10);  -- Add to READ UNCOMMITTED to show uncommited changes, Comment for other isolation levels
COMMIT;
