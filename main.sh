# less /etc/passwd

create_user () {
    clear
    echo '--- Inclusao de usuario'

    echo "\n\nDigite o nome do usuario: \n"
    read username

    echo "\n Digite a nova senha: \n"
    read password

    sudo useradd -p $password $username

    echo '\n Usuario criado com sucesso!'

    echo '\n Pressione [ENTER] para continuar'
    read enter
}

delete_user () {
    clear
    echo "Digite o nome do usuario: \n"
    read username

    sudo userdel $username

    echo '\n Usuario excluido com sucesso!'

    echo '\n Pressione [ENTER] para continuar'
    read enter
}

option=0
while [ $option -ne 99 ] 
    do
        clear
        echo '==== Gerenciador de Usuario e Permissoes ===='

        echo '\n--- Menu ---'
        echo '\n1) Criar Usuario'
        echo '2) Excluir usuario'
        echo '3) Permissoes de arquivo'

        echo '\nDigite uma opcao ou digite 99 para encerrar:'
        read option

        if [ $option -eq 1 ]
            then
                create_user
            elif [ $option -eq 2 ]
                then
                    delete_user
            elif [ $option -eq 3 ]
                then
                    clear
                    echo 'Opcao 3'
            else
              break  
        fi
    done



