from flask import Flask, render_template, send_from_directory
import platform


app = Flask(__name__)

print(platform.system())

@app.route('/')
def home():
    return render_template("index.html")

@app.route('/download')
def download_pdf():
    return send_from_directory('static', 'example.txt', as_attachment=True)

if __name__ == '__main__':
    app.run(debug=True, port=8080)
