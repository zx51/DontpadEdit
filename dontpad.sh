#!/usr/bin/env bash
##################### LEIA-ME ANTES! ####################
# Script automatizado para modificar páginas do site dontpad.com
# É apenas para fins didáticos, desenvolvido em shell script
# Por favor, não destrua essa página.

# Declarações
_text=""
_page=""

MENSAGEM_USO="
Uso:	$(basename "$0") [OPÇÕES]

OPÇÕES:
	-h, --help	Mostra esta tela de ajuda e sai
	-p, --page	Especifica a página para edição
	-s, --string	Escreve a string no site
"

# Validação
function isValid() {
	if test -z "$1";then
		echo "Faltou informação em algum argumento"
		exit 1
	fi
}

# set params
while test -n "$1"
do
	case "$1" in
		-h | --help)
			echo "$MENSAGEM_USO"
			exit 0
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

# Testar se variaveis foram preenchidas
if test "$_text" = ""; then
	echo "Não foi definido um texto para a página"
	echo "$MENSAGEM_USO"
	exit 1
fi

if test "$_page" = "";then
	echo "Não foi definido um título para a página"
	echo "$MENSAGEM_USO"
	exit 1
fi

# Função para editar uma página
function dontpadEdit() {
	curl -s -o /dev/null https://api.dontpad.com/$_page -d "text=$_text"
	echo "A página $_page foi modificada para o texto: $_text"
	exit 0
}

dontpadEdit
