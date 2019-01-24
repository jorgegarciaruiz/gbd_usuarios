create table usuarios(
  id_u number(20) constraint id_u_usuarios_pk primary key ,
  usuario varchar2(30) constraint usuario_usuarios_uk1 unique constraint usuario_usuarios_nn1 not null ,
  email varchar2(60) constraint email_usuarios_uk2 unique constraint email_usuarios_nn2 not null ,
  nombre varchar2(30) constraint nombre_usuarios_nn3 not null ,
  apellido1 varchar2(30) constraint apellido1_usuarios_nn4 not null ,
  apellido2 varchar2(30) ,
  passw varchar2(100)
);

create table post(
  pid number(20) constraint pid_post_pk primary key ,
  id_u number(20) constraint id_u_post_nn1 not null constraint id_u_post_fk1 references usuarios,
  texto varchar2(1000) constraint texto_post_nn2 not null ,
  pid_rel number(20) constraint pid_rel_post_fk2 references post,
  publicacion date constraint publicacion_post_nn3 not null ,
  duracion interval day to second constraint duracion_post_nn4 not null
);

create table contactos(
  id_u number(20) constraint id_u_contactos_fk1 references usuarios,
  contacto number(20) constraint contacto_contactos_fk2 references usuarios,
  constraint contacto_pk primary key(id_u,contacto)
);


create table ser_visible (
  id_u number(20),
  contacto number(20),
  pid number(20) constraint pid_ser_visible_fk2 references post,
  constraint ser_visible_pk primary key(id_u,contacto),
  constraint ser_visible_fk1 foreign key(id_u,contacto) references contactos
);

alter table post add constraint publicaciones_post_ck check ( publicacion>to_date('2/2/2017','DD/MM/YYYY'));


ALTER TABLE contactos ADD CONSTRAINT id_u_contacto_contactos_ck check ( id_u != contacto );

alter table post add constraint publicaion_post_ck check ( duracion> interval '30' minute);

alter table ser_visible rename to compartir;

alter table usuarios modify(
  id_u number(20) constraint superclave
  );

INSERT INTO USUARIOS (ID_U, USUARIO, E_MAIL, NOMBRE, APELLIDO1, APELLIDO2, PASSW)
VALUES (1, 'RAMONGAR','RAMON@HOTMAIL.COM', 'RAMON', 'GARCIA', 'ORTIGAL', '1234' );


INSERT INTO USUARIOS (ID_U, USUARIO, E_MAIL, NOMBRE, APELLIDO1, PASSW)
VALUES (2, 'LURDITA','LURDITA@BBC.CO.UK', 'LOURDES', 'ATIENZA', '1234' );


INSERT INTO USUARIOS (ID_U, USUARIO, E_MAIL, NOMBRE, APELLIDO1, APELLIDO2, PASSW)
VALUES (4, 'SERCAL','SERCAL1980@GMAIL.COM', 'FRANCISCO', 'SERRANO', 'CALVO', '1234' );


INSERT INTO USUARIOS (ID_U, USUARIO, E_MAIL, NOMBRE, APELLIDO1, APELLIDO2, PASSW)
VALUES (3, 'MARIOSO','MARIOSOL9@YAHOO.COM', 'MARISOL', 'JIMENEZ', 'DEL OSO', '1234' );



INSERT INTO POST(ID_U, PID, TEXTO, DURACION)
VALUES(2, 1, 'HOLA', interval '10' DAY);