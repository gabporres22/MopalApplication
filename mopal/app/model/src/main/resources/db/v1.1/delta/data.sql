alter  table QName(DATA, PERSONA_RELACIONADA)
	SetDefault(OBSERVACIONES, null);;

alter  table QName(DATA, PERSONA_RELACIONADA)
	DropNotNull(OBSERVACIONES);;

