CREATE DATABASE db_saude;
USE db_saude;

/* ---------------<TABELAS>-------------- */

CREATE TABLE TIPO_USUARIO(
	idTipoUsuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    tipoUsuario VARCHAR(45)
)
ENGINE INNODB;

CREATE TABLE HOSPITAL(
	idHospital INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nomeHospital VARCHAR(100) NOT NULL,
	ruaHospital VARCHAR(100) NOT NULL,
	bairroHospital VARCHAR(45) NOT NULL,
	cepHospital VARCHAR(9) NOT NULL,
    telefoneHospital VARCHAR(14)
)
ENGINE INNODB;

CREATE TABLE USUARIO(
	idUsuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nomeUsuario VARCHAR(100) NOT NULL,
    senhaUsuario VARCHAR(20),
    idTipoUsuario INT NOT NULL REFERENCES TIPO_USUARIO(idTipoUsuario),
    idHospital INT NOT NULL REFERENCES HOSPITAL(idHospital)
)
ENGINE INNODB;

CREATE TABLE PACIENTE(
	idPaciente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nomePaciente VARCHAR(100) NOT NULL,
    ruaPaciente	VARCHAR(100) NOT NULL,
    numeroSUS INT NOT NULL,
    telefonePaciente VARCHAR(14) NOT NULL,
    bairroPaciente VARCHAR(45) NOT NULL,
    gravidade VARCHAR(45) NOT NULL
)
ENGINE INNODB;

CREATE TABLE TIPO_UNIDADE(
	idTipoUnidade INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    tipoUnidade VARCHAR(3) NOT NULL
)
ENGINE INNODB;

CREATE TABLE ESPECIALIDADE(
	idEspecialidade INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	tipoEspecialidade VARCHAR(45) NOT NULL UNIQUE
)
ENGINE INNODB;

CREATE TABLE MEDICO(
	CRM VARCHAR(13) NOT NULL PRIMARY KEY,
    nomeMedico VARCHAR(45) NOT NULL,
    horarioMedico TIME NOT NULL,
    idEspecialidade INT NOT NULL REFERENCES ESPECIALIDADE(idEspecialidade)
)
ENGINE INNODB;

CREATE TABLE UNIDADE_SAUDE(
	idUnidadeSaude INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nomeUnidadeSaude VARCHAR(45) NOT NULL,
    ruaUnidadeSaude VARCHAR(100) NOT NULL,
    bairroUnidadeSaude VARCHAR(45) NOT NULL,
    telefoneUnidadeSaude VARCHAR(14) NOT NULL,
    idTipoUnidade INT NOT NULL REFERENCES TIPO_UNIDADE(idTipoUnidade)
)
ENGINE INNODB;

CREATE TABLE MEDICO_ATENDE_UNIDADE(
    idUnidadeSaude INT NOT NULL REFERENCES TIPO_UNIDADE(idTipoUnidade),
    CRM VARCHAR(13) NOT NULL REFERENCES MEDICO(CRM),
    CONSTRAINT PRIMARY KEY(idUnidadeSaude, CRM)
);

CREATE TABLE ENCAMINHAMENTO(
	idEncaminhamento INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    dataEncaminhamento DATETIME NOT NULL,
    idUnidadeSaude INT NOT NULL REFERENCES UNIDADE_SAUDE(idUnidadeSaude), 
    idPaciente INT NOT NULL REFERENCES PACIENTE(idPaciente),
    idHospital INT NOT NULL REFERENCES HOSPITAL(idHospital)
)
ENGINE INNODB;

SELECT * FROM MEDICO;