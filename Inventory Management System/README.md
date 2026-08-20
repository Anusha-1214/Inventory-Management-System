# Inventory Management System using Verilog

## Description

This project implements a basic Inventory Management System
using Verilog HDL.

The system can manage up to 16 products.

## Features

1. Add product
2. Add stock
3. Remove stock
4. Search product
5. Update product price
6. Check product quantity
7. Check product price
8. Detect insufficient stock
9. Product count
10. Reset functionality

## Product Information

Each product contains:

Product ID
Quantity
Price
Product Status

## Product IDs

Product IDs range from:

0 to 15

## Product Status

1 = Product exists
0 = Product does not exist

## Files

inventory_management_system.v
- Main Verilog design

inventory_management_system_tb.v
- Testbench

README.md
- Project documentation

## Tools Used

- VS Code
- Verilog HDL
- Icarus Verilog
- GTKWave

## Concepts Used

- Sequential logic
- Registers
- Memory arrays
- Counters
- Clock
- Reset
- Conditional statements
- Testbench
