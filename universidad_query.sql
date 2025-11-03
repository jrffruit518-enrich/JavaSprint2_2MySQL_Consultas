USE universidad;

#Base de dades Universidad
#1 Devuelve un listado con el primer apellido, segundo apellido y el nombre de todos los alumnos/as. 
#El listado deberá estar ordenado alfabéticamente de menor a mayor por el primer apellido, segundo apellido y nombre.
SELECT
    nombre,
    apellido1,
    apellido2
FROM
    persona
WHERE
    tipo = 'alumno'
ORDER BY
    apellido1,
    apellido2,
    nombre;

#2 Halla el nombre y los dos apellidos de los alumnos que no han dado de alta su número de teléfono en la base de datos.
SELECT
    nombre,
    apellido1,
    apellido2
FROM
    persona
WHERE
    tipo = 'alumno'
    AND telefono IS NULL;

#3 Devuelve el listado de los alumnos que nacieron en 1999.
SELECT
    *
FROM
    persona
WHERE
    tipo = 'alumno'
    AND YEAR(fecha_nacimiento) = 1999;

#4 Devuelve el listado de profesores/as que no han dado de alta su número de teléfono en la base de datos y además su NIF termina en K.
SELECT
    *
FROM
    persona
WHERE
    tipo = 'profesor'
    AND telefono IS NULL
    AND UPPER(nif) LIKE '%K';

#5 Devuelve el listado de las asignaturas que se imparten en el primer cuatrimestre, en el tercer curso del grado que tiene el identificador 7.
SELECT
    *
FROM
    asignatura
WHERE
    cuatrimestre = 1
    AND curso = 3
    AND id_grado = 7;

#6 Devuelve un listado de los profesores/as junto con el nombre del departamento al que están vinculados. 
#El listado debe devolver cuatro columnas, primer apellido, segundo apellido, nombre y nombre del departamento. 
#El resultado estará ordenado alfabéticamente de menor a mayor por apellidos y nombre.
SELECT
    p.apellido1,
    p.apellido2,
    p.nombre,
    d.nombre AS departamento_nombre
FROM
    persona AS p
    JOIN profesor AS pro ON p.id = pro.id_profesor
    JOIN departamento AS d ON pro.id_departamento = d.id
ORDER BY
    p.apellido1,
    p.apellido2,
    p.nombre;

#7 Devuelve un listado con el nombre de las asignaturas, año de inicio y año de fin del curso escolar del alumno/a con NIF 26902806M.
SELECT
    asi.nombre,
    cur.anyo_inicio,
    cur.anyo_fin
FROM
    asignatura AS asi
    JOIN alumno_se_matricula_asignatura AS alu ON asi.id = alu.id_asignatura
    JOIN curso_escolar AS cur ON alu.id_curso_escolar = cur.id
    JOIN persona AS p ON alu.id_alumno = p.id
WHERE
    UPPER(nif) = '26902806M';

#8 Devuelve un listado con el nombre de todos los departamentos que tienen profesores/as que imparten alguna asignatura en el Grado en Ingeniería Informática (Plan 2015).
SELECT
    DISTINCT d.nombre
FROM
    departamento AS d
    JOIN profesor AS p ON d.id = p.id_departamento
    JOIN asignatura AS a ON p.id_profesor = a.id_profesor
    JOIN grado AS g ON a.id_grado = g.id
WHERE
    g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

#9 Devuelve un listado con todos los alumnos que se han matriculado en alguna asignatura durante el curso escolar 2018/2019.
SELECT
    DISTINCT p.id,
    p.nombre
FROM
    persona AS p
    JOIN alumno_se_matricula_asignatura AS alu ON p.id = alu.id_alumno
    JOIN curso_escolar AS c ON alu.id_curso_escolar = c.id
WHERE
    c.id = 5;

