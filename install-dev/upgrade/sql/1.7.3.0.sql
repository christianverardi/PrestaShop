SET SESSION sql_mode = '';
SET NAMES 'utf8';

UPDATE `PREFIX_tab` SET `position` = 0 WHERE `class_name` = 'AdminZones' AND `position` = '1';
UPDATE `PREFIX_tab` SET `position` = 1 WHERE `class_name` = 'AdminCountries' AND `position` = '0';

/* PHP:ps_1730_add_quick_access_evaluation_catalog(); */;

/* PHP:ps_1730_move_some_aeuc_configuration_to_core(); */;

ALTER TABLE `PREFIX_product` ADD `low_stock_threshold` INT(10) NULL DEFAULT NULL AFTER `minimal_quantity`;
ALTER TABLE `PREFIX_product_shop` ADD `low_stock_threshold` INT(10) NULL DEFAULT NULL AFTER `minimal_quantity`;

ALTER TABLE `PREFIX_product_attribute` ADD `low_stock_threshold` INT(10) NULL DEFAULT NULL AFTER `minimal_quantity`;
ALTER TABLE `PREFIX_product_attribute_shop` ADD `low_stock_threshold` INT(10) NULL DEFAULT NULL AFTER `minimal_quantity`;

UPDATE `PREFIX_configuration` SET `value` = 'id_shop;id_currency;id_zone;id_country;id_group', `date_upd` = NOW() WHERE `name` = 'PS_SPECIFIC_PRICE_PRIORITIES';
ALTER TABLE `PREFIX_specific_price` ADD `id_zone` int(10) UNSIGNED NOT NULL AFTER `id_country`;
ALTER TABLE `PREFIX_specific_price` DROP INDEX `id_product_2`, ADD UNIQUE INDEX `id_product_2` (`id_product`,`id_product_attribute`,`id_customer`,`id_cart`,`from`,`to`,`id_shop`,`id_shop_group`,`id_currency`,`id_country`,`id_zone`,`id_group`,`from_quantity`,`id_specific_price_rule`);
ALTER TABLE `PREFIX_specific_price` DROP INDEX `id_product`, ADD INDEX `id_product` (`id_product`,`id_shop`,`id_currency`,`id_country`,`id_zone`,`id_group`,`id_customer`,`from_quantity`,`from`,`to`);
