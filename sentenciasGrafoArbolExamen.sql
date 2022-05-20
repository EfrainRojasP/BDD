use Examen2;
show tables;

select count(*) from paciente p inner join 
analisis a on p.idPaciente = a.paciente_idpaciente
where   a.clasificacionFinal = 3 or a.clasificacionFinal = 2  or a.clasificacionFinal = 1
group by p.sexo;
 -- a.clasificacionFinal = 3 or a.clasificacionFinal = 2  or a.clasificacionFinal = 1
