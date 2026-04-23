import React from 'react';
import { Link } from 'react-router-dom';

const ProductItem = ({ id, image, name, price }) => {
  return (
    <Link style={{ textDecoration: 'none', color: 'inherit' }} to={`/product/${id}`}>
      <div style={{ overflow: 'hidden', cursor: 'pointer' }}>
        <img 
          style={{ width: '100%', transition: '0.3s' }} 
          onMouseOver={e => e.target.style.transform = 'scale(1.1)'}
          onMouseOut={e => e.target.style.transform = 'scale(1)'}
          src={image} 
          alt={name} 
        />
      </div>
      <p style={{ paddingTop: '12px', paddingBottom: '4px', fontSize: '14px' }}>{name}</p>
      <p style={{ fontSize: '14px', fontWeight: '500' }}>${price}</p>
      <p style={{fontSize:'14px', fontweight:'600',backgroundColor:'yellow'}}>reviews</p>
      <p style={{fontsize:'20px', backgroundColor:'red',textBoxEdge:'ideographic-ink'}}>BUY-NOW</p>
      
    </Link>
  );
};
export default ProductItem;
