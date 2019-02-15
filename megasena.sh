#!/bin/bash
# Coloque aqui embaixo suas seis dezenas da megasena
  
NUMEROS=(05 10 15 20 25 30)

# Agora vamos pegar os resultados no site da CEF atraves de wget
JSONFILE=$(wget http://loterias.caixa.gov.br/wps/portal/loterias/landing/megasena/\!ut/p/a1/04_Sj9CPykssy0xPLMnMz0vMAfGjzOLNDH0MPAzcDbwMPI0sDBxNXAOMwrzCjA0sjIEKIoEKnN0dPUzMfQwMDEwsjAw8XZw8XMwtfQ0MPM2I02-AAzgaENIfrh-FqsQ9wNnUwNHfxcnSwBgIDUyhCvA5EawAjxsKckMjDDI9FQE-F4ca/dl5/d5/L2dBISEvZ0FBIS9nQSEh/pw/Z7_HGK818G0KO6H80AU71KG7J0072/res/id=buscaResultado/c=cacheLevelPage/=/?timestampAjax=1528890918492 -qO-)

# A função getValor() ficará responsavel por extrair as infomacoes do JSON
getValor() {
	JSON=$JSONFILE
	VALOR=$(echo $JSON | grep -o "$1.*" | cut -f2 -d:| cut -f1 -d , | tr --delete \" | sed 's/-/ /g' | sed 's/}/ /g')
	echo $VALOR
}

# Utilizando o getValor pega cada um dos valores
CONCURSO=$(getValor concurso)
EXTRAI=$(getValor resultado)
DATA=$(getValor data)
DATA=$(getValor dataStr)
LOCAL=$(getValor de_local_sorteio)
CIDADE=$(getValor no_cidade)
UF=$(getValor sg_uf)
RESULTADO=($EXTRAI)
GANHADORES=$(getValor ganhadores)
PREMIO1=$(getValor valor)
GANHADORQUINA=$(getValor ganhadores_quina)
PREMIO2=$(getValor valor_quina)
GANHADORQUADRA=$(getValor ganhadores_quadra)
PREMIO3=$(getValor valor_quadra)
ACUMULADO=$(getValor valor_acumulado)
PROXIMO=$(getValor dt_proximo_concursoStr)
ESTIMATIVA=$(getValor vr_estimativa)


#echo "Validando resultado ..."

for i in {0..5}
	do
	# echo "Checando a dezena ${NUMEROS[$i]}"
	if [[ ${NUMEROS[*]} =~ ${RESULTADO[$i]} ]]
	then
		ACERTOS+=" ${RESULTADO[$i]}"
		let CONTA_ACERTO++
	else
		ERROS+=" ${RESULTADO[$i]}"
	fi
done


for i in {0..5}
         do
         # echo "Checando a dezena ${NUMEROS[$i]}"
         if [[ ${RESULTADO[*]} =~ ${NUMEROS[$i]} ]]
         then
                 CONFERENCIA+=" [${NUMEROS[$i]}]"
         else
                 CONFERENCIA+=" ${NUMEROS[$i]}"
         fi
 done

#coloca espacos no texto
ESP="|           "
#delimita a tela
DELI=" =========================================================================="
echo $DELI
echo "$ESP Concurso...................: $((CONCURSO+1))"
echo "$ESP Data.......................: $DATA"
echo "$ESP Resultado..................: $EXTRAI"
echo "$ESP Local do sorteio...........: $LOCAL"
echo "$ESP Cidade.....................: $CIDADE - $UF"
echo $DELI
echo "$ESP >>> Minhas dezenas $CONFERENCIA <<<"
if [[ $CONTA_ACERTO -eq 4  ]]; then
echo "$ESP        >>> FEZ UMA QUADRA <<<"
elif [[ $CONTA_ACERTO -eq 5 ]]; then
echo "$ESP >>> FEZ UMA QUINA ! ! ! ! ! ! !  <<<"
elif [[ $CONTA_ACERTO -eq 6 ]]; then
echo "$ESP          >>> C A R A L E L E L E O ! ! ! ! <<<"
else
echo "$ESP     >>> Esquente seu pé frio <<< "
fi
echo "$ESP Acertou....................:$ACERTOS "
echo "$ESP Errou......................:$ERROS"
echo "$ESP Ganhador(es)...............: $GANHADORES"
echo "$ESP Premio.....................: R\$ $PREMIO1"
echo "$ESP Ganhador(es) Quina.........: $GANHADORQUINA"
echo "$ESP Premio.....................: R\$ $PREMIO2"
echo "$ESP Ganhador(es) Quadra........: $GANHADORQUADRA"
echo "$ESP Premio.....................: R\$ $PREMIO3"
echo $DELI
echo "$ESP Valor Acumulado............: R\$ $ACUMULADO"
echo "$ESP Estimativa de Premio.......: R\$ $ESTIMATIVA"
echo "$ESP Proximo sorteio............: $PROXIMO"
echo $DELI
echo "                                  \\"
echo "                                   \ _,,"
echo "                                    '-.\="
echo "                                       \\\\=   _.~"
echo "                                      _|/||||)_"
echo "                                      \\        \\"




