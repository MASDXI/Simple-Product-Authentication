pragma solidity 0.5.11;
pragma experimental ABIEncoderV2;
contract Products {
    
    struct Product {
        string brand;
        string serialnumber;
        string describe;
        // you can add more variable such as build date 
    }

    mapping (bytes32 => Product) products;

    function addManyProducts (Product [] memory _products) public {
        /* for exmaple input
            [["nike","nk001","Air Max 97"],
            ["nike","nk002","Free Flykinit"],
            ["addidas","add001","ULTRABOOST 19"],
            ["addidas","add002","NITE JOGGER"],
            ["asics","as001","GEL-Nimbus 21"],
            ["asics","as002","ASICS GEL-Nimbus 21"]]
        */
        for (uint i = 0; i < _products.length; i++) {
           bytes32 hash = keccak256(abi.encode(_products[i].serialnumber));
           products[hash] = _products[i];
        }
    }

    function addOneProduct (Product memory _products) public {
        //for exmaple input ["nike","nk001","Air Max 97"]
        bytes32 hash = keccak256(abi.encode(_products.serialnumber));
        products[hash] = _products;
    }

    function checkProduct (string memory _serialnumber) public view returns (string memory brand ,string memory describe ,string memory serialnumber) {
        bytes32 hash = keccak256(abi.encode(_serialnumber));
        return (products[hash].brand,
                products[hash].describe,
                products[hash].serialnumber);
        /* if result is empty it's mean that's Product is fake product*/ 
    }
}
