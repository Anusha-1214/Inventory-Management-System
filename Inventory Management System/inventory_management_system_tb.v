`timescale 1ns/1ps

module inventory_management_system_tb;

    reg clk;
    reg reset;

    reg add_product;
    reg remove_stock;
    reg search_product;
    reg update_price;

    reg [3:0] product_id;
    reg [7:0] quantity;
    reg [15:0] price;

    wire add_success;
    wire remove_success;
    wire product_found;
    wire update_success;
    wire insufficient_stock;

    wire [7:0] product_quantity;
    wire [15:0] product_price;
    wire [4:0] product_count;


    // --------------------------------
    // DUT
    // --------------------------------

    inventory_management_system DUT (

        .clk(clk),
        .reset(reset),

        .add_product(add_product),
        .remove_stock(remove_stock),
        .search_product(search_product),
        .update_price(update_price),

        .product_id(product_id),
        .quantity(quantity),
        .price(price),

        .add_success(add_success),
        .remove_success(remove_success),
        .product_found(product_found),
        .update_success(update_success),
        .insufficient_stock(insufficient_stock),

        .product_quantity(product_quantity),
        .product_price(product_price),
        .product_count(product_count)
    );


    // --------------------------------
    // CLOCK
    // --------------------------------

    always #5 clk = ~clk;


    initial begin

        // --------------------------------
        // INITIAL VALUES
        // --------------------------------

        clk = 0;
        reset = 1;

        add_product = 0;
        remove_stock = 0;
        search_product = 0;
        update_price = 0;

        product_id = 0;
        quantity = 0;
        price = 0;


        // --------------------------------
        // RESET
        // --------------------------------

        #10;
        reset = 0;


        // --------------------------------
        // ADD PRODUCT 1
        // Quantity = 100
        // Price = 500
        // --------------------------------

        product_id = 4'd1;
        quantity = 8'd100;
        price = 16'd500;

        add_product = 1;

        #10;

        add_product = 0;

        $display("--------------------------------");
        $display("Product 1 Added");
        $display("Add Success = %b",
                 add_success);

        $display("Product Count = %d",
                 product_count);


        // --------------------------------
        // SEARCH PRODUCT 1
        // --------------------------------

        search_product = 1;

        #10;

        search_product = 0;

        $display("--------------------------------");
        $display("Searching Product 1");

        $display("Product Found = %b",
                 product_found);

        $display("Quantity = %d",
                 product_quantity);

        $display("Price = %d",
                 product_price);


        // --------------------------------
        // ADD MORE STOCK
        // Add 50
        // --------------------------------

        quantity = 8'd50;

        add_product = 1;

        #10;

        add_product = 0;

        $display("--------------------------------");
        $display("Adding More Stock");

        $display("Add Success = %b",
                 add_success);


        // --------------------------------
        // SEARCH PRODUCT AGAIN
        // --------------------------------

        search_product = 1;

        #10;

        search_product = 0;

        $display("--------------------------------");
        $display("Product After Adding Stock");

        $display("Quantity = %d",
                 product_quantity);


        // --------------------------------
        // REMOVE STOCK
        // Remove 30
        // --------------------------------

        quantity = 8'd30;

        remove_stock = 1;

        #10;

        remove_stock = 0;

        $display("--------------------------------");
        $display("Removing 30 Units");

        $display("Remove Success = %b",
                 remove_success);


        // --------------------------------
        // SEARCH PRODUCT
        // --------------------------------

        search_product = 1;

        #10;

        search_product = 0;

        $display("--------------------------------");
        $display("Product After Removal");

        $display("Quantity = %d",
                 product_quantity);


        // --------------------------------
        // UPDATE PRICE
        // New Price = 600
        // --------------------------------

        price = 16'd600;

        update_price = 1;

        #10;

        update_price = 0;

        $display("--------------------------------");
        $display("Updating Product Price");

        $display("Update Success = %b",
                 update_success);


        // --------------------------------
        // SEARCH PRODUCT
        // --------------------------------

        search_product = 1;

        #10;

        search_product = 0;

        $display("--------------------------------");
        $display("Product After Price Update");

        $display("Quantity = %d",
                 product_quantity);

        $display("Price = %d",
                 product_price);


        // --------------------------------
        // TRY TO REMOVE TOO MUCH STOCK
        // --------------------------------

        quantity = 8'd200;

        remove_stock = 1;

        #10;

        remove_stock = 0;

        $display("--------------------------------");
        $display("Trying to Remove 200 Units");

        $display("Remove Success = %b",
                 remove_success);

        $display("Insufficient Stock = %b",
                 insufficient_stock);


        #10;

        $finish;

    end

endmodule
