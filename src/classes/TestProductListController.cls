/**
 * Created by Alex on 29/10/2018.
 */

@IsTest
private class TestProductListController {



    @testSetup static void testAutoRun() {

        Product_Table__c productField = new Product_Table__c(
                Name = 'iPhone2',
                Image_URL__c = 'https://c.ap4.visual.force.com/resource/1540281714000/Xiome?',
                Unit_Price__c = 100,
                Product_description__c = 'Descr',
                Units_Avalible__c = 3
        );
        insert productField;

        List<Product_Table__c> prodTable = [SELECT ID FROM Product_Table__c LIMIT 1];
        ProductListController controller = new ProductListController();
        controller.myProductId = prodTable[0].Id;

    }

    @isTest static void testGetNewProductTables (){
        ProductListController controller = new ProductListController();
        System.assertNotEquals(null, controller.getNewProductTables());
    }

    @isTest static void testRedirectToShopping() {
        ProductListController controller = new ProductListController();
        System.assertNotEquals(null, controller.RedirectToShopping());
    }

    @isTest static void testRedirectToFullPageProduct() {
        ProductListController controller = new ProductListController();
        System.assertNotEquals(null, controller.RedirectToFullPageProduct());
        System.assertEquals(null, controller.productField);
    }

    @isTest static void testRedirectToFullStore() {
        ProductListController controller = new ProductListController();
        System.assertNotEquals(null, controller.redirectToFullStore());
        System.assertEquals(null, controller.productField);
    }

    @isTest static void testMakePurchase() {

        ProductListController controller = new ProductListController();

        Contact cont = new Contact(
                LastName = 'Kohovich',
                FirstName = 'Alex'
        );

        Order_Table__c ordTableTest = new Order_Table__c (
                Units__c = 4,
                Order_Amount__c = 0
        );

        insert cont;
        insert ordTableTest;

        controller.contactMainInfo = new Contact(
                LastName = 'Kohovich',
                FirstName = 'Alex'
        );

        controller.containOrderInfo = new Order_Table__c (
                Units__c = 4,
                Order_Amount__c = 0
        );

        controller.productField = new Product_Table__c(
                Name = 'iPhone2',
                Image_URL__c = 'https://c.ap4.visual.force.com/resource/1540281714000/Xiome?',
                Unit_Price__c = 100,
                Product_description__c = 'Descr',
                Units_Avalible__c = 1
        );

        controller.makePurchase();

    }

    @isTest static void testMakePurchaseNegative() {

        ProductListController controller = new ProductListController();

        controller.containOrderInfo = new Order_Table__c (
                Units__c = 1,
                Order_Amount__c = 0
        );

        Contact cont = new Contact(
                LastName = 'Kohovich',
                FirstName = 'Alex'
        );

        Order_Table__c ordTableTest = new Order_Table__c (
                Units__c = 1,
                Order_Amount__c = 0
        );
        insert cont;
        insert ordTableTest;


        controller.contactMainInfo = new Contact(
                LastName = 'Kohovich',
                FirstName = 'Alex'
        );

        controller.containOrderInfo = new Order_Table__c (
                Units__c = 1,
                Order_Amount__c = 0
        );

        controller.productField = new Product_Table__c(
                Name = 'iPhone2',
                Image_URL__c = 'https://c.ap4.visual.force.com/resource/1540281714000/Xiome?',
                Unit_Price__c = 100,
                Product_description__c = 'Descr',
                Units_Avalible__c = 5
        );

        controller.makePurchase();

    }

    @isTest static  void testCalculateOrderAmount () {
        ProductListController controller = new ProductListController();

        controller.containOrderInfo = new Order_Table__c (
                Units__c = 1,
                Order_Amount__c = 0
        );

        controller.productField = new Product_Table__c(
                Name = 'iPhone2',
                Image_URL__c = 'https://c.ap4.visual.force.com/resource/1540281714000/Xiome?',
                Unit_Price__c = 100,
                Product_description__c = 'Descr',
                Units_Avalible__c = 5
        );

        controller.calculateOrderAmount();

        System.assertNotEquals(null, controller.containOrderInfo);

    }

}