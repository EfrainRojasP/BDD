use Examen2;
show tables;

select count(p.sexo) from paciente p inner join 
analisis a on p.idPaciente = a.paciente_idpaciente
where   a.clasificacionFinal = 3 or a.clasificacionFinal = 2  or a.clasificacionFinal = 1
group by p.sexo;
 -- a.clasificacionFinal = 3 or a.clasificacionFinal = 2  or a.clasificacionFinal = 1
 ######### 3.- daibetes  7.- hipertension 4.- epoc
select count(*)  from paciente p inner join enfermedad_has_paciente ehp 
 on p.idpaciente = ehp.paciente_idpaciente
 where (enfermedad_idenfermedad = 3 or enfermedad_idenfermedad = 7 or enfermedad_idenfermedad = 4) and idCatalogoSINO = 1;
select paciente_idPaciente from enfermedad_has_paciente ehp inner join enfermedad e
 on ehp.enfermedad_idEnfermedad = e.idEnfermedad 
 where (nombre = "daibetes" or nombre = "hipertension" or nombre = "epoc") and idCatalogoSINO = 1;

select idPaciente from paciente p inner join (select paciente_idPaciente from enfermedad_has_paciente ehp inner join enfermedad e
 on ehp.enfermedad_idEnfermedad = e.idEnfermedad 
 where (nombre = "daibetes" or nombre = "hipertension" or nombre = "epoc") and idCatalogoSINO = 1) res1
 on p.idPaciente = res1.paciente_idPaciente;

select count(*) from registropaciente r inner join catalogo_sector cs
 on r.idSector = cs.idCatalogoSector 
 where cs.descripcion = "CRUZ ROJA" and  r.fechaDefuncion != '2022-03-25';
 
 select r.fechaDefuncion, r.idSector from registropaciente r inner join (select idPaciente from paciente p inner join (select paciente_idPaciente from enfermedad_has_paciente ehp inner join enfermedad e
  on ehp.enfermedad_idEnfermedad = e.idEnfermedad 
  where (nombre = "daibetes" or nombre = "hipertension" or nombre = "epoc") and idCatalogoSINO = 1) res1
  on p.idPaciente = res1.paciente_idPaciente) res2 
  on r.paciente_idpaciente = res2.idPaciente;
 
 select count(res3.fechaDefuncion) from catalogo_sector cs inner join ( select r.fechaDefuncion, r.idSector from registropaciente r inner join (select idPaciente from paciente p inner join (select paciente_idPaciente from enfermedad_has_paciente ehp inner join enfermedad e
  on ehp.enfermedad_idEnfermedad = e.idEnfermedad 
  where (nombre = "daibetes" or nombre = "hipertension" or nombre = "epoc") and idCatalogoSINO = 1) res1
  on p.idPaciente = res1.paciente_idPaciente) res2 
  on r.paciente_idpaciente = res2.idPaciente) res3
  on cs.idCatalogoSector = res3.idSector
  where cs.descripcion = "CRUZ ROJA" and  res3.fechaDefuncion != '2022-03-25';
 
select * from catalogo_sector;

############
 
