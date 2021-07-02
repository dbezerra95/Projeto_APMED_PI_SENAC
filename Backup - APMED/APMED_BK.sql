/* Modelo Físico - APMED_BK */

/*BASE DE DADOS BACKUP DINAMICA*/

/* DDL - Data Definition Language |
Linguagem de Definição de Dados */

/* CREATE / DROP */

/* Criação do Banco de Dados - APMED */
CREATE DATABASE IF NOT EXISTS apmed_bk;

/* Comando para a utilização do banco de dados */
USE apmed_bk;

/* Criação da Tabela: Hospital */
# CREATE TABLE hospital
CREATE TABLE IF NOT EXISTS hospital_bk
(
	id_hosp INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	cnpj_hosp VARCHAR(25) NOT NULL,
	raz_hosp VARCHAR(150) NOT NULL,
	cep_hosp VARCHAR(15) NOT NULL,
	end_hosp VARCHAR(150) NOT NULL,
	tel_hosp VARCHAR(20) NULL,
	email_hosp VARCHAR(100) NULL
);

/* Criação da Tabela: Médico */
# CREATE TABLE medico_bk
CREATE TABLE IF NOT EXISTS medico_bk
(
	id_med INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	crm_med VARCHAR(15) NOT NULL,
	cpf_med VARCHAR(20) NOT NULL,
	nome_med VARCHAR(150) NOT NULL,
	nasc_med DATE NOT NULL,
	nac_med VARCHAR(45) NOT NULL,
	sexo_med ENUM ('M', 'F', 'O') DEFAULT 'M',
	end_med VARCHAR(150) NOT NULL,
	espec_med VARCHAR(45) NOT NULL,
	tel_med VARCHAR(20) NULL,
	email_med VARCHAR(100) NULL,
	setor_id_setor INT NOT NULL,
	setor_hospital_id_hosp INT NOT NULL
);

/* Criação de Tabela: Funcionário */
# CREATE TABLE funcionario_bk
CREATE TABLE IF NOT EXISTS funcionario_bk
(
	id_func INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	corem_func VARCHAR(20) NULL,
	cpf_func VARCHAR(20) NOT NULL,
	nome_func VARCHAR(150) NOT NULL,
	nasc_func DATE NOT NULL,
	nac_func VARCHAR(45) NOT NULL,
	sexo_func ENUM ('M', 'F', 'O') DEFAULT 'M',
	cargo_func VARCHAR(45) NOT NULL,
	end_func VARCHAR(150) NOT NULL,
	tel_func VARCHAR(20) NULL,
	email_func VARCHAR(100) NULL,
	departamento_id_dep INT,
	departamento_hospital_id_hosp INT,
	setor_id_setor INT,
	setor_hospital_id_hosp INT
);

/* Criação de Tabela: Paciente */
# CREATE TABLE paciente_bk
CREATE TABLE IF NOT EXISTS paciente_bk
(
	id_pac INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	cpf_pac VARCHAR(20) NOT NULL,
	nome_pac VARCHAR(150) NOT NULL,
	nasc_pac DATE NOT NULL,
	nac_pac VARCHAR(45) NOT NULL,
	sexo_pac ENUM ('M', 'F', 'O') DEFAULT 'M',
	ocup_pac VARCHAR(45) NOT NULL,
	end_pac VARCHAR(150) NOT NULL,
	tel_pac VARCHAR(20) NULL,
	email_pac VARCHAR(100) NULL,
	setor_id_setor INT NOT NULL,
	setor_hospital_id_hosp INT NOT NULL,
	convenio_id_conv INT NULL
);

/* Criação da Tabela Associativa: Consulta */
# CREATE TABLE consulta_bk
CREATE TABLE IF NOT EXISTS consulta_bk
(
	id_cons INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	paciente_id_pac INT,
	medico_id_med INT,
	documentacao_id_doc INT,
	paciente_setor_id_setor INT,
	paciente_setor_hospital_id_hosp INT
);
