// OP1: insertMany() — insert all 3 documents from sample_documents.json
db.products.insertMany([
  {
    _id: "prod_001",
    category: "Electronics",
    name: "Samsung 55-inch 4K Smart TV",
    brand: "Samsung",
    price: 45000,
    specs: {
      screen_size_inch: 55,
      resolution: "3840x2160",
      voltage: "220V",
      warranty_years: 2,
      smart_features: ["Netflix", "YouTube", "Hotstar"]
    },
    in_stock: true,
    tags: ["tv", "smart", "4k", "samsung"]
  },
  {
    _id: "prod_002",
    category: "Clothing",
    name: "Men's Slim Fit Chinos",
    brand: "Levi's",
    price: 1999,
    attributes: {
      sizes_available: ["S", "M", "L", "XL"],
      colors: ["beige", "navy", "olive"],
      fabric: "98% Cotton, 2% Elastane",
      care_instructions: "Machine wash cold, do not tumble dry"
    },
    in_stock: true,
    tags: ["men", "casual", "chinos", "bottomwear"]
  },
  {
    _id: "prod_003",
    category: "Groceries",
    name: "Organic Rolled Oats 1kg",
    brand: "True Elements",
    price: 349,
    attributes: {
      weight_grams: 1000,
      expiry_date: new Date("2024-12-31"),
      nutritional_info: { calories_per_100g: 389, protein_g: 17, carbs_g: 66, fat_g: 7 },
      allergens: ["gluten"],
      organic_certified: true
    },
    in_stock: true,
    tags: ["healthy", "breakfast", "organic", "oats"]
  }
]);

// OP2: find() — retrieve all Electronics products with price > 20000
db.products.find({ category: "Electronics", price: { $gt: 20000 } });

// OP3: find() — retrieve all Groceries expiring before 2025-01-01
db.products.find({
  category: "Groceries",
  "attributes.expiry_date": { $lt: new Date("2025-01-01") }
});

// OP4: updateOne() — add a "discount_percent" field to a specific product
db.products.updateOne(
  { _id: "prod_001" },
  { $set: { discount_percent: 10 } }
);

// OP5: createIndex() — create an index on category field and explain why

db.products.createIndex({ category: 1 });
