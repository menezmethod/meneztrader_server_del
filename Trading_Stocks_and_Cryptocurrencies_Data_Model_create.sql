-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2022-07-06 18:31:06.041

-- tables
-- Table: country
CREATE TABLE country (
    id int  NOT NULL,
    name varchar(128)  NOT NULL,
    CONSTRAINT country_ak_1 UNIQUE (name) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT country_pk PRIMARY KEY (id)
);

-- Table: currency
CREATE TABLE currency (
    id int  NOT NULL,
    code varchar(8)  NOT NULL,
    name varchar(128)  NOT NULL,
    is_active bool  NOT NULL,
    is_base_currency bool  NOT NULL,
    CONSTRAINT currency_ak_1 UNIQUE (code) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT currency_ak_2 UNIQUE (name) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT currency_pk PRIMARY KEY (id)
);

-- Table: currency_rate
CREATE TABLE currency_rate (
    id int  NOT NULL,
    currency_id int  NOT NULL,
    base_currency_id int  NOT NULL,
    rate decimal(16,6)  NOT NULL,
    ts timestamp  NOT NULL,
    CONSTRAINT currency_rate_pk PRIMARY KEY (id)
);

-- Table: currency_used
CREATE TABLE currency_used (
    id int  NOT NULL,
    country_id int  NOT NULL,
    currency_id int  NOT NULL,
    date_from date  NOT NULL,
    date_to date  NULL,
    CONSTRAINT currency_used_pk PRIMARY KEY (id)
);

-- Table: current_inventory
CREATE TABLE current_inventory (
    id int  NOT NULL,
    trader_id int  NOT NULL,
    item_id int  NOT NULL,
    quantity decimal(16,6)  NOT NULL,
    CONSTRAINT current_inventory_ak_1 UNIQUE (trader_id, item_id) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT current_inventory_pk PRIMARY KEY (id)
);

-- Table: item
CREATE TABLE item (
    id int  NOT NULL,
    code varchar(64)  NOT NULL,
    name varchar(255)  NOT NULL,
    is_active bool  NOT NULL,
    currency_id int  NOT NULL,
    details text  NULL,
    CONSTRAINT item_ak_1 UNIQUE (code) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT item_pk PRIMARY KEY (id)
);

-- Table: offer
CREATE TABLE offer (
    id int  NOT NULL,
    trader_id int  NOT NULL,
    item_id int  NOT NULL,
    quantity decimal(16,6)  NOT NULL,
    buy bool  NOT NULL,
    sell bool  NOT NULL,
    price decimal(16,6)  NULL,
    ts timestamp  NOT NULL,
    is_active bool  NOT NULL,
    CONSTRAINT offer_pk PRIMARY KEY (id)
);

-- Table: price
CREATE TABLE price (
    id int  NOT NULL,
    item_id int  NOT NULL,
    currency_id int  NOT NULL,
    buy decimal(16,6)  NOT NULL,
    sell decimal(16,6)  NOT NULL,
    ts timestamp  NOT NULL,
    CONSTRAINT price_pk PRIMARY KEY (id)
);

-- Table: report
CREATE TABLE report (
    id int  NOT NULL,
    trading_date date  NOT NULL,
    item_id int  NOT NULL,
    currency_id int  NOT NULL,
    first_price decimal(16,6)  NULL,
    last_price decimal(16,6)  NULL,
    min_price decimal(16,6)  NULL,
    max_price decimal(16,6)  NULL,
    avg_price decimal(16,6)  NULL,
    total_amount decimal(16,6)  NULL,
    quantity decimal(16,6)  NULL,
    CONSTRAINT report_ak_1 UNIQUE (trading_date, item_id, currency_id) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT report_pk PRIMARY KEY (id)
);

-- Table: trade
CREATE TABLE trade (
    id int  NOT NULL,
    item_id int  NOT NULL,
    seller_id int  NULL,
    buyer_id int  NOT NULL,
    qunatity decimal(16,6)  NOT NULL,
    unit_price decimal(16,6)  NOT NULL,
    description text  NOT NULL,
    offer_id int  NOT NULL,
    CONSTRAINT trade_pk PRIMARY KEY (id)
);

