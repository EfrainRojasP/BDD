#EXAMEN FINAL

use examen2_fv1_paciente;

delimiter //
create procedure insertarRegistro (idOrg int, idSector int, idEntUM int, sexo int, entNac int, entRes int, munRes int, 
								   idTipoPac int, fchIngreso date, fchSinto date, fchDef date, intubado int, neumonia int,
                                   edad int, nac int, embarazo int, hblIndg int, indg int, diabetes int, epoc int, asma int,
                                   inmunosupr int, hipertension int, otras_com int, cardiovascular int, obesidad int, 
                                   renal_cronica int, tabaquismo int, otroCaso int, tMLab int, resLab int, tMAnt int, 
                                   resAnt int, clasFinal int, migrante int, paisNac varchar(50), paisOrg int, UCI int)
begin 
   # Sirve para almecenar el id del ultimo paciente que se inserto
   declare ultimoPaciente int;
   
   #Codigo para las exepciones
   declare continue handler for sqlexception, sqlwarning
      begin
          SHOW ERRORS limit 1;
      rollback;
      end;
      
      #Empezamos la transaccion
      start transaction;
		 SET autocommit=0;
         insert into examen2_fv1_paciente.paciente values (null, edad, sexo, entNac, entRes, munRes, nac, hblIndg, indg, migrante, 
                                                        (select idPais from examen2_fv1_paciente.catalogo_pais where nombre = paisNac), paisOrg);
         #id del ultimo paciente que se ingreso
         set ultimoPaciente = (select max(idpaciente) from examen2_fv1_paciente.paciente);
        #Desactivamos temporalmente las llaves foraneas
        -- set for the current session:
		 SET FOREIGN_KEY_CHECKS=0;
		-- set globally:
        SET GLOBAL FOREIGN_KEY_CHECKS=0;
         insert into examen2_fv1_paciente.enfermedad_has_paciente values (null, 1, ultimoPaciente, neumonia);
         insert into examen2_fv1_paciente.enfermedad_has_paciente values (null, 2, ultimoPaciente, embarazo);
         insert into examen2_fv1_paciente.enfermedad_has_paciente values (null, 3, ultimoPaciente, diabetes);
         insert into examen2_fv1_paciente.enfermedad_has_paciente values (null, 4, ultimoPaciente, epoc);
         insert into examen2_fv1_paciente.enfermedad_has_paciente values (null, 5, ultimoPaciente, asma);
         insert into examen2_fv1_paciente.enfermedad_has_paciente values (null, 6, ultimoPaciente, inmunosupr);
         insert into examen2_fv1_paciente.enfermedad_has_paciente values (null, 7, ultimoPaciente, hipertension);
         insert into examen2_fv1_paciente.enfermedad_has_paciente values (null, 8, ultimoPaciente, otras_com);
         insert into examen2_fv1_paciente.enfermedad_has_paciente values (null, 9, ultimoPaciente, cardiovascular);
         insert into examen2_fv1_paciente.enfermedad_has_paciente values (null, 10, ultimoPaciente, obesidad);
         insert into examen2_fv1_paciente.enfermedad_has_paciente values (null, 11, ultimoPaciente, renal_cronica);
         insert into examen2_fv1_paciente.enfermedad_has_paciente values (null, 12, ultimoPaciente, tabaquismo);
		 insert into examen2_fv1_registropaciente.registropaciente 
		     values (ultimoPaciente, idOrg, idSector, idEntUM, idTipoPac, fchIngreso, fchSinto, fchDef, otroCaso);
		 insert into examen2_fv1_analisis.analisis values (ultimoPaciente, intubado, tMLab, resLab, tMAnt, resAnt, clasFinal, UCI); 
         #Activamos las llaves foraneas
        -- set for the current session:
		 SET FOREIGN_KEY_CHECKS=1;
		-- set globally:
        SET GLOBAL FOREIGN_KEY_CHECKS=1;
	commit;
   end
//   
delimiter ;

call insertarRegistro(1, 12, 9, 2, 9, 9, 12, 
					  1, '2020-10-16', '2020-10-16', '9999-12-31', 97, 2,
                      41, 1, 97, 99, 99, 2, 2, 2,
                      2, 2, 2, 2, 2, 
                      2, 2, 2, 2, 97, 2, 
                      97, 1, 99, 'Mexico', 97, 97);

select * from examen2_fv1_paciente.paciente;
select * from examen2_fv1_registropaciente.registropaciente;
select * from examen2_fv1_analisis.analisis;
select * from examen2_fv1_paciente.enfermedad_has_paciente;

drop procedure insertarRegistro;

