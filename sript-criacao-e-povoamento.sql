CREATE TABLE CADASTRO(
	CPF char(11),
	DataNascimento DATE NOT NULL,
	Email varchar(100) NOT NULL UNIQUE,
	Senha varchar(50) NOT NULL,
	Nome varchar(100) NOT NULL,
	Pais varchar(50) NOT NULL,
	Estado varchar(50) NOT NULL,
	Cidade varchar(50) NOT NULL,
	Bairro varchar(50) NOT NULL,
	Rua varchar(50) NOT NULL,
	Numero int,
	Complemento varchar(100),

	PRIMARY KEY(CPF)	
);

CREATE TABLE TIPO_QUARTO(
	Tipo VARCHAR(50),
	Descricao VARCHAR(100) NOT NULL,
	ValorDiaria REAL NOT NULL,

	PRIMARY KEY(Tipo)
);

CREATE TABLE QUARTO(
	Numero int,
	Tipo VARCHAR(50),
	Status BOOLEAN NOT NULL,

	PRIMARY KEY(Numero),
	FOREIGN KEY(Tipo) REFERENCES TIPO_QUARTO(Tipo) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE RESERVA(
	Codigo SERIAL,
	Data DATE NOT NULL,
	Status BOOLEAN NOT NULL,
	Tipo VARCHAR(50) NOT NULL ,
	NumQuarto INT,

	PRIMARY KEY(Codigo),
	FOREIGN KEY(NumQuarto) REFERENCES QUARTO(numero) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE HOSPEDE(
	ID SERIAL,
	CpfCadastrado CHAR(11),
	MotivoViagem VARCHAR(100),
	LocalOrigem VARCHAR(100),
	LocalDestino VARCHAR(100),
	NumQuarto INT,

	PRIMARY KEY(ID),
	FOREIGN KEY(CpfCadastrado) REFERENCES CADASTRO(CPF) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY(NumQuarto) REFERENCES QUARTO(Numero) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE CHECAGEM(
	Codigo SERIAL,
	DataMarcada DATE NOT NULL,
	HoraMarcada TIME NOT NULL,
	Status BOOLEAN NOT NULL,
	Observacao VARCHAR(100),
	IdHospede INT,
	Tipo VARCHAR(10) NOT NULL,
	Data DATE NOT NULL,
	Hora TIME NOT NULL,

	PRIMARY KEY(Codigo),
	FOREIGN KEY(IdHospede) REFERENCES HOSPEDE(ID) ON UPDATE CASCADE ON DELETE RESTRICT	
);

CREATE TABLE CONTA(
	NotaFiscal SERIAL,
	ValorTotal  REAL NOT NULL,
	Data DATE NOT NULL,
	Status BOOLEAN NOT NULL,
	CodReserva INT,

	PRIMARY KEY(NotaFiscal),
	FOREIGN KEY(CodReserva) REFERENCES RESERVA(Codigo) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE SERVICO_ACADEMIA(
	IdServExtra INT,
	Valor REAL NOT NULL,
	DuracaoTreino INT  NOT NULL,
	TipoTreino VARCHAR(50) NOT NULL,
	CodReserva INT,
	DataSolicitada DATE NOT NULL,
	HoraSolicitada TIME NOT NULL,

	PRIMARY KEY(IdServExtra),
	FOREIGN KEY(CodReserva) REFERENCES RESERVA(codigo) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE SERVICO_LAVANDERIA(
	IdServExtra INT,
	Valor REAL NOT NULL,
	CodReserva INT,
	DataSolicitada DATE NOT NULL,
	HoraSolicitada TIME NOT NULL,

	PRIMARY KEY(IdServExtra),
	FOREIGN KEY(CodReserva) REFERENCES RESERVA(codigo) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE SERVICO_BAR_RESTAURANTE(
	IdServExtra INT,
	Valor REAL NOT NULL,
	CodReserva INT,
	DataSolicitada DATE NOT NULL,
	HoraSolicitada TIME NOT NULL,

	PRIMARY KEY(IdServExtra),
	FOREIGN KEY(CodReserva) REFERENCES RESERVA(codigo) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE SERVICO_FRIGOBAR(
	IdServExtra INT,
	Valor REAL NOT NULL,
	CodReserva INT,
	DataSolicitada DATE NOT NULL,
	HoraSolicitada TIME NOT NULL,

	PRIMARY KEY(IdServExtra),
	FOREIGN KEY(CodReserva) REFERENCES RESERVA(codigo) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE PRODUTO(
	Codigo INT, 
	Nome VARCHAR(50) NOT NULL,
	Preco REAL NOT NULL,

	PRIMARY KEY(Codigo)
);

CREATE TABLE PECA(
	Tipo VARCHAR(30),
	Preco REAL NOT NULL,

	PRIMARY KEY(TIPO)
); 

CREATE TABLE TEM_RESERVA(
	IdHospede SERIAL, 
	CodReserva INT,

	PRIMARY KEY(IdHospede, CodReserva),
	FOREIGN KEY(CodReserva) REFERENCES RESERVA(Codigo) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY(IdHospede) REFERENCES HOSPEDE(Id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE ACOMPANHANTES(
	IdAcompanhante SERIAL,
	idHospedePrincipal SERIAL,

	PRIMARY KEY(IdAcompanhante, idHospedePrincipal),
	FOREIGN KEY(IdAcompanhante) REFERENCES HOSPEDE(ID) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY(idHospedePrincipal) REFERENCES HOSPEDE(ID) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE LAVANDERIA_LAVA_PECA(
	IdServExtraLavanderia INT,
	TipoPeca VARCHAR(30),
	Quantidade INT NOT NULL,
	ValorLavagem REAL NOT NULL,

	PRIMARY KEY(IdServExtraLavanderia, TipoPeca),
	FOREIGN KEY(IdServExtraLavanderia) REFERENCES SERVICO_LAVANDERIA(IdServExtra) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY(TipoPeca) REFERENCES PECA(TIPO) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE BAR_TEM_PRODUTO(
	IdServExtraBar INT,
	CodProduto INT,
	Quantidade INT NOT NULL,
	ValorVenda REAL NOT NULL,

	PRIMARY KEY(IdServExtraBar, CodProduto),
	FOREIGN KEY(IdServExtraBar) REFERENCES SERVICO_BAR_RESTAURANTE(idServExtra) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY(CodProduto) REFERENCES PRODUTO(Codigo) ON UPDATE CASCADE ON DELETE RESTRICT

);

CREATE TABLE FRIGOBAR_TEM_PRODUTO(
	IdServExtraFrigobar INT,
	CodProduto INT,
	Quantidade INT NOT NULL,
	ValorVenda REAL NOT NULL,

	PRIMARY KEY(IdServExtraFrigobar, CodProduto),
	FOREIGN KEY(IdServExtraFrigobar) REFERENCES SERVICO_FRIGOBAR(idServExtra) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY(CodProduto) REFERENCES PRODUTO(Codigo) ON UPDATE CASCADE ON DELETE RESTRICT	
);

CREATE TABLE TELEFONE_CADASTRO(
	CpfCadastrado CHARACTER(11),
	Telefone VARCHAR(15),
	
	PRIMARY KEY(CpfCadastrado, Telefone),
	FOREIGN KEY(CpfCadastrado) REFERENCES CADASTRO(CPF)	ON UPDATE CASCADE ON DELETE CASCADE
);

--TABELA CADASTRO
INSERT INTO CADASTRO(CPF, DATANASCIMENTO, EMAIL, SENHA, NOME, PAIS, ESTADO,
CIDADE, BAIRRO, RUA, NUMERO, COMPLEMENTO) 
VALUES(
	'63363932162',
	'22/12/1983',
	'JoaoMartinsCavalcanti@dayrep.com',
	'keipha9Moa',
	'Joao Martins Cavalcanti',
	'Brasil',
	'RS' ,
	'Água Santa',
	'Centro' ,
	'Rua Padre Júlio Marin',
	 669,
	'CASA'
);

INSERT INTO CADASTRO(CPF, DATANASCIMENTO, EMAIL, SENHA, NOME, PAIS, ESTADO,
CIDADE, BAIRRO, RUA, NUMERO, COMPLEMENTO) 
VALUES(
	'77619654470',
	'25/11/1994',
	'rayssastellanat@liacampos.com',
	'UxoGgUNd7y',
	'Rayssa Stella Natália Campos',
	'Brasil',
	'RN' ,
	'Almino Afonso',
	'Centro' ,
	'Rua Florentina Nunes',
	 22,
	'CASA'
);

INSERT INTO CADASTRO(CPF, DATANASCIMENTO, EMAIL, SENHA, NOME, PAIS, ESTADO,
CIDADE, BAIRRO, RUA, NUMERO, COMPLEMENTO) 
VALUES(
	'39667003280',
	'16/04/1999',
	'ccarloseduardojojo@cosma.com',
	'qiB9emlNpo',
	'Carlos Eduardo João Araújo',
	'Brasil',
	'AC' ,
	'Campinas',
	'Centro' ,
	'Rua Kaxinawás',
	 770,
	'CASA'
);

INSERT INTO CADASTRO(CPF, DATANASCIMENTO, EMAIL, SENHA, NOME, PAIS, ESTADO,
CIDADE, BAIRRO, RUA, NUMERO, COMPLEMENTO) 
VALUES(
	'98479365447',
	'09/04/1998',
	'carolinealmeida-92@etep.edu.br',
	'j9Hd2mPxA2',
	'Caroline Betina Vitória Almeida',
	'Brasil',
	'AL' ,
	'Belém',
	'Centro' ,
	'Rua do Comércio 123',
	 683,
	'APARTAMENTO'
);

INSERT INTO CADASTRO(CPF, DATANASCIMENTO, EMAIL, SENHA, NOME, PAIS, ESTADO,
CIDADE, BAIRRO, RUA, NUMERO, COMPLEMENTO) 
VALUES(
	'99511923510',
	'02/03/1996',
	'brunalima@techdomus.com.br',
	'6kG0hp7roK',
	'Lívia Bruna Lima',
	'Brasil',
	'BA' ,
	'Barra do Rocha',
	'Centro' ,
	'Rua Otávio Mangabeira 01',
	 257,
	'CASA'
);
INSERT INTO CADASTRO(CPF, DATANASCIMENTO, EMAIL, SENHA, NOME, PAIS, ESTADO,
CIDADE, BAIRRO, RUA, NUMERO, COMPLEMENTO) 
VALUES(
	'41639742379',
	'22/03/1995',
	'gabrieleduardofreitas@tadex.com.br',
	'BYFaXyzpXi',
	'Gabriel Eduardo Freitas',
	'Brasil',
	'CE' ,
	'Aguaí',
	'Centro' ,
	'Rua Principal, s/n',
	 528,
	'CASA'
);
INSERT INTO CADASTRO(CPF, DATANASCIMENTO, EMAIL, SENHA, NOME, PAIS, ESTADO,
CIDADE, BAIRRO, RUA, NUMERO, COMPLEMENTO) 
VALUES(
	'37266741360',
	'25/12/1994',
	'ricardoribeiro@ntiequipamentos.com.br',
	'bUMwFccuN3',
	'Lucca Luiz Ricardo Ribeiro',
	'Brasil',
	'CE' ,
	'Campos',
	'Centro' ,
	'Rua Principal, s/n',
	 577,
	'CASA'
);
INSERT INTO CADASTRO(CPF, DATANASCIMENTO, EMAIL, SENHA, NOME, PAIS, ESTADO,
CIDADE, BAIRRO, RUA, NUMERO, COMPLEMENTO) 
VALUES(
	'04853851127',
	'12/08/1993',
	'emanuellylima@supercleanlav.com.br',
	'FekJ6YqRNO',
	'Maria Emanuelly Lima',
	'Brasil',
	'DF' ,
	'Brasília',
	'Setor de Habitações Individuais Norte' ,
	'Quadra SHIN QI 11',
	 466,
	'CASA'
);
INSERT INTO CADASTRO(CPF, DATANASCIMENTO, EMAIL, SENHA, NOME, PAIS, ESTADO,
CIDADE, BAIRRO, RUA, NUMERO, COMPLEMENTO) 
VALUES(
	'41863714154',
	'24/02/1997',
	'ttheopietrobarros@mmetalica.com.br',
	'2ATWIKAc5K',
	'Theo Pietro Barros',
	'Brasil',
	'DF' ,
	'Brasília',
	'Samambaia Norte (Samambaia)' ,
	'Quadra QR 401 Área Especial 2',
	 935,
	'CASA'
);
INSERT INTO CADASTRO(CPF, DATANASCIMENTO, EMAIL, SENHA, NOME, PAIS, ESTADO,
CIDADE, BAIRRO, RUA, NUMERO, COMPLEMENTO) 
VALUES(
	'05638281100',
	'17/07/1993',
	'henriquenascimento@clubedorei.com.br',
	'WFnZmSubhn',
	'Henrique Juan Enrico Nascimento',
	'Brasil',
	'GO' ,
	'Aparecida de Goiânia',
	'Parque Ibirapuera' ,
	'Rua C 10',
	 944,
	'CASA'
);
INSERT INTO CADASTRO(CPF, DATANASCIMENTO, EMAIL, SENHA, NOME, PAIS, ESTADO,
CIDADE, BAIRRO, RUA, NUMERO, COMPLEMENTO) 
VALUES(
	'52244739694',
	'23/06/1990',
	'franciscomiguelima-87@silnave.com.br',
	'cLuAZAc3x0',
	'Francisco Miguel Lima',
	'Brasil',
	'MG' ,
	'Açucena',
	'Centro' ,
	'Rua Praça Edson Miranda 106',
	 403,
	'CASA'
);
INSERT INTO CADASTRO(CPF, DATANASCIMENTO, EMAIL, SENHA, NOME, PAIS, ESTADO,
CIDADE, BAIRRO, RUA, NUMERO, COMPLEMENTO) 
VALUES(
	'98673102413',
	'18/04/1983',
	'leteciaflaviacardoso_@soelegancia.com.br',
	'wIpwCRdZde',
	'Letícia Flávia Cardoso',
	'Brasil',
	'PB' ,
	'Cabedelo',
	'Renascer' ,
	'Rua Jesus de Nazaré',
	 101,
	'APARTAMENTO'
);
INSERT INTO CADASTRO(CPF, DATANASCIMENTO, EMAIL, SENHA, NOME, PAIS, ESTADO,
CIDADE, BAIRRO, RUA, NUMERO, COMPLEMENTO) 
VALUES(
	'32238039473',
	'27/08/1991',
	'enzonicolasrodrigopaula-94@cosma.com',
	'B5gUKuqE0A',
	'Enzo Nicolas Rodrigo de Paula',
	'Brasil',
	'PB' ,
	'Cabedelo',
	'Renascer' ,
	'Rua Jesus de Nazaré',
	 101,
	'APARTAMENTO'
);
INSERT INTO CADASTRO(CPF, DATANASCIMENTO, EMAIL, SENHA, NOME, PAIS, ESTADO,
CIDADE, BAIRRO, RUA, NUMERO, COMPLEMENTO) 
VALUES(
	'97533189442',
	'26/06/1988',
	'julianamarianeisabellima@nogueiramoura.adv.br',
	'u0HplmAAu2',
	'Juliana Mariane Isabel Lima',
	'Brasil',
	'CE' ,
	'Boa Vista',
	'Centro' ,
	'Rua do Comércio',
	 139,
	'CASA'
);
INSERT INTO CADASTRO(CPF, DATANASCIMENTO, EMAIL, SENHA, NOME, PAIS, ESTADO,
CIDADE, BAIRRO, RUA, NUMERO, COMPLEMENTO) 
VALUES(
	'17878302332',
	'03/12/1985',
	'henrypedro moura@valeguinchos.com.br',
	'GUtzKC0bkX',
	'André Henry Pedro Moura',
	'Brasil',
	'CE' ,
	'Boa Vista',
	'Centro' ,
	'Rua Cícero Justino Sobrinho, s/n',
	 930,
	'CASA'
);
INSERT INTO CADASTRO(CPF, DATANASCIMENTO, EMAIL, SENHA, NOME, PAIS, ESTADO,
CIDADE, BAIRRO, RUA, NUMERO, COMPLEMENTO) 
VALUES(
	'58297177432',
	'23/02/1990',
	'franciscoryanviniciusmendes-92@portoweb.com.br',
	'FeclTtiF6R',
	'Francisco Ryan Vinicius Mendes',
	'Brasil',
	'CE' ,
	'Boa Vista',
	'Centro' ,
	'Rua do Comércio',
	 139,
	'CASA'
);
INSERT INTO CADASTRO(CPF, DATANASCIMENTO, EMAIL, SENHA, NOME, PAIS, ESTADO,
CIDADE, BAIRRO, RUA, NUMERO, COMPLEMENTO) 
VALUES(
	'21244197149',
	'18/05/1982',
	'gabriellystefanyarajo@grupoitaipu.com.br',
	'mNj0ayP36O',
	'Gabrielly Stefany Araújo',
	'Brasil',
	'CE' ,
	'Boa Vista',
	'Centro' ,
	'Rua Cícero Justino Sobrinho, s/n',
	 930,
	'CASA'
);
INSERT INTO CADASTRO(CPF, DATANASCIMENTO, EMAIL, SENHA, NOME, PAIS, ESTADO,
CIDADE, BAIRRO, RUA, NUMERO, COMPLEMENTO) 
VALUES(
	'24134746256',
	'06/09/1989',
	'lorenacarolineemanuellymonteiro@yoma.com.br',
	'Oo8fHH2g1W',
	'Lorena Caroline Emanuelly Monteiro',
	'Brasil',
	'AM' ,
	'Fonte Boa',
	'Cidade Nova' ,
	'Avenida Governador Gilberto Mestrinho 626',
	 962,
	'CASA'
);

--TABELA TIPO_QUARTO

INSERT INTO TIPO_QUARTO(Tipo, Descricao, ValorDiaria)
VALUES(
	'Quarto Solteiro',
	'Quarto com 8m² para uma pessoa, com uma cama de solteiro.',
	80
);

INSERT INTO TIPO_QUARTO(Tipo, Descricao, ValorDiaria)
VALUES(
	'Quarto Duplo Solteiro',
	'Contém duas camas de solteiro destinadas a duas pessoas e com 18m².',
	150
);

INSERT INTO TIPO_QUARTO(Tipo, Descricao, ValorDiaria)
VALUES(
	'Quarto Casal',
	'Quarto com 18m² destinado a duas pessoas, mas com uma cama de casal.',
	180
);

INSERT INTO TIPO_QUARTO(Tipo, Descricao, ValorDiaria)
VALUES(
	'Quarto Família',
	'Quarto com 75m² para até cinco pessoas. Possui dois quartos separados, banheiro único e uma cozinha.',
	400
);

INSERT INTO TIPO_QUARTO(Tipo, Descricao, ValorDiaria)
VALUES(
	'Quarto Suíte',
	'Quarto bastante espaçoso com 200m². Semelhante a uma residência particular bem equipada',
	1000
);

--TABELA QUARTO

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	1,
	'Quarto Solteiro',
	true --true significa que o quarto está vago
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	2,
	'Quarto Solteiro',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	3,
	'Quarto Solteiro',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	4,
	'Quarto Solteiro',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	5,
	'Quarto Solteiro',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	6,
	'Quarto Solteiro',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	7,
	'Quarto Solteiro',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	8,
	'Quarto Solteiro',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	9,
	'Quarto Solteiro',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	10,
	'Quarto Solteiro',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	11,
	'Quarto Solteiro',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	12,
	'Quarto Solteiro',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	13,
	'Quarto Solteiro',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	14,
	'Quarto Solteiro',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	15,
	'Quarto Solteiro',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	16,
	'Quarto Solteiro',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	17,
	'Quarto Solteiro',
	true
);


INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	18,
	'Quarto Solteiro',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	19,
	'Quarto Solteiro',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	20,
	'Quarto Solteiro',
	true
);


INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	21,
	'Quarto Duplo Solteiro',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	22,
	'Quarto Duplo Solteiro',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	23,
	'Quarto Duplo Solteiro',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	24,
	'Quarto Duplo Solteiro',
	true
);


INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	25,
	'Quarto Duplo Solteiro',
	true
);


INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	26,
	'Quarto Duplo Solteiro',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	27,
	'Quarto Duplo Solteiro',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	28,
	'Quarto Duplo Solteiro',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	29,
	'Quarto Duplo Solteiro',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	30,
	'Quarto Duplo Solteiro',
	true
);


INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	31,
	'Quarto Casal',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	32,
	'Quarto Casal',
	true
);


INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	33,
	'Quarto Casal',
	true
);


INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	34,
	'Quarto Casal',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	35,
	'Quarto Casal',
	true
);


INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	36,
	'Quarto Casal',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	37,
	'Quarto Casal',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	38,
	'Quarto Casal',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	39,
	'Quarto Casal',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	40,
	'Quarto Casal',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	41,
	'Quarto Família',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	42,
	'Quarto Família',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	43,
	'Quarto Família',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	44,
	'Quarto Família',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	45,
	'Quarto Família',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	46,
	'Quarto Família',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	47,
	'Quarto Família',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	48,
	'Quarto Família',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	49,
	'Quarto Família',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	50,
	'Quarto Família',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	51,
	'Quarto Família',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	52,
	'Quarto Suíte',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	53,
	'Quarto Suíte',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	54,
	'Quarto Suíte',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	55,
	'Quarto Suíte',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	56,
	'Quarto Suíte',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	57,
	'Quarto Suíte',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	58,
	'Quarto Suíte',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	59,
	'Quarto Suíte',
	true
);

INSERT INTO QUARTO(Numero, Tipo, Status)
VALUES(
	60,
	'Quarto Suíte',
	true
);

--TABELA RESERVA
INSERT INTO RESERVA(Codigo, Data, Status, Tipo, NumQuarto)
VALUES(
	0001,
	'02/09/2017',
	false,
	'Feita através da EcoViagem',
	11
);

INSERT INTO RESERVA(Codigo, Data, Status, Tipo, NumQuarto)
VALUES(
	0002,
	'05/09/2017',
	false, --false significa que a reserva já passou o seu tempo
	'Feita no próprio hotel',
	1
);

INSERT INTO RESERVA(Codigo, Data, Status, Tipo, NumQuarto)
VALUES(
	0003,
	'05/09/2017',
	false,
	'Feita no próprio hotel',
	3
);

INSERT INTO RESERVA(Codigo, Data, Status, Tipo, NumQuarto)
VALUES(
	0004,
	'05/09/2017',
	false,
	'Feita através da CVC Viagens',
	4
);

INSERT INTO RESERVA(Codigo, Data, Status, Tipo, NumQuarto)
VALUES(
	0005,
	'05/09/2017',
	false,
	'Feita através da CVC Viagens',
	6
);

INSERT INTO RESERVA(Codigo, Data, Status, Tipo, NumQuarto)
VALUES(
	0006,
	'06/09/2017',
	false,
	'Feita através da EcoViagens',
	7
);

INSERT INTO RESERVA(Codigo, Data, Status, Tipo, NumQuarto)
VALUES(
	0007,
	'06/09/2017',
	false,
	'Feita através no próprio hotel',
	8
);

INSERT INTO RESERVA(Codigo, Data, Status, Tipo, NumQuarto)
VALUES(
	0008,
	'05/09/2017',
	false,
	'Feita através da CVC Viagens',
	10
);


INSERT INTO RESERVA(Codigo, Data, Status, Tipo, NumQuarto)
VALUES(
	0009,
	'05/09/2017',
	false,
	'Feita através EcoViagem',
	13
);

INSERT INTO RESERVA(Codigo, Data, Status, Tipo, NumQuarto)
VALUES(
	0010,
	'06/09/2017',
	false,
	'Feita no próprio hotel',
	19
);


INSERT INTO RESERVA(Codigo, Data, Status, Tipo, NumQuarto)
VALUES(
	0011,
	'03/09/2017',
	false,
	'Feita através da CVC Viagens',
	22
);

INSERT INTO RESERVA(Codigo, Data, Status, Tipo, NumQuarto)
VALUES(
	0012,
	'01/09/2017',
	false,
	'Feita através da trivago',
	31
);

INSERT INTO RESERVA(Codigo, Data, Status, Tipo, NumQuarto)
VALUES(
	0013,
	'02/09/2017',
	false,
	'Feita através da Submarino Viagens',
	45
);

--TABELA HOSPEDE

INSERT INTO HOSPEDE(ID, CpfCadastrado, MotivoViagem, LocalOrigem, LocalDestino, NumQuarto)
VALUES(
	1,
	'63363932162',
	'Não informado',
	'Não informado',
	'Não informado',
	1
);

INSERT INTO HOSPEDE(ID, CpfCadastrado, MotivoViagem, LocalOrigem, LocalDestino, NumQuarto)
VALUES(
	2,
	'77619654470',
	'Não informado',
	'Não informado',
	'Não informado',
	3
);

INSERT INTO HOSPEDE(ID, CpfCadastrado, MotivoViagem, LocalOrigem, LocalDestino, NumQuarto)
VALUES(
	3,
	'39667003280',
	'Trabalho',
	'Campinas-AC',
	'Cajazeiras',
	4
);

INSERT INTO HOSPEDE(ID, CpfCadastrado, MotivoViagem, LocalOrigem, LocalDestino, NumQuarto)
VALUES(
	4,
	'98479365447',
	'Trabalho',
	'Belém-AL',
	'Mauriti-CE',
	6
);

INSERT INTO HOSPEDE(ID, CpfCadastrado, MotivoViagem, LocalOrigem, LocalDestino, NumQuarto)
VALUES(
	5,
	'99511923510',
	'Não informado',
	'Não informado',
	'Não informado',
	7
);

INSERT INTO HOSPEDE(ID, CpfCadastrado, MotivoViagem, LocalOrigem, LocalDestino, NumQuarto)
VALUES(
	6,
	'41639742379',
	'Não informado',
	'Não informado',
	'Não informado',
	8
);

INSERT INTO HOSPEDE(ID, CpfCadastrado, MotivoViagem, LocalOrigem, LocalDestino, NumQuarto)
VALUES(
	7,
	'37266741360',
	'Trabalho',
	'Campos-CE',
	'Patos-PB',
	10
);

INSERT INTO HOSPEDE(ID, CpfCadastrado, MotivoViagem, LocalOrigem, LocalDestino, NumQuarto)
VALUES(
	18,
	'24134746256',
	'Trabalho',
	'Fonte Boa-AM',
	'Sousa-pb',
	11
);

INSERT INTO HOSPEDE(ID, CpfCadastrado, MotivoViagem, LocalOrigem, LocalDestino, NumQuarto)
VALUES(
	8,
	'04853851127',
	'Não informado',
	'Não informado',
	'Não informado',
	13
);

INSERT INTO HOSPEDE(ID, CpfCadastrado, MotivoViagem, LocalOrigem, LocalDestino, NumQuarto)
VALUES(
	9,
	'41863714154',
	'Não informado',
	'Não informado',
	'Não informado',
	19
);

INSERT INTO HOSPEDE(ID, CpfCadastrado, MotivoViagem, LocalOrigem, LocalDestino, NumQuarto)
VALUES(
	10,
	'05638281100',
	'Trabalho',
	'Aparecida de Goiânia',
	'Cajazeiras',
	22
);


INSERT INTO HOSPEDE(ID, CpfCadastrado, MotivoViagem, LocalOrigem, LocalDestino, NumQuarto)
VALUES(
	11,
	'52244739694',
	'Trabalho',
	'Açucena-MG',
	'Cajazeiras',
	22
);

INSERT INTO HOSPEDE(ID, CpfCadastrado, MotivoViagem, LocalOrigem, LocalDestino, NumQuarto)
VALUES(
	12,
	'98673102413',
	'Lazer',
	'Cabedelo-PB',
	'Cajazeiras',
	31
);


INSERT INTO HOSPEDE(ID, CpfCadastrado, MotivoViagem, LocalOrigem, LocalDestino, NumQuarto)
VALUES(
	13,
	'32238039473',
	'Lazer',
	'Cabedelo-PB',
	'Cajazeiras',
	31
);

INSERT INTO HOSPEDE(ID, CpfCadastrado, MotivoViagem, LocalOrigem, LocalDestino, NumQuarto)
VALUES(
	14,
	'97533189442',
	'Lazer',
	'Boa Vista-CE',
	'Cajazeiras',
	45
);


INSERT INTO HOSPEDE(ID, CpfCadastrado, MotivoViagem, LocalOrigem, LocalDestino, NumQuarto)
VALUES(
	15,
	'17878302332',
	'Lazer',
	'Boa Vista-CE',
	'Cajazeiras',
	45
);

INSERT INTO HOSPEDE(ID, CpfCadastrado, MotivoViagem, LocalOrigem, LocalDestino, NumQuarto)
VALUES(
	16,
	'58297177432',
	'Lazer',
	'Boa Vista-CE',
	'Cajazeiras',
	45
);

INSERT INTO HOSPEDE(ID, CpfCadastrado, MotivoViagem, LocalOrigem, LocalDestino, NumQuarto)
VALUES(
	17,
	'21244197149',
	'Lazer',
	'Boa Vista-CE',
	'Cajazeiras',
	45
);

--TABELA TEM_RESERVA

INSERT INTO TEM_RESERVA(IdHospede, CodReserva)
VALUES(
	18,
	1 

);

INSERT INTO TEM_RESERVA(IdHospede, CodReserva)
VALUES(
	1,
	2
);

INSERT INTO TEM_RESERVA(IdHospede, CodReserva)
VALUES(
	2, 
	3 

);

INSERT INTO TEM_RESERVA(IdHospede, CodReserva)
VALUES(
	3, 
	4 

);

INSERT INTO TEM_RESERVA(IdHospede, CodReserva)
VALUES(
	4, 
	5

);

INSERT INTO TEM_RESERVA(IdHospede, CodReserva)
VALUES(
	5, 
	6

);

INSERT INTO TEM_RESERVA(IdHospede, CodReserva)
VALUES(
	6, 
	7 

);

INSERT INTO TEM_RESERVA(IdHospede, CodReserva)
VALUES(
	7, 
	8

);

INSERT INTO TEM_RESERVA(IdHospede, CodReserva)
VALUES(
	8, 
	9 

);

INSERT INTO TEM_RESERVA(IdHospede, CodReserva)
VALUES(
	9, 
	10

);

INSERT INTO TEM_RESERVA(IdHospede, CodReserva)
VALUES(
	11, 
	11

);

INSERT INTO TEM_RESERVA(IdHospede, CodReserva)
VALUES(
	12, 
	12
);

INSERT INTO TEM_RESERVA(IdHospede, CodReserva)
VALUES(
	15,
	13

);


--TABELA CHECAGEM
INSERT INTO CHECAGEM(Codigo, DataMarcada, HoraMarcada, Status, Observacao, IdHospede, Tipo, Data, Hora)
VALUES(
	default,
	'05/09/2017',
	'00:00',
	true,
	'',
	1,
	'Entrada',
	'05/09/2017',
	'00:00'
);

INSERT INTO CHECAGEM(Codigo, DataMarcada, HoraMarcada, Status, Observacao, IdHospede, Tipo, Data, Hora)
VALUES(
	default,
	'06/09/2017',
	'00:00',
	true,
	'',
	1,
	'Saída',
	'05/09/2017',
	'12:30'
);

INSERT INTO CHECAGEM(Codigo, DataMarcada, HoraMarcada, Status, Observacao, IdHospede, Tipo, Data, Hora)
VALUES(
	default,
	'05/09/2017',
	'04:00',
	true,
	'',
	2,
	'Entrada',
	'05/09/2017',
	'04:00'
);

INSERT INTO CHECAGEM(Codigo, DataMarcada, HoraMarcada, Status, Observacao, IdHospede, Tipo, Data, Hora)
VALUES(
	default,
	'07/09/2017',
	'04:00',
	true,
	'',
	2,
	'Saída',
	'07/09/2017',
	'04:00'
);

INSERT INTO CHECAGEM(Codigo, DataMarcada, HoraMarcada, Status, Observacao, IdHospede, Tipo, Data, Hora)
VALUES(
	default,
	'07/09/2017',
	'08:30',
	true,
	'',
	3,
	'Entrada',
	'07/09/2017',
	'08:30'
);

INSERT INTO CHECAGEM(Codigo, DataMarcada, HoraMarcada, Status, Observacao, IdHospede, Tipo, Data, Hora)
VALUES(
	default,
	'08/09/2017',
	'08:30',
	true,
	'',
	3,
	'Saída',
	'07/09/2017',
	'21:30'
);

INSERT INTO CHECAGEM(Codigo, DataMarcada, HoraMarcada, Status, Observacao, IdHospede, Tipo, Data, Hora)
VALUES(
	default,
	'06/09/2017',
	'10:30',
	true,
	'Problema mecânico com o transporte',
	4,
	'Entrada',
	'06/09/2017',
	'11:40'
);

INSERT INTO CHECAGEM(Codigo, DataMarcada, HoraMarcada, Status, Observacao, IdHospede, Tipo, Data, Hora)
VALUES(
	default,
	'06/09/2017',
	'21:30',
	true,
	'',
	4,
	'Saída',
	'06/09/2017',
	'21:00'
);

INSERT INTO CHECAGEM(Codigo, DataMarcada, HoraMarcada, Status, Observacao, IdHospede, Tipo, Data, Hora)
VALUES(
	default,
	'06/09/2017',
	'10:30',
	true,
	'Problema mecânico com o transporte',
	5,
	'Entrada',
	'06/09/2017',
	'11:40'
);

INSERT INTO CHECAGEM(Codigo, DataMarcada, HoraMarcada, Status, Observacao, IdHospede, Tipo, Data, Hora)
VALUES(
	default,
	'06/09/2017',
	'21:30',
	true,
	'',
	5,
	'Saída',
	'06/09/2017',
	'21:00'
);

INSERT INTO CHECAGEM(Codigo, DataMarcada, HoraMarcada, Status, Observacao, IdHospede, Tipo, Data, Hora)
VALUES(
	default,
	'06/09/2017',
	'11:30',
	true,
	'',
	6,
	'Entrada',
	'06/09/2017',
	'11:30'
);

INSERT INTO CHECAGEM(Codigo, DataMarcada, HoraMarcada, Status, Observacao, IdHospede, Tipo, Data, Hora)
VALUES(
	default,
	'07/09/2017',
	'11:30',
	true,
	'',
	6,
	'Saída',
	'07/09/2017',
	'05:30'
);

INSERT INTO CHECAGEM(Codigo, DataMarcada, HoraMarcada, Status, Observacao, IdHospede, Tipo, Data, Hora)
VALUES(
	default,
	'06/09/2017',
	'11:30',
	true,
	'',
	7,
	'Entrada',
	'06/09/2017',
	'11:30'
);

INSERT INTO CHECAGEM(Codigo, DataMarcada, HoraMarcada, Status, Observacao, IdHospede, Tipo, Data, Hora)
VALUES(
	default,
	'07/09/2017',
	'11:30',
	true,
	'',
	7,
	'Saída',
	'07/09/2017',
	'09:30'
);

INSERT INTO CHECAGEM(Codigo, DataMarcada, HoraMarcada, Status, Observacao, IdHospede, Tipo, Data, Hora)
VALUES(
	default,
	'06/09/2017',
	'10:30',
	true,
	'',
	18,
	'Entrada',
	'06/09/2017',
	'15:30'
);

INSERT INTO CHECAGEM(Codigo, DataMarcada, HoraMarcada, Status, Observacao, IdHospede, Tipo, Data, Hora)
VALUES(
	default,
	'07/09/2017',
	'13:30',
	true,
	'',
	18,
	'Saída',
	'06/09/2017',
	'22:30'
);

INSERT INTO CHECAGEM(Codigo, DataMarcada, HoraMarcada, Status, Observacao, IdHospede, Tipo, Data, Hora)
VALUES(
	default,
	'06/09/2017',
	'11:30',
	true,
	'',
	8,
	'Entrada',
	'06/09/2017',
	'11:30'
);

INSERT INTO CHECAGEM(Codigo, DataMarcada, HoraMarcada, Status, Observacao, IdHospede, Tipo, Data, Hora)
VALUES(
	default,
	'07/09/2017',
	'11:30',
	true,
	'',
	8,
	'Saída',
	'06/09/2017',
	'18:30'
);

INSERT INTO CHECAGEM(Codigo, DataMarcada, HoraMarcada, Status, Observacao, IdHospede, Tipo, Data, Hora)
VALUES(
	default,
	'06/09/2017',
	'15:30',
	true,
	'',
	9,
	'Entrada',
	'06/09/2017',
	'15:30'
);

INSERT INTO CHECAGEM(Codigo, DataMarcada, HoraMarcada, Status, Observacao, IdHospede, Tipo, Data, Hora)
VALUES(
	default,
	'07/09/2017',
	'15:30',
	true,
	'',
	9,
	'Saída',
	'06/09/2017',
	'18:30'
);

INSERT INTO CHECAGEM(Codigo, DataMarcada, HoraMarcada, Status, Observacao, IdHospede, Tipo, Data, Hora)
VALUES(
	default,
	'07/09/2017',
	'05:00',
	true,
	'',
	11,
	'Entrada',
	'07/09/2017',
	'05:00'
);

INSERT INTO CHECAGEM(Codigo, DataMarcada, HoraMarcada, Status, Observacao, IdHospede, Tipo, Data, Hora)
VALUES(
	default,
	'08/09/2017',
	'05:00',
	true,
	'',
	11,
	'Saída',
	'08/09/2017',
	'05:00'
);

INSERT INTO CHECAGEM(Codigo, DataMarcada, HoraMarcada, Status, Observacao, IdHospede, Tipo, Data, Hora)
VALUES(
	default,
	'05/09/2017',
	'05:00',
	true,
	'',
	12,
	'Entrada',
	'05/09/2017',
	'05:00'
);

INSERT INTO CHECAGEM(Codigo, DataMarcada, HoraMarcada, Status, Observacao, IdHospede, Tipo, Data, Hora)
VALUES(
	default,
	'08/09/2017',
	'05:00',
	true,
	'',
	12,
	'Saída',
	'07/09/2017',
	'21:00'
);

INSERT INTO CHECAGEM(Codigo, DataMarcada, HoraMarcada, Status, Observacao, IdHospede, Tipo, Data, Hora)
VALUES(
	default,
	'05/09/2017',
	'05:00',
	true,
	'',
	15,
	'Entrada',
	'05/09/2017',
	'05:00'
);

INSERT INTO CHECAGEM(Codigo, DataMarcada, HoraMarcada, Status, Observacao, IdHospede, Tipo, Data, Hora)
VALUES(
	default,
	'08/09/2017',
	'05:00',
	true,
	'',
	15,
	'Saída',
	'07/09/2017',
	'21:00'
);

--TABELA ACOMPANHANTES

INSERT INTO ACOMPANHANTES(IdAcompanhante, IdHospedePrincipal)
VALUES(
	10,
	11
);

INSERT INTO ACOMPANHANTES(IdAcompanhante, IdHospedePrincipal)
VALUES(
	13,
	12
);

INSERT INTO ACOMPANHANTES(IdAcompanhante, IdHospedePrincipal)
VALUES(
	14,
	15
);

INSERT INTO ACOMPANHANTES(IdAcompanhante, IdHospedePrincipal)
VALUES(
	16,
	15
);

INSERT INTO ACOMPANHANTES(IdAcompanhante, IdHospedePrincipal)
VALUES(
	17,
	15
);

---TABELA PRODUTO
INSERT INTO PRODUTO(CODIGO , NOME , PRECO) 
VALUES(
	4,
	'Cerveja Skol - 350ML',
	4.50
);

INSERT INTO PRODUTO(CODIGO , NOME , PRECO) 
VALUES(
	5,
	'Vodka CÎROC - 750ML',
	4.50
);
INSERT INTO PRODUTO(CODIGO , NOME , PRECO) 
VALUES(
	6,
	'Vodka ABSOLUT - 1L',
	69.00
);
INSERT INTO PRODUTO(CODIGO , NOME , PRECO) 
VALUES(
	7,
	'Vodka Skyy 90 - 750ML',
	99.20
);
INSERT INTO PRODUTO(CODIGO , NOME , PRECO) 
VALUES(
	8,
	'Coca-Cola - 1L',
	6.00
	
);
INSERT INTO PRODUTO(CODIGO , NOME , PRECO) 
VALUES(
	9,
	'Coca-Cola - 350ML',
	2.90
	
);
INSERT INTO PRODUTO(CODIGO , NOME , PRECO) 
VALUES(
	10,
	'Cerveja Brahma - 350ML',
	4.50
);

INSERT INTO PRODUTO(CODIGO , NOME , PRECO) 
VALUES(
	11,
	'Guaraná Antartica - 2L',
	7.49
	
);
INSERT INTO PRODUTO(CODIGO , NOME , PRECO) 
VALUES(
	12,
	'Guaraná Antartica - 350ML',
	2.39
	
);
INSERT INTO PRODUTO(CODIGO , NOME , PRECO) 
VALUES(
	13,
	'Guaraná Antartica - 1L',
	5.90
	
);
INSERT INTO PRODUTO(CODIGO , NOME , PRECO) 
VALUES(
	14,
	'Tapioca',
	3.50
	
);
INSERT INTO PRODUTO(CODIGO , NOME , PRECO) 
VALUES(
	15,
	'Baião de Dois',
	9.00
	
);
INSERT INTO PRODUTO(CODIGO , NOME , PRECO) 
VALUES(
	16,
	'Carne de Sol com Queijo Coalho',
	11.00
	
);
INSERT INTO PRODUTO(CODIGO , NOME , PRECO) 
VALUES(
	17,
	'Vatapá',
	5.00
	
);
INSERT INTO PRODUTO(CODIGO , NOME , PRECO) 
VALUES(
	18,
	'Buchada de Bode',
	8.00
	
);
INSERT INTO PRODUTO(CODIGO , NOME , PRECO) 
VALUES(
	19,
	'Macaxeira',
	5.00
	
);
INSERT INTO PRODUTO(CODIGO , NOME , PRECO) 
VALUES(
	20,
	'Cuscuz de Milho.',
	6.50
	
);
INSERT INTO PRODUTO(CODIGO , NOME , PRECO) 
VALUES(
	21,
	'Sarapatel',
	7.50
);

INSERT INTO PRODUTO(CODIGO , NOME , PRECO) 
VALUES(
	22,
	'Cerveja Bohemia - 350ML',
	4.50
);
INSERT INTO PRODUTO(CODIGO , NOME , PRECO) 
VALUES(
	23,
	'Cerveja Devassa - 350ML',
	4.50
);

---PECA
INSERT INTO PECA(TIPO, PRECO) 
VALUES(
	'Bermuda',
	8.00
);
INSERT INTO PECA(TIPO, PRECO) 
VALUES(
	'Calça',
	13.50
);
INSERT INTO PECA(TIPO, PRECO) 
VALUES(
	'Blusa fem. simples',
	9.80
);
INSERT INTO PECA(TIPO, PRECO) 
VALUES(
	'Camisa',
	9.80
);
INSERT INTO PECA(TIPO, PRECO) 
VALUES(
	'Camiseta',
	8.00
);
INSERT INTO PECA(TIPO, PRECO) 
VALUES(
	'Shorts',
	7.00
);
INSERT INTO PECA(TIPO, PRECO) 
VALUES(
	'Vestido',
	10.00
);
INSERT INTO PECA(TIPO, PRECO) 
VALUES(
	'Saia longa',
	10.00
);
INSERT INTO PECA(TIPO, PRECO) 
VALUES(
	'Calça legging',
	9.00
);
INSERT INTO PECA(TIPO, PRECO) 
VALUES(
	'Jaqueta Jeans',
	12.00
);
INSERT INTO PECA(TIPO, PRECO) 
VALUES(
	'Jaleco',
	10.00
);

--TABELA CONTA
INSERT INTO CONTA(notaFiscal, data, valorTotal, status, codReserva)
VALUES(
	default,
	'06/09/2017',
	109,
	true,
	1
);

INSERT INTO CONTA(notaFiscal, data, valorTotal, status, codReserva)
VALUES(
	default,
	'05/09/2017',
	155,
	true,
	2
);

INSERT INTO CONTA(notaFiscal, data, valorTotal, status, codReserva)
VALUES(
	default,
	'07/09/2017',
	232.5,
	true,
	3
);

INSERT INTO CONTA(notaFiscal, data, valorTotal, status, codReserva)
VALUES(
	default,
	'06/09/2017',
	80,
	true,
	4
);

INSERT INTO CONTA(notaFiscal, data, valorTotal, status, codReserva)
VALUES(
	default,
	'06/09/2017',
	111,
	true,
	5
);

INSERT INTO CONTA(notaFiscal, data, valorTotal, status, codReserva)
VALUES(
	default,
	'06/09/2017',
	80,
	true,
	6
);

INSERT INTO CONTA(notaFiscal, data, valorTotal, status, codReserva)
VALUES(
	default,
	'07/09/2017',
	110,
	true,
	7
);

INSERT INTO CONTA(notaFiscal, data, valorTotal, status, codReserva)
VALUES(
	default,
	'07/09/2017',
	100,
	true,
	8
);

INSERT INTO CONTA(notaFiscal, data, valorTotal, status, codReserva)
VALUES(
	default,
	'06/09/2017',
	80,
	true,
	9
);

INSERT INTO CONTA(notaFiscal, data, valorTotal, status, codReserva)
VALUES(
	default,
	'06/09/2017',
	80,
	true,
	10
);

INSERT INTO CONTA(notaFiscal, data, valorTotal, status, codReserva)
VALUES(
	default,
	'08/09/2017',
	210,
	true,
	11
);

INSERT INTO CONTA(notaFiscal, data, valorTotal, status, codReserva)
VALUES(
	default,
	'07/09/2017',
	436,
	true,
	12
);

INSERT INTO CONTA(notaFiscal, data, valorTotal, status, codReserva)
VALUES(
	default,
	'07/09/2017',
	490,
	true,
	13
);

---TELEFONE_CADASTRO
INSERT INTO TELEFONE_CADASTRO(CpfCadastrado , telefone) 
VALUES(
	'24134746256' ,
	'(67) 99796-5297'
	
);
INSERT INTO TELEFONE_CADASTRO(CpfCadastrado , telefone) 
VALUES(
	'58297177432',
	'(98) 98823-4461'
);
INSERT INTO TELEFONE_CADASTRO(CpfCadastrado , telefone) 
VALUES(
	'21244197149' ,
	'(61) 99115-1522'
);
INSERT INTO TELEFONE_CADASTRO(CpfCadastrado , telefone) 
VALUES(
	'17878302332' ,
	'(68) 98381-8595'
	
);
INSERT INTO TELEFONE_CADASTRO(CpfCadastrado , telefone) 
VALUES(
	'97533189442' ,
	'(77) 98190-5348'
	
);
INSERT INTO TELEFONE_CADASTRO(CpfCadastrado , telefone) 
VALUES(
	'32238039473' ,
	'(51) 98803-9109'
);
INSERT INTO TELEFONE_CADASTRO(CpfCadastrado , telefone) 
VALUES(
	'98673102413' ,
	'(81) 98178-1387'
	
);
INSERT INTO TELEFONE_CADASTRO(CpfCadastrado , telefone) 
VALUES(
	
	'52244739694' ,
	'(27) 99718-1311'
);
INSERT INTO TELEFONE_CADASTRO(CpfCadastrado , telefone) 
VALUES(
	
	'05638281100',
	'(63) 98740-1199'
);
INSERT INTO TELEFONE_CADASTRO(CpfCadastrado , telefone) 
VALUES(
	
	'41863714154',
	'(71) 98341-5996'
);
INSERT INTO TELEFONE_CADASTRO(CpfCadastrado , telefone) 
VALUES(
	
	'04853851127',
	'(62) 99436-7543'
);
INSERT INTO TELEFONE_CADASTRO(CpfCadastrado , telefone) 
VALUES(
	
	'37266741360' ,
	'(79) 98571-6137'
); 
INSERT INTO TELEFONE_CADASTRO(CpfCadastrado , telefone) 
VALUES(
	
	'41639742379' ,
	'(96) 98582-5253'
); 
INSERT INTO TELEFONE_CADASTRO(CpfCadastrado , telefone) 
VALUES(
	
	'99511923510' ,
	'(79) 98365-1918'
);
INSERT INTO TELEFONE_CADASTRO(CpfCadastrado , telefone) 
VALUES(
	'98479365447',
	'(47) 99304-4340'
	
);
INSERT INTO TELEFONE_CADASTRO(CpfCadastrado , telefone) 
VALUES(
	'39667003280' ,
	'(79) 99749-1601'
);
INSERT INTO TELEFONE_CADASTRO(CpfCadastrado , telefone) 
VALUES(
	'77619654470',
	'(79) 99768-7641'
);
INSERT INTO TELEFONE_CADASTRO(CpfCadastrado , telefone) 
VALUES(
	'63363932162',
	'(95) 98977-7010'
);

--TABELA SERVICO_FRIGOBAR

INSERT INTO SERVICO_FRIGOBAR(idServExtra, valor, dataSolicitada, horaSolicitada, codReserva)
VALUES(
	1,
	20,
	'06/09/2017',
	'22:30',
	1
);

INSERT INTO SERVICO_FRIGOBAR(idServExtra, valor, dataSolicitada, horaSolicitada, codReserva)
VALUES(
	2,
	75,
	'05/09/2017',
	'12:30',
	2
);

INSERT INTO SERVICO_FRIGOBAR(idServExtra, valor, dataSolicitada, horaSolicitada, codReserva)
VALUES(
	3,
	45,
	'07/09/2017',
	'04:00',
	3
);

INSERT INTO SERVICO_FRIGOBAR(idServExtra, valor, dataSolicitada, horaSolicitada, codReserva)
VALUES(
	4,
	90,
	'06/09/2017',
	'05:00',
	13
);

INSERT INTO SERVICO_FRIGOBAR(idServExtra, valor, dataSolicitada, horaSolicitada, codReserva)
VALUES(
	5,
	45,
	'07/09/2017',
	'05:00',
	13
);

--TABELA FRIGOBAR_TEM_PRODUTO

INSERT INTO FRIGOBAR_TEM_PRODUTO(idServExtraFrigobar, codProduto, quantidade, valorVenda)
VALUES(
	1,
	22,
	5,
	4
);

INSERT INTO FRIGOBAR_TEM_PRODUTO(idServExtraFrigobar, codProduto, quantidade, valorVenda)
VALUES(
	2,
	6,
	1,
	69
);

INSERT INTO FRIGOBAR_TEM_PRODUTO(idServExtraFrigobar, codProduto, quantidade, valorVenda)
VALUES(
	2,
	8,
	1,
	6
);

INSERT INTO FRIGOBAR_TEM_PRODUTO(idServExtraFrigobar, codProduto, quantidade, valorVenda)
VALUES(
	3,
	23,
	10,
	45
);

INSERT INTO FRIGOBAR_TEM_PRODUTO(idServExtraFrigobar, codProduto, quantidade, valorVenda)
VALUES(
	4,
	22,
	20,
	4.5
);

INSERT INTO FRIGOBAR_TEM_PRODUTO(idServExtraFrigobar, codProduto, quantidade, valorVenda)
VALUES(
	5,
	22,
	20,
	4.5
);

--TABELA SERVICO_BAR_RESTAURANTE

INSERT INTO SERVICO_BAR_RESTAURANTE(idServExtra, valor, dataSolicitada, horaSolicitada, codReserva)
VALUES(
	1,
	9,
	'06/09/2017',
	'19:00',
	1
);

INSERT INTO SERVICO_BAR_RESTAURANTE(idServExtra, valor, dataSolicitada, horaSolicitada, codReserva)
VALUES(
	2,
	26,
	'05/09/2017',
	'13:00',
	3
);

INSERT INTO SERVICO_BAR_RESTAURANTE(idServExtra, valor, dataSolicitada, horaSolicitada, codReserva)
VALUES(
	3,
	31,
	'06/09/2017',
	'19:40',
	5
);

INSERT INTO SERVICO_BAR_RESTAURANTE(idServExtra, valor, dataSolicitada, horaSolicitada, codReserva)
VALUES(
	4,
	116,
	'06/09/2017',
	'19:00',
	12
);

INSERT INTO SERVICO_BAR_RESTAURANTE(idServExtra, valor, dataSolicitada, horaSolicitada, codReserva)
VALUES(
	5,
	138,
	'06/09/2017',
	'19:00',
	13
);

--TABELA BAR_TEM_PRODUTO
INSERT INTO BAR_TEM_PRODUTO(idServExtraBar, codProduto, quantidade, valorVenda)
VALUES(
	1,
	15,
	1,
	9
);

INSERT INTO BAR_TEM_PRODUTO(idServExtraBar, codProduto, quantidade, valorVenda)
VALUES(
	2,
	17,
	4,
	5
);

INSERT INTO BAR_TEM_PRODUTO(idServExtraBar, codProduto, quantidade, valorVenda)
VALUES(
	2,
	13,
	1,
	6
);

INSERT INTO BAR_TEM_PRODUTO(idServExtraBar, codProduto, quantidade, valorVenda)
VALUES(
	3,
	18,
	1,
	8
);

INSERT INTO BAR_TEM_PRODUTO(idServExtraBar, codProduto, quantidade, valorVenda)
VALUES(
	3,
	19,
	1,
	5
);

INSERT INTO BAR_TEM_PRODUTO(idServExtraBar, codProduto, quantidade, valorVenda)
VALUES(
	3,
	4,
	4,
	4.5
);

INSERT INTO BAR_TEM_PRODUTO(idServExtraBar, codProduto, quantidade, valorVenda)
VALUES(
	4,
	7,
	1,
	100
);

INSERT INTO BAR_TEM_PRODUTO(idServExtraBar, codProduto, quantidade, valorVenda)
VALUES(
	4,
	16,
	1,
	10
);

INSERT INTO BAR_TEM_PRODUTO(idServExtraBar, codProduto, quantidade, valorVenda)
VALUES(
	4,
	8,
	1,
	6
);

INSERT INTO BAR_TEM_PRODUTO(idServExtraBar, codProduto, quantidade, valorVenda)
VALUES(
	5,
	7,
	1,
	100
);


INSERT INTO BAR_TEM_PRODUTO(idServExtraBar, codProduto, quantidade, valorVenda)
VALUES(
	5,
	11,
	1,
	11
);

INSERT INTO BAR_TEM_PRODUTO(idServExtraBar, codProduto, quantidade, valorVenda)
VALUES(
	5,
	19,
	3,
	5
);

INSERT INTO BAR_TEM_PRODUTO(idServExtraBar, codProduto, quantidade, valorVenda)
VALUES(
	5,
	8,
	2,
	6
);

--TABELA SERVICO_ACADEMIA

INSERT INTO SERVICO_ACADEMIA(idServExtra, valor, dataSolicitada, horaSolicitada, codReserva, duracaoTreino, tipoTreino)
VALUES(
	1,
	30,
	'06/09/2017',
	'16:00',
	3,
	1,
	'Simples'
);

INSERT INTO SERVICO_ACADEMIA(idServExtra, valor, dataSolicitada, horaSolicitada, codReserva, duracaoTreino, tipoTreino)
VALUES(
	2,
	30,
	'06/09/2017',
	'17:00',
	7,
	1,
	'Simples'
);

INSERT INTO SERVICO_ACADEMIA(idServExtra, valor, dataSolicitada, horaSolicitada, codReserva, duracaoTreino, tipoTreino)
VALUES(
	3,
	30,
	'07/09/2017',
	'20:00',
	11,
	1,
	'Simples'
);

INSERT INTO SERVICO_ACADEMIA(idServExtra, valor, dataSolicitada, horaSolicitada, codReserva, duracaoTreino, tipoTreino)
VALUES(
	4,
	30,
	'07/09/2017',
	'19:00',
	11,
	1,
	'Simples'
);


INSERT INTO SERVICO_ACADEMIA(idServExtra, valor, dataSolicitada, horaSolicitada, codReserva, duracaoTreino, tipoTreino)
VALUES(
	5,
	30,
	'05/09/2017',
	'14:00',
	12,
	1,
	'Simples'
);

INSERT INTO SERVICO_ACADEMIA(idServExtra, valor, dataSolicitada, horaSolicitada, codReserva, duracaoTreino, tipoTreino)
VALUES(
	6,
	30,
	'06/09/2017',
	'14:00',
	12,
	1,
	'Simples'
);

INSERT INTO SERVICO_ACADEMIA(idServExtra, valor, dataSolicitada, horaSolicitada, codReserva, duracaoTreino, tipoTreino)
VALUES(
	7,
	30,
	'07/09/2017',
	'14:00',
	12,
	1,
	'Simples'
);

--TABELA SERVICO_LAVANDERIA
INSERT INTO SERVICO_LAVANDERIA(idServExtra, valor, dataSolicitada, horaSolicitada, codReserva)
VALUES(
	1,
	52.5,
	'06/09/2017',
	'08:00',
	3
);

INSERT INTO SERVICO_LAVANDERIA(idServExtra, valor, dataSolicitada, horaSolicitada, codReserva)
VALUES(
	2,
	20,
	'06/09/2017',
	'08:00',
	8
);

INSERT INTO SERVICO_LAVANDERIA(idServExtra, valor, dataSolicitada, horaSolicitada, codReserva)
VALUES(
	3,
	10,
	'07/09/2017',
	'08:00',
	12
);

INSERT INTO SERVICO_LAVANDERIA(idServExtra, valor, dataSolicitada, horaSolicitada, codReserva)
VALUES(
	4,
	10,
	'06/09/2017',
	'08:00',
	12
);

INSERT INTO SERVICO_LAVANDERIA(idServExtra, valor, dataSolicitada, horaSolicitada, codReserva)
VALUES(
	5,
	30,
	'05/09/2017',
	'09:00',
	12
);

--TABELA LAVANDERIA_LAVA_PECA
INSERT INTO LAVANDERIA_LAVA_PECA(idServExtraLavanderia, tipoPeca, quantidade, valorLavagem)
VALUES(
	1,
	'Calça',
	3,
	13.5
);

INSERT INTO LAVANDERIA_LAVA_PECA(idServExtraLavanderia, tipoPeca, quantidade, valorLavagem)
VALUES(
	1,
	'Jaqueta Jeans',
	1,
	12
);

INSERT INTO LAVANDERIA_LAVA_PECA(idServExtraLavanderia, tipoPeca, quantidade, valorLavagem)
VALUES(
	2,
	'Camisa',
	2,
	10
);


INSERT INTO LAVANDERIA_LAVA_PECA(idServExtraLavanderia, tipoPeca, quantidade, valorLavagem)
VALUES(
	3,
	'Jaleco',
	1,
	10
);

INSERT INTO LAVANDERIA_LAVA_PECA(idServExtraLavanderia, tipoPeca, quantidade, valorLavagem)
VALUES(
	4,
	'Camisa',
	1,
	10
);

INSERT INTO LAVANDERIA_LAVA_PECA(idServExtraLavanderia, tipoPeca, quantidade, valorLavagem)
VALUES(
	5,
	'Camisa',
	3,
	30
);