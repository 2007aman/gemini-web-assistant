import React from 'react';

const Cart = () => {
  return (
    <div style={{ padding: '40px' }}>
      <h2 style={{ fontSize: '24px', borderBottom: '2px solid #000', paddingBottom: '10px', width: 'fit-content' }}>YOUR CART</h2>
      <div style={{ marginTop: '40px', textAlign: 'center', padding: '100px', border: '1px dashed #ccc' }}>
        <p>Your shopping bag is currently empty.</p>
        <button style={{ background: '#000', color: '#fff', padding: '10px 30px', marginTop: '20px', cursor: 'pointer' }}>CONTINUE SHOPPING</button>
      </div>
    </div>
  );
};
export default Cart;
