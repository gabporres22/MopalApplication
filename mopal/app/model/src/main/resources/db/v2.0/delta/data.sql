-- if NeedsCreateSequence

create sequence QName(DATA, COMUNIDAD_PASTOR_SEQ)
	start with SequenceStartValue(1)
	increment by 1 SequenceCache;;

create sequence QName(DATA, DETALLE_ASISTENCIA__6D60B2_SEQ)
	start with SequenceStartValue(1)
	increment by 1 SequenceCache;;

create sequence QName(DATA, ENCUENTRO_SEQ)
	start with SequenceStartValue(1)
	increment by 1 SequenceCache;;

create sequence QName(DATA, PRJORNADA_MARIA_SEQ)
	start with SequenceStartValue(1)
	increment by 1 SequenceCache;;

create sequence QName(DATA, USUARIO_ASISTENTE_SEQ)
	start with SequenceStartValue(1)
	increment by 1 SequenceCache;;

-- end
alter  table QName(DATA, PERSONA)
	drop constraint BARRIO_PERSONA_FK;;

alter  table QName(DATA, PERSONA)
	drop constraint COMUNIDAD_PERSONA_FK;;

alter  table QName(DATA, PERSONA)
	drop constraint LOCALIDAD_PERSONA_FK;;

alter  table QName(DATA, PERSONA)
	drop constraint NIVEL_PERSONA_FK;;

alter  table QName(DATA, PERSONA_RELACIONADA)
	drop constraint PERSONA_PERSONA_RELACIONADA_FK;;

drop   table QName(DATA, PERSONA);;

drop   table QName(DATA, PERSONA_RELACIONADA);;

create table QName(DATA, ASISTENTE_JORNADA_MARIA) (
	EVENTO_ID                         int              not null,
	PERSONA_ID                        int              not null,
	MONTO_CONTRIBUCION                decimal(10,2)    default 0.00 not null,
	OBSERVACIONES                     nvarchar(255),
	UPDATE_TIME                       datetime(3)      default CurrentTime not null,
	CREATION_TIME                     datetime(3)      default CurrentTime not null,
	CREATION_USER                     nvarchar(100),
	UPDATE_USER                       nvarchar(100),

	constraint PK_ASISTENTE_JORNADA_MARIA primary key(EVENTO_ID, PERSONA_ID)
);;

create table QName(DATA, COMUNIDAD_PASTOR) (
	ID                                Serial(1,COMUNIDAD_PASTOR_SEQ) not null,
	COMUNIDAD_ID                      int              not null,
	PASTOR_ID                         int              not null,
	UPDATE_TIME                       datetime(3)      default CurrentTime not null,
	DEPRECATION_TIME                  datetime(3),
	DEPRECATION_USER                  nvarchar(100),

	constraint PK_COMUNIDAD_PASTOR primary key(ID)
);;

create table QName(DATA, DETALLE_ASISTENCIA_ENCUENTRO) (
	ID                                Serial(1,DETALLE_ASISTENCIA__6D60B2_SEQ) not null,
	ENCUENTRO_ID                      int              not null,
	PERSONA_ID                        int              not null,
	PRESENTE                          boolean          default False CheckBoolConstraint(DETALLE_ASISTENCIA_EN_1D4FD2_B, PRESENTE) not null,
	OBSERVACIONES                     nvarchar(255)    default EmptyString not null,
	UPDATE_TIME                       datetime(3)      default CurrentTime not null,

	constraint PK_DETALLE_ASISTENCIA_ENCUENTR primary key(ID)
);;

create table QName(DATA, ENCUENTRO) (
	ID                                Serial(1,ENCUENTRO_SEQ) not null,
	COMUNIDAD_ID                      int              not null,
	FECHA_ENCUENTRO                   datetime(0)      default CurrentTime not null,
	OBSERVACIONES                     nvarchar(255)    default EmptyString not null,
	UPDATE_TIME                       datetime(3)      default CurrentTime not null,

	constraint PK_ENCUENTRO primary key(ID)
);;

create table QName(DATA, PRJORNADA_MARIA) (
	ID                                Serial(1,PRJORNADA_MARIA_SEQ) not null,
	PERSONA_RELACIONADA_EVENTO_ID     int              not null,
	PERSONA_RELACIONADA_PERSONA_ID    int              not null,
	NOMBRE                            nvarchar(255)    default EmptyString not null,
	APELLIDO                          nvarchar(255)    default EmptyString not null,
	FECHA_NACIMIENTO                  date             default CurrentDate not null,
	GRUPO_REFERENCIA                  nvarchar(255)    default EmptyString not null,
	OBSERVACIONES                     nvarchar(255),
	UPDATE_TIME                       datetime(3)      default CurrentTime not null,
	CREATION_TIME                     datetime(3)      default CurrentTime not null,
	CREATION_USER                     nvarchar(100),
	UPDATE_USER                       nvarchar(100),

	constraint PK_PRJORNADA_MARIA primary key(ID)
);;

