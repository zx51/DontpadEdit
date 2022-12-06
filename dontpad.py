#!/usr/bin/env python
# Importa bibliotecas
import requests
import argparse

# Trata argumentos
parser = argparse.ArgumentParser(description="Modifica paginas dontpad")
parser.add_argument('-s', '--string', required=True, help="Insere a string na página.")
parser.add_argument('-p', '--page', required=True, help="Estipula a página a ser alterada")
args = parser.parse_args()

# Armazena argumentos
page = str(args.page)
text = str(args.string)

# Prepara requisição
url = "https://api.dontpad.com/"   page
data = {
	'text': text
}

requisicao = requests.post(url, data=data)
print(f"A página {page} foi modificada para o texto: {text}")
