# Comnados para verificacao:
# less /etc/passwd -> listar usuarios
# groupadd <nome_group> -> criar grupo
# cat /etc/group -> listar grupos
# ls -l <arquivo_ou_diretorio> -> ver dono

read_enter () {
    echo '\n Pressione [ENTER] para continuar'
    read enter
}

create_user () {
    clear
    echo '--- Inclusao de usuario ---'

    echo "\n\nDigite o nome do usuario:"
    read username

    echo "\n Digite a nova senha:"
    read password
    
    echo '\nCriando usuario...'
    sudo useradd -p $password $username ||
    {
        read_enter
        return
    }

    echo '\n Usuario criado com sucesso!'

    read_enter
}

delete_user () {
    clear
    echo '--- Exclusao de usuario ---'

    echo "\n\nDigite o nome do usuario:"
    read username

    echo '\nExcluindo usuario...'
    sudo userdel $username ||
    {
        read_enter
        return
    }

    echo '\n Usuario excluido com sucesso!'

    read_enter
}

open_permissions () {
    clear

    secondMenuOption=0
    while [ $secondMenuOption -ne 99 ]
	do
	    clear
	    echo '--- Você está editando as permissões de acesso'

	    echo '\n--- Menu ---'
	    echo '\n1) Modificar dono de arquivo ou diretório'
	    echo '2) Modificar grupo dono de arquivo ou diretório'
	    echo '3) Modificar permissões de arquivo ou diretório'

	    echo '\nDigite uma opção ou digite 99 para voltar: '
	    read secondMenuOption

        if [ $secondMenuOption -eq 2 ]
		    then
			change_group
		elif [ $secondMenuOption -eq 3 ]
		    then
			change_file_permissions
		else
		    break
	    fi
	done
}

change_group() {
    clear 
    echo '--- Alteracao de grupo dono do arquivo ou diretorio ---'

    echo '\n\nDigite o nome do arquivo ou diretorio:'
    read objectName

    echo '\nDigite o nome do grupo:'
    read group

    echo '\nAlterando grupo dono...'
    sudo chgrp $group $objectName || 
    {
        read_enter
        return
    }

    echo 'Grupo dono alterado com sucesso!'

    read_enter
}

change_file_permissions(){
    clear

    echo 'Digite o arquivo ou diretório que deseja modificar suas permissões: \n'
    read file

    if [ ! -d "$file" && ! -f "$file"]
    then
	echo "Arquivo ou diretório não existe!"
	read enter
	break
    else
	thirdMenuOption=0
    changePermissionsToOwner=false
    changePermissionsToGroup=false
    changePermissionsToOther=false
    changePermissionsToAll=false

    while [ $thirdMenuOption -ne 99 ]
	do
	    clear
	    echo '--- Você deseja alterar as permissões do: \n'

	    echo '\n1) Dono'
	    echo '2) Grupo'
	    echo '3) Outros'
	    echo '4) Todos'

	    echo '\nDigite uma opção ou digite 99 para voltar: '
	    read thirdMenuOption

	    if [ $thirdMenuOption -eq 1 ]
	        then
	    	    changePermissionsToOwner=true
		    break
	        elif [ $thirdMenuOption -eq 2 ]
		    then
			changePermissionsToGroup=true
			break
		elif [ $thirdMenuOption -eq 3 ]
		    then
			changePermissionsToOther=true
			break
		elif [ $thirdMenuOption -eq 4 ]
		    then
			changePermissionsToAll=true
			break
		else
		    break
	    fi
	done

     fourthMenuOption=0

     while [ $fourthMenuOption -ne 99 ]
	do
	    clear
	    echo '--- o dono/grupo/outros terá permissão de: \n'

	    echo '\n1) Nenhuma permissão'
	    echo '2) Escrita'
	    echo '3) Leitura'
	    echo '4) Execução'

	    echo '\nDigite uma opção ou digite 99 para voltar: '
	    read fourthMenuOption

	    if [ $fourthMenuOption -eq 1 ]
	        then
	    	    if $changePermissionsToOwner
			then
			    echo "trocar permissões dono"
			    read enter
		        elif $changePermissionsToGroup
			    then
			    	echo "trocar permissões grupo"
				read enter
			elif $changePermissionsToOther
			    then
				echo "trocar permissões outros"
				read enter
		        elif $changePermissionsToAll
			    then
				echo "trocar permissões todos"
				read enter
		    fi
		break
	        elif [ $fourthMenuOption -eq 2 ]
		    then
			if $changePermissionsToOwner
			    then
			    	echo "trocar permissões dono"
			    	read enter
			    elif $changePermissionsToGroup
			    	then
			    	    echo "trocar permissões grupo"
				    read enter
			    elif $changePermissionsToOther
			    	then
				    echo "trocar permissões outros"
				    read enter
			    elif $changePermissionsToAll
			    	then
				    echo "trocar permissões todos"
				    read enter
			fi
			break
		elif [ $fourthMenuOption -eq 3 ]
		    then
			if $changePermissionsToOwner
			    then
			    	echo "trocar permissões dono"
			    	read enter
		            elif $changePermissionsToGroup
			    	then
			    	    echo "trocar permissões grupo"
				    read enter
			    elif $changePermissionsToOther
			    	then
				    echo "trocar permissões outros"
				    read enter
		            elif $changePermissionsToAll
			    	then
				    echo "trocar permissões todos"
				    read enter
			fi
			break
		elif [ $fourthMenuOption -eq 4 ]
		    then
			if $changePermissionsToOwner
			    then
			    	echo "trocar permissões dono"
			    	read enter
		            elif $changePermissionsToGroup
			    	then
			    	    echo "trocar permissões grupo"
				    read enter
			    elif $changePermissionsToOther
			    	then
				    echo "trocar permissões outros"
				    read enter
		            elif $changePermissionsToAll
			    	then
				    echo "trocar permissões todos"
				    read enter
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
        elif [ $option -eq 99 ]
            then
                break
        fi
    done

