
CREATE TABLE IF NOT EXISTS `manufacturer`(
`id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
`manufacturer_name` varchar(255) NOT NULL,
`address` varchar(255) NOT NULL,
`telephone` varchar(255) NOT NULL,
PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `supplier`(
`id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
`supplier_name` varchar(255) NOT NULL,
`address` varchar(255) NOT NULL,
`telephone` varchar(255) NOT NULL,
PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `category`(
`id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
`category_name` varchar(255) NOT NULL,
PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `subcategory`(
`id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
`subcategory_name` varchar(255) NOT NULL,
PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `prescription_types`(
`id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
`prescription_name` varchar(255) NOT NULL,
PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `prescription_items` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `manufacturer_id` varchar(255) NOT NULL,
  `category_id` varchar(255) NOT NULL,
  `prescription_type_id` varchar(255) NOT NULL,
  `itemname` varchar(255) NOT NULL,
  `genericname` varchar(255) NOT NULL,
  `strength` varchar(255) NOT NULL,
  `dosageform` varchar(255) NOT NULL,
  `packagingtype` varchar(255) NOT NULL,
  `packsizes` varchar(255) NOT NULL,
  `countryofmanufacture` varchar(255) NOT NULL,
  `oldprice` varchar(255) NOT NULL,
  `newprice` varchar(255) NOT NULL,
  `stockstatus` varchar(255) NOT NULL,
  `discount_id` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
);



CREATE VIEW search_prescription_items AS 
SELECT 
      prescription_items.id,
      manufacturer.manufacturer_name,
      prescription_items.itemname,
      prescription_items.genericname,
      prescription_items.strength,
      prescription_items.dosageform,
      prescription_items.packsizes,
      prescription_items.oldprice,
      prescription_items.newprice,
      prescription_items.stockstatus,
      discounts.discount,
      prescription_types.prescription_name
FROM prescription_items 
INNER JOIN manufacturer 
ON prescription_items.manufacturer_id = manufacturer.id 
INNER JOIN discounts 
ON prescription_items.discount_id = discounts.id 
INNER JOIN prescription_types 
ON prescription_items.prescription_type_id = prescription_types.id; 


CREATE VIEW substitutes_count AS
SELECT genericname, COUNT(*)-1 AS substitutes FROM prescription_items GROUP BY genericname HAVING COUNT(*) >1;



CREATE TABLE IF NOT EXISTS `non_prescription_items` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `manufacturer_id` varchar(255) NOT NULL,
  `category_id` varchar(255) NOT NULL,
  `sub_category_id` varchar(255) NOT NULL,
  `itemname` varchar(255) NOT NULL,
  `strength` varchar(255) NOT NULL,
  `packagingtype` varchar(255) NOT NULL,
  `packsizes` varchar(255) NOT NULL,
  `oldprice` varchar(255) NOT NULL,
  `newprice` varchar(255) NOT NULL,
  `stockstatus` varchar(255) NOT NULL,
  `discount_id` varchar(255) NOT NULL,
  `imagename` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
);


CREATE TABLE IF NOT EXISTS `item_images` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `imagename` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `supplier_items` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `item_id` varchar(255) NOT NULL,
  `supplier_id` varchar(255) NOT NULL,
  `cost` varchar(255) NOT NULL,
  `stockstatus` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `discounts` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `discount` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `shipping_fees` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cost` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `customers` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `phonenumber` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `appusername` varchar(255) NOT NULL,
  `userpassword` varchar(255) NOT NULL,
  `postalcode_bill` varchar(255) NOT NULL,
  `address_bill` varchar(255) NOT NULL,
  `city_bill` varchar(255) NOT NULL,
  `state_bill` varchar(255) NOT NULL,
  `country_bill` varchar(255) NOT NULL,
  `postalcode_delivery` varchar(255) NOT NULL,
  `address_delivery` varchar(255) NOT NULL,
  `city_delivery` varchar(255) NOT NULL,
  `state_delivery` varchar(255) NOT NULL,
  `country_delivery` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
);



CREATE TABLE IF NOT EXISTS `cart` (
  `id` int(10)  UNSIGNED NOT NULL AUTO_INCREMENT,
  `item_id` varchar(255) NOT NULL,
  `quantity` varchar(255) NOT NULL,
  `amount` varchar(255) NOT NULL,
  `userid` varchar(255) NOT NULL,
  `cartstatus` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `contact_members` (
  `id` int(10)  UNSIGNED NOT NULL AUTO_INCREMENT,
  `userid` varchar(255) NOT NULL,
  `contact_how` varchar(255) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `reason_message` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `tbl_uploaded_pic`(
`_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
`_name` varchar(255) NOT NULL,
`user_name` varchar(255) NOT NULL,
PRIMARY KEY (`_id`)
);


CREATE VIEW cart_items_count AS
SELECT userid,cartstatus, COUNT(*) AS cartcount, SUM(amount) AS carttotal, cost AS shippingcost 
FROM cart,shipping_fees GROUP BY userid,cartstatus,cost;



CREATE VIEW cart_prescription_items_details AS
SELECT
    cart.id as cartid,
    prescription_items.itemname,
    prescription_items.genericname,
    prescription_items.strength,
    cart.quantity,
    prescription_items.newprice,
    cart.amount,
    cart.userid,
    cart.cartstatus,
    cart.created
FROM prescription_items
INNER JOIN cart
ON prescription_items.id =  cart.item_id;


FROM cart GROUP BY userid,cartstatus

