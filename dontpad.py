#!/usr/bin/env python

# Com esse script é possível alterar ou visualizar o conteúdo de páginas do site https://dontpad.com/ 
# Para mudar o conteúdo: python ./dontpad.py [-a edit] -p "nome_da_pagina" -s "texto"  
# Para obter o conteúdo: python ./dontpad.py -a view -p "nome_da_pagina"

# Importa bibliotecas
import requests
import argparse

# Trata argumentos
parser = argparse.ArgumentParser(description="Modifica paginas dontpad")
parser.add_argument('-s', '--string', type=str, required=False, help="Insere a string na página.", default="")
parser.add_argument('-p', '--page', type=str, required=True, help="Estipula a página a ser alterada")
parser.add_argument('-a', '--action', type=str, required=True, help="Escolhe entre os modos EDIT/VIEW", default="edit")
args = parser.parse_args()

# Armazena argumentos
page = args.page
text = args.string
action = args.action

def dontpadEdit():
	url = "https://api.dontpad.com/"   page
	payload = {
		'text': text
	}
	requisicao = requests.post(url, data=payload)
	print(f"A página {page} foi modificada para o texto: {text}")
	exit(0)

def dontpadView():
	url = "https://api.dontpad.com/"   page   ".body.json"
	params = {
		'lastModified': 0
	}
	requisicao = requests.get(url, params=params)
	text = requisicao.json()
	print(text["body"])
	exit(0)


if action == "edit":
	dontpadEdit()
elif action == "view":
	dontpadView()
else:
	print("Algo deu errado! digite: \"edit\" ou \"view\"")
