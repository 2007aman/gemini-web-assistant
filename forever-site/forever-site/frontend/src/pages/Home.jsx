import React from 'react';
// Make sure your image is saved as 'logo.png' in the src/assets folder
import heroLogo from '../assets/logo.png'; 

import latestcollections from '../components/latestcollection';

const Home = () => {
  return (
    <div style={{ color: '#414141' }}>
      {/* --- HERO SECTION --- */}
      <div style={{ 
        display: 'flex', 
        flexWrap: 'wrap', 
        alignItems: 'center', 
        backgroundColor: '#ffffff', // Clean white for the text side
        margin: '20px',
        border: '1px solid #eee',
        overflow: 'hidden'
      }}>
        
        {/* Left Side: Text Content */}
        <div style={{ flex: 1, padding: '60px', minWidth: '300px' }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
            <div style={{ width: '40px', height: '2px', backgroundColor: '#414141' }}></div>
            <p style={{ letterSpacing: '2px', fontWeight: '500', margin: 0 }}>OUR BESTSELLERS</p>
          </div>
          
          <h2 style={{ 
            fontSize: '3.5rem', 
            margin: '20px 0', 
            fontWeight: '400', 
            color: '#000',
            lineHeight: '1.2' 
          }}>
            Latest Arrivals
          </h2>
          
          <div style={{ display: 'flex', alignItems: 'center', gap: '10px', cursor: 'pointer' }}>
            <button style={{ fontWeight: '600', fontSize: '40px' ,backgroundColor:'black',color:'orange'}}>SHOP NOW</button>
            <div style={{ width: '40px', height: '1px', backgroundColor: '#414141' }}></div>
          </div>
        </div>

     
          <div style={{ display: 'flex', alignItems:'left', gap: '10px', cursor: 'pointer',fontsize:'80px' }}>
           <div style={{color:'black',backgroundColor:'grey',fontsize:'80px',fontFamily:'emoji',textAlign:'left',paddingleft:'-500px'}}>FASHION FOR MEN AND WOMEN ! TOP SALES ARE IN THE ACTION</div>
            <div></div>
            <div></div>
          </div>
        {/* Right Side: The Logo Banner */}
        <div style={{ 
          flex: 1, 
          minWidth: '300px', 
          backgroundColor: '#0b0e14', // Matches the dark background of your logo
          display: 'flex', 
          justifyContent: 'center', 
          alignItems: 'center',
          height: '500px' 
        }}>
          <img 
            src={heroLogo} 
            alt="Forever Ecommerce Logo" 
            style={{ 
              width: '90%', 
              maxHeight: '400px', 
              objectFit: 'contain',
              // Subtle glow effect to make the silver pop
              filter: 'drop-shadow(0px 0px 15px rgba(255,255,255,0.1))' 
            }} 
          />
        </div>
      </div>
    </div>
  );

<div>
  <latestcollection/>
</div>
// Set up a timer to change the index every 5000ms (5 seconds)
  
};

export default Home;