create table QName(DATA, USUARIO_ASISTENTE) (
	ID                                Serial(1,USUARIO_ASISTENTE_SEQ) not null,
	USUARIO_ID                        nvarchar(256)    not null,
	ASISTENTE_ID                      int              not null,
	UPDATE_TIME                       datetime(3)      default CurrentTime not null,
	DEPRECATION_TIME                  datetime(3),
	DEPRECATION_USER                  nvarchar(100),

	constraint PK_USUARIO_ASISTENTE primary key(ID)
);;

alter  table QName(DATA, ASISTENTE_RETIRO_PASCUA)
	AddColumn(CREATION_TIME                     datetime(3)      default CurrentTime not null);;

alter  table QName(DATA, ASISTENTE_RETIRO_PASCUA)
	AddColumn(CREATION_USER                     nvarchar(100));;

alter  table QName(DATA, ASISTENTE_RETIRO_PASCUA)
	AddColumn(UPDATE_USER                       nvarchar(100));;

alter  table QName(DATA, PRRETIRO_PASCUA)
	AddColumn(CREATION_TIME                     datetime(3)      default CurrentTime not null);;

alter  table QName(DATA, PRRETIRO_PASCUA)
	AddColumn(CREATION_USER                     nvarchar(100));;

alter  table QName(DATA, PRRETIRO_PASCUA)
	AddColumn(UPDATE_USER                       nvarchar(100));;

alter table QName(DATA, ASISTENTE_JORNADA_MARIA) add constraint PERSONA_ASISTENTE_JO_59A344_FK
	foreign key(PERSONA_ID)
	references QName(DATA, ASISTENTE)(ID);;


alter table QName(DATA, ASISTENTE_JORNADA_MARIA) add constraint EVENTO_ASISTENTE_JOR_5A426F_FK
	foreign key(EVENTO_ID)
	references QName(DATA, EVENTO)(ID);;


alter table QName(DATA, COMUNIDAD_PASTOR) add constraint PASTOR_COMUNIDAD_PASTOR_FK
	foreign key(PASTOR_ID)
	references QName(DATA, ASISTENTE)(ID);;


alter table QName(DATA, COMUNIDAD_PASTOR) add constraint COMUNIDAD_COMUNIDAD_PASTOR_FK
	foreign key(COMUNIDAD_ID)
	references QName(DATA, COMUNIDAD)(ID);;


alter table QName(DATA, DETALLE_ASISTENCIA_ENCUENTRO) add constraint PERSONA_DETALLE_ASIS_EE72EA_FK
	foreign key(PERSONA_ID)
	references QName(DATA, ASISTENTE)(ID);;


alter table QName(DATA, DETALLE_ASISTENCIA_ENCUENTRO) add constraint ENCUENTRO_DETALLE_AS_78A9F0_FK
	foreign key(ENCUENTRO_ID)
	references QName(DATA, ENCUENTRO)(ID);;


alter table QName(DATA, ENCUENTRO) add constraint COMUNIDAD_ENCUENTRO_FK
	foreign key(COMUNIDAD_ID)
	references QName(DATA, COMUNIDAD)(ID);;


alter table QName(DATA, PRJORNADA_MARIA) add constraint PERSONA_RELACIONADA__817A59_FK
	foreign key(PERSONA_RELACIONADA_EVENTO_ID, PERSONA_RELACIONADA_PERSONA_ID)
	references QName(DATA, ASISTENTE_JORNADA_MARIA)(EVENTO_ID, PERSONA_ID);;


-- if NeedsGrantReference
grant references on QName(AUTHORIZATION, USER) to SchemaOrUser(DATA);;
-- end
alter table QName(DATA, USUARIO_ASISTENTE) add constraint USUARIO_USUARIO_ASISTENTE_FK
	foreign key(USUARIO_ID)
	references QName(AUTHORIZATION, USER)(ID);;


alter table QName(DATA, USUARIO_ASISTENTE) add constraint ASISTENTE_USUARIO_ASISTENTE_FK
	foreign key(ASISTENTE_ID)
	references QName(DATA, ASISTENTE)(ID);;


-- if NeedsCreateSequence

drop   sequence QName(DATA, PERSONA_RELACIONADA_SEQ) /* Ignore Errors */;;

drop   sequence QName(DATA, PERSONA_SEQ) /* Ignore Errors */;;

-- end
