-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2022-07-06 18:31:06.041

-- foreign keys
ALTER TABLE currency_rate
    DROP CONSTRAINT currency_rate_base_currency;

ALTER TABLE currency_rate
    DROP CONSTRAINT currency_rate_currency;

ALTER TABLE currency_used
    DROP CONSTRAINT currency_used_country;

ALTER TABLE currency_used
    DROP CONSTRAINT currency_used_currency;

ALTER TABLE current_inventory
    DROP CONSTRAINT current_inventory_item;

ALTER TABLE current_inventory
    DROP CONSTRAINT current_inventory_trader;

ALTER TABLE item
    DROP CONSTRAINT item_currency;

ALTER TABLE offer
    DROP CONSTRAINT offer_item;

ALTER TABLE offer
    DROP CONSTRAINT offer_trader;

ALTER TABLE price
    DROP CONSTRAINT price_currency;

ALTER TABLE price
    DROP CONSTRAINT price_item;

ALTER TABLE report
    DROP CONSTRAINT report_currency;

ALTER TABLE report
    DROP CONSTRAINT report_item;

ALTER TABLE trade
    DROP CONSTRAINT trade_buyer;

ALTER TABLE trade
    DROP CONSTRAINT trade_item;

ALTER TABLE trade
    DROP CONSTRAINT trade_offer;

ALTER TABLE trade
    DROP CONSTRAINT trade_seller;

ALTER TABLE trader
    DROP CONSTRAINT trader_country;

ALTER TABLE trader
    DROP CONSTRAINT trader_currency;

-- tables
DROP TABLE country;

DROP TABLE currency;

DROP TABLE currency_rate;

DROP TABLE currency_used;

DROP TABLE current_inventory;

DROP TABLE item;

DROP TABLE offer;

DROP TABLE price;

DROP TABLE report;

DROP TABLE trade;

DROP TABLE trader;

-- End of file.

