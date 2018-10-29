/**
 * Created by Alex on 29/10/2018.
 */

@IsTest
private class TestProductListController {

    @isTest static void testAutoRun() {

        Product_Table__c productField = new Product_Table__c(
                Name = 'iPhone2',
                Image_URL__c = 'https://c.ap4.visual.force.com/resource/1540281714000/Xiome?',
                Unit_Price__c = 100,
                Product_description__c = 'Descr'
        );
        insert productField;

        ProductListController controller = new ProductListController();

    }

    //add Rows
    @isTest static void testRedirectToShopping() {
        PageReference pageButProduct = Page.BuyProduct;
        //testPage.getParameters().put('oid', '12345');
        Test.setCurrentPage(Page.ProductList);
        Test.StartTest();
        ProductListController controller = new ProductListController();
        controller.RedirectToShopping();
        System.assertEquals( pageButProduct.getURL(), pageButProduct.getURL() );
        Test.StopTest();
    }

    @isTest static void testRedirectToFullPageProduct() {
        PageReference pageButProduct = Page.FullDescProduct;
        //testPage.getParameters().put('oid', '12345');
        Test.setCurrentPage(Page.ProductList);
        Test.StartTest();
        ProductListController controller = new ProductListController();
        controller.RedirectToFullPageProduct();
        System.assertEquals( pageButProduct.getURL(), pageButProduct.getURL() );
        Test.StopTest();
    }

    @isTest static void testRedirectToFullStore() {
        PageReference pageMainProduct = Page.ProductList;
        Test.setCurrentPage(Page.BuyProduct);
        Test.StartTest();
        ProductListController controller = new ProductListController();
        controller.redirectToFullStore();
        System.assertEquals( pageMainProduct.getURL(), pageMainProduct.getURL() );
        Test.StopTest();
    }



}