#################################################### IMPORTANTE #######################################################
	# O Sql vem configurado para não
	# permitir que sejam feitos 
	# delete e update sem o critério
	# where, fazendo com que não possamos rodar esses comandos,
	# para remover:
	# Edit > Preferences > SQL Editor > Desmarcar a caixa de Safe Updates
########################################################################################################################
													########
													########
############################################## COMANDOS GERAIS #########################################################
        
        
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

########################################################################################################################
													########
													########
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
		alter table tbl_filme
					change data_nascimento
					data_lancamento date not null;


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

#######################################################################################################################
													########
													########
################################# SELECT PARA TRAZER TODAS AS CHAVES ESTRANGEIRAS ####################################
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

########################################################################################################################
													########
													########
########################## MANIPULANDO DADOS DAS TABELAS - INSERINDO E ATUALIZANDO ######################################

			# 1ª Maneira - Inserindo os gêneros na tbl_gênero com valor único
			insert into 
					tbl_genero (nome) 
				values 
					('Policial');

			insert into 
					tbl_genero (nome) 
				values 
					('Suspense');

			# 2ª Maneira - Inserindo os gêneros na tbl_gênero com multiplos valores
			insert into 
					tbl_genero (nome) 
				values 
					('Romance'),
                    ('Ficção'),
                    ('Aventura'),
                    ('Músical'),
                    ('Animação');

			# 1ª Maneira Sem Critério / CUIDADO AO UTILIZAR PARA MUDA TODA A TABELA
            # - Muda todos o conteúdo de determinado atributo
			update 
				tbl_genero 
			set 
				nome = 'Musical';
            
            # 2ª Maneira Com Critério / UTILIZA O ID PARA IDENTIFICAR O CONTÉUDO A SER MUDADO
            # - Muda só o conteúdo do atributo determinado pelo id
			update 
				tbl_diretor
			set 
				nome_artistico = null
			where 
				id = 3;
            
            desc tbl_ator_nacionalidade;
            select * from tbl_ator_nacionalidade;
            
            insert into 
					tbl_classificacao (sigla, nome, descricao) 
				values 
					('L', 'Livre', 'Não expõe crianças a conteúdo potencialmente prejudiciais.'),
                    ('10', 'Não recomendado para menores de 10 anos', 'Conteúdo violento ou linguagem inapropriada para crianças, ainda que em men...'),
                    ('12', 'Não recomendado para menores de 12 anos', 'As cenas podem conter agressão física, consumo de drogas e insinuação sexual.'),
                    ('14', 'Não recomendado para menores de 14 anos', 'Conteúdos mais violentos e/ou de linguagem sexual mais acentuada.'),
                    ('16', 'Não recomendado para menores de 14 anos', 'Conteúdos mais violentos ou com conteúdo sexual mais intenso com cenas de t...'),
                    ('18', 'Não recomendado para menores de 14 anos', 'Conteúdos violentos e sexuais extremos. Cenas de sexo, incesto ou atos repe...');

			alter table tbl_classificacao modify column descricao varchar(150) not null;

			show tables;

			desc tbl_filme;

			## INSERT
			### TABELA DE FILME
			insert into
				tbl_filme (nome, nome_original, data_lancamento, duracao, data_relancamento, foto_capa, sinopse, id_classificacao)
			values
				('VINGADORES: ULTIMATO',
					'Avengers: Endgame',
					'2019-04-25',
					'03:01:00',
					'2019-07-11',
					'https://br.web.img2.acsta.net/c_310_420/pictures/19/04/26/17/30/2428965.jpg',
					'Em Vingadores: Ultimato, após Thanos eliminar metade das criaturas vivas em Vingadores: Guerra Infinita, os heróis precisam lidar com a dor da perda de amigos e seus entes queridos. Com Tony Stark (Robert Downey Jr.) vagando perdido no espaço sem água nem comida, o Capitão América/Steve Rogers (Chris Evans) e a Viúva Negra/Natasha Romanov (Scarlett Johansson) precisam liderar a resistência contra o titã louco.',
					21
					);
				
			insert into
				tbl_filme (nome, nome_original, data_lancamento, duracao, data_relancamento, foto_capa, sinopse, id_classificacao)
			values
				('O PODEROSO CHEFÃO',
				'The Godfather',
				'1972-03-24',
				'02:55:00',
				'2022-02-24',
				'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/90/93/20/20120876.jpg',
				'Don Vito Corleone (Marlon Brando) é o chefe de uma "família" de Nova York que está feliz, pois Connie (Talia Shire), sua filha, se casou com Carlo (Gianni Russo). Porém, durante a festa, Bonasera (Salvatore Corsitto) é visto no escritório de Don Corleone pedindo "justiça", vingança na verdade contra membros de uma quadrilha, que espancaram barbaramente sua filha por ela ter se recusado a fazer sexo para preservar a honra. Vito discute, mas os argumentos de Bonasera o sensibilizam e ele promete que os homens, que maltrataram a filha de Bonasera não serão mortos, pois ela também não foi, mas serão severamente castigados. Vito porém deixa claro que ele pode chamar Bonasera algum dia para devolver o "favor". Do lado de fora, no meio da festa, está o terceiro filho de Vito, Michael (Al Pacino), um capitão da marinha muito decorado que há pouco voltou da 2ª Guerra Mundial. Universitário educado, sensível e perceptivo, ele quase não é notado pela maioria dos presentes, com exceção de uma namorada da faculdade, Kay Adams (Diane Keaton), que não tem descendência italiana mas que ele ama. Em contrapartida há alguém que é bem notado, Johnny Fontane (Al Martino), um cantor de baladas românticas que provoca gritos entre as jovens que beiram a histeria. Don Corleone já o tinha ajudado, quando Johnny ainda estava em começo de carreira e estava preso por um contrato com o líder de uma grande banda, mas a carreira de Johnny deslanchou e ele queria fazer uma carreira solo. Por ser seu padrinho Vito foi procurar o líder da banda e ofereceu 10 mil dólares para deixar Johnny sair, mas teve o pedido recusado. Assim, no dia seguinte Vito voltou acompanhado por Luca Brasi (Lenny Montana), um capanga, e após uma hora ele assinou a liberação por apenas mil dólares, mas havia um detalhe: nas "negociações" Luca colocou uma arma na cabeça do líder da banda. Agora, no meio da alegria da festa, Johnny quer falar algo sério com Vito, pois precisa conseguir o principal papel em um filme para levantar sua carreira, mas o chefe do estúdio, Jack Woltz (John Marley), nem pensa em contratá-lo. Nervoso, Johnny começa a chorar e Vito, irritado, o esbofeteia, mas promete que ele conseguirá o almejado papel. Enquanto a festa continua acontecendo, Don Corleone comunica a Tom Hagen (Robert Duvall), seu filho adotivo que atua como conselheiro, que Carlo terá um emprego mas nada muito importante, e que os "negócios" não devem ser discutidos na sua frente. Os verdadeiros problemas começam para Vito quando Sollozzo (Al Lettieri), um gângster que tem apoio de uma família rival, encabeçada por Phillip Tattaglia (Victor Rendina) e seu filho Bruno (Tony Giorgio). Sollozzo, em uma reunião com Vito, Sonny e outros, conta para a família que ele pretende estabelecer um grande esquema de vendas de narcóticos em Nova York, mas exige permissão e proteção política de Vito para agir. Don Corleone odeia esta idéia, pois está satisfeito em operar com jogo, mulheres e proteção, mas isto será apenas a ponta do iceberg de uma mortal luta entre as "famílias".',
				22
				);
				
			## INSERT
			## TABELA DE RELAÇÃO ENTRE FILME E GENERO

			insert into tbl_filme_genero (id_filme, id_genero) values (1, 3), (1, 4), (1, 5), (1, 8);

			insert into tbl_filme_genero (id_filme, id_genero) values (7, 8), (7, 10), (7, 3);

			insert into tbl_filme_genero (id_filme, id_genero) values (6, 8), (6, 11);

			select * from tbl_classificacao;
						
			select * from tbl_genero;

			select * from tbl_sexo;



			## Criando os atores
			insert into 
				tbl_ator (nome, nome_artistico, data_nascimento, data_falecimento, biografia, foto, id_sexo)
			values
				( 'Mark Alan Ruffalo',
			'MARK RUFFALO',
			'1967-11-22',
			null,
			'Apesar de ter um pequeno papel em Ride With The Devil (1999), a primeira participação de destaque de Mark Ruffalo no cinema vem com o premiado drama Conte Comigo (2000). Ele conquista papéis importantes no thriller erótico Em Carne Viva (2003) e no drama Brilho Eterno de uma Mente Sem Lembranças (2004), antes de se lançar em comédias românticas como De Repente 30 (2004) e Dizem Por Aí... (2005).

			Ele retoma os dramas e suspenses com Zodíaco (2007) e Ensaio Sobre a Cegueira (2008). Em 2010, Martin Scorsese convida-o a atuar em Ilha do Medo, ao lado de Leonardo DiCaprio. Ele recebe sua primeira indicação ao Oscar como ator coadjuvante no drama Minhas Mães e Meu Pai (2010). Um grande passo para o reconhecimento popular vem com o papel de Hulk no grande sucesso Os Vingadores - The Avengers (2012), abrindo a porta para novas produções no papel do monstro gigantesco.',
			'https://br.web.img3.acsta.net/c_310_420/pictures/19/04/22/20/02/3083743.jpg',
			1
			);
			
			### Vinculando Atores aos filmes
			insert into tbl_filme_ator (id_filme, id_ator) values (7, 17);

			## Vinculando Atores ás Nacionalidades
			insert into tbl_ator_nacionalidade (id_ator, id_nacionalidade) values (17, 1);
			
			## Vinculando Atores ás Nacionalidades
			insert into tbl_diretor_nacionalidade (id_diretor, id_nacionalidade) values (8, 1);
		
			## Inserindo os diretores
			insert into
				tbl_diretor (nome, nome_artistico, data_nascimento, biografia, foto, id_sexo)
			values
				( 'Anthony J. Russo',
				'ANTHONY RUSSO',
				'1970-02-03',
				'Anthony Russo nasceu o 3 de fevereiro de 1970 em Cleveland, Ohio, EUA. É produtor e diretor, conhecido pelo seu trabalho em Tudo em Todo o Lugar ao Mesmo Tempo (2022), Vingadores: Ultimato (2019) e Vingadores: Guerra Infinita (2018).',
				'https://br.web.img2.acsta.net/c_310_420/pictures/15/11/24/16/59/250993.jpg',
				1
				);
				
			## Vinculando os Diretores aos Filmes
			insert into tbl_filme_diretor (id_filme, id_diretor) values (7, 8);
		 
			## Inserindo as avaliações
			insert into 
				tbl_filme_avaliacao (nota, comentario, id_filme)
			values
				(3.5,
				'Vingadores; Ultimato- Um final fraco para um universo espetacular
				Na minha opinião, Endgame é um filme mediano para terminar algo grandioso.',
				7
				);
				
			
