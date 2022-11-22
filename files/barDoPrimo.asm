.data
	initUser: .asciiz "Ola! Digite a sua quantidade de dinheiro: "
	opcUser: .asciiz "  Indique um numero acima para receber a cerveja: "
	saldoUser: .asciiz "Seu saldo: "
	fimUser: .asciiz "Obrigado por escolher nosso bar, volte sempre!"
	pobreUser: .asciiz "Voce nao tem dinheiro suficiente para uma bebida, volte outra vez."
	
	#para utilizar arquivo
	nomeArq: .asciiz "cardapio.txt"
	tamArq: .space 1024 
	
.text
	la $a0, initUser   #recebe a string da memória
	
	#print da string
	li $v0, 4
	syscall
	
	#receber o dinheiro
	li $v0, 5
	syscall
	
	#passar o dinheiro do $v0 para $t0
	move $t0, $v0
	
	#se não tiver dinheiro suficiente para uma bebida, não entrará no bar
	blt $t0, 4, pobre
	
		while:
			blt $t0, 4, fim
			
				li $v0, 13           	# abertura para o arquivo
    				la $a0, nomeArq     	# nome ou diretorio do arquivo
    				li $a1, 0           	# flag para leitura
    				syscall
    				move $s0, $v0        	# salva o descritor do arquivo
	
				#lê o arquivo
				li $v0, 14		# syscall de leitura
				move $a0, $s0		# descritor do arquivo
				la $a1, tamArq 	# buffer que segura o arquivo inteiro
				la $a2, 1024		# tamanho do buffer
				syscall
	
				# print do conteúdo do arquivo
				li $v0, 4
				la $a0, tamArq
				syscall
	
				#Fechamento do arquivo
    				li $v0, 16
    				move $a0, $s0
    				syscall
    				
    				la $a0, saldoUser #string para mostrar o dinheiro do cliente
    				
    				#print da string
    				li $v0, 4
    				syscall
    				
    				#print do dinheiro
    				move $a0, $t0
    				li $v0, 1
    				syscall
    				
    				la $a0, opcUser   #recebe a string sobre qual bebida o usuario vai escolher
    				
    				#print da string
				li $v0, 4
				syscall
				
				#recebe o número da bebida em que o usuário vai escolher
				li $v0, 5
				syscall
				
				#preço da bebida fica salvo em $t1
				move $t1, $v0
				
				if:
					#se nao for erdinger, passa para a próxima
					bne $t1, 1, elseIf1
						blt $t0, 23, else
						sub $t2, $t0, 23
						move $t0, $t2
						j while
				
				elseIf1:
					#se não for heineken, passa para a próxima
					bne $t1, 2, elseIf2
						blt $t0, 15, else
						sub $t2, $t0, 15
						move $t0, $t2
						j while
					
				elseIf2:
					#se não for vodka absolute, passa para a próxima
					bne $t1, 3, elseIf3
						blt $t0, 88, else
						sub $t2, $t0, 88
						move $t0, $t2
						j while
					
				elseIf3:
					#se não for budweiser, passa para a próxima
					bne $t1, 4, elseIf4
						blt $t0, 4, else
						sub $t2, $t0, 4
						move $t0, $t2
						j while
					
				elseIf4:
					#se não for amstel, volta para o while
					bne $t1, 5, else
						blt $t0, 9, else
						sub $t2, $t0, 9
						move $t0, $t2
						j while
					
				else:
					j while
			
			fim:
				la $a0, fimUser   #recebe a string da memória para anunciar o fim
	
				#print da string
				li $v0, 4
				syscall 
	
				#encerra o programa
				li $v0, 10
				syscall
	
	pobre:
		la $a0, pobreUser   #recebe a string para o usuario com pouco dinheiro
		
		#print da string
		li $v0, 4
		syscall
		
		#encerra o programa
		li $v0, 10
		syscall
