USE universidad;
-- 1 Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom
SELECT persona.apellido1, persona.apellido2, persona.nombre FROM persona WHERE persona.tipo = "alumno" ORDER BY apellido1,apellido2,nombre;
-- 2 Esbrina el nom i els dos cognoms dels/les alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT persona.nombre, persona.apellido1, persona.apellido2 FROM persona WHERE persona.telefono IS NULL AND persona.tipo = "alumno";
-- 3 Retorna el llistat dels/les alumnes que van néixer en 1999.
SELECT persona.nombre, persona.apellido1, persona.apellido2, persona.fecha_nacimiento FROM persona WHERE persona.fecha_nacimiento BETWEEN '1999-01-01' AND '1999-12-31'AND persona.tipo = "alumno"; 
-- 4 Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.
SELECT persona.nombre, persona.apellido1, persona.apellido2, persona.nif FROM persona WHERE persona.telefono IS NULL AND persona.tipo = "profesor" AND persona.nif LIKE '%K';
-- 5 Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
SELECT nombre FROM asignatura WHERE curso = 3 AND cuatrimestre = 1 AND id_grado = 7; 
-- 6 Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats/des. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
SELECT persona.apellido1, persona.apellido2, persona.nombre, profesor.id_departamento, departamento.nombre, profesor.id_profesor FROM persona JOIN profesor ON persona.id = profesor.id_profesor JOIN departamento ON profesor.id_departamento = departamento.id WHERE persona.tipo='profesor' ORDER BY persona.apellido1,persona.apellido2,persona.nombre;
-- 7 Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
SELECT DISTINCT asignatura.nombre,asignatura.id AS clase, curso_escolar.anyo_inicio,curso_escolar.anyo_fin, persona.id FROM alumno_se_matricula_asignatura AS m JOIN persona ON m.id_alumno = persona.id JOIN asignatura ON m.id_asignatura = asignatura.id JOIN curso_escolar ON m.id_curso_escolar = curso_escolar.id WHERE persona.nif ='26902806M';
-- 8 Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT departamento.nombre FROM grado JOIN asignatura ON grado.id = asignatura.id_grado JOIN profesor ON asignatura.id_profesor = profesor.id_profesor JOIN departamento ON departamento.id = profesor.id_departamento WHERE p ;
-- SELECT departamento.nombre FROM departamento JOIN profesor ON departamento.id = profesor.id_departamento WHERE departamento.nombre= (SELECT departamento.nombre FROM grado JOIN asignatura ON grado.id = asignatura.id_grado WHERE grado.nombre= 'ingenieria informatica');
-- 9 Retorna un llistat amb tots els/les alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
SELECT DISTINCT persona.nombre, curso_escolar.anyo_inicio FROM alumno_se_matricula_asignatura AS matricula JOIN persona ON matricula.id_alumno = persona.id JOIN curso_escolar ON matricula.id_curso_escolar = curso_escolar.id WHERE persona.tipo='alumno' AND curso_escolar.anyo_inicio=2018;

