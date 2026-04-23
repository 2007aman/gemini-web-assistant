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
