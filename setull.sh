#!/bin/bash

# ==========================================
# MATRIX OPERATIONS TOOL - FULL BUNDLE
# ==========================================

PROJECT_DIR="matrix_operations_tool"

echo ">>> Creating project folder: $PROJECT_DIR"
mkdir -p "$PROJECT_DIR/templates"
cd "$PROJECT_DIR" || exit

echo ">>> Generating project source files..."

# 1. Create requirements.txt
cat <<EOF > requirements.txt
flask==3.0.0
numpy==1.26.0
EOF

# 2. Create README.md
cat <<EOF > README.md
# Matrix Engine

A specialized tool for linear algebra tasks. 

## Quick Launch
1. Run the setup script.
2. Access the UI at: http://127.0.0.1:5000

## Matrix Format
Use commas for columns and semicolons for rows.
Example: 1,2;3,4
EOF

# 3. Create the Front-end (templates/index.html)
cat <<EOF > templates/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Matrix Engine</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body { background-color: #0f172a; color: #f8fafc; font-family: 'Courier New', Courier, monospace; }
        .neon-border { border: 1px solid #38bdf8; box-shadow: 0 0 12px #0ea5e9; }
        textarea { background: #1e293b; border: 1px solid #334155; padding: 12px; width: 100%; height: 100px; outline: none; }
        textarea:focus { border-color: #38bdf8; }
        button { background: #0369a1; padding: 10px 20px; border-radius: 4px; font-weight: bold; transition: 0.3s; }
        button:hover { background: #0ea5e9; transform: scale(1.05); }
    </style>
</head>
<body class="p-8 md:p-16">
    <div class="max-w-5xl mx-auto">
        <header class="mb-12">
            <h1 class="text-4xl font-black text-sky-400 tracking-tighter uppercase">Matrix Terminal v1.0</h1>
            <div class="h-1 w-20 bg-sky-500 mt-2"></div>
        </header>
        
        <div class="grid md:grid-cols-2 gap-10 mb-10">
            <div>
                <label class="block text-xs text-sky-400 mb-2 uppercase tracking-widest font-bold">Input Matrix A</label>
                <textarea id="m1" placeholder="1,2;3,4"></textarea>
            </div>
            <div>
                <label class="block text-xs text-sky-400 mb-2 uppercase tracking-widest font-bold">Input Matrix B</label>
                <textarea id="m2" placeholder="5,6;7,8"></textarea>
            </div>
        </div>

        <div class="flex flex-wrap gap-4 mb-12">
            <button onclick="runOp('add')">ADDITION</button>
            <button onclick="runOp('sub')">SUBTRACTION</button>
            <button onclick="runOp('mul')">MULTIPLICATION</button>
            <button onclick="runOp('transpose')" class="bg-slate-700">TRANSPOSE A</button>
            <button onclick="runOp('det')" class="bg-slate-700">DETERMINANT A</button>
        </div>

        <div id="res-box" class="hidden p-8 rounded-lg bg-slate-900 neon-border">
            <h2 class="text-sky-500 font-bold mb-4 uppercase text-sm tracking-widest">Calculated Output</h2>
            <pre id="display" class="text-2xl font-bold text-sky-200"></pre>
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
                disp.innerText = "FAIL: " + data.error;
                disp.className = "text-red-500 text-xl";
            } else {
                disp.innerText = Array.isArray(data.result) ? 
                    data.result.map(r => "[  " + r.join('    ') + "  ]").join('\\n') : data.result;
                disp.className = "text-sky-300 text-2xl";
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

def parse_matrix(raw):
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
    m1 = parse_matrix(data.get('m1', ''))
    op = data.get('op')
    
    if m1 is None:
        return jsonify(error="Matrix A format error"), 400

    try:
        if op == "transpose":
            res = m1.T.tolist()
        elif op == "det":
            if m1.shape[0] != m1.shape[1]:
                return jsonify(error="Requires square matrix"), 400
            res = round(float(np.linalg.det(m1)), 2)
        else:
            m2 = parse_matrix(data.get('m2', ''))
            if m2 is None: return jsonify(error="Matrix B format error"), 400
            if op == "add": res = (m1 + m2).tolist()
            elif op == "sub": res = (m1 - m2).tolist()
            elif op == "mul": res = np.matmul(m1, m2).tolist()
            
        return jsonify(result=res)
    except Exception as e:
        return jsonify(error=str(e)), 400

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
EOF

# 5. Virtual Environment & Dependencies
echo ">>> Initializing environment inside $PROJECT_DIR..."
python3 -m venv venv
source venv/bin/activate

echo ">>> Installing NumPy and Flask..."
pip install --upgrade pip
pip install -r requirements.txt

echo ">>> Setup finished."
echo ">>> Serving Matrix Tool on http://127.0.0.1:5000"
python3 app.py
