import React from 'react';

const About = () => {
  return (
    <div style={{ padding: '60px 40px', textAlign: 'center' }}>
      <h2 style={{ fontSize: '32px', letterSpacing: '2px' }}>ABOUT US</h2>
      <div style={{ display: 'flex', gap: '40px', marginTop: '40px', alignItems: 'center', textAlign: 'left' }}>
        <div style={{ flex: 1, backgroundColor: '#f4f4f4', height: '400px' }}><img src='/home/aman/Downloads/Gemini_Generated_Image_iylsu6iylsu6iyls.png'></img></div>
        <div style={{ flex: 1 }}>
          <p>Forever was born out of a passion for customer convenience and premium quality.</p>
          <p>Our mission is to provide an effortless shopping experience that brings the latest trends directly to your doorstep.</p>
        </div>
      </div>
    </div>
  );
};
export default About;
