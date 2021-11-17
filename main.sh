# Comandos para verificacao:
# less /etc/passwd -> listar usuarios
# groupadd <nome_group> -> criar grupo
# cat /etc/group -> listar grupos
# ls -l <arquivo_ou_diretorio> -> ver dono

read_enter () {
    echo -e '\nPressione [ENTER] para continuar'
    read enter
}

create_user () {
    clear
    echo '--- Inclusão de usuário ---'

    echo -e "\n\nDigite o nome do usuário:"
    read username

	echo -e "\nDigite a nova senha:"
    read -s password
	echo
    
    echo -e '\nCriando usuário...'
    sudo useradd -p $password $username ||
    {
        read_enter
        return
    }

    echo -e '\nUsuário criado com sucesso!'

    read_enter
}

delete_user () {
    clear
    echo '--- Exclusão de usuário ---'

    echo -e "\n\nDigite o nome do usuário:"
    read username

    echo -e '\nExcluindo usuário...'
    sudo userdel $username ||
    {
        read_enter
        return
    }

    echo -e '\nUsuario excluído com sucesso!'

    read_enter
}

open_permissions () {
    clear

    secondMenuOption=0
    while [ $secondMenuOption -ne 99 ]
	do
	    clear
	    echo '--- Você está editando as permissões de acesso'

	    echo -e '\n--- Menu ---'
	    echo -e '\n1) Modificar dono de arquivo ou diretório'
	    echo '2) Modificar grupo dono de arquivo ou diretório'
	    echo '3) Modificar permissões de arquivo ou diretório'

	    echo -e '\nDigite uma opção ou digite 99 para voltar: '
	    read secondMenuOption

		if [ $secondMenuOption -eq 1 ]
			then
				change_owner_user
        elif [ $secondMenuOption -eq 2 ]
		    then
				change_owner_group
		elif [ $secondMenuOption -eq 3 ]
		    then
				change_file_permissions
		elif [ $secondMenuOption -eq 99 ]
			then
				break
	    fi
	done
}

change_owner_group() {
    clear 
    echo '--- Alteracão de grupo dono do arquivo ou diretório ---'

    echo -e '\n\nDigite o nome do arquivo ou diretório:'
    read objectName

    echo -e '\nDigite o nome do grupo:'
    read group

    echo -e '\nAlterando grupo dono...'
    sudo chgrp $group $objectName || 
    {
        read_enter
        return
    }

    echo 'Grupo dono alterado com sucesso!'

    read_enter
}

change_owner_user() {
    clear 
    echo '--- Alteracão de dono do arquivo ou diretório ---'

    echo -e '\n\nDigite o nome do arquivo ou diretório:'
    read objectName

    echo -e '\nDigite o nome do novo dono:'
    read username

    echo -e '\nAlterando dono...'
    sudo chown $username $objectName || 
    {
        read_enter
        return
    }

    echo 'Dono alterado com sucesso!'

    read_enter
}

