import React from 'react';

const Footer = () => {
  return (
    <div style={{ padding: '80px 40px 20px 40px', borderTop: '1px solid #eee', marginTop: '40px' }}>
      <div style={{ display: 'grid', gridTemplateColumns: '3fr 1fr 1fr', gap: '80px', marginBottom: '40px' }}>
        <div>
          <h1 style={{ letterSpacing: '4px', marginBottom: '20px' }}>FOREVER.</h1>
          <p style={{ color: '#666', lineHeight: '1.6', width: '80%' }}>
            Your destination for premium fashion and quality lifestyle. 
            Elevating your everyday wardrobe with timeless pieces.
          </p>
        </div>
        <div>
          <p style={{ fontWeight: 'bold', marginBottom: '20px' }}>COMPANY</p>
          <p style={{ color: '#666', margin: '5px 0' }}>Home</p>
          <p style={{ color: '#666', margin: '5px 0' }}>About us</p>
          <p style={{ color: '#666', margin: '5px 0' }}>Delivery</p>
          <p style={{ color: '#666', margin: '5px 0' }}>Privacy Policy</p>
        </div>
        <div>
          <p style={{ fontWeight: 'bold', marginBottom: '20px' }}>GET IN TOUCH</p>
          <p style={{ color: '#666', margin: '5px 0' }}>+91-123-456-7890</p>
          <p style={{ color: '#666', margin: '5px 0' }}>contact@forever.com</p>
        </div>
      </div>
      <p style={{ textAlign: 'center', borderTop: '1px solid #eee', paddingTop: '20px', color: '#666', fontSize: '12px' }}>
        Copyright 2026 @ Forever.com - All Rights Reserved.
      </p>
    </div>
  );
};
export default Footer;
