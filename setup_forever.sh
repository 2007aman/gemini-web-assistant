#!/bin/bash

# 1. CREATE DIRECTORY STRUCTURE
echo "--- Creating Forever Ecommerce Folders ---"
mkdir -p forever-ecommerce/{frontend/src/{assets,components,pages,context},backend/{core,api}}
cd forever-ecommerce

# 2. CREATE FRONTEND FILES (React + Vite + Tailwind Configuration)
echo "--- Generating Frontend Files ---"

# package.json
cat <<EOF > frontend/package.json
{
  "name": "forever-frontend",
  "private": true,
  "version": "0.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vite build"
  },
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-router-dom": "^6.22.0",
    "axios": "^1.6.7",
    "lucide-react": "^0.344.0"
  },
  "devDependencies": {
    "@types/react": "^18.2.55",
    "@types/react-dom": "^18.2.19",
    "@vitejs/plugin-react": "^4.2.1",
    "vite": "^5.1.4"
  }
}
EOF

# index.html
cat <<EOF > frontend/index.html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Forever Ecommerce</title>
    <style>body { margin: 0; font-family: sans-serif; }</style>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.jsx"></script>
  </body>
</html>
EOF

# src/main.jsx
cat <<EOF > frontend/src/main.jsx
import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App.jsx'
import { BrowserRouter } from 'react-router-dom'

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <BrowserRouter>
      <App />
    </BrowserRouter>
  </React.StrictMode>,
)
EOF

# src/App.jsx (The Main UI)
cat <<EOF > frontend/src/App.jsx
import React from 'react';
import { Routes, Route, Link } from 'react-router-dom';
import { ShoppingBag, User, Search, Menu } from 'lucide-react';

const Navbar = () => (
  <header style={{ padding: '20px 40px', display: 'flex', justifyContent: 'space-between', alignItems: 'center', borderBottom: '1px solid #eaeaet' }}>
    <Link to="/" style={{ fontSize: '24px', fontWeight: 'bold', textDecoration: 'none', color: '#000', letterSpacing: '4px' }}>FOREVER.</Link>
    <div style={{ display: 'flex', gap: '25px', fontSize: '14px', fontWeight: '500' }}>
      <Link to="/" style={{ textDecoration: 'none', color: '#333' }}>HOME</Link>
      <Link to="/collection" style={{ textDecoration: 'none', color: '#333' }}>COLLECTION</Link>
      <Link to="/about" style={{ textDecoration: 'none', color: '#333' }}>ABOUT</Link>
    </div>
    <div style={{ display: 'flex', gap: '20px' }}>
      <Search size={20} />
      <User size={20} />
      <Link to="/cart"><ShoppingBag size={20} color="#000" /></Link>
    </div>
  </header>
);

const Home = () => (
  <div style={{ padding: '50px 40px' }}>
    <div style={{ background: '#f9f9f9', height: '400px', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
      <div style={{ textAlign: 'center' }}>
        <p style={{ letterSpacing: '2px' }}>OUR BESTSELLERS</p>
        <h1 style={{ fontSize: '48px', margin: '10px 0' }}>Latest Arrivals</h1>
        <button style={{ padding: '10px 30px', background: '#000', color: '#fff', border: 'none', cursor: 'pointer' }}>SHOP NOW</button>
      </div>
    </div>
  </div>
);

const App = () => {
  return (
    <div>
      <Navbar />
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/collection" element={ <div style={{padding: '40px'}}><h2>Collection Page</h2></div> } />
        <Route path="/cart" element={ <div style={{padding: '40px'}}><h2>Your Cart is Empty</h2></div> } />
      </Routes>
    </div>
  );
};

export default App;
EOF

# 3. CREATE BACKEND SHELL (No code as requested)
echo "--- Generating Backend Files ---"
touch backend/manage.py
touch backend/requirements.txt
touch backend/core/settings.py
touch backend/core/urls.py
touch backend/api/models.py
touch backend/api/views.py

# 4. FINAL INSTALL & RUN SCRIPT
echo "--- Finalizing ---"
cat <<EOF > start.sh
#!/bin/bash
echo "Starting Frontend..."
cd frontend && npm install && npm run dev
EOF
chmod +x start.sh

echo "SUCCESS! Project 'forever-ecommerce' is ready."
echo "Type: cd forever-ecommerce && ./start.sh"