########################################################################################################################
													########
													########
####################################### MANIPULANDO DADOS COM O SELECT ################################################

			# -> Select
				## SELECT 	- serve para especificar quais colunas serão exibidades
				## FROM 	- serve para definir qual(is) tabelas serão utilizadas
				## WHERE 	- serve para definir o critério de busca

			## Retorna todas as colunas de uma tabela e todos os registros
			select * from tbl_filme;
			select tbl_filme.* from tbl_filme;

			## Retorna apenas as colunos escolhidas
			select  id, nome, nome_original from tbl_filme;
			select tbl_filme.id, tbl_filme.nome, tbl_filme.nome_original from tbl_filme;
			
			## Podemos criar nomenclaturas virtuais para as colunas e tabelas (isso não altera fisicamente a tabela)
			select filme.id as id_filme,
					filme.nome as nome_filme,
					filme.data_lancamento as data_lancamento_filme,
					filme.id_classificacao as filme_classificacao
			from tbl_filme as filme;

			## Permite ordenar de forma crescente e decrescente
			select * from tbl_filme order by nome; # (crescente)
			select * from tbl_filme order by nome asc;
			select * from tbl_filme order by nome desc;
			select * from tbl_filme order by nome, data_lancamento asc;
			select * from tbl_filme order by nome, data_lancamento asc, sinopse desc;
			
			## Limitar a quantidade de registros que serão exibidos
				## Limit é diferente em outros bancos (TOP no Oracle)
			select * from tbl_filme limit 3;
			select * from tbl_filme order by nome desc limit 3;
			
            ## ucase ou upper - padroniza o resultado do dados em Maisculo
            ## lcase ou lower - padroniza o resultado dos dados em Minusculo
			select ucase(filme.nome) as nome_filme from tbl_filme as filme;
            
            select ucase(filme.nome) as nome_filme,
					lower(filme.nome_original) as nome_original
                    from tbl_filme as filme;
                    
            select lcase(filme.nome_original) as nome_filme_original from tbl_filme as filme;

			select ucase(filme.nome) as nome_filme,
					lower(filme.nome_original) as nome_original,
                    length(filme.nome) as qtde_caracteres_nome
                    from tbl_filme as filme;
                    
                    ##lenght - retorna a quantidade de caracteres
                    ## concat - permite concatenar strings
                    ## substr - ´permite cortar string
			select 	filme.nome_original as nome_filme_original,
					lcase(filme.nome_original) as nome_original_minusculo,
					ucase(filme.nome_original) as nome_original_maiusculo,
                    length(filme.nome_original) as qtde_caracteres_nome_original,
                    concat('Filme: ', filme.nome_original) as nome_filme_formatado_original,
                    concat('<span>Filme: ', filme.nome_original,'</span>') as nome_original_formatado,
                    filme.sinopse,
                    concat(substr(filme.sinopse, 1, 50), '... Leia Mais')  as sinopse_reduzida
                    from tbl_filme as filme;
			