-- if NeedsCreateSequence

create sequence QName(DATA, PRASAMBLEA_SEQ)
	start with SequenceStartValue(1)
	increment by 1 SequenceCache;;

-- end
create table QName(DATA, ASISTENTE_ASAMBLEA) (
	EVENTO_ID                         int              not null,
	PERSONA_ID                        int              not null,
	OBSERVACIONES                     nvarchar(255),
	UPDATE_TIME                       datetime(3)      default CurrentTime not null,

	constraint PK_ASISTENTE_ASAMBLEA primary key(EVENTO_ID, PERSONA_ID)
);;

create table QName(DATA, PRASAMBLEA) (
	ID                                Serial(1,PRASAMBLEA_SEQ) not null,
	PERSONA_RELACIONADA_EVENTO_ID     int              not null,
	PERSONA_RELACIONADA_PERSONA_ID    int              not null,
	NOMBRE                            nvarchar(255)    default EmptyString not null,
	APELLIDO                          nvarchar(255)    default EmptyString not null,
	FECHA_NACIMIENTO                  date             default CurrentDate not null,
	GRUPO_REFERENCIA                  nvarchar(255)    default EmptyString not null,
	OBSERVACIONES                     nvarchar(255),
	UPDATE_TIME                       datetime(3)      default CurrentTime not null,

	constraint PK_PRASAMBLEA primary key(ID)
);;

alter table QName(DATA, ASISTENTE_ASAMBLEA) add constraint PERSONA_ASISTENTE_ASAMBLEA_FK
	foreign key(PERSONA_ID)
	references QName(DATA, ASISTENTE)(ID);;


alter table QName(DATA, ASISTENTE_ASAMBLEA) add constraint EVENTO_ASISTENTE_ASAMBLEA_FK
	foreign key(EVENTO_ID)
	references QName(DATA, EVENTO)(ID);;


alter table QName(DATA, PRASAMBLEA) add constraint PERSONA_RELACIONADA__60DFD8_FK
	foreign key(PERSONA_RELACIONADA_EVENTO_ID, PERSONA_RELACIONADA_PERSONA_ID)
	references QName(DATA, ASISTENTE_ASAMBLEA)(EVENTO_ID, PERSONA_ID);;


