		#Permite exibir todos o databases existentes
		show databases;

		#Cria um database
		create database db_videolocadora_tarde_20231;

		#Apaga um database
		#drop database db_videolocadora_tarde_20231;

		#Permite selecionar o database que será utilizado
		use db_videolocadora_tarde_20231;

		#Exibe todas as tabelas existentes no database
		show tables;

		#TABELA: CLASSIFICACAO
		create table tbl_classificacao(
			 id int not null auto_increment primary key,
             sigla varchar(2) not null,
             nome varchar(45) not null,
             descricao varchar(80) not null,
             
             unique index(id)
);

		#TABELA: GENERO
		create table tbl_genero(
			 id int not null auto_increment primary key,
             nome varchar(45) not null,
             
             unique index(id)
		);

		#TABELA: SEXO
		create table tbl_sexo(
			 id int not null auto_increment primary key,
             sigla varchar(5) not null,
             nome varchar(45) not null,
             
              unique index(id)
);

		#TABELA: NACIONALIDADE
		create table tbl_nacionalidade(

			 id int not null auto_increment primary key,
             nome varchar(45),
             
             unique index(id)
);

		#Permite visualizar a estrutura de uma tabela
		desc tbl_nacionalidade;
		describe tbl_filme;
        
        #Exclui uma tabela do database
		drop table tbl_nacionalidade;

######################################### COMANDOS PARA ALTERAR A TABELA ###############################################

		#add column - adiciona uma nova coluna na tabela
		alter table tbl_nacionalidade
					add column 
					descricao 
					varchar(50) not null;
            
		alter table tbl_nacionalidade
					add column teste
					int,
					add column teste2
					varchar(10) not null;

		#drop column - Exclui uma coluna da tabela
		alter table tbl_nacionalidade
					drop column teste2;

		#modify column - Permite alterar a estrutura de uma coluna
		alter table tbl_nacionalidade
					modify column teste
					varchar(5) not null;

		#change - Permite alterar a escrita e a sua estrutura
		alter table tbl_nacionalidade
					change teste 
					teste_nacionalidade int not null;


#######################################################################################################################
													########
													########
############################################# CRIANDO TABELAS COM FK ##################################################

		#TABELA: FILME
		create table tbl_filme (
				 id int not null auto_increment primary key,
				 nome varchar(100) not null,
				 nome_original varchar(100) not null,
				 data_nascimento date not null,
				 data_relancamento date,
				 duracao time not null,
				 foto_capa varchar(150) not null,
				 sinopse text not null,
				 id_classificacao int not null,
				 
				 #É atribuir um nome ao processo de criar a FK
				 constraint FK_Classificacao_Filme
				 
				 #É o atributo desta tabela que será a FK
				 foreign key (id_classificacao)
				 
				 #Especifica de onde irá vir a FK
				 references tbl_classificacao (id),
				 
				 unique index(id)
	);

		#TABELA: FILME_GENERO
		create table tbl_filme_genero (
				 id int not null auto_increment,
				 id_filme int not null,
				 id_genero int not null,
				 
				 #Relacionamento: Filme_FilmeGenero
				 constraint FK_Filme_FilmeGenero
				 foreign key (id_filme)
				 references tbl_filme (id),
				 
				 #Relacionamento: Genero_FilmeGenero
				 constraint FK_Genero_FilmeGenero
				 foreign key (id_genero)
				 references tbl_genero (id),
				 
				 primary key (id),
				 unique index (id)

	);

		#Permite excluir uma constraint de uma tabela
			#(somente podemos alterar a estrutura de uma table auqe fornece uma KF,
            # se apagarmos a(s) sua(s) constraints)
		alter table tbl_filme_genero
					drop foreign key FK_Genero_FilmeGenero;

		#Permite criar uma constraint e suas relações em uma tabelam já existente
		alter table tbl_filme_genero
					add constraint FK_Genero_FilmeGenero
								   foreign key (id_genero)
                                   references tbl_genero (id);

########################################################################################################################
			#IMPORTANT
			#select
			#	constraint_name, referenced_table_name, referenced_column_name
			#from
			#	information_schema.key_column_usage
			#where
########################################################################################################################
													########
													########
########################################### CRIANDO O RESTANTE DAS TABELAS #############################################
		
			create table tbl_filme_avaliacao (
						 id int not null auto_increment primary key,
						 nota float not null,
						 comentario varchar(300),
						 id_filme int not null,
                     
						 constraint FK_Filme_FilmeAvaliacao
						 foreign key (id_filme)
						 references tbl_filme (id),
        
						 unique index (id)
        );

			create table tbl_ator (
						 id int not null auto_increment primary key,
                         nome varchar(100) not null,
                         nome_artistico varchar(100),
                         data_nascimento date not null,
                         data_falecimento date,
                         biografia text not null,
						 foto varchar(150) not null,
                         id_sexo int not null,
                         
                         constraint FK_Sexo_Autor
                         foreign key (id_sexo)
                         references tbl_sexo (id),
                         
                         unique index (id)
            
            );
		
			create table tbl_filme_ator (
						 id int not null auto_increment primary key,
                         id_filme int not null,
                         id_ator int not null,
                         
                         constraint FK_Filme_FilmeAtor
                         foreign key (id_filme)
                         references tbl_filme (id),
                         
                         constraint FK_Ator_FilmeAtor
						 foreign key (id_ator)
                         references tbl_ator (id),
                         
                         unique index (id)
            );
		
			create table tbl_ator_nacionalidade (
						 id int not null auto_increment primary key,
                         id_ator int not null,
                         id_nacionalidade int not null,
                         
                         constraint FK_Ator_AtorNacionalidade
                         foreign key (id_ator)
                         references tbl_ator (id),
                         
                         constraint FK_Nacionalidade_AtorNacionalidade
                         foreign key (id_nacionalidade)
						 references tbl_nacionalidade (id),
                         
                         unique index (id)
            
            );
            
            create table tbl_diretor (
						 id int not null auto_increment primary key,
                         nome varchar(100) not null,
                         nome_artistico varchar(100),
                         data_nascimento date not null,
                         biografia text not null,
                         foto varchar(150) not null,
                         id_sexo int not null,
                         
                         constraint FK_Sexo_Diretor
                         foreign key (id_sexo)
                         references tbl_sexo (id),
 
						 unique index (id)
                        
            );
	
			create table tbl_diretor_nacionalidade (
						 id int not null auto_increment primary key,
                         id_diretor int not null,
                         id_nacionalidade int not null,
                         
                         constraint FK_Diretor_DiretorNacionalidade
                         foreign key (id_diretor)
                         references tbl_diretor (id),
                         
                         constraint FK_Nacionalidade_DiretorNacionalidade
                         foreign key (id_nacionalidade)
						 references tbl_nacionalidade (id),
                         
                         unique index (id)
                        
            );
			
			create table tbl_filme_diretor (
						 id int not null auto_increment primary key,
                         id_filme int not null,
                         id_diretor int not null,
                         
                         constraint FK_Filme_FilmeDiretor
                         foreign key (id_filme)
						 references tbl_filme (id),
                         
                         constraint FK_Diretor_FilmeDiretor
                         foreign key (id_diretor)
                         references tbl_diretor (id),
                         
                         unique index (id)

            );



	
