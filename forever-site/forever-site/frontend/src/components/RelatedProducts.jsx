import React from 'react';
import { products } from '../assets/assets';
import ProductItem from './ProductItem';

const RelatedProducts = ({category}) => {
  const related = products.filter(item => item.category === category).slice(0, 4);
  return (
    <div style={{ margin: '80px 0' }}>
      <div style={{ textAlign: 'center', fontSize: '24px', paddingBottom: '24px' }}>
        <h2>RELATED <span style={{ fontWeight: 'bold' }}>PRODUCTS</span></h2>
      </div>
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(200px, 1fr))', gap: '16px' }}>
        {related.map((item, index) => (
          <ProductItem key={index} id={item._id} name={item.name} image={item.image} price={item.price} />
        ))}
      </div>
    </div>
  );
};
export default RelatedProducts;
