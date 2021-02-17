"use strict";

module.exports = function () {
  return {
    productsList: [
      {
        id: 1,
        name: "Yoga mat",
        description: "Yoga mat with special colors",
        categoryCode: "YMT",
        vendorCode: "LLL",
        sku: "sku123456",
        price: 1.3344,
      },
      {
        id: 2,
        name: "Yoga block",
        description: "Yoga block with special colors",
        categoryCode: "YAC",
        vendorCode: "LLL",
        sku: "sku123457",
        price: 3.3344,
      },
    ],
    /*
     * Retrieve a product with a given id or return all the products if the id is undefined.
     */
    findItems(id) {
      if (id) {
        return this.productsList.find((element) => {
          return element.id === id;
        });
      } else {
        return this.productsList;
      }
    },
    findCategoryItems(category) {
      let result = [];
      if (category) {
        for (let i = 0; i < this.productsList.length; i++){
          if (this.productsList[i].categoryCode === category) {
            result.push(this.productsList[i]);
          }
        }
        };
      return result;
    },
  };
}; 