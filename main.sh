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

open_permissions () {
    clear
    second_menu_option=0

    while [ $second_menu_option -ne 99 ]
	do
	    clear
	    echo '--- Você está editando as permissões de acesso'

	    echo '\n--- Menu ---'
	    echo '\n1) Modificar dono de arquivo ou diretório'
	    echo '2) Modificar grupo dono de arquivo ou diretório'
	    echo '3) Modificar permissões de arquivo ou diretório'

	    echo '\nDigite uma opção ou digite 99 para voltar: '
	    read second_menu_option

	    if [ $second_menu_opition -eq 1 ]
	        then
	    	    echo 'Vazquez faz'
		    read enter
	        elif [ $second_menu_opition -eq 2 ]
		    then
			echo 'Scalese faz'
			read enter
		elif [ $second_menu_opition -eq 3 ]
		    then
			echo 'Felis faz'
			read enter
		else
		    break
	    fi
	done
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
                    open_permissions
            else
              break  
        fi
    done



