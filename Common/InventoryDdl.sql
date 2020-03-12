DELETE FROM PRODUCT;

DELETE FROM SUPPLIER;

DROP TABLE PRODUCT;

DROP TABLE SUPPLIER;

CREATE TABLE PRODUCT (
		SKU INTEGER NOT NULL generated by default as identity,
		INSTOCK INTEGER,
		VERSION INTEGER,
		SUPP_ID INTEGER
	);

ALTER TABLE PRODUCT ADD CONSTRAINT PRODUCT_PK PRIMARY KEY (SKU);

CREATE TABLE SUPPLIER (
		SUPP_ID INTEGER NOT NULL,
		NAME VARCHAR (50)
);

ALTER TABLE SUPPLIER ADD CONSTRAINT SUPPLIER_PK PRIMARY KEY (SUPP_ID);

ALTER TABLE PRODUCT	ADD CONSTRAINT PRODUCT_FK FOREIGN KEY

		(SUPP_ID)

	REFERENCES SUPPLIER

		(SUPP_ID);

