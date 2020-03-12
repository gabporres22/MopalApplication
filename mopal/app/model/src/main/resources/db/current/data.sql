-- SQL for Schema DATA --

-- if NeedsCreateSequence

create sequence QName(DATA, ASISTENTE_SEQ)
	start with SequenceStartValue(1) increment by 1 SequenceCache;;

create sequence QName(DATA, ASISTENTE_JORNADA_MARIA_SEQ)
	start with SequenceStartValue(1) increment by 1 SequenceCache;;

create sequence QName(DATA, BARRIO_SEQ)
	start with SequenceStartValue(1) increment by 1 SequenceCache;;

create sequence QName(DATA, COMUNIDAD_SEQ)
	start with SequenceStartValue(1) increment by 1 SequenceCache;;

create sequence QName(DATA, COMUNIDAD_PASTOR_SEQ)
	start with SequenceStartValue(1) increment by 1 SequenceCache;;

create sequence QName(DATA, DETALLE_ASISTENCIA__6D60B2_SEQ)
	start with SequenceStartValue(1) increment by 1 SequenceCache;;

create sequence QName(DATA, ENCUENTRO_SEQ)
	start with SequenceStartValue(1) increment by 1 SequenceCache;;

create sequence QName(DATA, EVENTO_SEQ)
	start with SequenceStartValue(1) increment by 1 SequenceCache;;

create sequence QName(DATA, LOCALIDAD_SEQ)
	start with SequenceStartValue(1) increment by 1 SequenceCache;;

create sequence QName(DATA, NIVEL_SEQ)
	start with SequenceStartValue(1) increment by 1 SequenceCache;;

create sequence QName(DATA, PRASAMBLEA_SEQ)
	start with SequenceStartValue(1) increment by 1 SequenceCache;;

create sequence QName(DATA, PRJORNADA_MARIA_SEQ)
	start with SequenceStartValue(1) increment by 1 SequenceCache;;

create sequence QName(DATA, PRJORNADA_PENTECOSTES_SEQ)
	start with SequenceStartValue(1) increment by 1 SequenceCache;;

create sequence QName(DATA, PRRETIRO_PASCUA_SEQ)
	start with SequenceStartValue(1) increment by 1 SequenceCache;;

-- end

create table QName(DATA, ASISTENTE) (
	ID                                Serial(1,ASISTENTE_SEQ)                   not null,
	NOMBRE                            nvarchar(255)    default EmptyString      not null,
	APELLIDO                          nvarchar(255)    default EmptyString      not null,
	EMAIL                             nvarchar(255),
	LOCALIDAD_ID                      int                                       not null,
	BARRIO_ID                         int,
	FECHA_NACIMIENTO                  date             default CurrentDate      not null,
	NIVEL_ID                          int                                       not null,
	COMUNIDAD_ID                      int,
	CANTIDAD_HIJOS                    int              default 0,
	TELEFONO_DE_CONTACTO              nvarchar(255),
	TIPO_ESTADO_CIVIL                 nvarchar(50)     default 'SOLTERO',
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,

	constraint PK_ASISTENTE           primary key (ID)
);;

create table QName(DATA, ASISTENTE_ASAMBLEA) (
	EVENTO_ID                         int                                       not null,
	PERSONA_ID                        int                                       not null,
	OBSERVACIONES                     nvarchar(255),
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,

	constraint PK_ASISTENTE_ASAMBLEA  primary key (EVENTO_ID,PERSONA_ID)
);;

create table QName(DATA, ASISTENTE_JORNADA_MARIA) (
	ID                                Serial(1,ASISTENTE_JORNADA_MARIA_SEQ)     not null,
	EVENTO_ID                         int                                       not null,
	PERSONA_ID                        int                                       not null,
	MONTO_CONTRIBUCION                decimal(10,2)    default 0                not null,
	OBSERVACIONES                     nvarchar(255),
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,
	CREATION_TIME                     datetime(3)      default CurrentTime      not null,
	CREATION_USER                     nvarchar(100),
	UPDATE_USER                       nvarchar(100),

	constraint PK_ASISTENTE_JORNADA_MARIA primary key (ID)
);;

create table QName(DATA, ASISTENTE_JORNADA_PENTECOSTES) (
	EVENTO_ID                         int                                       not null,
	PERSONA_ID                        int                                       not null,
	MONTO_CONTRIBUCION                decimal(10,2)    default 0                not null,
	OBSERVACIONES                     nvarchar(255),
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,

	constraint PK_ASISTENTE_JORNADA_PENTECOST primary key (EVENTO_ID,PERSONA_ID)
);;

