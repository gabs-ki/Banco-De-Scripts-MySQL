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
				tbl_genero 
			set 
				nome = 'Policial' 
			where 
				id = 7;
            
            
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
                
                
select * from tbl_genero;

## INSERT
## TABELA DE RELAÇÃO ENTRE FILME E GENERO

insert into tbl_filme_genero (id_filme, id_genero) values (1, 3), (1, 4), (1, 5), (1, 8);

insert into tbl_filme_genero (id_filme, id_genero) values (7, 8), (7, 10), (7, 3);

insert into tbl_filme_genero (id_filme, id_genero) values (6, 8), (6, 11);

select * from tbl_classificacao;
            
select * from tbl_genero;



select * from tbl_sexo;




	insert into 
		tbl_ator (nome, nome_artistico, data_nascimento, data_falecimento, biografia, foto, id_sexo)
	values
		( 'Todd Jones',
        'JAMES EARL JONES',
        '1931-01-17',
        null,
        '- Do signo de Capricórnio;

		- Possui descendência africana, indígena e irlandesa;

		- Foi criado pelos avós maternos. Seus pais, Ruth Connolly and Robert Earl Jones, se separaram pouco antes de seu nascimento;

		- Começou a ter aulas de atuação para curar sua gagueira;

		- Também para melhorar sua dicção, começou a escrever poesias e contava com o apoio dos professores, que permitiam que ele as lesse em sala de aula;

		- É um veterano do exército dos Estados Unidos;

		- É membro da NRA (Associação Nacional de Rifles da América);

		- Foi casado com a atriz Julienne Marie, de quem se separou em 1972. Se casou novamente dez anos depois, em 82, com Cecilia Hart, com quem teve um filho;

		- Foi o primeiro afro-descendente a interpretar o presidente dos EUA. Foi no telefilme The Man, de 1972;

		- Conhecido por sua voz marcante, tendo conquistado notoriedade por dublar Darth Vader em Star Wars e Mufasa em O Rei Leão;

		- Jones revela que George Lucas queria Orson Welles como voz de Darth Vader, mas que desistiu da ideia por considerar que o ator/diretor era conhecido demais e poderia roubar a cena do personagem;

		- Pediu para não ter seu nome nos créditos de Guerra nas Estrelas e O Império Contra-ataca por considerar que sua contribuição para os filmes não era significativa o bastante. Aceitou ser creditado em O Retorno de Jedi;

		- Recebeu apenas US$ 9 mil pelo trabalho no primeiro Star Wars (1977). Mais tarde, em 88, faturou US$ 900 mil para interpretar o pai de Eddie Murphy em Um Príncipe em Nova York;

		- Teve sua morte anunciada em um jogo da NBA em 1998. O morto na verdade era James Earl Ray, o assassino de Martin Luther King;

		- Atuou cinco vezes com a atriz Madge Sinclair;

		- Interpretou um mesmo papel no teatro ("The Great White Hope") e no cinema (A Grande Esperança Branca). A atuação nos palcos lhe rendeu o primeiro de seus dois prêmios Tony e a no cinema lhe deu sua única indicação ao Oscar;

		- Foi a primeira celebridade a aceitar aparecer como convidada no seriado dos Muppets, Sesame Street;

		- Em 2005, foi obrigado a deixar a adaptação de Num Lago Dourado na Broadway em razão de uma pneumonia;

		- Uma banda de rock da Noruega batizou seu nome em homenagem ao ator: James Earl Jones Barbershop Explosion!;

		- Foi escolhido pela Academia de Artes e Ciências Cinematográficas para receber um Oscar Honorário em 2011.',
		'https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/55/34/20040970.jpg',
        1
        );
        
        desc tbl_ator;
        
        insert into tbl_filme_ator (id_filme, id_ator) values (5, 4);

select * from tbl_filme;

select * from tbl_filme_ator;

select * from tbl_ator;

select * from tbl_filme_ator;



