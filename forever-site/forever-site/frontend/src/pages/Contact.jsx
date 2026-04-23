import React from 'react';

const Contact = () => {
  return (
    <div style={{ padding: '60px 40px' }}>
      <div style={{ textAlign: 'center', marginBottom: '40px' }}>
        <h2 style={{ fontSize: '28px', letterSpacing: '2px', fontWeight: '400' }}>
          CONTACT <span style={{ fontWeight: '700' }}>US</span>
        </h2>
      </div>

      <div style={{ display: 'flex', gap: '80px', justifyContent: 'center', alignItems: 'flex-start', maxWidth: '1000px', margin: '0 auto' }}>
        {/* Left Side: Image Placeholder */}
        <div style={{ flex: 1, backgroundColor: '#f4f4f4', height: '400px', width: '100%' }}>
          {/* You can replace this div with an <img> tag later */}
        </div>

        {/* Right Side: Contact Info */}
        <div style={{ flex: 1, display: 'flex', flexDirection: 'column', gap: '25px', color: '#414141' }}>
          <div>
            <p style={{ fontWeight: 'bold', fontSize: '18px', marginBottom: '10px' }}>Our Store</p>
            <p style={{ margin: '5px 0' }}>54709 Willms Station</p>
            <p style={{ margin: '5px 0' }}>Suite 350, Washington, USA</p>
          </div>

          <div>
            <p style={{ margin: '5px 0' }}>Tel: (415) 555-0132</p>
            <p style={{ margin: '5px 0' }}>Email: admin@forever.com</p>
          </div>

          <div>
            <p style={{ fontWeight: 'bold', fontSize: '18px', marginBottom: '10px' }}>Careers at Forever</p>
            <p style={{ margin: '5px 0' }}>Learn more about our teams and job openings.</p>
            <button style={{ 
              marginTop: '20px', 
              padding: '15px 30px', 
              border: '1px solid #000', 
              background: 'transparent', 
              cursor: 'pointer',
              transition: '0.3s'
            }}>
              Explore Jobs
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Contact;
