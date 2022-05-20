create table catalogo_entidad(
   idCatalogoEntidad int not null auto_increment,
   entidad_federativa varchar(100),
   abreviatura varchar(5), 
   primary key(idCatalogoEntidad)
) engine = FEDERATED connection = 'mysql://bdd22i:22i@204.158.203.104:3306/Covid19/Catalogo_Entidad';