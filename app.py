from flask import Flask, render_template, send_from_directory

app = Flask(__name__)

@app.route('/')
def home():
    return render_template("index.html")

@app.route('/download/windows')
def download_windows():
    return send_from_directory('static', 'run_windows.bat', as_attachment=True)

@app.route('/download/linux')
def download_linux():
    return send_from_directory('static', 'run_linux.sh', as_attachment=True)

if __name__ == '__main__':
    app.run(debug=True, port=8080)
