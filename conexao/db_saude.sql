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
    telefoneHospital VARCHAR(14),
	idUsuario INT NOT NULL REFERENCES USUARIO(idUsuario)
)
ENGINE INNODB;

CREATE TABLE USUARIO(
	idUsuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nomeUsuario VARCHAR(100) NOT NULL UNIQUE,
    senhaUsuario VARCHAR(255),
    idTipoUsuario INT NOT NULL REFERENCES TIPO_USUARIO(idTipoUsuario)
)
ENGINE INNODB;

CREATE TABLE PACIENTE(
	idPaciente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nomePaciente VARCHAR(100) NOT NULL,
    ruaPaciente	VARCHAR(100) NOT NULL,
    numeroSUS VARCHAR(15) NOT NULL,
    telefonePaciente VARCHAR(14) NOT NULL,
    bairroPaciente VARCHAR(45) NOT NULL,
    gravidade VARCHAR(45) NOT NULL
)
ENGINE INNODB;

CREATE TABLE TIPO_UNIDADE(
	idTipoUnidade INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    tipoUnidade VARCHAR(50) NOT NULL
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
	horarioMedico DATETIME NOT NULL,
    idUnidadeSaude INT NOT NULL REFERENCES TIPO_UNIDADE(idTipoUnidade),
    CRM VARCHAR(13) NOT NULL REFERENCES MEDICO(CRM),
    CONSTRAINT PRIMARY KEY(idUnidadeSaude, CRM)
);

CREATE TABLE ENCAMINHAMENTO(
	idEncaminhamento INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    dataEncaminhamento DATETIME NOT NULL,
    idUnidadeSaude INT NOT NULL REFERENCES UNIDADE_SAUDE(idUnidadeSaude), 
    idPaciente INT NOT NULL REFERENCES PACIENTE(idPaciente),
    idHospital INT NOT NULL REFERENCES HOSPITAL(idHospital),
    idUsuario INT NOT NULL REFERENCES USUARIO(idUsuario)
)
ENGINE INNODB;

SELECT * FROM MEDICO_ATENDE_UNIDADE;
SELECT * FROM USUARIO;
SELECT * FROM UNIDADE_SAUDE;
SELECT `UNIDADE_SAUDE`.`nomeUnidadeSaude`, `UNIDADE_SAUDE`.`ruaUnidadeSaude`, `UNIDADE_SAUDE`.`bairroUnidadeSaude`, 
			`TIPO_UNIDADE`.`tipoUnidade`, `MEDICO`.`nomeMedico`, `ESPECIALIDADE`.`tipoEspecialidade`, 
            DATE_FORMAT(`MEDICO_ATENDE_UNIDADE`.`horarioMedico`, "%d/%m/%Y") AS horario
            FROM UNIDADE_SAUDE 
            INNER JOIN TIPO_UNIDADE ON (`UNIDADE_SAUDE`.`idTipoUnidade` = `TIPO_UNIDADE`.`idTipoUnidade`)
            INNER JOIN MEDICO_ATENDE_UNIDADE ON (`MEDICO_ATENDE_UNIDADE`.`idUnidadeSaude` = `UNIDADE_SAUDE`.`idUnidadeSaude`)
            INNER JOIN MEDICO ON (`MEDICO`.`CRM` = `MEDICO_ATENDE_UNIDADE`.`CRM`) 
            INNER JOIN ESPECIALIDADE ON (`MEDICO`.`idEspecialidade` = `ESPECIALIDADE`.`idEspecialidade`) 
            WHERE 1 = 1;
            
SELECT `ENCAMINHAMENTO`.`idEncaminhamento`, `PACIENTE`.`nomePaciente`, `UNIDADE_SAUDE`.`nomeUnidadeSaude`, 
			`UNIDADE_SAUDE`.`ruaUnidadeSaude`, `UNIDADE_SAUDE`.`bairroUnidadeSaude`, `MEDICO`.`nomeMedico`,
            DATE_FORMAT(`MEDICO_ATENDE_UNIDADE`.`horarioMedico`, "%d/%m/%Y") AS horario,
            `HOSPITAL`.`nomeHospital`, `USUARIO`.`nomeUsuario`
            FROM ENCAMINHAMENTO
            INNER JOIN UNIDADE_SAUDE ON (`ENCAMINHAMENTO`.`idUnidadeSaude` = `UNIDADE_SAUDE`.`idUnidadeSaude`)
            INNER JOIN PACIENTE ON (`ENCAMINHAMENTO`.`idPaciente` = `PACIENTE`.`idPaciente`)
            INNER JOIN MEDICO_ATENDE_UNIDADE ON (`ENCAMINHAMENTO`.`idUnidadeSaude` = `UNIDADE_SAUDE`.`idUnidadeSaude`)
            INNER JOIN MEDICO ON (`MEDICO`.`CRM` = `MEDICO_ATENDE_UNIDADE`.`CRM`) 
            INNER JOIN HOSPITAL ON (`ENCAMINHAMENTO`.`idHospital` = `HOSPITAL`.`idHospital`) 
            INNER JOIN USUARIO ON (`ENCAMINHAMENTO`.`idUsuario` = `USUARIO`.`idUsuario`)
            WHERE 1 = 1;
            
SELECT `ESPECIALIDADE`.`tipoEspecialidade`
            FROM UNIDADE_SAUDE 
            INNER JOIN TIPO_UNIDADE ON (`UNIDADE_SAUDE`.`idTipoUnidade` = `TIPO_UNIDADE`.`idTipoUnidade`)
            INNER JOIN MEDICO_ATENDE_UNIDADE ON (`MEDICO_ATENDE_UNIDADE`.`idUnidadeSaude` = `UNIDADE_SAUDE`.`idUnidadeSaude`)
            INNER JOIN MEDICO ON (`MEDICO`.`CRM` = `MEDICO_ATENDE_UNIDADE`.`CRM`) 
            INNER JOIN ESPECIALIDADE ON (`MEDICO`.`idEspecialidade` = `ESPECIALIDADE`.`idEspecialidade`) 
            WHERE 1 = 1;
            
SELECT * FROM UNIDADE_SAUDE WHERE ruaUnidadeSaude = 'Guadalupe' AND bairroUnidadeSaude = 'Junqueira 2';

SELECT * FROM PACIENTE WHERE gravidade = 'Pouco Urgente' OR 'Não Urgente';