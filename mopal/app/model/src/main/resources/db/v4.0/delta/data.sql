alter  table QName(DATA, USUARIO_ASISTENTE)
	drop constraint USUARIO_USUARIO_ASISTENTE_FK;;

alter  table QName(DATA, USUARIO_ASISTENTE)
	drop constraint ASISTENTE_USUARIO_ASISTENTE_FK;;

alter  table QName(DATA, COMUNIDAD_PASTOR)
	drop constraint PASTOR_COMUNIDAD_PASTOR_FK;;

drop   table QName(DATA, USUARIO_ASISTENTE);;

alter  table QName(DATA, COMUNIDAD_PASTOR)
	AlterColumnType(PASTOR_ID, nvarchar(256));;

-- if NeedsGrantReference
grant references on QName(AUTHORIZATION, USER) to SchemaOrUser(DATA);;
-- end
alter table QName(DATA, COMUNIDAD_PASTOR) add constraint PASTOR_COMUNIDAD_PASTOR_FK
	foreign key(PASTOR_ID)
	references QName(AUTHORIZATION, USER)(ID);;

-- if NeedsCreateSequence

drop   sequence QName(DATA, USUARIO_ASISTENTE_SEQ) /* Ignore Errors */;;

-- end
