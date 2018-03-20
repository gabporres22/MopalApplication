-- @Generated at 2018-03-20 17:07:15

-- SQL for Schema MODEL --

-- if NeedsCreateSequence

create sequence QName(MODEL, COMUNIDAD_SEQ)
	start with SequenceStartValue(1) increment by 1 SequenceCache;;

create sequence QName(MODEL, LOCALIDAD_SEQ)
	start with SequenceStartValue(1) increment by 1 SequenceCache;;

create sequence QName(MODEL, PERSONA_SEQ)
	start with SequenceStartValue(1) increment by 1 SequenceCache;;

-- end

create table QName(MODEL, COMUNIDAD) (
	ID                                Serial(1,COMUNIDAD_SEQ)                   not null,
	NIVEL_COMUNIDAD                   nvarchar(50)     default 'NINGUNA'        not null,
	LOCALIDAD_ID                      int                                       not null,
	DESCRIPCION                       nvarchar(255)    default EmptyString      not null,
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,

	constraint PK_COMUNIDAD           primary key (ID)
);;

create table QName(MODEL, LOCALIDAD) (
	ID                                Serial(1,LOCALIDAD_SEQ)                   not null,
	DESCRIPCION                       nvarchar(255)    default EmptyString      not null,
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,

	constraint PK_LOCALIDAD           primary key (ID)
);;

create table QName(MODEL, PERSONA) (
	ID                                Serial(1,PERSONA_SEQ)                     not null,
	NOMBRE                            nvarchar(255)    default EmptyString      not null,
	APELLIDO                          nvarchar(255)    default EmptyString      not null,
	LOCALIDAD_ID                      int                                       not null,
	FECHA_NACIMIENTO                  date             default CurrentDate      not null,
	TIPO_CAMINO                       nvarchar(50)     default 'INGRESANTE'     not null,
	NIVEL                             nvarchar(50)     default 'NINGUNA'        not null,
	COMUNIDAD_ID                      int,
	CANTIDAD_PASCUAS                  int              default 0                not null,
	CANTIDAD_HIJOS                    int              default 0,
	TELEFONO_DE_CONTACTO              nvarchar(255)    default EmptyString      not null,
	TIPO_ESTADO_CIVIL                 nvarchar(50)     default 'SOLTERO',
	ASISTENCIA_JUEVES                 boolean          default False CheckBoolConstraint(PERSONA_ASISTENCIA_JUEVES_B, ASISTENCIA_JUEVES) not null,
	ASISTENCIA_VIERNES                boolean          default False CheckBoolConstraint(PERSONA_ASISTENCIA_VIERNES_B, ASISTENCIA_VIERNES) not null,
	ASISTENCIA_SABADO                 boolean          default False CheckBoolConstraint(PERSONA_ASISTENCIA_SABADO_B, ASISTENCIA_SABADO) not null,
	CONTRIBUCION_PASCUA               boolean          default False CheckBoolConstraint(PERSONA_CONTRIBUCION_PASCUA_B, CONTRIBUCION_PASCUA) not null,
	MONTO_CONTRIBUCION                decimal(10,2)    default 0                not null,
	OBSERVACIONES                     nvarchar(255),
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,

	constraint PK_PERSONA             primary key (ID)
);;

create table QName(MODEL, PERSONA_RELACIONADA) (
	PERSONA_ID                        int                                       not null,
	SEQ_ID                            int              default 0                not null,
	NOMBRE                            nvarchar(255)    default EmptyString      not null,
	APELLIDO                          nvarchar(255)    default EmptyString      not null,
	FECHA_NACIMIENTO                  date             default CurrentDate      not null,
	TELEFONO_DE_CONTACTO              nvarchar(255)    default EmptyString      not null,
	ASISTENCIA_JUEVES                 boolean          default False CheckBoolConstraint(PERSONA_RELACIONADA_A_1F5D39_B, ASISTENCIA_JUEVES) not null,
	ASISTENCIA_VIERNES                boolean          default False CheckBoolConstraint(PERSONA_RELACIONADA_A_FC2DD7_B, ASISTENCIA_VIERNES) not null,
	ASISTENCIA_SABADO                 boolean          default False CheckBoolConstraint(PERSONA_RELACIONADA_A_2C1EC3_B, ASISTENCIA_SABADO) not null,
	OBSERVACIONES                     nvarchar(255)    default EmptyString      not null,
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,

	constraint PK_PERSONA_RELACIONADA primary key (PERSONA_ID,SEQ_ID)
);;

create table QName(MODEL, _METADATA) (
	VERSION                           nvarchar(24)                              not null,
	SHA                               nvarchar(128)                             not null,
	SHA_OVL                           nvarchar(128),
	UPDATE_TIME                       datetime(0),
	SCHEMA                            clob,
	OVERLAY                           clob,

	constraint PK_METADATA            primary key (VERSION)
);;

alter table QName(MODEL, COMUNIDAD) add constraint LOCALIDAD_COMUNIDAD_FK
	foreign key (LOCALIDAD_ID)
	references QName(MODEL, LOCALIDAD) (ID);;

alter table QName(MODEL, PERSONA) add constraint LOCALIDAD_PERSONA_FK
	foreign key (LOCALIDAD_ID)
	references QName(MODEL, LOCALIDAD) (ID);;

alter table QName(MODEL, PERSONA) add constraint COMUNIDAD_PERSONA_FK
	foreign key (COMUNIDAD_ID)
	references QName(MODEL, COMUNIDAD) (ID);;

alter table QName(MODEL, PERSONA_RELACIONADA) add constraint PERSONA_PERSONA_RELACIONADA_FK
	foreign key (PERSONA_ID)
	references QName(MODEL, PERSONA) (ID);;

-- if NeedsSerialComment
comment on column QName(MODEL,COMUNIDAD).ID                is 'Serial(1,COMUNIDAD_SEQ)';;
comment on column QName(MODEL,LOCALIDAD).ID                is 'Serial(1,LOCALIDAD_SEQ)';;
comment on column QName(MODEL,PERSONA).ID                  is 'Serial(1,PERSONA_SEQ)';;
-- end

