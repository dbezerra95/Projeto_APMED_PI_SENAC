# Utilização do Banco de Dados APMED
USE apmed;

select * from funcionario;

# Função de verificação do acesso que o funcionário possui para o sistema
DELIMITER $$
CREATE FUNCTION sf_identCredencial(cargo_func VARCHAR(70)) 
RETURNS VARCHAR(25)
DETERMINISTIC
BEGIN
    DECLARE nivelAcesso VARCHAR(25);

    IF cargo_func = 'Enfermeiro' THEN
		SET nivelAcesso = 'Prioridade: Baixa!';
    ELSEIF cargo_func = 'Enfermeira' THEN
        SET nivelAcesso = 'Prioridade: Baixa!';
	ELSE
		SET nivelAcesso = 'Prioridade: Normal!';
    END IF;
	-- return the customer level
	RETURN (nivelAcesso);
END$$
DELIMITER ;

SELECT id_func AS MATRICULA,
		nome_func AS FUNCIONARIO,
		cargo_func AS CARGO,
        sf_identCredencial(cargo_func) AS PRIORIDADE
        FROM funcionario ORDER BY nome_func ASC;

# Função de verificação se o paciente é maior/menor de idade
DELIMITER $$
CREATE FUNCTION sf_maiorIdade(nasc_pac DATE)
RETURNS VARCHAR(25)
DETERMINISTIC
BEGIN
    DECLARE maiorIdade VARCHAR(25);
    DECLARE idade VARCHAR(20);
    
    SELECT YEAR(FROM_DAYS(TO_DAYS(NOW()) - TO_DAYS(nasc_pac))) INTO idade;
    
	IF idade < 18
		THEN
			SET maiorIdade = 'Menor de idade!';
		ELSE
			SET maiorIdade = 'Maior de idade!';
	END IF;
    
	RETURN maiorIdade;
    
END $$
DELIMITER ;

SELECT	nome_pac AS PACIENTE,
		nasc_pac AS NASC_PAC,
        sf_maiorIdade(nasc_pac) AS CLASSIFICACAO
        FROM paciente ORDER BY nome_pac ASC;

# Seleção da idade dos funcionários
SELECT YEAR (FROM_DAYS(TO_DAYS(NOW()) - TO_DAYS(nasc_pac))) AS IDADE FROM paciente;