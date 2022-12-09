#!/usr/bin/env bash

# Variaveis e chaves
_text=""
_page=""
EDIT=0
VIEW=0

MENSAGEM_USO="
Uso:	$(basename "$0") -e/-v -p 'pagina' -s 'texto'

OPÇÕES:
	-h, --help	Mostra esta tela de ajuda e sai
	-e, --edit	Edita a página, juntamente com o -p e -s
	-v, --view	Visualiza o texto da página
	-p, --page	Especifica a página para edição
	-s, --string	Escreve a string no site
"

# Validação de parametros
function isValid() {
	if test -z "$1"
	then
		echo "Faltou informação em algum argumento"
		exit 1
	fi
}

while test -n "$1"
do
	case "$1" in
		-h | --help)
			echo "$MENSAGEM_USO"
			exit 0
		;;

		-e | --edit)
			EDIT=1
		;;

		-v | --view)
			VIEW=1
		;;

		-s | --string)
			shift
			_text="$1"
			isValid $_text
		;;

		-p | --page)
			shift
			_page="$1"
			isValid $_page
		;;

		*)
			echo "Opção inválida"
			exit 1
		;;
	esac
	shift
done

# Validação da página
if [ "$_page" = "" ]
then
	echo "É necessário informar uma página"
	exit 1
fi

# Função para editar uma página
function dontpadEdit() {
	curl -s -o /dev/null https://api.dontpad.com/$_page -d "text=$_text"
	echo "A página $_page foi modificada para o texto: $_text"
	exit 0
}

# Função para trazer o conteúdo da página
function dontpadView() {
	curl -s https://api.dontpad.com/$_page.body.json?lastModified=0 | jq '.body'
	exit 0
}

# Verifica função a ser executada
test $EDIT -eq 1 && dontpadEdit
test $VIEW -eq 1 && dontpadView
echo "Algo deu errado, use a opção -h"
