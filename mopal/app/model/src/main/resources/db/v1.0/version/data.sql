-- @Generated at 2018-03-24 06:58:13

-- SQL for Schema DATA --

-- if NeedsCreateSequence

create sequence QName(DATA, COMUNIDAD_SEQ)
	start with SequenceStartValue(1) increment by 1 SequenceCache;;

create sequence QName(DATA, LOCALIDAD_SEQ)
	start with SequenceStartValue(1) increment by 1 SequenceCache;;

create sequence QName(DATA, NIVEL_SEQ)
	start with SequenceStartValue(1) increment by 1 SequenceCache;;

create sequence QName(DATA, PERSONA_SEQ)
	start with SequenceStartValue(1) increment by 1 SequenceCache;;

create sequence QName(DATA, PERSONA_RELACIONADA_SEQ)
	start with SequenceStartValue(1) increment by 1 SequenceCache;;

-- end

create table QName(DATA, COMUNIDAD) (
	ID                                Serial(1,COMUNIDAD_SEQ)                   not null,
	NIVEL_COMUNIDAD_ID                int                                       not null,
	LOCALIDAD_ID                      int                                       not null,
	DESCRIPCION                       nvarchar(255)    default EmptyString      not null,
	CANTIDAD_PERSONAS                 int              default 0                not null,
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,

	constraint PK_COMUNIDAD           primary key (ID)
);;

create table QName(DATA, LOCALIDAD) (
	ID                                Serial(1,LOCALIDAD_SEQ)                   not null,
	DESCRIPCION                       nvarchar(255)    default EmptyString      not null,
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,

	constraint PK_LOCALIDAD           primary key (ID)
);;

create table QName(DATA, NIVEL) (
	ID                                Serial(1,NIVEL_SEQ)                       not null,
	DESCRIPCION                       nvarchar(255)    default EmptyString      not null,
	ORDEN                             int              default 0                not null,
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,

	constraint PK_NIVEL               primary key (ID)
);;

create table QName(DATA, PERSONA) (
	ID                                Serial(1,PERSONA_SEQ)                     not null,
	NOMBRE                            nvarchar(255)    default EmptyString      not null,
	APELLIDO                          nvarchar(255)    default EmptyString      not null,
	EMAIL                             nvarchar(255),
	LOCALIDAD_ID                      int                                       not null,
	FECHA_NACIMIENTO                  date             default CurrentDate      not null,
	TIPO_CAMINO                       nvarchar(50)     default 'INGRESANTE'     not null,
	NIVEL_ID                          int                                       not null,
	COMUNIDAD_ID                      int,
	CANTIDAD_PASCUAS                  int              default 0                not null,
	CANTIDAD_HIJOS                    int              default 0,
	TELEFONO_DE_CONTACTO              nvarchar(255)    default EmptyString      not null,
	TIPO_ESTADO_CIVIL                 nvarchar(50)     default 'SOLTERO',
	ASISTENCIA_JUEVES                 boolean          default False CheckBoolConstraint(PERSONA_ASISTENCIA_JUEVES_B, ASISTENCIA_JUEVES) not null,
	ASISTENCIA_VIERNES                boolean          default False CheckBoolConstraint(PERSONA_ASISTENCIA_VIERNES_B, ASISTENCIA_VIERNES) not null,
	ASISTENCIA_SABADO                 boolean          default False CheckBoolConstraint(PERSONA_ASISTENCIA_SABADO_B, ASISTENCIA_SABADO) not null,
	MONTO_CONTRIBUCION                decimal(10,2)    default 0                not null,
	OBSERVACIONES                     nvarchar(255),
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,

	constraint PK_PERSONA             primary key (ID)
);;

create table QName(DATA, PERSONA_RELACIONADA) (
	ID                                Serial(1,PERSONA_RELACIONADA_SEQ)         not null,
	PERSONA_ID                        int                                       not null,
	NOMBRE                            nvarchar(255)    default EmptyString      not null,
	APELLIDO                          nvarchar(255)    default EmptyString      not null,
	FECHA_NACIMIENTO                  date             default CurrentDate      not null,
	TELEFONO_DE_CONTACTO              nvarchar(255)    default EmptyString      not null,
	GRUPO_REFERENCIA                  nvarchar(255)    default EmptyString      not null,
	ASISTENCIA_JUEVES                 boolean          default False CheckBoolConstraint(PERSONA_RELACIONADA_A_1F5D39_B, ASISTENCIA_JUEVES) not null,
	ASISTENCIA_VIERNES                boolean          default False CheckBoolConstraint(PERSONA_RELACIONADA_A_FC2DD7_B, ASISTENCIA_VIERNES) not null,
	ASISTENCIA_SABADO                 boolean          default False CheckBoolConstraint(PERSONA_RELACIONADA_A_2C1EC3_B, ASISTENCIA_SABADO) not null,
	OBSERVACIONES                     nvarchar(255)    default EmptyString      not null,
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,

	constraint PK_PERSONA_RELACIONADA primary key (ID)
);;

create table QName(DATA, _METADATA) (
	VERSION                           nvarchar(24)                              not null,
	SHA                               nvarchar(128)                             not null,
	SHA_OVL                           nvarchar(128),
	UPDATE_TIME                       datetime(0),
	SCHEMA                            clob,
	OVERLAY                           clob,

	constraint PK_METADATA            primary key (VERSION)
);;

create index IndexName(DATA, NIVEL_ORDEN_IDXT)
	on QName(DATA, NIVEL) (ORDEN) IndexTableSpace;;

alter table QName(DATA, COMUNIDAD) add constraint NIVEL_COMUNIDAD_COMUNIDAD_FK
	foreign key (NIVEL_COMUNIDAD_ID)
	references QName(DATA, NIVEL) (ID);;

alter table QName(DATA, COMUNIDAD) add constraint LOCALIDAD_COMUNIDAD_FK
	foreign key (LOCALIDAD_ID)
	references QName(DATA, LOCALIDAD) (ID);;

alter table QName(DATA, PERSONA) add constraint LOCALIDAD_PERSONA_FK
	foreign key (LOCALIDAD_ID)
	references QName(DATA, LOCALIDAD) (ID);;

alter table QName(DATA, PERSONA) add constraint NIVEL_PERSONA_FK
	foreign key (NIVEL_ID)
	references QName(DATA, NIVEL) (ID);;

alter table QName(DATA, PERSONA) add constraint COMUNIDAD_PERSONA_FK
	foreign key (COMUNIDAD_ID)
	references QName(DATA, COMUNIDAD) (ID);;

alter table QName(DATA, PERSONA_RELACIONADA) add constraint PERSONA_PERSONA_RELACIONADA_FK
	foreign key (PERSONA_ID)
	references QName(DATA, PERSONA) (ID);;

-- if NeedsSerialComment
comment on column QName(DATA,COMUNIDAD).ID                 is 'Serial(1,COMUNIDAD_SEQ)';;
comment on column QName(DATA,LOCALIDAD).ID                 is 'Serial(1,LOCALIDAD_SEQ)';;
comment on column QName(DATA,NIVEL).ID                     is 'Serial(1,NIVEL_SEQ)';;
comment on column QName(DATA,PERSONA).ID                   is 'Serial(1,PERSONA_SEQ)';;
comment on column QName(DATA,PERSONA_RELACIONADA).ID       is 'Serial(1,PERSONA_RELACIONADA_SEQ)';;
-- end

