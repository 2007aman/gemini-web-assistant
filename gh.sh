#!/bin/bash

# ==========================================
# MATRIX OPERATIONS TOOL - SETUP SCRIPT
# ==========================================

echo ">>> Starting project initialization..."

# 1. Create requirements.txt
cat <<EOF > requirements.txt
flask==3.0.0
numpy==1.26.0
EOF

# 2. Create README.md
cat <<EOF > README.md
# Matrix Engine

A specialized tool for linear algebra tasks. This application allows users to input 
matrices and perform calculations like addition, multiplication, and determinants.

## Quick Launch
1. Setup environment: ./setup.sh
2. Open: http://127.0.0.1:5000

## Format Guide
Input matrices using commas for columns and semicolons for rows.
Example: 1,2;3,4
EOF

# 3. Create the Front-end (templates/index.html)
mkdir -p templates
cat <<EOF > templates/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Matrix Engine</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body { background-color: #0f172a; color: #f8fafc; font-family: monospace; }
        .neon-border { border: 1px solid #38bdf8; box-shadow: 0 0 8px #0ea5e9; }
        textarea { background: #1e293b; border: 1px solid #334155; padding: 12px; width: 100%; height: 100px; outline: none; transition: 0.3s; }
        textarea:focus { border-color: #38bdf8; }
        button { background: #0369a1; padding: 8px 16px; border-radius: 2px; font-weight: bold; }
        button:hover { background: #0ea5e9; }
    </style>
</head>
<body class="p-6 md:p-12">
    <div class="max-w-4xl mx-auto">
        <h1 class="text-3xl font-bold text-sky-400 mb-2 uppercase tracking-tighter">Matrix Ops Tool</h1>
        <p class="text-slate-500 mb-10 italic">Linear Algebra Computation Interface</p>
        
        <div class="grid md:grid-cols-2 gap-8 mb-8">
            <div>
                <label class="block text-xs text-sky-300 mb-2 uppercase font-bold">Matrix A</label>
                <textarea id="m1" placeholder="e.g., 1,2;3,4"></textarea>
            </div>
            <div>
                <label class="block text-xs text-sky-300 mb-2 uppercase font-bold">Matrix B</label>
                <textarea id="m2" placeholder="e.g., 5,6;7,8"></textarea>
            </div>
        </div>

        <div class="flex flex-wrap gap-4 mb-12">
            <button onclick="runOp('add')">ADD</button>
            <button onclick="runOp('sub')">SUB</button>
            <button onclick="runOp('mul')">MULTIPLY</button>
            <button onclick="runOp('transpose')" class="bg-slate-700">TRANSPOSE A</button>
            <button onclick="runOp('det')" class="bg-slate-700">DETERMINANT A</button>
        </div>

        <div id="res-box" class="hidden p-6 rounded bg-slate-800 neon-border">
            <h2 class="text-sky-400 font-bold mb-4 uppercase text-sm">Computation Result</h2>
            <pre id="display" class="text-xl leading-relaxed text-sky-100"></pre>
        </div>
    </div>

    <script>
        async function runOp(op) {
            const out = document.getElementById('res-box');
            const disp = document.getElementById('display');
            
            const res = await fetch('/calculate', {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify({
                    m1: document.getElementById('m1').value,
                    m2: document.getElementById('m2').value,
                    op: op
                })
            });
            const data = await res.json();
            out.classList.remove('hidden');
            if(data.error) {
                disp.innerText = "Error: " + data.error;
                disp.style.color = "#f87171";
            } else {
                disp.innerText = Array.isArray(data.result) ? 
                    data.result.map(r => "[ " + r.join('  ') + " ]").join('\\n') : data.result;
                disp.style.color = "#7dd3fc";
            }
        }
    </script>
</body>
</html>
EOF

# 4. Create the Back-end (app.py)
cat <<EOF > app.py
from flask import Flask, render_template, request, jsonify
import numpy as np

app = Flask(__name__)

def parse_input(raw):
    try:
        return np.array([list(map(float, r.split(','))) for r in raw.strip().split(';') if r])
    except:
        return None

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/calculate', methods=['POST'])
def calculate():
    data = request.json
    m1 = parse_input(data.get('m1', ''))
    op = data.get('op')
    
    if m1 is None:
        return jsonify(error="Invalid Matrix A format"), 400

    try:
        if op == "transpose":
            res = m1.T.tolist()
        elif op == "det":
            if m1.shape[0] != m1.shape[1]:
                return jsonify(error="Must be square for determinant"), 400
            res = round(float(np.linalg.det(m1)), 2)
        else:
            m2 = parse_input(data.get('m2', ''))
            if m2 is None: return jsonify(error="Invalid Matrix B format"), 400
            if op == "add": res = (m1 + m2).tolist()
            elif op == "sub": res = (m1 - m2).tolist()
            elif op == "mul": res = np.matmul(m1, m2).tolist()
            
        return jsonify(result=res)
    except Exception as e:
        return jsonify(error=str(e)), 400

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
EOF

# 5. Environment Setup
echo ">>> Setting up Python virtual environment..."
python3 -m venv venv
source venv/bin/activate

echo ">>> Installing dependencies..."
pip install -r requirements.txt

echo ">>> All systems ready."
echo ">>> Server starting on http://127.0.0.1:5000"
python3 app.pyMake the script executable: chmod +x setup.sh.
