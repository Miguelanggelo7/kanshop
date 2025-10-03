# 🛒 KANTOX - Supermarket Checkout System (Ruby)

This project implements a checkout system in plain Ruby, developed as part of a technical evaluation.  
The focus was on **TDD with RSpec**, designing for extensibility (easy to add new pricing rules or products).

---

## 📌 Requirements

- Implement a `Checkout` system with products and special pricing rules.
- Available products:

| Code | Product      | Base Price |
|------|--------------|------------|
| GR1  | Green tea    | £3.11      |
| SR1  | Strawberries | £5.00      |
| CF1  | Coffee       | £11.23     |

- Special pricing rules:
  - **GR1 (Green Tea):** Buy One Get One Free.  
  - **SR1 (Strawberries):** If you buy 3 or more, price drops to £4.50 each.  
  - **CF1 (Coffee):** If you buy 3 or more, all coffees drop to 2/3 of their original price.  

- Checkout usage should be flexible:
  ```ruby
  co = Checkout.new(pricing_rules)
  co.scan(product)
  co.scan(product)
  total = co.total
