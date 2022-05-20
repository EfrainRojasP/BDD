use ventas;
create table cliente(
   clienteID int not null,
   clienteNom varchar(50),
   clienteDir varchar(150),
   clienteTel varchar(15),
   clienteRFC varchar(20)
)engine = FEDERATED connection = 'mysql://root:root@192.168.1.65:3306/ventas/cliente';

-- engine = FEDERATED connection = 'mysql://[USUARIO]:[CONTRASEÑA]@[IPdelaBD]:3306/[DB]/[TABLA]';

create table catalogo_entidad(
   idCatalogoEntidad int not null auto_increment,
   entidad_federativa varchar(100),
   abreviatura varchar(5), 
   primary key(idCatalogoEntidad)
) engine = FEDERATED connection = 'mysql://bdd22i:22i@204.158.203.104:3306/Covid19/Catalogo_Entidad';


