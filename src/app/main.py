from flask import Flask, request, jsonify
from flask_basicauth import BasicAuth
from textblob import TextBlob
from sklearn.linear_model import LinearRegression
import pickle
import os

colunas = ["tamanho", "ano", "garagem"]
modelo = pickle.load(open("../../models/modelo.sav", "rb"))

app = Flask(__name__)
app.config["BASIC_AUTH_USERNAME"] = os.environ.get("BASIC_AUTH_USERNAME")
app.config["BASIC_AUTH_PASSWORD"] = os.environ.get("BASIC_AUTH_PASSWORD")

basic_auth = BasicAuth(app)

@app.route("/")

def home():
    return "Minha primeira API."

@app.route("/sentiment-analysis/<frase>")
@basic_auth.required

def sentimento(frase):
    tb = TextBlob(frase)
    tb = tb.translate(from_lang='pt', to='en')
    polarity = tb.sentiment.polarity
    return "A polaridade do texto é: {}".format(polarity)

@app.route("/quotation/", methods=["POST"])
@basic_auth.required

def quotation():
    dados = request.get_json()
    dados_input = [dados[col] for col in colunas]
    price = modelo.predict([dados_input])
    return jsonify(price=price[0])

app.run(debug=True, host="0.0.0.0", port=8080)
