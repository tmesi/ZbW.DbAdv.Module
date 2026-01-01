DROP TABLE sales;
CREATE TABLE sales
(
	id			INTEGER			NOT NULL,
	month		VARCHAR(MAX)	NOT NULL,
	net_sales	DECIMAL(10, 2) NOT NULL,
	PRIMARY KEY (id)
);

INSERT INTO sales (id,  month, net_sales) values (1,  '201901', 2015.5);
INSERT INTO sales (id,  month, net_sales) values (2,  '201902', 3515.0);
INSERT INTO sales (id,  month, net_sales) values (3,  '201903', 3621.9);
INSERT INTO sales (id,  month, net_sales) values (4,  '201904', 4119.5);
INSERT INTO sales (id,  month, net_sales) values (5,  '201905', 2915.7);
INSERT INTO sales (id,  month, net_sales) values (6,  '201906', 3615.3);
INSERT INTO sales (id,  month, net_sales) values (7,  '201907', 3313.6);
INSERT INTO sales (id,  month, net_sales) values (8,  '201908', 4015.3);
INSERT INTO sales (id,  month, net_sales) values (9,  '201909', 7014.3);
INSERT INTO sales (id,  month, net_sales) values (10,  '201910', 1914.6);
INSERT INTO sales (id,  month, net_sales) values (11,  '201911', 2622.1);
INSERT INTO sales (id,  month, net_sales) values (12,  '201912', 2422.6);

SELECT	month,
		net_sales,
		LAG(net_sales, 1) OVER (ORDER BY month) x
FROM	sales;

