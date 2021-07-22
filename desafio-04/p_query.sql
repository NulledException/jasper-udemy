SELECT 
    jaspercurso.empresas.razao_social,
    jaspercurso.empresas.telefone,
    jaspercurso.empresas.cnpj,
    jaspercurso.funcionarios.id_funcionario,
    jaspercurso.funcionarios.nome,
    jaspercurso.cargos.titulo AS cargo_titulo,
    jaspercurso.departamentos.titulo AS departamento_titulo,
    jaspercurso.funcionarios.data_admissao,
    jaspercurso.funcionarios.salario,
    jaspercurso.niveis.bonus,
    jaspercurso.funcionarios.salario * jaspercurso.niveis.bonus AS valor_bonificacao,
    CASE
        WHEN jaspercurso.funcionarios.salario <= 1556.94 THEN (jaspercurso.funcionarios.salario * 0.08)
        WHEN
            jaspercurso.funcionarios.salario >= 1556.95
                AND jaspercurso.funcionarios.salario <= 2594.92
        THEN
            (jaspercurso.funcionarios.salario * 0.09)
        WHEN
            jaspercurso.funcionarios.salario >= 2594.93
                AND jaspercurso.funcionarios.salario <= 5189.82
        THEN
            (jaspercurso.funcionarios.salario * 0.11)
        ELSE 570.88
    END AS valor_inss,
    CASE
        WHEN (jaspercurso.funcionarios.salario - valor_inss) <= 1903.98 THEN 0
        WHEN
            (jaspercurso.funcionarios.salario - valor_inss) >= 1903.99
                AND (jaspercurso.funcionarios.salario - valor_inss) <= 2826.65
        THEN
            (((jaspercurso.funcionarios.salario - valor_inss) * 0.075) - 142.80)
        WHEN
            (jaspercurso.funcionarios.salario - valor_inss) >= 2826.66
                AND (jaspercurso.funcionarios.salario - valor_inss) <= 3751.05
        THEN
            (((jaspercurso.funcionarios.salario - valor_inss) * 0.15) - 354.80)
        WHEN
            (jaspercurso.funcionarios.salario - valor_inss) >= 3751.06
                AND (jaspercurso.funcionarios.salario - valor_inss) <= 4664.68
        THEN
            (((jaspercurso.funcionarios.salario - valor_inss) * 0.225) - 636.13)
        ELSE (((jaspercurso.funcionarios.salario - valor_inss) * 0.275) - 869.36)
    END AS valor_irrf
FROM
    jaspercurso.empresas,
    jaspercurso.funcionarios
        INNER JOIN
    jaspercurso.cargos ON jaspercurso.funcionarios.id_cargo = jaspercurso.cargos.id_cargo
        INNER JOIN
    jaspercurso.departamento_tem_cargos ON jaspercurso.departamento_tem_cargos.id_cargo = jaspercurso.cargos.id_cargo
        INNER JOIN
    jaspercurso.niveis ON jaspercurso.funcionarios.id_nivel = jaspercurso.niveis.id_nivel
        INNER JOIN
    jaspercurso.departamentos ON jaspercurso.departamentos.id_departamento = jaspercurso.departamento_tem_cargos.id_departamento
WHERE
    jaspercurso.funcionarios.salario <> 0