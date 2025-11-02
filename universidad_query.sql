USE universidad;


#Base de dades Universidad
#1 Devuelve un listado con el primer apellido, segundo apellido y el nombre de todos los alumnos/as. 
#El listado deberá estar ordenado alfabéticamente de menor a mayor por el primer apellido, segundo apellido y nombre.
SELECT nombre,apellido1,apellido2
FROM persona
WHERE tipo = 'alumno'
ORDER BY apellido1,apellido2,nombre;

#2 Halla el nombre y los dos apellidos de los alumnos que no han dado de alta su número de teléfono en la base de datos.
SELECT nombre,apellido1,apellido2
FROM persona
WHERE tipo = 'alumno' AND telefono IS NULL;


#3 Devuelve el listado de los alumnos que nacieron en 1999.
SELECT *
FROM persona
WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;

#4 Devuelve el listado de profesores/as que no han dado de alta su número de teléfono en la base de datos y además su NIF termina en K.
SELECT *
FROM persona
WHERE tipo = 'profesor' AND telefono IS NULL AND UPPER(nif)  LIKE '%K';

#5 Devuelve el listado de las asignaturas que se imparten en el primer cuatrimestre, en el tercer curso del grado que tiene el identificador 7.
SELECT *
FROM asignatura
WHERE cuatrimestre =1 AND curso = 3 AND id_grado = 7;

#6 Devuelve un listado de los profesores/as junto con el nombre del departamento al que están vinculados. 
#El listado debe devolver cuatro columnas, primer apellido, segundo apellido, nombre y nombre del departamento. 
#El resultado estará ordenado alfabéticamente de menor a mayor por apellidos y nombre.
SELECT p.apellido1,p.apellido2,p.nombre,d.nombre AS departamento_nombre
FROM persona AS p
JOIN profesor AS pro ON p.id = pro.id_profesor
JOIN departamento AS d ON pro.id_departamento = d.id
ORDER BY p.apellido1,p.apellido2,p.nombre;

#7 Devuelve un listado con el nombre de las asignaturas, año de inicio y año de fin del curso escolar del alumno/a con NIF 26902806M.
SELECT asi.nombre,cur.anyo_inicio,cur.anyo_fin
FROM asignatura AS asi
JOIN alumno_se_matricula_asignatura AS alu ON asi.id =alu.id_asignatura
JOIN curso_escolar AS cur ON alu.id_curso_escolar = cur.id
JOIN persona AS p ON alu.id_alumno = p.id
WHERE UPPER(nif) = '26902806M';

#8 Devuelve un listado con el nombre de todos los departamentos que tienen profesores/as que imparten alguna asignatura en el Grado en Ingeniería Informática (Plan 2015).
SELECT DISTINCT d.nombre 
FROM departamento AS d
JOIN profesor AS p ON d.id = p.id_departamento
JOIN asignatura AS a ON p.id_profesor = a.id_profesor
JOIN grado AS g ON a.id_grado = g.id
WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

#9 Devuelve un listado con todos los alumnos que se han matriculado en alguna asignatura durante el curso escolar 2018/2019.
SELECT DISTINCT p.id,p.nombre
FROM persona AS p
JOIN alumno_se_matricula_asignatura AS alu ON p.id = alu.id_alumno
JOIN curso_escolar AS c ON alu.id_curso_escolar = c.id
WHERE c.id = 5;

#LEFT JOIN y RIGHT JOIN.
#1 Devuelve un listado con los nombres de todos los profesores/as y los departamentos que tienen vinculados. 
-- El listado también debe mostrar aquellos profesores/as que no tienen ningún departamento asociado. 
-- El listado debe devolver cuatro columnas, nombre del departamento, primer apellido, segundo apellido y nombre del profesor/a. 
-- El resultado estará ordenado alfabéticamente de menor a mayor por el nombre del departamento, apellidos y nombre.
SELECT COALESCE(d.nombre,'Sin departamento') AS departamento_nombre, p.apellido1,p.apellido2,p.nombre
FROM persona AS p 
LEFT JOIN profesor AS pro ON p.id = pro.id_profesor
LEFT JOIN departamento AS d ON pro.id_departamento = d.id
WHERE p.tipo = 'profesor' 
ORDER BY d.nombre,p.apellido1,p.apellido2,p.nombre;

#2 Devuelve un listado con los profesores/as que no están asociados a un departamento.
SELECT d.nombre AS departamento_nombre, p.apellido1,p.apellido2,p.nombre
FROM persona AS p 
LEFT JOIN profesor AS pro ON p.id = pro.id_profesor
LEFT JOIN departamento AS d ON pro.id_departamento = d.id
WHERE p.tipo = 'profesor' AND (pro.id_profesor IS NULL OR d.id IS NULL)
ORDER BY p.apellido1,p.apellido2,p.nombre;

#3 Devuelve un listado con los departamentos que no tienen profesores asociados.
SELECT d.nombre
FROM departamento AS d
LEFT JOIN profesor AS pro ON pro.id_departamento = d.id
WHERE id_profesor IS NULL; 

#4 Devuelve un listado con los profesores/as que no imparten ninguna asignatura.
SELECT p.nombre
FROM persona AS p
LEFT JOIN asignatura AS a ON p.id = a.id_profesor
WHERE p.tipo = 'profesor' AND a.id_profesor IS NULL
ORDER BY p.nombre;

#5 Devuelve un listado con las asignaturas que no tienen un profesor/a asignado.
SELECT *
FROM asignatura 
WHERE id_profesor IS NULL;


#6 Devuelve un listado con todos los departamentos que no han impartido asignaturas en ningún curso escolar.
SELECT DISTINCT d.nombre
FROM departamento AS d
LEFT JOIN profesor AS p ON p.id_departamento = d.id
LEFT JOIN asignatura AS a ON p.id_profesor =  a.id_profesor
WHERE a.id_profesor IS NULL
ORDER BY d.nombre;

#Consultas resumen:
#1 Devuelve el número total de alumnos existentes.
SELECT COUNT(id) AS alumno_number
FROM persona
WHERE tipo = 'alumno';

#2 Calcula cuántos alumnos nacieron en 1999.
SELECT COUNT(id) AS alumno_number
FROM persona
WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;

#3 Calcula cuántos profesores/as hay en cada departamento. 
-- El resultado sólo debe mostrar dos columnas, una con el nombre del departamento y otra con el número de profesores/as que hay en ese departamento.
-- El resultado sólo debe incluir los departamentos que tienen profesores/as asociados y tendrá que estar ordenado de mayor a menor por el número de profesores/as.
SELECT d.nombre,COUNT(a.id)
FROM persona AS a
JOIN profesor AS p ON a.id = p.id_profesor
JOIN departamento AS d ON d.id = p.id_departamento
WHERE tipo = 'profesor' 
GROUP BY d.nombre
ORDER BY COUNT(a.id) DESC;

#4 Devuelve un listado con todos los departamentos y el número de profesores/as que hay en cada uno de ellos. 
-- Tenga en cuenta que pueden existir departamentos que no tienen profesores asociados. Estos departamentos también deben aparecer en el listado.