create table QName(DATA, ASISTENTE_RETIRO_PASCUA) (
	EVENTO_ID                         int                                       not null,
	PERSONA_ID                        int                                       not null,
	TIPO_CAMINO                       nvarchar(50)     default 'INGRESANTE'     not null,
	CANTIDAD_DE_PASCUAS               int              default 0                not null,
	ASISTENCIA_JUEVES                 boolean          default False CheckBoolConstraint(ASISTENTE_RETIRO_PASC_A6B7F5_B, ASISTENCIA_JUEVES) not null,
	ASISTENCIA_VIERNES                boolean          default False CheckBoolConstraint(ASISTENTE_RETIRO_PASC_1F855B_B, ASISTENCIA_VIERNES) not null,
	ASISTENCIA_SABADO                 boolean          default False CheckBoolConstraint(ASISTENTE_RETIRO_PASC_C46920_B, ASISTENCIA_SABADO) not null,
	MONTO_CONTRIBUCION                decimal(10,2)    default 0                not null,
	OBSERVACIONES                     nvarchar(255),
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,
	CREATION_TIME                     datetime(3)      default CurrentTime      not null,
	CREATION_USER                     nvarchar(100),
	UPDATE_USER                       nvarchar(100),

	constraint PK_ASISTENTE_RETIRO_PASCUA primary key (EVENTO_ID,PERSONA_ID)
);;

create table QName(DATA, BARRIO) (
	ID                                Serial(1,BARRIO_SEQ)                      not null,
	LOCALIDAD_ID                      int                                       not null,
	DESCRIPCION                       nvarchar(255)    default EmptyString      not null,
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,

	constraint PK_BARRIO              primary key (ID)
);;

create table QName(DATA, COMUNIDAD) (
	ID                                Serial(1,COMUNIDAD_SEQ)                   not null,
	NIVEL_COMUNIDAD_ID                int                                       not null,
	LOCALIDAD_ID                      int                                       not null,
	BARRIO_ID                         int,
	DESCRIPCION                       nvarchar(255)    default EmptyString      not null,
	CANTIDAD_PERSONAS                 int              default 0                not null,
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,

	constraint PK_COMUNIDAD           primary key (ID)
);;

create table QName(DATA, COMUNIDAD_PASTOR) (
	ID                                Serial(1,COMUNIDAD_PASTOR_SEQ)            not null,
	COMUNIDAD_ID                      int                                       not null,
	PASTOR_ID                         nvarchar(256)                             not null,
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,
	DEPRECATION_TIME                  datetime(3),
	DEPRECATION_USER                  nvarchar(100),
	CREATION_TIME                     datetime(3)      default CurrentTime      not null,
	CREATION_USER                     nvarchar(100),
	UPDATE_USER                       nvarchar(100),

	constraint PK_COMUNIDAD_PASTOR    primary key (ID)
);;

create table QName(DATA, DETALLE_ASISTENCIA_ENCUENTRO) (
	ID                                Serial(1,DETALLE_ASISTENCIA__6D60B2_SEQ)  not null,
	ENCUENTRO_ID                      int                                       not null,
	PERSONA_ID                        int                                       not null,
	PRESENTE                          boolean          default False CheckBoolConstraint(DETALLE_ASISTENCIA_EN_1D4FD2_B, PRESENTE) not null,
	OBSERVACIONES                     nvarchar(255),
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,
	DEPRECATION_TIME                  datetime(3),
	DEPRECATION_USER                  nvarchar(100),
	CREATION_TIME                     datetime(3)      default CurrentTime      not null,
	CREATION_USER                     nvarchar(100),
	UPDATE_USER                       nvarchar(100),

	constraint PK_DETALLE_ASISTENCIA_ENCUENTR primary key (ID)
);;

create table QName(DATA, ENCUENTRO) (
	ID                                Serial(1,ENCUENTRO_SEQ)                   not null,
	COMUNIDAD_ID                      int                                       not null,
	FECHA_ENCUENTRO                   date             default CurrentDate      not null,
	OBSERVACIONES                     nvarchar(255),
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,
	DEPRECATION_TIME                  datetime(3),
	DEPRECATION_USER                  nvarchar(100),
	CREATION_TIME                     datetime(3)      default CurrentTime      not null,
	CREATION_USER                     nvarchar(100),
	UPDATE_USER                       nvarchar(100),

	constraint PK_ENCUENTRO           primary key (ID)
);;