#LEFT JOIN y RIGHT JOIN.
#1 Devuelve un listado con los nombres de todos los profesores/as y los departamentos que tienen vinculados. 
-- El listado también debe mostrar aquellos profesores/as que no tienen ningún departamento asociado. 
-- El listado debe devolver cuatro columnas, nombre del departamento, primer apellido, segundo apellido y nombre del profesor/a. 
-- El resultado estará ordenado alfabéticamente de menor a mayor por el nombre del departamento, apellidos y nombre.
SELECT
    COALESCE(d.nombre, 'Sin departamento') AS departamento_nombre,
    p.apellido1,
    p.apellido2,
    p.nombre
FROM
    persona AS p
    LEFT JOIN profesor AS pro ON p.id = pro.id_profesor
    LEFT JOIN departamento AS d ON pro.id_departamento = d.id
WHERE
    p.tipo = 'profesor'
ORDER BY
    d.nombre,
    p.apellido1,
    p.apellido2,
    p.nombre;

#2 Devuelve un listado con los profesores/as que no están asociados a un departamento.
SELECT
    d.nombre AS departamento_nombre,
    p.apellido1,
    p.apellido2,
    p.nombre
FROM
    persona AS p
    LEFT JOIN profesor AS pro ON p.id = pro.id_profesor
    LEFT JOIN departamento AS d ON pro.id_departamento = d.id
WHERE
    p.tipo = 'profesor'
    AND (
        pro.id_profesor IS NULL
        OR d.id IS NULL
    )
ORDER BY
    p.apellido1,
    p.apellido2,
    p.nombre;

#3 Devuelve un listado con los departamentos que no tienen profesores asociados.
SELECT
    d.nombre
FROM
    departamento AS d
    LEFT JOIN profesor AS pro ON pro.id_departamento = d.id
WHERE
    id_profesor IS NULL;

#4 Devuelve un listado con los profesores/as que no imparten ninguna asignatura.
SELECT
    p.nombre
FROM
    persona AS p
    LEFT JOIN asignatura AS a ON p.id = a.id_profesor
WHERE
    p.tipo = 'profesor'
    AND a.id_profesor IS NULL
ORDER BY
    p.nombre;

#5 Devuelve un listado con las asignaturas que no tienen un profesor/a asignado.
SELECT
    *
FROM
    asignatura
WHERE
    id_profesor IS NULL;

#6 Devuelve un listado con todos los departamentos que no han impartido asignaturas en ningún curso escolar.
SELECT
    DISTINCT d.nombre
FROM
    departamento AS d
    LEFT JOIN profesor AS p ON p.id_departamento = d.id
    LEFT JOIN asignatura AS a ON p.id_profesor = a.id_profesor
WHERE
    a.id_profesor IS NULL
ORDER BY
    d.nombre;

#Consultas resumen:
#1 Devuelve el número total de alumnos existentes.
SELECT
    COUNT(id) AS alumno_number
FROM
    persona
WHERE
    tipo = 'alumno';

#2 Calcula cuántos alumnos nacieron en 1999.
SELECT
    COUNT(id) AS alumno_number
FROM
    persona
WHERE
    tipo = 'alumno'
    AND YEAR(fecha_nacimiento) = 1999;

#3 Calcula cuántos profesores/as hay en cada departamento. 
-- El resultado sólo debe mostrar dos columnas, una con el nombre del departamento y otra con el número de profesores/as que hay en ese departamento.
-- El resultado sólo debe incluir los departamentos que tienen profesores/as asociados y tendrá que estar ordenado de mayor a menor por el número de profesores/as.
SELECT
    d.nombre,
    COUNT(a.id)
FROM
    persona AS p
    JOIN profesor AS pro ON a.id = pro.id_profesor
    JOIN departamento AS d ON d.id = pro.id_departamento
WHERE
    tipo = 'profesor'
GROUP BY
    d.nombre
ORDER BY
    COUNT(a.id) DESC;

#4 Devuelve un listado con todos los departamentos y el número de profesores/as que hay en cada uno de ellos. 
-- Tenga en cuenta que pueden existir departamentos que no tienen profesores asociados. Estos departamentos también deben aparecer en el listado.
SELECT
    d.nombre,
    COUNT(p.id_profesor) AS profesor_number
