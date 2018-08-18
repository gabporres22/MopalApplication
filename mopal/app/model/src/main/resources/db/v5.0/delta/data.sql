-- if NeedsCreateSequence

create sequence QName(DATA, ASISTENTE_JORNADA_MARIA_SEQ)
	start with SequenceStartValue(1)
	increment by 1 SequenceCache;;

-- end
alter  table QName(DATA, PRJORNADA_MARIA)
	drop constraint PERSONA_RELACIONADA__817A59_FK;;

alter  table QName(DATA, ASISTENTE_JORNADA_MARIA)
	drop constraint PK_ASISTENTE_JORNADA_MARIA;;

alter  table QName(DATA, ASISTENTE_JORNADA_MARIA)
	AddColumn(ID                                Serial(1,ASISTENTE_JORNADA_MARIA_SEQ) not null);;

alter  table QName(DATA, ASISTENTE_JORNADA_MARIA)
	add constraint PK_ASISTENTE_JORNADA_MARIA primary key(ID);;

alter  table QName(DATA, PRJORNADA_MARIA)
	RenameColumn(PERSONA_RELACIONADA_EVENTO_ID, PERSONA_RELACIONADA_ID);;

alter  table QName(DATA, PRJORNADA_MARIA)
	AddColumn(PERSONA_RELACIONADA2_ID           int);;

alter table QName(DATA, PRJORNADA_MARIA) add constraint PERSONA_RELACIONADA2_DD7868_FK
	foreign key(PERSONA_RELACIONADA2_ID)
	references QName(DATA, ASISTENTE_JORNADA_MARIA)(ID);;

alter table QName(DATA, PRJORNADA_MARIA) add constraint PERSONA_RELACIONADA__817A59_FK
	foreign key(PERSONA_RELACIONADA_ID)
	references QName(DATA, ASISTENTE_JORNADA_MARIA)(ID);;

