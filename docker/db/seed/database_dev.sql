CREATE DATABASE IF NOT EXISTS `coconu24_dev` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE USER 'coconut'@'127.0.0.1' IDENTIFIED BY 'coconut';
GRANT ALL PRIVILEGES ON *.* TO 'coconut'@'127.0.0.1';

CREATE USER 'coconut'@'localhost' IDENTIFIED BY 'coconut';
GRANT ALL PRIVILEGES ON *.* TO 'coconut'@'localhost' WITH GRANT OPTION;

CREATE USER 'coconut'@'%' IDENTIFIED BY 'coconut';
GRANT ALL PRIVILEGES ON *.* TO 'coconut'@'%' WITH GRANT OPTION;

FLUSH PRIVILEGES;

USE `coconu24_dev`

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;


-- --------------------------------------------------------

--
-- Table structure for table `accountingSettings`
--

CREATE TABLE `accountingSettings` (
  `vendorId` varchar(50) NOT NULL,
  `accountingMonthStartDay` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `accountingDayStartHour` tinyint(3) UNSIGNED NOT NULL DEFAULT 6,
  `differenceFromUTC` tinyint(4) NOT NULL DEFAULT 8
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `billingInfo`
--

CREATE TABLE `billingInfo` (
  `vendorId` varchar(50) NOT NULL,
  `addressLine1` varchar(100) NOT NULL,
  `addressLine2` varchar(100) NOT NULL,
  `operatedBy` varchar(100) NOT NULL,
  `companyNo` varchar(30) NOT NULL,
  `taxRate` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `taxName` varchar(15) DEFAULT 'SST',
  `serviceChargeRate` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `applyServiceChargeToTakeout` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `constants`
--

CREATE TABLE `constants` (
  `name` varchar(50) NOT NULL,
  `val` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `discounts`
--

CREATE TABLE `discounts` (
  `vendorId` varchar(50) NOT NULL,
  `id` int(11) UNSIGNED NOT NULL,
  `label` varchar(100) NOT NULL,
  `discountPercent` tinyint(3) UNSIGNED NOT NULL,
  `discountAbsolute` decimal(5,2) NOT NULL,
  `tags` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `financeOnetimeOperatingExpenses`
--

CREATE TABLE `financeOnetimeOperatingExpenses` (
  `vendorId` varchar(50) NOT NULL,
  `id` smallint(5) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '',
  `amount` decimal(8,2) NOT NULL,
  `incurredOn` varchar(10) NOT NULL,
  `paidOn` varchar(10) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `financeRecurringOperatingExpenses`
--

CREATE TABLE `financeRecurringOperatingExpenses` (
  `vendorId` varchar(50) NOT NULL,
  `id` smallint(5) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '',
  `baseAmount` decimal(8,2) NOT NULL,
  `variableAmountRate` decimal(3,3) NOT NULL DEFAULT 0.000,
  `variableAmountAppliesAbove` decimal(8,2) NOT NULL DEFAULT 0.00,
  `variableAmountFunctionOf` varchar(25) NOT NULL DEFAULT 'revenue',
  `variableAmountReplacesBaseWhenActive` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `kitchenGroups`
--

CREATE TABLE `kitchenGroups` (
  `vendorId` varchar(50) NOT NULL,
  `id` int(11) NOT NULL,
  `label` varchar(50) NOT NULL,
  `color` varchar(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `managerUsers`
--

CREATE TABLE `managerUsers` (
  `id` varchar(50) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(32) NOT NULL,
  `passwordHash` varchar(64) NOT NULL,
  `authToken` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `managerUsersVendors`
--

CREATE TABLE `managerUsersVendors` (
  `userId` varchar(50) NOT NULL,
  `vendorId` varchar(50) NOT NULL,
  `authToken` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `menuCategories`
--

CREATE TABLE `menuCategories` (
  `vendorId` varchar(50) NOT NULL,
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `icon` varchar(25) DEFAULT NULL,
  `displayInDineInMenu` tinyint(1) NOT NULL DEFAULT 1,
  `displayInOnlineMenu` tinyint(1) NOT NULL DEFAULT 1,
  `timeRestriction` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `menuCategoriesSubCategories`
--

CREATE TABLE `menuCategoriesSubCategories` (
  `vendorId` varchar(50) NOT NULL,
  `categoryId` smallint(5) UNSIGNED NOT NULL,
  `subCategoryId` int(11) UNSIGNED NOT NULL,
  `indexWithinCategory` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `displayInDineInMenu` tinyint(1) NOT NULL DEFAULT 1,
  `displayInOnlineMenu` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `menuItemOptions`
--

CREATE TABLE `menuItemOptions` (
  `vendorId` varchar(50) NOT NULL,
  `optionSetId` int(11) NOT NULL,
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(500) NOT NULL,
  `icon` varchar(25) DEFAULT NULL,
  `volume` smallint(5) UNSIGNED DEFAULT NULL,
  `weight` smallint(5) UNSIGNED DEFAULT NULL,
  `pcs` smallint(5) UNSIGNED DEFAULT NULL,
  `alcoholContent` decimal(4,2) DEFAULT NULL,
  `spiciness` enum('1','2','3') DEFAULT NULL,
  `price` decimal(7,2) DEFAULT NULL,
  `priceAdd` decimal(7,2) DEFAULT NULL,
  `cost` decimal(8,2) NOT NULL DEFAULT 0.00,
  `kitchenHandled` tinyint(1) NOT NULL DEFAULT 1,
  `available` tinyint(1) NOT NULL DEFAULT 1,
  `displayInDineInMenu` tinyint(1) NOT NULL DEFAULT 1,
  `allowPurchaseInDineInMenu` tinyint(1) NOT NULL DEFAULT 1,
  `displayInOnlineMenu` tinyint(1) NOT NULL DEFAULT 1,
  `allowPurchaseInOnlineMenu` tinyint(1) NOT NULL DEFAULT 1,
  `discountTags` varchar(200) NOT NULL,
  `kitchenName` varchar(50) NOT NULL,
  `kitchenGroup` int(11) DEFAULT NULL,
  `accountingGroups` varchar(200) NOT NULL,
  `bestSeller` tinyint(1) NOT NULL DEFAULT 0,
  `hotSeller` tinyint(1) NOT NULL DEFAULT 0,
  `recommended` tinyint(1) NOT NULL DEFAULT 0,
  `indexInSet` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `addToItemNameText` varchar(50) DEFAULT NULL,
  `addToItemNameTextSeparatingChar` varchar(3) DEFAULT '-',
  `addToItemKitchenNameText` varchar(50) DEFAULT NULL,
  `addToItemKitchenNameTextSeparatingChar` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `menuItemOptionSets`
--

CREATE TABLE `menuItemOptionSets` (
  `vendorId` varchar(50) NOT NULL,
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `kitchenName` varchar(50) NOT NULL,
  `icon` varchar(25) DEFAULT NULL,
  `minSelectedOptions` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `maxSelectedOptions` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `addSelectedOptionToItemName` tinyint(1) NOT NULL DEFAULT 1,
  `optionsHaveQuantity` tinyint(1) NOT NULL DEFAULT 0,
  `displayInDineInMenu` tinyint(1) NOT NULL DEFAULT 1,
  `displayInOnlineMenu` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `menuItems`
--

CREATE TABLE `menuItems` (
  `vendorId` varchar(50) NOT NULL,
  `id` int(11) UNSIGNED NOT NULL,
  `hasOptions` tinyint(1) NOT NULL DEFAULT 0,
  `name` varchar(100) NOT NULL,
  `description` varchar(500) NOT NULL,
  `volume` smallint(5) UNSIGNED DEFAULT NULL,
  `weight` smallint(5) UNSIGNED DEFAULT NULL,
  `pcs` smallint(5) UNSIGNED DEFAULT NULL,
  `alcoholContent` decimal(4,2) DEFAULT NULL,
  `spiciness` enum('1','2','3') DEFAULT NULL,
  `price` decimal(7,2) DEFAULT NULL,
  `cost` decimal(8,2) DEFAULT 0.00,
  `kitchenHandled` tinyint(1) NOT NULL DEFAULT 1,
  `available` tinyint(1) NOT NULL DEFAULT 1,
  `displayInDineInMenu` tinyint(1) NOT NULL DEFAULT 1,
  `allowPurchaseInDineInMenu` tinyint(1) NOT NULL DEFAULT 1,
  `displayInOnlineMenu` tinyint(1) NOT NULL DEFAULT 1,
  `allowPurchaseInOnlineMenu` tinyint(1) NOT NULL DEFAULT 1,
  `discountTags` varchar(200) NOT NULL,
  `kitchenName` varchar(50) DEFAULT NULL,
  `kitchenGroup` int(11) DEFAULT NULL,
  `accountingGroups` varchar(200) NOT NULL,
  `bestSeller` tinyint(1) NOT NULL DEFAULT 0,
  `hotSeller` tinyint(1) NOT NULL DEFAULT 0,
  `recommended` tinyint(1) NOT NULL DEFAULT 0,
  `addToItemNameText` varchar(50) DEFAULT NULL,
  `addToItemKitchenNameText` varchar(50) DEFAULT NULL,
  `timeRestriction` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `menuItemsOptionSets`
--

CREATE TABLE `menuItemsOptionSets` (
  `vendorId` varchar(50) NOT NULL,
  `itemId` int(11) UNSIGNED NOT NULL,
  `optionSetId` int(10) UNSIGNED NOT NULL,
  `optionSetIndex` smallint(6) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `menuItemsSubCategories`
--

CREATE TABLE `menuItemsSubCategories` (
  `vendorId` varchar(50) NOT NULL,
  `subCategoryId` int(11) UNSIGNED NOT NULL,
  `itemId` int(11) UNSIGNED NOT NULL,
  `indexWithinCategory` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `menuSubCategories`
--

CREATE TABLE `menuSubCategories` (
  `vendorId` varchar(50) NOT NULL,
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `icon` varchar(25) DEFAULT NULL,
  `displayInDineInMenu` tinyint(1) NOT NULL DEFAULT 1,
  `displayInOnlineMenu` tinyint(1) NOT NULL DEFAULT 1,
  `timeRestriction` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `menuSubCategoriesItems`
--

CREATE TABLE `menuSubCategoriesItems` (
  `vendorId` varchar(50) NOT NULL,
  `subCategoryId` int(11) UNSIGNED NOT NULL,
  `itemId` int(11) UNSIGNED NOT NULL,
  `indexWithinCategory` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `menuTimeRestrictions`
--

CREATE TABLE `menuTimeRestrictions` (
  `id` int(10) UNSIGNED NOT NULL,
  `vendorId` varchar(50) NOT NULL,
  `todayFrom` varchar(5) DEFAULT NULL,
  `todayTo` varchar(5) DEFAULT NULL,
  `mondayFrom` varchar(5) DEFAULT NULL,
  `mondayTo` varchar(5) DEFAULT NULL,
  `mondayUnavailable` tinyint(1) NOT NULL DEFAULT 0,
  `tuesdayFrom` varchar(5) DEFAULT NULL,
  `tuesdayTo` varchar(5) DEFAULT NULL,
  `tuesdayUnavailable` tinyint(1) NOT NULL DEFAULT 0,
  `wednesdayFrom` varchar(5) DEFAULT NULL,
  `wednesdayTo` varchar(5) DEFAULT NULL,
  `wednesdayUnavailable` tinyint(1) NOT NULL DEFAULT 0,
  `thursdayFrom` varchar(5) DEFAULT NULL,
  `thursdayTo` varchar(5) DEFAULT NULL,
  `thursdayUnavailable` tinyint(1) NOT NULL DEFAULT 0,
  `fridayFrom` varchar(5) DEFAULT NULL,
  `fridayTo` varchar(5) DEFAULT NULL,
  `fridayUnavailable` tinyint(1) NOT NULL DEFAULT 0,
  `saturdayFrom` varchar(5) DEFAULT NULL,
  `saturdayTo` varchar(5) DEFAULT NULL,
  `saturdayUnavailable` tinyint(1) NOT NULL DEFAULT 0,
  `sundayFrom` varchar(5) DEFAULT NULL,
  `sundayTo` varchar(5) DEFAULT NULL,
  `sundayUnavailable` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `onlineOrderItemOptions`
--

CREATE TABLE `onlineOrderItemOptions` (
  `id` int(11) UNSIGNED NOT NULL,
  `orderId` varchar(25) NOT NULL,
  `itemId` int(11) NOT NULL,
  `optionId` int(11) UNSIGNED NOT NULL,
  `optionSetId` int(11) UNSIGNED NOT NULL,
  `quantity` smallint(5) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `onlineOrderItems`
--

CREATE TABLE `onlineOrderItems` (
  `id` int(11) UNSIGNED NOT NULL,
  `orderId` varchar(25) NOT NULL,
  `itemId` int(11) NOT NULL,
  `quantity` smallint(5) NOT NULL,
  `itemPrice` decimal(7,2) NOT NULL,
  `sessionItemId` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `onlineOrders`
--

CREATE TABLE `onlineOrders` (
  `id` varchar(25) NOT NULL,
  `vendorId` varchar(50) NOT NULL,
  `type` enum('takeout','delivery') NOT NULL,
  `serviceCharge` decimal(7,2) NOT NULL DEFAULT 0.00,
  `tax` decimal(7,2) NOT NULL DEFAULT 0.00,
  `deliveryDistance` smallint(5) UNSIGNED DEFAULT NULL,
  `deliveryDrivingTime` smallint(5) UNSIGNED DEFAULT NULL,
  `deliveryFee` decimal(7,2) NOT NULL DEFAULT 0.00,
  `total` decimal(7,2) NOT NULL DEFAULT 0.00,
  `sessionId` int(11) DEFAULT NULL,
  `placedTimestamp` int(11) NOT NULL,
  `scheduledTimestamp` int(11) DEFAULT NULL,
  `phoneNumber` varchar(30) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `unit` varchar(20) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `paid` tinyint(1) NOT NULL DEFAULT 0,
  `complete` tinyint(1) NOT NULL DEFAULT 0,
  `completeTimestamp` varchar(11) DEFAULT NULL,
  `language` varchar(3) NOT NULL DEFAULT 'en',
  `ordersPlacedBeforeTotal` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `ordersPlacedBeforePaid` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `vendorSelfDelivery` tinyint(1) NOT NULL DEFAULT 0,
  `courierTrackingLink` varchar(100) DEFAULT NULL,
  `onDeliveryNow` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `openingHours`
--

CREATE TABLE `openingHours` (
  `vendorId` varchar(50) NOT NULL,
  `mondayFrom` varchar(5) NOT NULL,
  `mondayTo` varchar(5) NOT NULL,
  `mondayKitchenTo` varchar(5) NOT NULL,
  `mondayClosed` tinyint(1) NOT NULL DEFAULT 0,
  `tuesdayFrom` varchar(5) NOT NULL,
  `tuesdayTo` varchar(5) NOT NULL,
  `tuesdayKitchenTo` varchar(5) NOT NULL,
  `tuesdayClosed` tinyint(1) NOT NULL DEFAULT 0,
  `wednesdayFrom` varchar(5) NOT NULL,
  `wednesdayTo` varchar(5) NOT NULL,
  `wednesdayKitchenTo` varchar(5) NOT NULL,
  `wednesdayClosed` tinyint(1) NOT NULL DEFAULT 0,
  `thursdayFrom` varchar(5) NOT NULL,
  `thursdayTo` varchar(5) NOT NULL,
  `thursdayKitchenTo` varchar(5) NOT NULL,
  `thursdayClosed` tinyint(1) NOT NULL DEFAULT 0,
  `fridayFrom` varchar(5) NOT NULL,
  `fridayTo` varchar(5) NOT NULL,
  `fridayKitchenTo` varchar(5) NOT NULL,
  `fridayClosed` tinyint(1) NOT NULL DEFAULT 0,
  `saturdayFrom` varchar(5) NOT NULL,
  `saturdayTo` varchar(5) NOT NULL,
  `saturdayKitchenTo` varchar(5) NOT NULL,
  `saturdayClosed` tinyint(1) NOT NULL DEFAULT 0,
  `sundayFrom` varchar(5) NOT NULL,
  `sundayTo` varchar(5) NOT NULL,
  `sundayKitchenTo` varchar(5) NOT NULL,
  `sundayClosed` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `paymentMethods`
--

CREATE TABLE `paymentMethods` (
  `vendorId` varchar(50) NOT NULL,
  `id` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `processingFeeAbsolute` decimal(8,2) NOT NULL DEFAULT 0.00,
  `processingFeeRate` tinyint(3) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `receiptDiscounts`
--

CREATE TABLE `receiptDiscounts` (
  `vendorId` varchar(50) NOT NULL,
  `receiptCode` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `amount` decimal(9,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `receiptItems`
--

CREATE TABLE `receiptItems` (
  `sessionItemId` int(11) NOT NULL,
  `vendorId` varchar(50) NOT NULL,
  `receiptCode` varchar(25) NOT NULL,
  `itemId` smallint(5) UNSIGNED NOT NULL,
  `itemName` varchar(200) NOT NULL,
  `itemVendorName` varchar(200) NOT NULL,
  `price` decimal(9,2) NOT NULL,
  `quantity` tinyint(3) UNSIGNED NOT NULL,
  `quantityAfterSpecialEvents` smallint(5) UNSIGNED NOT NULL,
  `type` enum('table','takeout','delivery') NOT NULL DEFAULT 'table',
  `totalSaleRevenue` decimal(9,2) NOT NULL,
  `totalCost` decimal(8,2) NOT NULL DEFAULT 0.00,
  `totalProfitAfterDiscountsSpecialEvents` decimal(8,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `receiptPayments`
--

CREATE TABLE `receiptPayments` (
  `vendorId` varchar(50) NOT NULL,
  `receiptCode` varchar(25) NOT NULL,
  `method` varchar(25) NOT NULL DEFAULT 'cash',
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `processingFee` decimal(8,2) NOT NULL DEFAULT 0.00,
  `timeReceived` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `receipts`
--

CREATE TABLE `receipts` (
  `sessionId` int(11) NOT NULL,
  `vendorId` varchar(50) NOT NULL,
  `receiptCode` varchar(50) NOT NULL,
  `sessionType` enum('table','takeout','delivery','virtual') NOT NULL DEFAULT 'table',
  `sessionLabel` varchar(50) NOT NULL,
  `sessionStartedTime` varchar(10) NOT NULL,
  `sessionEndedTime` varchar(10) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL DEFAULT 0.00,
  `serviceCharge` decimal(8,2) NOT NULL DEFAULT 0.00,
  `tax` decimal(8,2) NOT NULL DEFAULT 0.00,
  `rounding` decimal(3,2) NOT NULL DEFAULT 0.00,
  `total` decimal(10,2) NOT NULL DEFAULT 0.00,
  `totalItemCost` decimal(8,2) NOT NULL DEFAULT 0.00,
  `totalPaymentProcessingFees` decimal(8,2) NOT NULL DEFAULT 0.00,
  `totalProfit` decimal(8,2) NOT NULL DEFAULT 0.00,
  `serviceChargeLabel` varchar(50) NOT NULL DEFAULT '10% SERVICE CHARGE',
  `serviceChargeAppliesToTakeout` tinyint(1) NOT NULL DEFAULT 0,
  `taxLabel` varchar(50) NOT NULL DEFAULT '6% SST TAX',
  `sessionCreatedByCustomer` tinyint(1) NOT NULL DEFAULT 1,
  `numberOfConnectedCustomers` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `invalidated` tinyint(1) NOT NULL DEFAULT 0,
  `onlineOrderId` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `receiptSpecialEvents`
--

CREATE TABLE `receiptSpecialEvents` (
  `vendorId` varchar(50) NOT NULL,
  `receiptCode` varchar(50) NOT NULL,
  `type` enum('customer-refused','quality-issue','free') NOT NULL DEFAULT 'free',
  `itemName` varchar(50) NOT NULL,
  `itemVendorName` varchar(50) NOT NULL,
  `quantity` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `amount` decimal(9,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sessionAppliedDiscounts`
--

CREATE TABLE `sessionAppliedDiscounts` (
  `sessionId` int(10) UNSIGNED NOT NULL,
  `discountId` int(10) UNSIGNED NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sessionCustomerRequests`
--

CREATE TABLE `sessionCustomerRequests` (
  `sessionId` int(11) UNSIGNED NOT NULL,
  `customerId` smallint(5) UNSIGNED DEFAULT NULL,
  `type` enum('waiter','bill') NOT NULL DEFAULT 'waiter',
  `placedTime` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sessionCustomers`
--

CREATE TABLE `sessionCustomers` (
  `sessionId` int(11) UNSIGNED NOT NULL,
  `id` int(11) UNSIGNED NOT NULL,
  `authToken` varchar(32) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sessionItemOptions`
--

CREATE TABLE `sessionItemOptions` (
  `id` int(11) UNSIGNED NOT NULL,
  `sessionId` int(11) NOT NULL,
  `vendorId` varchar(50) NOT NULL,
  `itemId` int(11) UNSIGNED NOT NULL,
  `optionId` int(11) UNSIGNED NOT NULL,
  `optionSetId` int(11) UNSIGNED NOT NULL,
  `quantity` smallint(5) UNSIGNED DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sessionItems`
--

CREATE TABLE `sessionItems` (
  `id` int(11) NOT NULL,
  `vendorId` varchar(50) NOT NULL,
  `sessionId` int(11) UNSIGNED NOT NULL,
  `onlineOrderId` varchar(50) DEFAULT NULL,
  `onlineOrderItemId` int(10) UNSIGNED DEFAULT NULL,
  `itemId` int(11) UNSIGNED NOT NULL,
  `quantity` smallint(5) UNSIGNED NOT NULL,
  `type` enum('table','takeout','delivery') NOT NULL DEFAULT 'table',
  `state` enum('processing','scheduled','served') NOT NULL DEFAULT 'processing',
  `customerId` int(11) DEFAULT NULL,
  `scheduledTime` int(11) UNSIGNED DEFAULT NULL,
  `placedTime` int(11) UNSIGNED DEFAULT NULL,
  `servedTime` int(10) UNSIGNED DEFAULT NULL,
  `kitchenHandled` tinyint(1) NOT NULL DEFAULT 1,
  `queuePosition` smallint(3) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sessionPayments`
--

CREATE TABLE `sessionPayments` (
  `sessionId` int(5) UNSIGNED NOT NULL,
  `id` int(11) UNSIGNED NOT NULL,
  `method` enum('cash','card','stripe') NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `processingFee` decimal(10,2) NOT NULL DEFAULT 0.00,
  `madeTime` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` int(11) UNSIGNED NOT NULL,
  `vendorId` varchar(50) NOT NULL,
  `type` enum('table','takeout','delivery','virtual') NOT NULL DEFAULT 'table'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sessionSpecialEvents`
--

CREATE TABLE `sessionSpecialEvents` (
  `id` int(11) UNSIGNED NOT NULL,
  `sessionId` int(11) UNSIGNED NOT NULL,
  `itemId` int(11) UNSIGNED NOT NULL,
  `quantity` smallint(5) UNSIGNED NOT NULL,
  `reason` enum('customer-refused','quality-issue','free') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sessions_deliveries`
--

CREATE TABLE `sessions_deliveries` (
  `id` int(11) NOT NULL,
  `vendorId` varchar(50) NOT NULL,
  `label` varchar(5) NOT NULL,
  `startedTime` varchar(10) NOT NULL,
  `createdByCustomer` tinyint(1) NOT NULL DEFAULT 1,
  `receiptCode` varchar(50) NOT NULL,
  `pusherChannel` varchar(32) NOT NULL,
  `scheduledTimestamp` int(11) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sessions_tables`
--

CREATE TABLE `sessions_tables` (
  `id` int(11) NOT NULL,
  `vendorId` varchar(50) NOT NULL,
  `label` varchar(5) NOT NULL,
  `tableId` int(11) UNSIGNED NOT NULL,
  `startedTime` varchar(10) NOT NULL,
  `createdByCustomer` tinyint(1) NOT NULL DEFAULT 1,
  `receiptCode` varchar(50) NOT NULL,
  `pusherChannel` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sessions_takeouts`
--

CREATE TABLE `sessions_takeouts` (
  `id` int(11) NOT NULL,
  `vendorId` varchar(50) NOT NULL,
  `label` varchar(5) NOT NULL,
  `startedTime` varchar(10) NOT NULL,
  `createdByCustomer` tinyint(1) NOT NULL DEFAULT 1,
  `receiptCode` varchar(50) NOT NULL,
  `pusherChannel` varchar(32) NOT NULL,
  `scheduledTimestamp` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `sessions_virtual`
--

CREATE TABLE `sessions_virtual` (
  `id` int(11) NOT NULL,
  `vendorId` varchar(50) NOT NULL,
  `label` varchar(5) NOT NULL,
  `startedTime` varchar(10) NOT NULL,
  `receiptCode` varchar(50) NOT NULL,
  `pusherChannel` varchar(32) NOT NULL,
  `scheduledTimestamp` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `stripeKeys`
--

CREATE TABLE `stripeKeys` (
  `vendorId` varchar(50) NOT NULL,
  `sk` varchar(200) NOT NULL,
  `pk` varchar(200) NOT NULL,
  `webhookToken` varchar(32) NOT NULL,
  `webhookSecret` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `stripeOnlineOrderPayments`
--

CREATE TABLE `stripeOnlineOrderPayments` (
  `vendorId` varchar(50) NOT NULL,
  `paymentIntent` varchar(50) NOT NULL,
  `orderId` varchar(25) NOT NULL,
  `method` varchar(50) DEFAULT NULL,
  `amount` decimal(11,2) NOT NULL,
  `amountReceived` decimal(11,2) DEFAULT NULL,
  `status` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `stripePayments`
--

CREATE TABLE `stripePayments` (
  `vendorId` varchar(50) NOT NULL,
  `paymentIntent` varchar(50) NOT NULL,
  `sessionId` int(11) NOT NULL,
  `method` varchar(50) DEFAULT NULL,
  `amount` decimal(11,2) NOT NULL,
  `amountReceived` decimal(11,2) DEFAULT NULL,
  `status` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tables`
--

CREATE TABLE `tables` (
  `vendorId` varchar(50) NOT NULL,
  `id` smallint(5) UNSIGNED NOT NULL,
  `label` varchar(50) NOT NULL,
  `url` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `translationsMenuCategories`
--

CREATE TABLE `translationsMenuCategories` (
  `vendorId` varchar(50) NOT NULL,
  `categoryId` int(11) NOT NULL,
  `languageCode` varchar(3) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `translationsMenuItems`
--

CREATE TABLE `translationsMenuItems` (
  `vendorId` varchar(50) NOT NULL,
  `itemId` int(11) NOT NULL,
  `languageCode` varchar(3) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(500) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `translationsMenuOptions`
--

CREATE TABLE `translationsMenuOptions` (
  `vendorId` varchar(50) NOT NULL,
  `optionId` int(11) NOT NULL,
  `languageCode` varchar(3) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(500) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `translationsMenuOptionSets`
--

CREATE TABLE `translationsMenuOptionSets` (
  `vendorId` varchar(50) NOT NULL,
  `optionSetId` int(11) NOT NULL,
  `languageCode` varchar(3) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `translationsMenuSubCategories`
--

CREATE TABLE `translationsMenuSubCategories` (
  `vendorId` varchar(50) NOT NULL,
  `categoryId` int(11) NOT NULL,
  `subCategoryId` int(11) NOT NULL,
  `languageCode` varchar(3) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `translationsVendorData`
--

CREATE TABLE `translationsVendorData` (
  `vendorId` varchar(50) NOT NULL,
  `languageCode` varchar(3) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `tagline` varchar(100) DEFAULT NULL,
  `hashtags` varchar(200) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  `deliveryArea` varchar(150) DEFAULT NULL,
  `appHomeButtonLabel` varchar(21) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE `vendors` (
  `id` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `url` varchar(50) NOT NULL,
  `tagline` varchar(100) NOT NULL,
  `hashtags` varchar(200) NOT NULL,
  `location` varchar(100) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `whatsapp` varchar(50) NOT NULL,
  `delivers` tinyint(1) NOT NULL DEFAULT 1,
  `deliveryArea` varchar(150) NOT NULL,
  `waitersPusherChannel` varchar(32) NOT NULL,
  `kitchenViewEnabled` tinyint(1) NOT NULL DEFAULT 0,
  `onlineOrderPrefix` varchar(10) NOT NULL,
  `appHomeButtonLabel` varchar(21) DEFAULT NULL,
  `facebook` varchar(50) DEFAULT NULL,
  `instagram` varchar(50) DEFAULT NULL,
  `googleMaps` varchar(100) DEFAULT NULL,
  `googleMapsLat` varchar(20) DEFAULT NULL,
  `googleMapsLng` varchar(20) DEFAULT NULL,
  `googleMapsDeliveryRadiusKm` tinyint(3) UNSIGNED NOT NULL DEFAULT 20
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `waiters`
--

CREATE TABLE `waiters` (
  `vendorId` varchar(50) NOT NULL,
  `id` smallint(5) UNSIGNED NOT NULL,
  `state` enum('active','inactive') NOT NULL DEFAULT 'inactive',
  `username` varchar(20) NOT NULL,
  `kitchenViewMode` tinyint(1) NOT NULL DEFAULT 0,
  `password` varchar(32) NOT NULL,
  `passwordHash` varchar(64) NOT NULL,
  `authToken` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accountingSettings`
--
ALTER TABLE `accountingSettings`
  ADD PRIMARY KEY (`vendorId`);

--
-- Indexes for table `billingInfo`
--
ALTER TABLE `billingInfo`
  ADD PRIMARY KEY (`vendorId`);

--
-- Indexes for table `constants`
--
ALTER TABLE `constants`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `discounts`
--
ALTER TABLE `discounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `financeOnetimeOperatingExpenses`
--
ALTER TABLE `financeOnetimeOperatingExpenses`
  ADD PRIMARY KEY (`vendorId`,`id`);

--
-- Indexes for table `financeRecurringOperatingExpenses`
--
ALTER TABLE `financeRecurringOperatingExpenses`
  ADD PRIMARY KEY (`vendorId`,`id`);

--
-- Indexes for table `kitchenGroups`
--
ALTER TABLE `kitchenGroups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `managerUsers`
--
ALTER TABLE `managerUsers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `authToken` (`authToken`);

--
-- Indexes for table `managerUsersVendors`
--
ALTER TABLE `managerUsersVendors`
  ADD PRIMARY KEY (`userId`,`vendorId`);

--
-- Indexes for table `menuCategories`
--
ALTER TABLE `menuCategories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menuCategoriesSubCategories`
--
ALTER TABLE `menuCategoriesSubCategories`
  ADD PRIMARY KEY (`categoryId`,`subCategoryId`);

--
-- Indexes for table `menuItemOptions`
--
ALTER TABLE `menuItemOptions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menuItemOptionSets`
--
ALTER TABLE `menuItemOptionSets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menuItems`
--
ALTER TABLE `menuItems`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menuItemsOptionSets`
--
ALTER TABLE `menuItemsOptionSets`
  ADD PRIMARY KEY (`vendorId`,`itemId`,`optionSetId`);

--
-- Indexes for table `menuItemsSubCategories`
--
ALTER TABLE `menuItemsSubCategories`
  ADD PRIMARY KEY (`subCategoryId`,`itemId`);

--
-- Indexes for table `menuSubCategories`
--
ALTER TABLE `menuSubCategories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menuSubCategoriesItems`
--
ALTER TABLE `menuSubCategoriesItems`
  ADD PRIMARY KEY (`subCategoryId`,`itemId`);

--
-- Indexes for table `menuTimeRestrictions`
--
ALTER TABLE `menuTimeRestrictions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `onlineOrderItemOptions`
--
ALTER TABLE `onlineOrderItemOptions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `onlineOrderItems`
--
ALTER TABLE `onlineOrderItems`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `onlineOrders`
--
ALTER TABLE `onlineOrders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `openingHours`
--
ALTER TABLE `openingHours`
  ADD PRIMARY KEY (`vendorId`);

--
-- Indexes for table `paymentMethods`
--
ALTER TABLE `paymentMethods`
  ADD PRIMARY KEY (`vendorId`,`id`);

--
-- Indexes for table `receiptDiscounts`
--
ALTER TABLE `receiptDiscounts`
  ADD PRIMARY KEY (`vendorId`,`receiptCode`);

--
-- Indexes for table `receiptItems`
--
ALTER TABLE `receiptItems`
  ADD PRIMARY KEY (`sessionItemId`);

--
-- Indexes for table `receiptPayments`
--
ALTER TABLE `receiptPayments`
  ADD PRIMARY KEY (`vendorId`,`receiptCode`);

--
-- Indexes for table `receipts`
--
ALTER TABLE `receipts`
  ADD PRIMARY KEY (`sessionId`);

--
-- Indexes for table `receiptSpecialEvents`
--
ALTER TABLE `receiptSpecialEvents`
  ADD PRIMARY KEY (`vendorId`,`receiptCode`,`itemVendorName`);

--
-- Indexes for table `sessionAppliedDiscounts`
--
ALTER TABLE `sessionAppliedDiscounts`
  ADD PRIMARY KEY (`sessionId`,`discountId`);

--
-- Indexes for table `sessionCustomerRequests`
--
ALTER TABLE `sessionCustomerRequests`
  ADD PRIMARY KEY (`sessionId`);

--
-- Indexes for table `sessionCustomers`
--
ALTER TABLE `sessionCustomers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessionItemOptions`
--
ALTER TABLE `sessionItemOptions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessionItems`
--
ALTER TABLE `sessionItems`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessionPayments`
--
ALTER TABLE `sessionPayments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessionSpecialEvents`
--
ALTER TABLE `sessionSpecialEvents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions_deliveries`
--
ALTER TABLE `sessions_deliveries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions_tables`
--
ALTER TABLE `sessions_tables`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions_takeouts`
--
ALTER TABLE `sessions_takeouts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions_virtual`
--
ALTER TABLE `sessions_virtual`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stripeKeys`
--
ALTER TABLE `stripeKeys`
  ADD PRIMARY KEY (`vendorId`);

--
-- Indexes for table `stripeOnlineOrderPayments`
--
ALTER TABLE `stripeOnlineOrderPayments`
  ADD PRIMARY KEY (`vendorId`,`paymentIntent`);

--
-- Indexes for table `stripePayments`
--
ALTER TABLE `stripePayments`
  ADD PRIMARY KEY (`vendorId`,`paymentIntent`);

--
-- Indexes for table `tables`
--
ALTER TABLE `tables`
  ADD PRIMARY KEY (`vendorId`,`id`),
  ADD UNIQUE KEY `url` (`url`);

--
-- Indexes for table `translationsMenuCategories`
--
ALTER TABLE `translationsMenuCategories`
  ADD PRIMARY KEY (`categoryId`,`languageCode`);

--
-- Indexes for table `translationsMenuItems`
--
ALTER TABLE `translationsMenuItems`
  ADD PRIMARY KEY (`itemId`,`languageCode`);

--
-- Indexes for table `translationsMenuOptions`
--
ALTER TABLE `translationsMenuOptions`
  ADD PRIMARY KEY (`optionId`,`languageCode`);

--
-- Indexes for table `translationsMenuOptionSets`
--
ALTER TABLE `translationsMenuOptionSets`
  ADD PRIMARY KEY (`optionSetId`,`languageCode`);

--
-- Indexes for table `translationsMenuSubCategories`
--
ALTER TABLE `translationsMenuSubCategories`
  ADD PRIMARY KEY (`categoryId`,`subCategoryId`,`languageCode`);

--
-- Indexes for table `translationsVendorData`
--
ALTER TABLE `translationsVendorData`
  ADD PRIMARY KEY (`vendorId`,`languageCode`);

--
-- Indexes for table `vendors`
--
ALTER TABLE `vendors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `waiters`
--
ALTER TABLE `waiters`
  ADD PRIMARY KEY (`vendorId`,`id`),
  ADD UNIQUE KEY `authToken` (`authToken`),
  ADD KEY `vendorId` (`vendorId`,`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `discounts`
--
ALTER TABLE `discounts`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kitchenGroups`
--
ALTER TABLE `kitchenGroups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `menuCategories`
--
ALTER TABLE `menuCategories`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `menuItemOptions`
--
ALTER TABLE `menuItemOptions`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `menuItemOptionSets`
--
ALTER TABLE `menuItemOptionSets`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `menuItems`
--
ALTER TABLE `menuItems`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `menuSubCategories`
--
ALTER TABLE `menuSubCategories`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `menuTimeRestrictions`
--
ALTER TABLE `menuTimeRestrictions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `onlineOrderItemOptions`
--
ALTER TABLE `onlineOrderItemOptions`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `onlineOrderItems`
--
ALTER TABLE `onlineOrderItems`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sessionCustomers`
--
ALTER TABLE `sessionCustomers`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sessionItemOptions`
--
ALTER TABLE `sessionItemOptions`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sessionItems`
--
ALTER TABLE `sessionItems`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sessionPayments`
--
ALTER TABLE `sessionPayments`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sessions`
--
ALTER TABLE `sessions`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sessionSpecialEvents`
--
ALTER TABLE `sessionSpecialEvents`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
