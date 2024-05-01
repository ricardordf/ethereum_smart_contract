//SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract storeSample
{
    address public owner;                               // Propietario del contrato
    uint256 public balance;                             // Caja de cobro
    uint256 private donutPrice;                         // Precio del donuts (puede introducirse como constante)
    uint256 private cookiePrice;                        // Precio de la galleta (puede introducirse como constante)    
    uint256 private candyPrice;                         // Precio de los caramelos (puede introducirse como constante)
    mapping(address => uint) private donutBalances;     // Unidades de donuts "por persona"
    mapping(address => uint) private cookieBalances;    // Unidades de galletas "por persona" 
    mapping(address => uint) private candyBalances;     // Unidades de caramelos "por persona" 
    enum product{ COOKIE, DONUT, CANDY }                // Productos de la tienda 


    // Inicializa el contrato asignando el creador del contrato como propietario y establece los inventarios iniciales y precios de los productos.
    constructor() //Inicialización del contrato
    {
        owner = msg.sender;
        donutBalances[address(this)] = 20;
        cookieBalances[address(this)] = 100;
        candyBalances[address(this)] = 200;
        donutPrice  = 2000000000000000000;          // 1 donut (2ether)
        cookiePrice = 100000000000000000;           // 10 cookies (1ethr)
        candyPrice  = 1000000000000000000;          // 200 caramelos (1ether)
    }

    //-----------------------------------------------------------------------------------------------------------------------------------------------------
    
    //Permite a los usuarios comprar productos (donuts, cookies, caramelos). Valida que haya suficiente producto y que el pago recibido sea el correcto.
    function purchaseProduct(product _product, uint8 amount) public payable returns (uint8) { //Compra de productos
        require(uint8(_product) <= 2,'Not a valid product');
        if(_product == product.DONUT){
            require(msg.value >= amount * donutPrice, "You must pay at least 2 ether per donut");
            require(donutBalances[address(this)] >= amount, "OOPS! Not enough donuts");
            balance += msg.value; // keep track of balance (in WEI)
            donutBalances[address(this)] -= amount;
            donutBalances[address(msg.sender)] += amount;
            return amount;
        }
        if(_product == product.COOKIE){
            require(msg.value >= amount * cookiePrice, "You must pay at least 0.1 ether per cookie");
            require(cookieBalances[address(this)] >= amount, "OOPS! Not enough cookie");
            balance += msg.value; // keep track of balance (in WEI)
            cookieBalances[address(this)] -= amount;
            cookieBalances[address(msg.sender)] += amount;
            return amount;
        }
        if(_product == product.CANDY){
            require(msg.value >= amount * candyPrice, "You must pay at least 1 ether per candy");
            require(candyBalances[address(this)] >= amount, "OOPS! Not enough candy");
            balance += msg.value; // keep track of balance (in WEI)
            candyBalances[address(this)] -= amount;
            candyBalances[address(msg.sender)] += amount;
            return amount;
        }
        revert("Invalid product");
    }

    //-----------------------------------------------------------------------------------------------------------------------------------------------------
    
    //Devuelve la cantidad de galletas que tiene un usuario específico. Solo es accesible internamente dentro del contrato.
    function getMyCookieBalance(address user) private view returns (uint) {
        return cookieBalances[user];
    }

    //Devuelve la cantidad de donuts que tiene un usuario específico. Solo es accesible internamente dentro del contrato.
    function getMyDonutBalance(address user) private view returns (uint) {
        return donutBalances[user];
    }

    //Devuelve la cantidad de caramelos que tiene un usuario específico. Solo es accesible internamente dentro del contrato.
    function getMyCandyBalance(address user) private view returns (uint) {
        return candyBalances[user];
    }

    //Los métodos anteriores deben ser declarados como privados para que los address sean accesibles.

    //-----------------------------------------------------------------------------------------------------------------------------------------------------

    //Devuelve la cantidad disponible en inventario de un producto específico en el contrato, visible para cualquier usuario.
    function getProductStocks(product _product) public view returns (uint) // Comprobacion del stock de la tienda (this)
    {
        require(uint8(_product) <= 2,'Not a valid product');
        if(_product == product.DONUT){
            return donutBalances[address(this)];
        }
        if(_product == product.COOKIE){
            return cookieBalances[address(this)];
        }
        if(_product == product.CANDY){
            return candyBalances[address(this)];
        }
        revert("Invalid product");
    }

    //-----------------------------------------------------------------------------------------------------------------------------------------------------

    // Permite al propietario del contrato añadir más galletas al inventario.
    function restockCookies(uint amount) public // restock de la tienda
    {
        require(msg.sender == owner, "Only owner can restock the cookies!");
        cookieBalances[address(this)]+= amount;
    }
    
    //Permite al propietario del contrato añadir más donuts al inventario.
    function restockDonuts(uint amount) public // restock de la tienda
    {
        require(msg.sender == owner, "Only owner can restock the donuts!");
        donutBalances[address(this)]+= amount;
    }

    //Permite al propietario del contrato añadir más caramelos al inventario.
    function restockCandy(uint amount) public // restock de la tienda
    {
        require(msg.sender == owner, "Only owner can restock the candy!");
        candyBalances[address(this)]+= amount;
    }

    //-----------------------------------------------------------------------------------------------------------------------------------------------------

    //Permite al propietario retirar una cantidad específica de ether del balance del contrato a una dirección dada.
    function withdraw(uint amount, address payable destAddr) public // retirada del dinero
    { 
        require(msg.sender == owner, "Only owner can withdraw");
        require(amount <= balance, "Insufficient funds");
        
        destAddr.transfer(amount); // send funds to given address
        balance -= amount;
    }

    //-----------------------------------------------------------------------------------------------------------------------------------------------------
    
    //Devuelve los balances de todos los productos para un usuario específico, permitiendo que el usuario conozca su inventario de productos comprados.
    function getUserBalances(address user) public view returns (uint donuts, uint cookies, uint candies) {
        return (getMyDonutBalance(user), getMyCookieBalance(user), getMyCandyBalance(user));
    }

    //-----------------------------------------------------------------------------------------------------------------------------------------------------

}