# 🧮 Calculadora em Bash

Um script simples de linha de comando, escrito em **Bash**, que realiza as quatro operações matemáticas básicas (soma, subtração, multiplicação e divisão) de forma interativa no terminal.

---

## 📁 Estrutura do repositório

---

## ▶️ Como executar o arquivo .sh

1. **Clone o repositório** (ou baixe o arquivo `calculadora.sh`):
```bash
   git clone https://github.com/SEU-USUARIO/calculadora-bash.git
   cd calculadora-bash
```

2. **Dê permissão de execução** ao script (necessário apenas na primeira vez):
```bash
   chmod +x calculadora.sh
```

3. **Execute o script:**
```bash
   ./calculadora.sh
```

   Caso o comando acima não funcione no seu sistema, você também pode rodar chamando o interpretador Bash diretamente:
```bash
   bash calculadora.sh
```

4. **Siga as instruções no terminal:**
   - Digite o primeiro número;
   - Digite a operação desejada (`+`, `-`, `*` ou `/`);
   - Digite o segundo número;
   - O resultado será exibido na tela;
   - Em seguida, escolha se deseja fazer outra operação (`s` para sim, qualquer outra tecla para sair).

> 💡 **Pré-requisito:** o script usa o comando `bc` (calculadora de precisão arbitrária) para fazer as contas. A maioria das distribuições Linux já vem com ele instalado. Caso não tenha, instale com:
> ```bash
> sudo apt install bc      # Debian/Ubuntu
> sudo dnf install bc      # Fedora
> brew install bc          # macOS (Homebrew)
> ```

---

## 🧠 Explicação do código

O script funciona dentro de um **laço infinito** (`while true; do ... done`), que permite ao usuário fazer quantas operações quiser até decidir sair.

### 1. Cabeçalho e leitura dos dados
```bash
read -p "Digite o primeiro numero: " num1
read -p "Digite a operacao (+, -, *, /): " operacao
read -p "Digite o segundo numero: " num2
```
O comando `read -p` exibe uma mensagem (`-p`) e armazena o que o usuário digitar em uma variável (`num1`, `operacao`, `num2`).

### 2. Seleção da operação com `case`
```bash
case $operacao in
    +)
        resultado=$(echo "$num1 + $num2" | bc)
        ;;
    -)
        resultado=$(echo "$num1 - $num2" | bc)
        ;;
    \*)
        resultado=$(echo "$num1 * $num2" | bc)
        ;;
    /)
        ...
        ;;
    *)
        echo "Operacao invalida. Use +, -, * ou /."
        ;;
esac
```
- O `case` compara o valor digitado em `operacao` com cada padrão (`+`, `-`, `*`, `/`).
- O `*` no final funciona como **padrão coringa** ("qualquer outro valor"), tratando entradas inválidas.
- O `*` da multiplicação precisa ser escrito como `\*` porque, sem a barra invertida, o Bash poderia interpretá-lo como um caractere especial de expansão de nomes de arquivo.
- Cada bloco termina com `;;`, que indica o fim daquela opção do `case`.

### 3. Cálculo com `bc`
O Bash, por padrão, não sabe fazer contas com números decimais. Por isso o script envia a expressão para o programa **`bc`** através de um pipe (`|`):
```bash
resultado=$(echo "$num1 + $num2" | bc)
```
Na divisão, usamos `scale=2` para garantir **duas casas decimais** no resultado:
```bash
resultado=$(echo "scale=2; $num1 / $num2" | bc)
```

### 4. Tratamento de divisão por zero
```bash
if [ "$num2" == "0" ]; then
    echo "Erro: divisao por zero nao e permitida."
    resultado=""
else
    resultado=$(echo "scale=2; $num1 / $num2" | bc)
fi
```
Antes de dividir, o script verifica se o segundo número é `0`. Se for, exibe uma mensagem de erro em vez de tentar calcular (o que quebraria o programa).

### 5. Exibição do resultado
```bash
if [ -n "$resultado" ]; then
    echo "Resultado: $num1 $operacao $num2 = $resultado"
fi
```
`-n "$resultado"` verifica se a variável **não está vazia**. Isso evita mostrar um resultado quando a operação era inválida ou houve divisão por zero.

### 6. Continuar ou sair
```bash
read -p "Deseja fazer outra operacao? (s/n): " continuar
if [ "$continuar" != "s" ] && [ "$continuar" != "S" ]; then
    echo "Encerrando a calculadora. Ate mais!"
    break
fi
```
Se o usuário não digitar `s` ou `S`, o comando `break` interrompe o laço `while` e o script termina.

---

## 🛠️ Tecnologias utilizadas
- **Bash** (shell script)
- **bc** (utilitário de cálculo do Linux/Unix)

## ✍️ Autor
Projeto desenvolvido como exercício prático de scripting em Bash.
