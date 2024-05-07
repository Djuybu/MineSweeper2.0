DROP TABLE IF EXISTS customer, product, region, store, return, transaction, calendar CASCADE;

CREATE TABLE customer (
  customer_id INT PRIMARY KEY,
  customer_acct_num BIGINT,
  first_name VARCHAR(30) NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  customer_address VARCHAR(40),
  customer_city VARCHAR(30),
  customer_state_province VARCHAR(30),
  customer_postal_code INT,
  customer_country VARCHAR(12),
  birthdate VARCHAR(10),
  marital_status VARCHAR(1),
  yearly_income VARCHAR(15),
  gender VARCHAR(2),
  total_children INT,
  num_children_at_home INT,
  education VARCHAR(35),
  acct_open_date VARCHAR(12),
  member_card VARCHAR(10),
  occupation VARCHAR(20),
  homeowner VARCHAR(1)
);

CREATE TABLE product (
  product_id INT PRIMARY KEY,
  product_brand VARCHAR(20) NOT NULL,
  product_name VARCHAR(100) NOT NULL,
  product_sku BIGINT UNIQUE,
  product_retail_price DOUBLE PRECISION,
  product_cost DOUBLE PRECISION,
  product_weight DOUBLE PRECISION,
  recyclable INT,
  low_fat INT
);

CREATE TABLE region (
  region_id INT PRIMARY KEY,
  sales_district VARCHAR(20),
  sales_region VARCHAR(30)
);

CREATE TABLE store (
  store_id INT PRIMARY KEY,
  region_id INT,
  store_type VARCHAR(20),
  store_name VARCHAR(12) NOT NULL,
  store_street_address VARCHAR(30),
  store_city VARCHAR(20),
  store_state VARCHAR(15),
  store_country VARCHAR(20),
  store_phone VARCHAR(13),
  first_opened_date VARCHAR(15),
  last_remodel_date VARCHAR(15),
  total_sqft INT,
  grocery_sqft INT,
  FOREIGN KEY (region_id) REFERENCES region(region_id)
);

CREATE TABLE return (  
  return_date VARCHAR(13),
  product_id INT, 
  store_id INT,
  quantity INT,
  FOREIGN KEY (product_id) REFERENCES product(product_id),
  FOREIGN KEY (store_id) REFERENCES store(store_id)
);

CREATE TABLE transaction (
  transaction_date VARCHAR(13),
  stock_date VARCHAR(13),
  product_id INT,
  store_id INT,
  customer_id INT,
  quantity INT,
  FOREIGN KEY (product_id) REFERENCES product(product_id),
  FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE calendar (
  date_num VARCHAR(13) PRIMARY KEY
);

ALTER TABLE transaction
  ADD CONSTRAINT fk_transaction_date FOREIGN KEY (transaction_date) REFERENCES calendar(date_num);

ALTER TABLE return
  ADD CONSTRAINT fk_return_date FOREIGN KEY (return_date) REFERENCES calendar(date_num);
END; 
COPY calendar (date_num) FROM 'C:\Users\macmi\temps\calendar.csv' WITH DELIMITER ',' CSV HEADER;
  
COPY customer (customer_id, customer_acct_num, first_name, last_name, customer_address, 
                customer_city, customer_state_province, customer_postal_code, 
                customer_country, birthdate, marital_status, yearly_income, gender, 
                total_children, num_children_at_home, education, acct_open_date, 
                member_card, occupation, homeowner)
				
FROM 'C:\Users\macmi\temps\customer.csv' WITH DELIMITER  ',' CSV HEADER;

COPY product (product_id, product_brand, product_name, product_sku, product_retail_price, product_cost, product_weight, recyclable, low_fat)
FROM 'C:\Users\macmi\temps\product.csv' WITH DELIMITER  ',' CSV HEADER;


COPY region (region_id, sales_district, sales_region) FROM 'C:\Users\macmi\temps\region.csv' WITH DELIMITER ',' CSV HEADER;

COPY store (store_id, region_id, store_type, store_name, store_street_address, store_city, store_state, store_country, store_phone, first_opened_date, last_remodel_date, total_sqft, grocery_sqft) 
FROM 'C:\Users\macmi\temps\store.csv' WITH DELIMITER  ',' CSV HEADER;

COPY return (return_date, product_id, store_id, quantity) FROM 'C:\Users\macmi\temps\return.csv' WITH DELIMITER ',' CSV HEADER;

COPY transaction (transaction_date, stock_date, product_id, customer_id, store_id, quantity) FROM 'C:\Users\macmi\temps\transaction.csv' WITH DELIMITER  ',' CSV HEADER;