change_file_permissions(){
    clear

    echo -e 'Digite o arquivo ou diretório que deseja modificar suas permissões: \n'
    read file

    if [ ! -d "$file" && ! -f "$file"]
    then
	echo "Arquivo ou diretório não existe!"
	read enter
	break
    else
	thirdMenuOption=0
    

    while [ $thirdMenuOption -ne 99 ]
	do
	    clear
	    echo -e '--- Você deseja alterar as permissões do: \n'

	    echo -e '\n1) Dono'
	    echo '2) Grupo'
	    echo '3) Outros'
	    echo '4) Todos'

	    echo -e '\nDigite uma opção ou digite 99 para voltar: '
	    read thirdMenuOption
	    if [ $thirdMenuOption -eq 1 -o $thirdMenuOption -eq 2 -o $thirdMenuOption -eq 3 -o $thirdMenuOption -eq 4 ]
		then
		   break
   	    fi
	done

     fourthMenuOption=0

     while [ $fourthMenuOption -ne 99 ]
	do
	    clear
	    echo -e '--- o dono/grupo/outros terá permissão de: \n'

	    echo -e '\n1) Nenhuma permissão'
	    echo '2) Escrita'
	    echo '3) Leitura'
	    echo '4) Execução'

	    echo -e '\nDigite uma opção ou digite 99 para voltar: '
	    read fourthMenuOption

	    if [ $fourthMenuOption -eq 1 ]
	        then
	    	    if [ $thirdMenuOption -eq 1 ]
			then
			    chmod -rwx $file
			    echo "Removidas todas as permissões do dono"
			    read_enter
		        elif [ $thirdMenuOption -eq 2 ]
			    then
			    	chmod g-rwx $file
			        echo "Removidas todas as permissões do grupo"
			    	read_enter
			elif [ $thirdMenuOption -eq 3 ]
			    then
				chmod o-rwx $file
			    	echo "Removidas todas as permissões de outros"
			    	read_enter
		        elif [ $thirdMenuOption -eq 4 ]
			    then
				chmod ugo-rwx $file
			    	echo "Removidas todas as permissões de todos"
			    	read_enter
		    fi
		break
	        elif [ $fourthMenuOption -eq 2 ]
		    then
			if [ $thirdMenuOption -eq 1 ]
			    then
			    	chmod +w $file
			    	echo "Dono agora tem permissão de escrita"
			    	read_enter
			    elif [ $thirdMenuOption -eq 2 ]
			    	then
			    	    chmod g+w $file
			    	    echo "Grupo agora tem permissão de escrita"
			    	    read_enter
			    elif [ $thirdMenuOption -eq 3 ]
			    	then
				    chmod o+w $file
			    	    echo "Outros agora tem permissão de escrita"
			    	    read_enter
			    elif [ $thirdMenuOption -eq 4 ]
			    	then
				    chmod ugo+w $file
			    	    echo "Todos agora tem permissão de escrita"
			    	    read_enter
			fi
			break
		elif [ $fourthMenuOption -eq 3 ]
		    then
			if [ $thirdMenuOption -eq 1 ]
			    then
			    	chmod +r $file
			    	echo "Dono agora tem permissão de leitura"
			    	read_enter
		            elif [ $thirdMenuOption -eq 2 ]
			    	then
			    	    chmod g+r $file
			    	    echo "Grupo agora tem permissão de leitura"
			    	    read_enter
			    elif [ $thirdMenuOption -eq 3 ]
			    	then
				    chmod o+r $file
			    	    echo "Outros agora tem permissão de leitura"
			    	    read_enter
		            elif [ $thirdMenuOption -eq 4 ]
			    	then
				    chmod ugo+r $file
			    	    echo "Todos agora tem permissão de leitura"
			    	    read_enter
			fi
			break
		elif [ $fourthMenuOption -eq 4 ]
		    then
			if [ $thirdMenuOption -eq 1 ]
			    then
			    	chmod +x $file
			    	echo "Dono agora tem permissão de execução"
			    	read_enter
		            elif [ $thirdMenuOption -eq 2 ]
			    	then
			    	    chmod g+x $file
			    	    echo "Grupo agora tem permissão de execução"
			    	    read_enter
			    elif [ $thirdMenuOption -eq 3 ]
			    	then
				    chmod o+x $file
			    	    echo "Outros agora tem permissão de execução"
			    	    read_enter
		            elif [ $thirdMenuOption -eq 4 ]
			    	then
				    chmod ugo+x $file
			    	    echo "Todos agora tem permissão de execução"
			    	    read_enter
			fi
			break
		else
		    break
	    fi
	done
    fi
}

option=0
while [ $option -ne 99 ] 
    do
        clear
        echo '==== Gerenciador de Usuario e Permissoes ===='

        echo -e '\n--- Menu ---'
        echo -e '\n1) Criar Usuario'
        echo '2) Excluir usuario'
        echo '3) Permissoes de arquivo'

        echo -e '\nDigite uma opcao ou digite 99 para encerrar:'
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
        elif [ $option -eq 99 ]
            then
                break
        fi
    done