create table QName(DATA, EVENTO) (
	ID                                Serial(1,EVENTO_SEQ)                      not null,
	DESCRIPCION                       nvarchar(255)    default EmptyString      not null,
	TIPO_EVENTO                       nvarchar(50)     default 'JORNADA_PENTECOSTES'  not null,
	ACTIVO                            boolean          default False CheckBoolConstraint(EVENTO_ACTIVO_B, ACTIVO) not null,
	MONTO_SOLTERO                     decimal(10,2),
	MONTO_MATRIMONIO                  decimal(10,2),
	MONTO_NINO                        decimal(10,2),
	MONTO_NINOS_DESCUENTO             decimal(10,2),
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,

	constraint PK_EVENTO              primary key (ID)
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

create table QName(DATA, PRASAMBLEA) (
	ID                                Serial(1,PRASAMBLEA_SEQ)                  not null,
	PERSONA_RELACIONADA_EVENTO_ID     int                                       not null,
	PERSONA_RELACIONADA_PERSONA_ID    int                                       not null,
	NOMBRE                            nvarchar(255)    default EmptyString      not null,
	APELLIDO                          nvarchar(255)    default EmptyString      not null,
	FECHA_NACIMIENTO                  date             default CurrentDate      not null,
	GRUPO_REFERENCIA                  nvarchar(255)    default EmptyString      not null,
	OBSERVACIONES                     nvarchar(255),
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,

	constraint PK_PRASAMBLEA          primary key (ID)
);;

create table QName(DATA, PRJORNADA_MARIA) (
	ID                                Serial(1,PRJORNADA_MARIA_SEQ)             not null,
	PERSONA_RELACIONADA_ID            int                                       not null,
	PERSONA_RELACIONADA2_ID           int,
	NOMBRE                            nvarchar(255)    default EmptyString      not null,
	APELLIDO                          nvarchar(255)    default EmptyString      not null,
	FECHA_NACIMIENTO                  date             default CurrentDate      not null,
	GRUPO_REFERENCIA                  nvarchar(255)    default EmptyString      not null,
	OBSERVACIONES                     nvarchar(255),
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,
	CREATION_TIME                     datetime(3)      default CurrentTime      not null,
	CREATION_USER                     nvarchar(100),
	UPDATE_USER                       nvarchar(100),

	constraint PK_PRJORNADA_MARIA     primary key (ID)
);;

create table QName(DATA, PRJORNADA_PENTECOSTES) (
	ID                                Serial(1,PRJORNADA_PENTECOSTES_SEQ)       not null,
	PERSONA_RELACIONADA_EVENTO_ID     int                                       not null,
	PERSONA_RELACIONADA_PERSONA_ID    int                                       not null,
	NOMBRE                            nvarchar(255)    default EmptyString      not null,
	APELLIDO                          nvarchar(255)    default EmptyString      not null,
	FECHA_NACIMIENTO                  date             default CurrentDate      not null,
	GRUPO_REFERENCIA                  nvarchar(255)    default EmptyString      not null,
	OBSERVACIONES                     nvarchar(255),
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,

	constraint PK_PRJORNADA_PENTECOSTES primary key (ID)
);;

create table QName(DATA, PRRETIRO_PASCUA) (
	ID                                Serial(1,PRRETIRO_PASCUA_SEQ)             not null,
	PERSONA_RELACIONADA_EVENTO_ID     int                                       not null,
	PERSONA_RELACIONADA_PERSONA_ID    int                                       not null,
	NOMBRE                            nvarchar(255)    default EmptyString      not null,
	APELLIDO                          nvarchar(255)    default EmptyString      not null,
	FECHA_NACIMIENTO                  date             default CurrentDate      not null,
	GRUPO_REFERENCIA                  nvarchar(255)    default EmptyString      not null,
	ASISTENCIA_JUEVES                 boolean          default False CheckBoolConstraint(PRRETIRO_PASCUA_ASIST_F9495F_B, ASISTENCIA_JUEVES) not null,
	ASISTENCIA_VIERNES                boolean          default False CheckBoolConstraint(PRRETIRO_PASCUA_ASIST_5F80CC_B, ASISTENCIA_VIERNES) not null,
	ASISTENCIA_SABADO                 boolean          default False CheckBoolConstraint(PRRETIRO_PASCUA_ASIST_98EE95_B, ASISTENCIA_SABADO) not null,
	OBSERVACIONES                     nvarchar(255),
	UPDATE_TIME                       datetime(3)      default CurrentTime      not null,

	constraint PK_PRRETIRO_PASCUA     primary key (ID)
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

alter table QName(DATA, ASISTENTE) add constraint LOCALIDAD_ASISTENTE_FK
	foreign key (LOCALIDAD_ID)
	references QName(DATA, LOCALIDAD) (ID);;

alter table QName(DATA, ASISTENTE) add constraint BARRIO_ASISTENTE_FK
	foreign key (BARRIO_ID)
	references QName(DATA, BARRIO) (ID);;

alter table QName(DATA, ASISTENTE) add constraint NIVEL_ASISTENTE_FK
	foreign key (NIVEL_ID)
	references QName(DATA, NIVEL) (ID);;

alter table QName(DATA, ASISTENTE) add constraint COMUNIDAD_ASISTENTE_FK
	foreign key (COMUNIDAD_ID)
	references QName(DATA, COMUNIDAD) (ID);;

alter table QName(DATA, ASISTENTE_ASAMBLEA) add constraint EVENTO_ASISTENTE_ASAMBLEA_FK
	foreign key (EVENTO_ID)
	references QName(DATA, EVENTO) (ID);;

alter table QName(DATA, ASISTENTE_ASAMBLEA) add constraint PERSONA_ASISTENTE_ASAMBLEA_FK
	foreign key (PERSONA_ID)
	references QName(DATA, ASISTENTE) (ID);;

alter table QName(DATA, ASISTENTE_JORNADA_MARIA) add constraint EVENTO_ASISTENTE_JOR_5A426F_FK
	foreign key (EVENTO_ID)
	references QName(DATA, EVENTO) (ID);;

alter table QName(DATA, ASISTENTE_JORNADA_MARIA) add constraint PERSONA_ASISTENTE_JO_59A344_FK
	foreign key (PERSONA_ID)
	references QName(DATA, ASISTENTE) (ID);;

alter table QName(DATA, ASISTENTE_JORNADA_PENTECOSTES) add constraint EVENTO_ASISTENTE_JOR_CD672B_FK
	foreign key (EVENTO_ID)
	references QName(DATA, EVENTO) (ID);;

alter table QName(DATA, ASISTENTE_JORNADA_PENTECOSTES) add constraint PERSONA_ASISTENTE_JO_FBA80B_FK
	foreign key (PERSONA_ID)
	references QName(DATA, ASISTENTE) (ID);;

alter table QName(DATA, ASISTENTE_RETIRO_PASCUA) add constraint EVENTO_ASISTENTE_RET_641BC2_FK
	foreign key (EVENTO_ID)
	references QName(DATA, EVENTO) (ID);;

alter table QName(DATA, ASISTENTE_RETIRO_PASCUA) add constraint PERSONA_ASISTENTE_RE_275A6D_FK
	foreign key (PERSONA_ID)
	references QName(DATA, ASISTENTE) (ID);;

alter table QName(DATA, BARRIO) add constraint LOCALIDAD_BARRIO_FK
	foreign key (LOCALIDAD_ID)
	references QName(DATA, LOCALIDAD) (ID);;

alter table QName(DATA, COMUNIDAD) add constraint NIVEL_COMUNIDAD_COMUNIDAD_FK
	foreign key (NIVEL_COMUNIDAD_ID)
	references QName(DATA, NIVEL) (ID);;

alter table QName(DATA, COMUNIDAD) add constraint LOCALIDAD_COMUNIDAD_FK
	foreign key (LOCALIDAD_ID)
	references QName(DATA, LOCALIDAD) (ID);;

alter table QName(DATA, COMUNIDAD) add constraint BARRIO_COMUNIDAD_FK
	foreign key (BARRIO_ID)
	references QName(DATA, BARRIO) (ID);;

alter table QName(DATA, COMUNIDAD_PASTOR) add constraint COMUNIDAD_COMUNIDAD_PASTOR_FK
	foreign key (COMUNIDAD_ID)
	references QName(DATA, COMUNIDAD) (ID);;

-- if NeedsGrantReference
grant references on QName(AUTHORIZATION,USER) to SchemaOrUser(DATA);;
-- end
alter table QName(DATA, COMUNIDAD_PASTOR) add constraint PASTOR_COMUNIDAD_PASTOR_FK
	foreign key (PASTOR_ID)
	references QName(AUTHORIZATION, USER) (ID);;

alter table QName(DATA, DETALLE_ASISTENCIA_ENCUENTRO) add constraint ENCUENTRO_DETALLE_AS_78A9F0_FK
	foreign key (ENCUENTRO_ID)
	references QName(DATA, ENCUENTRO) (ID);;

alter table QName(DATA, DETALLE_ASISTENCIA_ENCUENTRO) add constraint PERSONA_DETALLE_ASIS_EE72EA_FK
	foreign key (PERSONA_ID)
	references QName(DATA, ASISTENTE) (ID);;

alter table QName(DATA, ENCUENTRO) add constraint COMUNIDAD_ENCUENTRO_FK
	foreign key (COMUNIDAD_ID)
	references QName(DATA, COMUNIDAD) (ID);;

alter table QName(DATA, PRASAMBLEA) add constraint PERSONA_RELACIONADA__60DFD8_FK
	foreign key (PERSONA_RELACIONADA_EVENTO_ID, PERSONA_RELACIONADA_PERSONA_ID)
	references QName(DATA, ASISTENTE_ASAMBLEA) (EVENTO_ID, PERSONA_ID);;

alter table QName(DATA, PRJORNADA_MARIA) add constraint PERSONA_RELACIONADA__817A59_FK
	foreign key (PERSONA_RELACIONADA_ID)
	references QName(DATA, ASISTENTE_JORNADA_MARIA) (ID);;

alter table QName(DATA, PRJORNADA_MARIA) add constraint PERSONA_RELACIONADA2_DD7868_FK
	foreign key (PERSONA_RELACIONADA2_ID)
	references QName(DATA, ASISTENTE_JORNADA_MARIA) (ID);;

alter table QName(DATA, PRJORNADA_PENTECOSTES) add constraint PERSONA_RELACIONADA__CD2F38_FK
	foreign key (PERSONA_RELACIONADA_EVENTO_ID, PERSONA_RELACIONADA_PERSONA_ID)
	references QName(DATA, ASISTENTE_JORNADA_PENTECOSTES) (EVENTO_ID, PERSONA_ID);;

alter table QName(DATA, PRRETIRO_PASCUA) add constraint PERSONA_RELACIONADA__F876B0_FK
	foreign key (PERSONA_RELACIONADA_EVENTO_ID, PERSONA_RELACIONADA_PERSONA_ID)
	references QName(DATA, ASISTENTE_RETIRO_PASCUA) (EVENTO_ID, PERSONA_ID);;

-- if NeedsSerialComment
comment on column QName(DATA,ASISTENTE).ID                 is 'Serial(1,ASISTENTE_SEQ)';;
comment on column QName(DATA,ASISTENTE_JORNADA_MARIA).ID   is 'Serial(1,ASISTENTE_JORNADA_MARIA_SEQ)';;
comment on column QName(DATA,BARRIO).ID                    is 'Serial(1,BARRIO_SEQ)';;
comment on column QName(DATA,COMUNIDAD).ID                 is 'Serial(1,COMUNIDAD_SEQ)';;
comment on column QName(DATA,COMUNIDAD_PASTOR).ID          is 'Serial(1,COMUNIDAD_PASTOR_SEQ)';;
comment on column QName(DATA,DETALLE_ASISTENCIA_ENCUENTRO).ID is 'Serial(1,DETALLE_ASISTENCIA__6D60B2_SEQ)';;
comment on column QName(DATA,ENCUENTRO).ID                 is 'Serial(1,ENCUENTRO_SEQ)';;
comment on column QName(DATA,EVENTO).ID                    is 'Serial(1,EVENTO_SEQ)';;
comment on column QName(DATA,LOCALIDAD).ID                 is 'Serial(1,LOCALIDAD_SEQ)';;
comment on column QName(DATA,NIVEL).ID                     is 'Serial(1,NIVEL_SEQ)';;
comment on column QName(DATA,PRASAMBLEA).ID                is 'Serial(1,PRASAMBLEA_SEQ)';;
comment on column QName(DATA,PRJORNADA_MARIA).ID           is 'Serial(1,PRJORNADA_MARIA_SEQ)';;
comment on column QName(DATA,PRJORNADA_PENTECOSTES).ID     is 'Serial(1,PRJORNADA_PENTECOSTES_SEQ)';;
comment on column QName(DATA,PRRETIRO_PASCUA).ID           is 'Serial(1,PRRETIRO_PASCUA_SEQ)';;
-- end

