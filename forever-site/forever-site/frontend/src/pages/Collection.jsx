import React from 'react';
import { products } from '../assets/assets';
import ProductItem from '../components/ProductItem';

const Collection = () => {
  return (
    <div style={{ padding: '40px' }}>
      <div style={{ display: 'flex', flexWrap: 'wrap', gap: '40px' }}>
        
        {/* Left Sidebar Filters */}
        <div style={{ minWidth: '200px' }}>
          <p style={{ fontSize: '20px', marginBottom: '20px', letterSpacing: '1px' }}>FILTERS</p>
          <div style={{ border: '1px solid #eee', padding: '20px', marginBottom: '20px' }}>
            <p style={{ fontWeight: '600', marginBottom: '10px' }}>CATEGORIES</p>
            <p><input type="checkbox" /> Men</p>
            <p><input type="checkbox" /> Women</p>
            <p><input type="checkbox" /> Kids</p>
          </div>
        </div>

        {/* Right Side: Product Grid */}
        <div style={{ flex: 1 }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
            <h2 style={{ fontSize: '24px', fontWeight: '400' }}>ALL COLLECTIONS</h2>
            <select style={{ padding: '10px', border: '1px solid #ccc', fontSize: '14px' }}>
              <option value="relevant">Sort by: Relevant</option>
              <option value="low-high">Price: Low to High</option>
              <option value="high-low">Price: High to Low</option>
            </select>
          </div>

          {/* Map through all 20 products */}
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(200px, 1fr))', gap: '20px' }}>
            {products.map((item, index) => (
              <ProductItem key={index} id={item._id} name={item.name} image={item.image} price={item.price} />
            ))}
          </div>
        </div>
      </div>
    </div>
  );
};

export default Collection;