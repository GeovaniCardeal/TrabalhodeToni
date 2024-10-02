#!/bin/bash

#Trablho feito por: Geovani Machado, Nadson Pereira e Pedro Yuri

if [ "$(id -u)" -ne 0 ]; then  #$(id -u): Obtém o ID do usuário atual. #-ne 0: Verifica se o ID do usuário é 0 (que corresponde ao root (adm) ).
    #Se não for root, irá fechar.
    echo "Este script deve ser executado como root."
    exit 1
fi

check_cpu() {
    echo "=============================="   # check_cpu: Define uma função para verificar o uso da CPU.
    echo "          USO DA CPU          "   # top -bn1: Executa o comando top uma vez (-b para modo batch, -n1 para uma execução
    echo "=============================="   # rep "Cpu(s)": Filtra a saída para mostrar apenas a linha relacionada ao uso da CPU.
    
    top -bn1 | grep "Cpu(s)"                #TERMOS DA CPU:
                                            # us(user): Tempo gasto executando processos de usuários. 
                                            #sy(system): Tempo gasto com processos de sistema (kernel).
                                            #ni(nice): Tempo gasto em processos de usuários com prioridade alterada. 
                                            #id(idle): Percentual de tempo ocioso (a CPU não está sendo utilizada).
                                            #wa(iowait): Tempo esperando por I/O (disco, rede, etc.). 
                                            #hi(hardware interrupts): Tempo gasto processando interrupções de hardware.
                                            #si(software interrupts): Tempo gasto processando interrupções de software. 
                                            #st(steel time): Tempo roubado por máquinas virtuais
} 

check_memory() {                             # check_memory: Define uma função para verificar o uso da memória.
    echo "=============================="
    echo "        USO DA MEMÓRIA         "
    echo "=============================="
    free -h                                  
}                                            # free é utilizado para mostrar informações sobre a memória RAM e a memória swap do sistema
                                             # -h: Usa o formato em GB ou MB (-h).


check_disk() {                               #check_disk: Define uma função para verificar o espaço em disco.
    echo "=============================="
    echo "        ESPAÇO EM DISCO        "
    echo "=============================="
    df -h /                                 # O comando df é usado para exibir informações sobre a utilização do espaço em disco,
                                            # O comando -h converte os valores de bytes para GB.
}                                           # O / exibe o espaço no sistema de arquivos na raiz (/)

check_top_processes() {                     # check_top_processes: Define uma função para listar os processos que consomem mais memória.
    echo "=============================="
    echo "    PROCESSOS MAIS PESADOS     "
    echo "=============================="
    ps aux --sort=-%mem | head -n 10        # ps aux --sort=-%mem:  Mostra todos os processos, ordenados pelo uso de memória em ordem decrescente.
}

check_uptime() {                            # check_uptime: Define uma função para mostrar o tempo que o sistema está ativo.
    echo "=============================="
    echo "         TEMPO DE ATIVIDADE    "
    echo "=============================="
    uptime                                  # uptime Exibe o tempo de atividade do sistema, juntamente com o número de usuários e a carga média.
}                                           # O sistema imprime nesta ordem : Hora atual, Tempo de atividade, 
                                            # Número de usuários logados (CASO TENHA 2 USUARIOS UM DOS USUARIO É O ROOT) 
                                            # Load average Carga média do sistema nos últimos 1, 5 e 15 minutos

show_menu() {                                     # Define uma função que exibe um menu de opções para o usuário.
    echo "===================================="
    echo "   Monitoramento do Sistema"
    echo "===================================="
    echo "1. Verificar uso da CPU"
    echo "2. Verificar uso da memória"
    echo "3. Verificar espaço em disco"
    echo "4. Listar processos mais pesados"
    echo "5. Verificar tempo de atividade"
    echo "6. Sair"
    echo "===================================="
}

while true; do                                 # Inicia um loop 
    show_menu                                  # Chama a função para mostrar o menu.
    read -p "Escolha uma opção [1-7]: " OPTION # read captura O que o usuario escreveu, -p Mostra a mensagem escolha uma opção [1,7]
                                               # OPTION variável onde a entrada do usuário será armazenada 
                                               # (Não é necessário declarar a variável OPTION O Bash cria essa variável, quando usamos read
    
    
    
    
    case $OPTION in   # case $OPTION in Avalia a opção escolhida:   
                       # 1-5: Chama a função correspondente para cada opção.
                        # 6: Exibe uma mensagem e encerra o script com sucesso.
                          # *: Se a variável OPTION não corresponder a nenhum dos padrões anteriores 1 a 6 sera executado o comando associado a *   
                           # O *funciona como um coringa no Bash
        1) 
            check_cpu
            ;;
        2)
            check_memory
            ;;
        3)
            check_disk
            ;;
        4)
            check_top_processes
            ;;
        5)
            check_uptime
            ;;
        6)
            echo "Saindo..."
            exit 0
            ;;
        *)
            echo "Opção inválida. Tente novamente."
            ;;
    esac # esac é a palavra que finaliza a estrutura case
done    # done é a palavra-chave que indica o final de um loop.
