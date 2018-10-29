public class ProductListController {

    //get id when press link name or button buy
    public String myProductId {get; set;}

    //contains product fields
    public Product_Table__c productField {get; set;}

    //contains Contact
    public Contact contactMainInfo {get;set;}

    //contain Order_Table__c
    public Order_Table__c containOrderInfo {get;set;}

    //constructor contactMainInfo
    public ProductListController () {
        contactMainInfo = new Contact(LastName='.',FirstName='',Email='');
        containOrderInfo = new Order_Table__c(Units__c = 0, Order_Amount__c = 0);
    }

    public List<Product_Table__c> getNewProductTables() {
        List<Product_Table__c> listProduct = [SELECT Image_URL__c, ID, Unit_Price__c, Title__c, Name, Product_description__c  FROM Product_Table__c limit 100];
        return listProduct;
    }

    public PageReference RedirectToFullPageProduct() {
        productField = [SELECT Image_URL__c, ID, Unit_Price__c, Title__c, Units_Avalible__c, Name, Product_description__c FROM Product_Table__c WHERE Id =: myProductId limit 1];
        return Page.FullDescProduct;
    }

    public PageReference RedirectToShopping () {
        return Page.ProductList;
    }

    public PageReference redirectToFullStore () {
        productField = [SELECT Image_URL__c, ID, Unit_Price__c, Title__c, Units_Avalible__c, Name, Product_description__c FROM Product_Table__c WHERE Id =: myProductId limit 1];
        return Page.BuyProduct;
    }

    public void makePurchase () {
        List<Contact> containContacts = [SELECT Email, Id, FirstName, LastName FROM Contact WHERE Email =: contactMainInfo.Email LIMIT 1];

        if(containOrderInfo.Units__c > productField.Units_Avalible__c) {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Units Not Enough! ' + productField.Units_Avalible__c + ' Units is available in our VRP-Store'));
        } else {
            try{
                if (containContacts.isEmpty()) {
                    Contact mainListContact = new Contact();
                    mainListContact.Email = contactMainInfo.Email;
                    mainListContact.FirstName = contactMainInfo.FirstName;
                    mainListContact.LastName = contactMainInfo.LastName;
                    insert mainListContact;
                } else {
                    containContacts[0].FirstName = contactMainInfo.FirstName;
                    containContacts[0].LastName = contactMainInfo.LastName;
                    update containContacts;
                }

                Order_Table__c orderTableProduct = new Order_Table__c();
                orderTableProduct.Product__c = productField.Id;
                orderTableProduct.Contact__c = contactMainInfo.Id;
                orderTableProduct.Units__c = containOrderInfo.Units__c;
                orderTableProduct.Order_Amount__c = containOrderInfo.Units__c * productField.Unit_Price__c;
                insert orderTableProduct;

                productField.Units_Avalible__c -= containOrderInfo.Units__c;
                update productField;

                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM, 'Your order is accepted. Thanks for your order '));

            } catch(Exception ex){
                ApexPages.addMessages(ex);
            }
        }
    }

    public void calculateOrderAmount () {
        if(containOrderInfo.Units__c > 0 ) {
            containOrderInfo.Order_Amount__c = containOrderInfo.Units__c * productField.Unit_Price__c;
        } else {
            System.debug('Incorrect data');
        }
    }

}



