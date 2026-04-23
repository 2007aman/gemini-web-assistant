import React, { useState } from 'react';
import { Routes, Route, Link } from 'react-router-dom';
import { ShoppingBag, User, Search, PhoneCall, X } from 'lucide-react';

// Import your pages
import Home from './pages/Home';
import Collection from './pages/Collection';
import About from './pages/About';
import Cart from './pages/Cart';
import Contact from './pages/Contact';
import Footer from './components/Footer';

// 1. IMPORT YOUR LOGO HERE
import logo from './assets/logo.png'; 

export default function App() {
  const [showSearch, setShowSearch] = useState(false);
  const [search, setSearch] = useState('');

  return (
    <div style={{ fontFamily: 'sans-serif', minHeight: '100vh', display: 'flex', flexDirection: 'column' }}>
      
      {/* --- NAVBAR --- */}
      <nav style={{ 
        display: 'flex', 
        justifyContent: 'space-between', 
        padding: '10px 40px', 
        borderBottom: '1px solid #eee', 
        alignItems: 'center', 
        backgroundColor: '#fff', 
        position: 'sticky', 
        top: 0, 
        zIndex: 10 
      }}>
        
        {/* Logo Section */}
        <Link to="/" style={{ textDecoration: 'none', display: 'flex', alignItems: 'center' }}>
          <img 
            src={logo} 
            alt="Forever Logo" 
            style={{ 
              height: '60px', // Slightly larger to show the detail
              width: 'auto',
              objectFit: 'contain'
            }} 
          />
        </Link>
        
        {/* Navigation Links */}
        <div style={{ display: 'flex', gap: '30px' }}>
           <Link to="/" style={{ textDecoration: 'none', color: '#333', fontWeight: '500', fontSize: '14px', letterSpacing: '1px' }}>HOME</Link>
           <Link to="/collection" style={{ textDecoration: 'none', color: '#333', fontWeight: '500', fontSize: '14px', letterSpacing: '1px' }}>COLLECTION</Link>
           <Link to="/about" style={{ textDecoration: 'none', color: '#333', fontWeight: '500', fontSize: '14px', letterSpacing: '1px' }}>ABOUT</Link>
           <Link to="/contact" style={{ textDecoration: 'none', color: '#333', fontWeight: '500', fontSize: '14px', letterSpacing: '1px' }}>CONTACT</Link>
        </div>

        {/* Icon Toolbar */}
        <div style={{ display: 'flex', gap: '22px', alignItems: 'center' }}>
          <Search size={20} onClick={() => setShowSearch(true)} style={{ cursor: 'pointer' }} />
          <User size={20} style={{ cursor: 'pointer' }} />
          
          <Link to="/cart" style={{ position: 'relative' }}>
            <ShoppingBag size={20} color="black" />
            {/* Small notification dot for style */}
            <span style={{ position: 'absolute', right: '-5px', bottom: '-2px', backgroundColor: 'black', color: 'white', borderRadius: '50%', padding: '2px 5px', fontSize: '8px' }}>0</span>
          </Link>
          
          <a href="tel:+911234567890" style={{ color: 'inherit' }}>
            <PhoneCall size={20} style={{ cursor: 'pointer' }} />
          </a>
        </div>
      </nav>

      {/* --- SEARCH BAR --- */}
      {showSearch && (
        <div style={{ borderBottom: '1px solid #eee', backgroundColor: '#f9f9f9', padding: '15px 0', display: 'flex', justifyContent: 'center', alignItems: 'center' }}>
          <div style={{ display: 'inline-flex', alignItems: 'center', border: '1px solid #ccc', padding: '8px 20px', borderRadius: '50px', width: '50%', backgroundColor: '#fff' }}>
            <input 
              autoFocus
              type="text" 
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              placeholder="Search for products..." 
              style={{ flex: 1, border: 'none', outline: 'none', fontSize: '14px' }} 
            />
            <Search size={16} color="#666" />
          </div>
          <X 
            size={20} 
            onClick={() => { setShowSearch(false); setSearch(''); }} 
            style={{ marginLeft: '15px', cursor: 'pointer', color: '#666' }} 
          />
        </div>
      )}

      {/* --- MAIN CONTENT --- */}
      <main style={{ flex: 1 }}>
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/collection" element={<Collection />} />
          <Route path="/about" element={<About />} />
          <Route path="/cart" element={<Cart />} />
          <Route path="/contact" element={<Contact />} />
        </Routes>
      </main>
      

      <Footer />
    </div>
  );
}
