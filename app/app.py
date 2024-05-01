from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route("/health", methods=["GET"])
def health():
    if (request.method == "GET"):
        user_data = { 
            "error":  "false",
            "result": "Healthy"
        }
    
    return jsonify(user_data), 200

if __name__ == "__main__":
    app.run(debug=True)