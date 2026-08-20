#!/bin/bash

echo "===================================="
echo "        CALCULADORA EM BASH"
echo "===================================="

while true; do
    echo ""
    read -p "Digite o primeiro numero: " num1
    read -p "Digite a operacao (+, -, *, /): " operacao
    read -p "Digite o segundo numero: " num2

    case $operacao in
        +
            resultado=$(echo "$num1 + $num2" | bc)
            ;;
        -
            resultado=$(echo "$num1 - $num2" | bc)
            ;;
        \*
            resultado=$(echo "$num1 * $num2" | bc)
            ;;
        /
            if [ "$num2" == "0" ]; then
                echo "Erro: divisao por zero nao e permitida."
                resultado=""
            else
                resultado=$(echo "scale=2; $num1 / $num2" | bc)
            fi
            ;;
        *
            echo "Operacao invalida. Use +, -, * ou /."
            resultado=""
            ;;
    esac

    if [ -n "$resultado" ]; then
        echo "Resultado: $num1 $operacao $num2 = $resultado"
    fi

    echo ""
    read -p "Deseja fazer outra operacao? (s/n): " continuar
    if [ "$continuar" != "s" ] && [ "$continuar" != "S" ]; then
        echo "Encerrando a calculadora. Ate mais!"
        break
    fi
done