-- Table: trader
CREATE TABLE trader (
    id int  NOT NULL,
    first_name varchar(64)  NOT NULL,
    last_name varchar(64)  NOT NULL,
    user_name varchar(64)  NOT NULL,
    password varchar(64)  NOT NULL,
    email varchar(128)  NOT NULL,
    confirmation_code varchar(128)  NOT NULL,
    time_registered timestamp  NOT NULL,
    time_confirmed timestamp  NOT NULL,
    country_id int  NOT NULL,
    preferred_currency_id int  NOT NULL,
    CONSTRAINT trader_ak_1 UNIQUE (user_name, email) NOT DEFERRABLE  INITIALLY IMMEDIATE,
    CONSTRAINT trader_pk PRIMARY KEY (id)
);

-- foreign keys
-- Reference: currency_rate_base_currency (table: currency_rate)
ALTER TABLE currency_rate ADD CONSTRAINT currency_rate_base_currency
    FOREIGN KEY (base_currency_id)
    REFERENCES currency (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: currency_rate_currency (table: currency_rate)
ALTER TABLE currency_rate ADD CONSTRAINT currency_rate_currency
    FOREIGN KEY (currency_id)
    REFERENCES currency (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: currency_used_country (table: currency_used)
ALTER TABLE currency_used ADD CONSTRAINT currency_used_country
    FOREIGN KEY (country_id)
    REFERENCES country (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: currency_used_currency (table: currency_used)
ALTER TABLE currency_used ADD CONSTRAINT currency_used_currency
    FOREIGN KEY (currency_id)
    REFERENCES currency (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: current_inventory_item (table: current_inventory)
ALTER TABLE current_inventory ADD CONSTRAINT current_inventory_item
    FOREIGN KEY (item_id)
    REFERENCES item (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: current_inventory_trader (table: current_inventory)
ALTER TABLE current_inventory ADD CONSTRAINT current_inventory_trader
    FOREIGN KEY (trader_id)
    REFERENCES trader (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: item_currency (table: item)
ALTER TABLE item ADD CONSTRAINT item_currency
    FOREIGN KEY (currency_id)
    REFERENCES currency (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: offer_item (table: offer)
ALTER TABLE offer ADD CONSTRAINT offer_item
    FOREIGN KEY (item_id)
    REFERENCES item (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: offer_trader (table: offer)
ALTER TABLE offer ADD CONSTRAINT offer_trader
    FOREIGN KEY (trader_id)
    REFERENCES trader (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: price_currency (table: price)
ALTER TABLE price ADD CONSTRAINT price_currency
    FOREIGN KEY (currency_id)
    REFERENCES currency (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: price_item (table: price)
ALTER TABLE price ADD CONSTRAINT price_item
    FOREIGN KEY (item_id)
    REFERENCES item (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: report_currency (table: report)
ALTER TABLE report ADD CONSTRAINT report_currency
    FOREIGN KEY (currency_id)
    REFERENCES currency (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: report_item (table: report)
ALTER TABLE report ADD CONSTRAINT report_item
    FOREIGN KEY (item_id)
    REFERENCES item (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: trade_buyer (table: trade)
ALTER TABLE trade ADD CONSTRAINT trade_buyer
    FOREIGN KEY (buyer_id)
    REFERENCES trader (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: trade_item (table: trade)
ALTER TABLE trade ADD CONSTRAINT trade_item
    FOREIGN KEY (item_id)
    REFERENCES item (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: trade_offer (table: trade)
ALTER TABLE trade ADD CONSTRAINT trade_offer
    FOREIGN KEY (offer_id)
    REFERENCES offer (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: trade_seller (table: trade)
ALTER TABLE trade ADD CONSTRAINT trade_seller
    FOREIGN KEY (seller_id)
    REFERENCES trader (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: trader_country (table: trader)
ALTER TABLE trader ADD CONSTRAINT trader_country
    FOREIGN KEY (country_id)
    REFERENCES country (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: trader_currency (table: trader)
ALTER TABLE trader ADD CONSTRAINT trader_currency
    FOREIGN KEY (preferred_currency_id)
    REFERENCES currency (id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

