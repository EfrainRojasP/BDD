###
#FUENTES:
# https://josejuansanchez.org/bd/unidad-12-teoria/index.html#c%C3%B3mo-realizar-transacciones-con-procedimientos-almacenados

use examen2_fv1_paciente;

#obtener el id del ultimo registro
select max(idpaciente) from examen2_fv1_paciente.paciente;


delimiter //
create procedure insertarRegistro (edad int, sexo int, entNac int, entRes int, munRes int, nac int, hblIndg int, indg int, migrante int, paisNac int, paisOrg int, -- Paciente
                                   idOrg int, idSector int, idEntUM int, idTipoPac int, fchIngreso date, fchSinto date, fchDef date, otroCaso int, -- RegistroPaciente
                                   intubado int, tMLab int, resLab int, tMAnt int, resAnt int, clasFinal int, UCI int) -- Analisis
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
         insert into examen2_fv1_paciente.paciente values (null, edad, sexo, entNac, entRes, munRes, nac, hblIndg, indg, migrante, paisNac, paisOrg);
         #id del ultimo paciente que se ingreso
         set ultimoPaciente = (select max(idpaciente) from examen2_fv1_paciente.paciente);
        #Desactivamos temporalmente las llaves foraneas
        -- set for the current session:
		 SET FOREIGN_KEY_CHECKS=0;
		-- set globally:
        SET GLOBAL FOREIGN_KEY_CHECKS=0;
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

delimiter //  
create procedure insertarEnferHasPac (enf_idEnf int, idCatSN int)
   begin
      # Sirve para almecenar el id del ultimo paciente que se inserto
      declare ultimoPaciente int;
      declare continue handler for sqlexception, sqlwarning
         begin
            SHOW ERRORS limit 1;
		 rollback;
         end;
      
      start transaction;
         set autocommit = 0;
         set ultimoPaciente = (select max(idpaciente) from examen2_fv1_paciente.paciente);
         insert into examen2_fv1_paciente.enfermedad_has_paciente values (null, enf_idEnf, ultimoPaciente, idCatSN);
      commit;
   end;
//
delimiter ;

call insertarRegistro(41, 2, 9, 9, 12, 1, 99, 99, 99, 5, 5,
                       1, 12, 9, 1, '2020-10-16', '2020-10-16', '2020-12-31', 2,
                       97, 2, 97, 2, 97, 1, 97);
                       
call insertarEnferHasPac (1, 2);
call insertarEnferHasPac (2, 97);
call insertarEnferHasPac (3, 2);
call insertarEnferHasPac (4, 2);
call insertarEnferHasPac (5, 2);
call insertarEnferHasPac (6, 2);
call insertarEnferHasPac (7, 2);
call insertarEnferHasPac (8, 2);
call insertarEnferHasPac (9, 2);
call insertarEnferHasPac (10, 2);
call insertarEnferHasPac (11, 2);
call insertarEnferHasPac (12, 2);

select * from examen2_fv1_paciente.paciente;
select * from examen2_fv1_registropaciente.registropaciente;
select * from examen2_fv1_analisis.analisis;
select * from examen2_fv1_paciente.enfermedad_has_paciente where paciente_idpaciente = 1001;

drop procedure insertarRegistro;
drop procedure  insertarEnferHasPac;

