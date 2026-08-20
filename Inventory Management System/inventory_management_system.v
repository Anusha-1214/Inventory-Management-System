module inventory_management_system (
    input clk,
    input reset,

    input add_product,
    input remove_stock,
    input search_product,
    input update_price,

    input [3:0] product_id,
    input [7:0] quantity,
    input [15:0] price,

    output reg add_success,
    output reg remove_success,
    output reg product_found,
    output reg update_success,
    output reg insufficient_stock,

    output reg [7:0] product_quantity,
    output reg [15:0] product_price,
    output reg [4:0] product_count
);

    // Maximum 16 products
    reg product_exists [0:15];

    // Product information memory
    reg [7:0] quantity_memory [0:15];
    reg [15:0] price_memory [0:15];

    integer i;

    always @(posedge clk or posedge reset) begin

        if (reset) begin

            product_count <= 5'd0;

            add_success <= 1'b0;
            remove_success <= 1'b0;
            product_found <= 1'b0;
            update_success <= 1'b0;
            insufficient_stock <= 1'b0;

            product_quantity <= 8'd0;
            product_price <= 16'd0;

            // Clear product records
            for (i = 0; i < 16; i = i + 1) begin

                product_exists[i] <= 1'b0;
                quantity_memory[i] <= 8'd0;
                price_memory[i] <= 16'd0;

            end

        end

        else begin

            // Default outputs
            add_success <= 1'b0;
            remove_success <= 1'b0;
            update_success <= 1'b0;
            insufficient_stock <= 1'b0;

            // --------------------------------
            // ADD PRODUCT / ADD STOCK
            // --------------------------------

            if (add_product) begin

                if (!product_exists[product_id]) begin

                    product_exists[product_id] <= 1'b1;

                    quantity_memory[product_id] <= quantity;

                    price_memory[product_id] <= price;

                    product_count <= product_count + 1'b1;

                    add_success <= 1'b1;

                end

                else begin

                    // Product already exists.
                    // Add quantity to existing stock.

                    quantity_memory[product_id] <=
                        quantity_memory[product_id] + quantity;

                    add_success <= 1'b1;

                end

            end

            // --------------------------------
            // REMOVE STOCK
            // --------------------------------

            else if (remove_stock) begin

                if (product_exists[product_id]) begin

                    if (quantity <= quantity_memory[product_id]) begin

                        quantity_memory[product_id] <=
                            quantity_memory[product_id] - quantity;

                        remove_success <= 1'b1;

                    end

                    else begin

                        insufficient_stock <= 1'b1;

                    end

                end

            end

            // --------------------------------
            // UPDATE PRICE
            // --------------------------------

            else if (update_price) begin

                if (product_exists[product_id]) begin

                    price_memory[product_id] <= price;

                    update_success <= 1'b1;

                end

            end

            // --------------------------------
            // SEARCH PRODUCT
            // --------------------------------

            else if (search_product) begin

                if (product_exists[product_id]) begin

                    product_found <= 1'b1;

                    product_quantity <=
                        quantity_memory[product_id];

                    product_price <=
                        price_memory[product_id];

                end

                else begin

                    product_found <= 1'b0;

                    product_quantity <= 8'd0;

                    product_price <= 16'd0;

                end

            end

        end

    end

endmodule