-- SEGUNDA PARTE
-- 1 Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats/des. El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
SELECT departamento.nombre AS departamento, persona.apellido1,persona.apellido2,persona.nombre FROM profesor RIGHT JOIN persona ON profesor.id_profesor = persona.id RIGHT JOIN departamento ON profesor.id_departamento= departamento.id;
-- 2 Retorna un llistat amb els professors/es que no estan associats a un departament.
SELECT DISTINCT persona.apellido1,persona.apellido2,persona.nombre, profesor.id_departamento FROM profesor RIGHT JOIN persona ON profesor.id_profesor = persona.id WHERE profesor.id_departamento IS NULL;
-- 3 Retorna un llistat amb els departaments que no tenen professors/es associats.
SELECT departamento.nombre AS departamento, persona.apellido1,persona.apellido2,persona.nombre FROM profesor RIGHT JOIN persona ON profesor.id_profesor = persona.id RIGHT JOIN departamento ON profesor.id_departamento= departamento.id WHERE profesor.id_departamento IS NULL;
-- 4 Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
SELECT persona.nombre, persona.apellido1, persona.id FROM persona LEFT JOIN asignatura ON persona.id= asignatura.id_profesor WHERE asignatura.id_profesor IS NULL AND persona.tipo='profesor';
-- 5 Retorna un llistat amb les assignatures que no tenen un professor/a assignat.
SELECT asignatura.nombre, asignatura.id_profesor FROM asignatura LEFT JOIN profesor ON asignatura.id_profesor = profesor.id_profesor WHERE asignatura.id_profesor IS NULL;
-- 6 Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
SELECT DISTINCT departamento.nombre,asignatura.curso FROM curso_escolar RIGHT JOIN alumno_se_matricula_asignatura as matricula ON curso_escolar.id = matricula.id_curso_escolar RIGHT JOIN asignatura ON matricula.id_asignatura = asignatura.id RIGHT JOIN profesor ON asignatura.id_profesor =profesor.id_profesor RIGHT JOIN departamento ON profesor.id_departamento= departamento.id WHERE asignatura.id IS NULL; 

-- consultes resumen 
-- 1 Retorna el nombre total d'alumnes que hi ha.
SELECT COUNT(*) FROM persona WHERE tipo='alumno';
-- 2 Calcula quants/es alumnes van néixer en 1999.
SELECT COUNT(*) AS 'nacidos en 1999' FROM persona WHERE fecha_nacimiento BETWEEN '1999-01-01' AND '1999-12-31' AND tipo='alumno';
-- 3 Calcula quants/es professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.
SELECT departamento.nombre, COUNT(persona.nombre) FROM persona JOIN profesor ON persona.id= profesor.id_profesor JOIN departamento ON profesor.id_departamento=departamento.id WHERE persona.tipo='profesor' GROUP BY departamento.nombre;
-- 4 Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. Té en compte que poden existir departaments que no tenen professors/es associats/des. Aquests departaments també han d'aparèixer en el llistat.
SELECT departamento.nombre, COUNT(persona.nombre) FROM persona RIGHT JOIN profesor ON persona.id= profesor.id_profesor RIGHT JOIN departamento ON profesor.id_departamento=departamento.id GROUP BY departamento.nombre;
-- 5 Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Té en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
SELECT grado.nombre, COUNT(asignatura.id_grado) FROM grado LEFT JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre ;
-- 6 Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.
SELECT grado.nombre, COUNT(asignatura.id_grado) AS total_asignaturas FROM grado LEFT JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre HAVING total_asignaturas>=40;
-- 7 Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.
SELECT grado.nombre, asignatura.tipo, SUM(asignatura.creditos) AS 'suma creditos' FROM asignatura JOIN grado ON asignatura.id_grado = grado.id GROUP BY grado.nombre,asignatura.tipo;
-- 8 Retorna un llistat que mostri quants/es alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats/des.
SELECT curso_escolar.anyo_inicio, COUNT(alumno_se_matricula_asignatura.id_alumno) FROM alumno_se_matricula_asignatura as matricula JOIN curso_escolar ON matricula.id_curso_escolar = curso_escolar.id GROUP BY curso_escolar.anyo_inicio;
-- 9 Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.
SELECT persona.id, persona.nombre, persona.apellido1, persona.apellido2, COUNT(asignatura.id_profesor) AS 'cantidad alumnos' FROM persona LEFT JOIN asignatura ON persona.id= asignatura.id_profesor WHERE persona.tipo='profesor' GROUP BY persona.id, persona.nombre, persona.apellido1, persona.apellido2;
-- 10 Retorna totes les dades de l'alumne més jove.
SELECT * FROM persona WHERE fecha_nacimiento= (SELECT MAX(persona.fecha_nacimiento) FROM persona);
-- 11 Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.
SELECT persona.nombre, persona.apellido1,persona.apellido2 FROM persona JOIN profesor ON persona.id = profesor.id_profesor LEFT JOIN asignatura ON asignatura.id_profesor = profesor.id_profesor WHERE asignatura.id_profesor IS NULL;