FROM
    departamento AS d
    LEFT JOIN profesor AS p ON d.id = p.id_departamento
GROUP BY
    d.id
ORDER BY
    profesor_number DESC;

#5 Devuelve un listado con el nombre de todos los grados existentes en la base de datos y 
-- el número de asignaturas que tiene cada uno. Ten en cuenta que pueden existir grados que carecen de asignaturas asociadas. 
-- Estos grados también deben aparecer en el listado. El resultado deberá estar ordenado de mayor a menor por el número de asignaturas.
SELECT
    g.nombre,
    COUNT(a.id) AS asignatura_number
FROM
    grado AS g
    LEFT JOIN asignatura AS a ON g.id = a.id_grado
GROUP BY
    g.id,
    g.nombre
ORDER BY
    COUNT(a.id) DESC;

#6 Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno, 
-- de los grados que tengan más de 40 asignaturas asociadas.
SELECT
    g.nombre,
    COUNT(a.id) AS asignatura_number
FROM
    grado AS g
    LEFT JOIN asignatura AS a ON g.id = a.id_grado
GROUP BY
    g.id,
    g.nombre
HAVING
    COUNT(a.id) > 40
ORDER BY
    COUNT(a.id) DESC;

#7 Devuelve un listado que muestre el nombre de los grados y la suma del número total de créditos existentes para cada tipo de asignatura. 
-- El resultado debe tener tres columnas: nombre del grado, tipo de asignatura y la suma de los créditos de todas las asignaturas que existen de este tipo.
SELECT
    g.nombre,
    a.tipo AS asignatura_tipo,
    SUM(a.creditos) AS credit_sum
FROM
    grado AS g
    LEFT JOIN asignatura AS a ON g.id = a.id_grado
GROUP BY
    g.id,
    g.nombre,
    a.tipo;
    
 #8 Devuelve un listado que muestre cuántos alumnos se han matriculado de alguna asignatura en cada uno de los cursos escolares. 
 -- El resultado tendrá que mostrar dos columnas, una columna con el año de inicio del curso escolar y otra con el número de alumnos matriculados.
SELECT
    c.anyo_inicio,
    COUNT(DISTINCT a.id_alumno) AS num_alumnos
FROM
    curso_escolar AS c
    LEFT JOIN alumno_se_matricula_asignatura AS a ON c.id = a.id_curso_escolar
GROUP BY
    c.id,
    c.anyo_inicio
ORDER BY
    c.anyo_inicio;

#9 Devuelve un listado con el número de asignaturas que imparte cada profesor/a. 
-- El listado debe tener en cuenta a aquellos profesores/as que no imparten ninguna asignatura.
-- El resultado mostrará cinco columnas: id, nombre, primer apellido, segundo apellido y número de asignaturas.
-- El resultado estará ordenado de mayor a menor por el número de asignaturas.
SELECT
    p.id,
    p.nombre,
    p.apellido1,
    p.apellido2,
    COUNT(a.id) AS asignaturas_numero
FROM
    persona AS p
    LEFT JOIN profesor AS pro ON p.id = pro.id_profesor
    LEFT JOIN asignatura AS a ON pro.id_profesor = a.id_profesor
GROUP BY
    p.id,
    p.nombre,
    p.apellido1,
    p.apellido2
ORDER BY
    COUNT(a.id) DESC;

#10 Devuelve todos los datos del alumno/a más joven.
SELECT
    *
FROM
    persona
WHERE
    tipo = 'alumno'
ORDER BY
    fecha_nacimiento DESC
LIMIT
    1;

#11 Devuelve un listado con los profesores/as que tienen un departamento asociado y que no imparten ninguna asignatura.
SELECT
    p.nombre,
    p.apellido1,
    p.apellido2,
    d.nombre AS departamento_nombre
FROM
    profesor AS pro
    JOIN persona AS p ON p.id = pro.id_profesor
    JOIN departamento AS d ON d.id = pro.id_departamento
    LEFT JOIN asignatura AS a ON a.id_profesor = pro.id_profesor
WHERE
    a.id IS NULL
ORDER BY
    p.nombre;